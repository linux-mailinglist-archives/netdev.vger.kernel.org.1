Return-Path: <netdev+bounces-59990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A124B81D08E
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 00:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF97B236F1
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 23:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837135EE9;
	Fri, 22 Dec 2023 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pt1s+364"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11A364C1
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703288489; x=1734824489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wioe1OTHqmh2iXVv2+MtEfxvcbcfbMpOE+svJ++M40=;
  b=Pt1s+364Mq1oUlWR3Ydb5GIDfiJ4pqtT3ytpH95zltf+JhLX4Ux2BztD
   JkgjP8jJG9iqOPwjtS6isv+vT/XpTygD0I9If4yCLaV6VuJnmCfMgwk6O
   xS+sFTUSsmU4ie8PSU4a5mJAz75hCHkRkAhY/uo+gBMHE0OZBikZ0eNHv
   PSrWxftHf/B1t4EYWsAIC6XT0s15rvyQBKQf3XUoy0ZLpiFdt2hoa33dT
   yhM+ka2ya/4m4pn/3fZRM19kL4TQxc90GwIlq2t1vjs7JbxWWdCZk670Q
   pfJ9J3a3HzMNuHwBE2Ps8710enkMVUCyyIW+UkYmkmAzlf3Z7ZIMFQMnY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="482347695"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="482347695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:41:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="806114432"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="806114432"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2023 15:41:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGp8q-000A0U-0I;
	Fri, 22 Dec 2023 23:41:21 +0000
Date: Sat, 23 Dec 2023 07:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] i40e: add trace events related to SFP module
 IOCTLs
Message-ID: <202312230700.6El79he7-lkp@intel.com>
References: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>

Hi Aleksandr,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Loktionov/i40e-add-trace-events-related-to-SFP-module-IOCTLs/20231222-165333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20231220173837.3326983-1-aleksandr.loktionov%40intel.com
patch subject: [PATCH iwl-next v2] i40e: add trace events related to SFP module IOCTLs
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20231223/202312230700.6El79he7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230700.6El79he7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230700.6El79he7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/net/ethernet/intel/i40e/i40e_trace.h:276,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:25:
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'ftrace_test_probe_i40e_ioctl_get_module_info':
   include/trace/trace_events.h:416:42: error: 'trace_event_raw_event_i40e_ioctl_template' undeclared (first use in this function); did you mean 'trace_event_raw_event_i40e_tx_template'?
     416 |         check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   include/trace/trace_events.h:416:42: note: each undeclared identifier is reported only once for each function it appears in
     416 |         check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'ftrace_test_probe_i40e_ioctl_get_module_eeprom':
   include/trace/trace_events.h:416:42: error: 'trace_event_raw_event_i40e_ioctl_template' undeclared (first use in this function); did you mean 'trace_event_raw_event_i40e_tx_template'?
     416 |         check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:211:1: note: in expansion of macro 'DEFINE_EVENT'
     211 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'ftrace_test_probe_i40e_ioctl_get_link_ksettings':
   include/trace/trace_events.h:416:42: error: 'trace_event_raw_event_i40e_ioctl_template' undeclared (first use in this function); did you mean 'trace_event_raw_event_i40e_tx_template'?
     416 |         check_trace_callback_type_##call(trace_event_raw_event_##template); \
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:217:1: note: in expansion of macro 'DEFINE_EVENT'
     217 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: At top level:
   include/trace/trace_events.h:441:36: error: 'event_class_i40e_ioctl_template' undeclared here (not in a function); did you mean 'event_class_i40e_xmit_template'?
     441 |         .class                  = &event_class_##template,              \
         |                                    ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   include/trace/trace_events.h:445:36: error: 'trace_event_type_funcs_i40e_ioctl_template' undeclared here (not in a function); did you mean 'trace_event_type_funcs_i40e_xmit_template'?
     445 |         .event.funcs            = &trace_event_type_funcs_##template,   \
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   include/trace/trace_events.h:446:35: error: 'print_fmt_i40e_ioctl_template' undeclared here (not in a function); did you mean 'print_fmt_i40e_tx_template'?
     446 |         .print_fmt              = print_fmt_##template,                 \
         |                                   ^~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:103:
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'perf_test_probe_i40e_ioctl_get_module_info':
   include/trace/perf.h:67:42: error: 'perf_trace_i40e_ioctl_template' undeclared (first use in this function); did you mean 'perf_trace_i40e_xmit_template'?
      67 |         check_trace_callback_type_##call(perf_trace_##template);        \
         |                                          ^~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'perf_test_probe_i40e_ioctl_get_module_eeprom':
   include/trace/perf.h:67:42: error: 'perf_trace_i40e_ioctl_template' undeclared (first use in this function); did you mean 'perf_trace_i40e_xmit_template'?
      67 |         check_trace_callback_type_##call(perf_trace_##template);        \
         |                                          ^~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:211:1: note: in expansion of macro 'DEFINE_EVENT'
     211 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'perf_test_probe_i40e_ioctl_get_link_ksettings':
   include/trace/perf.h:67:42: error: 'perf_trace_i40e_ioctl_template' undeclared (first use in this function); did you mean 'perf_trace_i40e_xmit_template'?
      67 |         check_trace_callback_type_##call(perf_trace_##template);        \
         |                                          ^~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:217:1: note: in expansion of macro 'DEFINE_EVENT'
     217 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   In file included from include/trace/define_trace.h:104:
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: In function 'bpf_test_probe_i40e_ioctl_get_module_info':
>> include/trace/bpf_probe.h:65:42: error: '__bpf_trace_i40e_ioctl_template' undeclared (first use in this function); did you mean '__bpf_trace_i40e_tx_template'?
      65 |         check_trace_callback_type_##call(__bpf_trace_##template);       \
         |                                          ^~~~~~~~~~~~
   include/trace/bpf_probe.h:101:9: note: in expansion of macro '__DEFINE_EVENT'
     101 |         __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
         |         ^~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h: At top level:
