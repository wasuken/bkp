import { mount } from '@vue/test-utils';
import Component from '_/components/journals/content.vue';

describe('journal test', () => {
    test('is a Vue instance', () => {
        const wrapper = mount(Component);
        expect(wrapper.isVueInstance()).toBeTruthy();
    });
});