>> include/trace/bpf_probe.h:75:35: error: '__bpf_trace_i40e_ioctl_template' undeclared here (not in a function); did you mean '__bpf_trace_i40e_tx_template'?
      75 |                 .bpf_func       = __bpf_trace_##template,               \
         |                                   ^~~~~~~~~~~~
   include/trace/bpf_probe.h:101:9: note: in expansion of macro '__DEFINE_EVENT'
     101 |         __DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
         |         ^~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/./i40e_trace.h:205:1: note: in expansion of macro 'DEFINE_EVENT'
     205 | DEFINE_EVENT(
         | ^~~~~~~~~~~~


vim +65 include/trace/bpf_probe.h

c4f6699dfcb855 Alexei Starovoitov 2018-03-28   52  
6939f4ef16d48f Qais Yousef        2021-01-19   53  #undef DECLARE_EVENT_CLASS
6939f4ef16d48f Qais Yousef        2021-01-19   54  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
6939f4ef16d48f Qais Yousef        2021-01-19   55  	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
6939f4ef16d48f Qais Yousef        2021-01-19   56  
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   57  /*
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   58   * This part is compiled out, it is only here as a build time check
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   59   * to make sure that if the tracepoint handling changes, the
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   60   * bpf probe will fail to compile unless it too is updated.
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   61   */
9df1c28bb75217 Matt Mullins       2019-04-26   62  #define __DEFINE_EVENT(template, call, proto, args, size)		\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   63  static inline void bpf_test_probe_##call(void)				\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   64  {									\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28  @65  	check_trace_callback_type_##call(__bpf_trace_##template);	\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   66  }									\
e8c423fb31fa8b Alexei Starovoitov 2019-10-15   67  typedef void (*btf_trace_##call)(void *__data, proto);			\
441420a1f0b303 Andrii Nakryiko    2020-03-01   68  static union {								\
441420a1f0b303 Andrii Nakryiko    2020-03-01   69  	struct bpf_raw_event_map event;					\
441420a1f0b303 Andrii Nakryiko    2020-03-01   70  	btf_trace_##call handler;					\
441420a1f0b303 Andrii Nakryiko    2020-03-01   71  } __bpf_trace_tp_map_##call __used					\
33def8498fdde1 Joe Perches        2020-10-21   72  __section("__bpf_raw_tp_map") = {					\
441420a1f0b303 Andrii Nakryiko    2020-03-01   73  	.event = {							\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   74  		.tp		= &__tracepoint_##call,			\
441420a1f0b303 Andrii Nakryiko    2020-03-01  @75  		.bpf_func	= __bpf_trace_##template,		\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   76  		.num_args	= COUNT_ARGS(args),			\
9df1c28bb75217 Matt Mullins       2019-04-26   77  		.writable_size	= size,					\
441420a1f0b303 Andrii Nakryiko    2020-03-01   78  	},								\
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   79  };
c4f6699dfcb855 Alexei Starovoitov 2018-03-28   80  
9df1c28bb75217 Matt Mullins       2019-04-26   81  #define FIRST(x, ...) x
9df1c28bb75217 Matt Mullins       2019-04-26   82  
65223741ae1b75 Hou Tao            2021-10-04   83  #define __CHECK_WRITABLE_BUF_SIZE(call, proto, args, size)		\
9df1c28bb75217 Matt Mullins       2019-04-26   84  static inline void bpf_test_buffer_##call(void)				\
9df1c28bb75217 Matt Mullins       2019-04-26   85  {									\
9df1c28bb75217 Matt Mullins       2019-04-26   86  	/* BUILD_BUG_ON() is ignored if the code is completely eliminated, but \
9df1c28bb75217 Matt Mullins       2019-04-26   87  	 * BUILD_BUG_ON_ZERO() uses a different mechanism that is not	\
9df1c28bb75217 Matt Mullins       2019-04-26   88  	 * dead-code-eliminated.					\
9df1c28bb75217 Matt Mullins       2019-04-26   89  	 */								\
9df1c28bb75217 Matt Mullins       2019-04-26   90  	FIRST(proto);							\
9df1c28bb75217 Matt Mullins       2019-04-26   91  	(void)BUILD_BUG_ON_ZERO(size != sizeof(*FIRST(args)));		\
65223741ae1b75 Hou Tao            2021-10-04   92  }
65223741ae1b75 Hou Tao            2021-10-04   93  
65223741ae1b75 Hou Tao            2021-10-04   94  #undef DEFINE_EVENT_WRITABLE
65223741ae1b75 Hou Tao            2021-10-04   95  #define DEFINE_EVENT_WRITABLE(template, call, proto, args, size) \
65223741ae1b75 Hou Tao            2021-10-04   96  	__CHECK_WRITABLE_BUF_SIZE(call, PARAMS(proto), PARAMS(args), size) \
9df1c28bb75217 Matt Mullins       2019-04-26   97  	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
9df1c28bb75217 Matt Mullins       2019-04-26   98  
9df1c28bb75217 Matt Mullins       2019-04-26   99  #undef DEFINE_EVENT
9df1c28bb75217 Matt Mullins       2019-04-26  100  #define DEFINE_EVENT(template, call, proto, args)			\
9df1c28bb75217 Matt Mullins       2019-04-26 @101  	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
c4f6699dfcb855 Alexei Starovoitov 2018-03-28  102  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

