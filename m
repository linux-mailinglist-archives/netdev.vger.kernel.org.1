Return-Path: <netdev+bounces-61890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8328252B9
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CA9B21A2A
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1283828DDD;
	Fri,  5 Jan 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fqUW4wB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3602CCB4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso14167865e9.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704453855; x=1705058655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHtS1d9QBmqdBAQnfXJibwcBv45HvLzy/lTJnq7N6K0=;
        b=fqUW4wB1ZfKgImrtGxaO2Ufjdt1VHcUXGlcYh7rWi54k3LqIoWBLpyeuTyv6BtSEpz
         l1L5Gv29GPIkbbSyva4o349t0wWYAD0Str93QpqFzOyEO4L6linKNndSXIrn6Ru53Ukv
         1AXxRW72mrVEdbLOVTcSorOc3iW9dHPT35RbE565x+gRqYtNL1Y13LsP26LS+MJDCAHT
         2wBY1AUc4yV0R5emejQdlcLT/nDLjVlHCiGsJyHdQ7mSBZf+noI7CKVi7x0oNsRE+71C
         cEQHlG3mJadrMH1Hz9B2LfMeAoLRjXiuu76jWQPTtc849K1kSJR+id1XU4k8hnV5kwPi
         HxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704453855; x=1705058655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHtS1d9QBmqdBAQnfXJibwcBv45HvLzy/lTJnq7N6K0=;
        b=dukEoHeCfxyBrrCoEjwWXDV9mlfC7Gl4Yc+K7VcYpnZ+Y43ZbhseRTlRmPWYE60/Eg
         1qjPrebSxcZEueBn/kaPX/niqaEkmrDB7n94MCAqpw7plQBgGy9vfEhDLti/6yr4Fz1U
         3lgqWGtgstcQlYqNKS9MVGZzgIAwNKUN5aGqtN6o31Cic7PN40Xj+5cmf0XO9UGGmEN+
         H8s0/WWajmPzpaGNBTtimyyBApGGg6akBuUFX5fUX0vhRfd4eqA/YFoaLFJpyuLPxYOm
         1slLRGmW2q+3Oc/74cS9U3sX2Auek+2pCdGsEYf059CWQGV5C/aiW61HrzfjsqMCV/Ce
         NT1w==
X-Gm-Message-State: AOJu0Yx39ZWBgOb/aE3x31AOfgRxp8uJv42FpknIFWpTKnGLgTJXL9KT
	uzly3M8MkR8F49vA+chHShatVGon74DdbQ==
X-Google-Smtp-Source: AGHT+IFaklc2MPE9GioUJ0eWAJFCspeYWNDDBMmpDnmekiFXInVWgstnwxfQtJO+LZl/If6uO2mhtA==
X-Received: by 2002:a05:600c:2193:b0:40d:5c82:ec91 with SMTP id e19-20020a05600c219300b0040d5c82ec91mr1055701wme.106.1704453854912;
        Fri, 05 Jan 2024 03:24:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b0040d53588d94sm1268558wmb.46.2024.01.05.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:24:14 -0800 (PST)
Date: Fri, 5 Jan 2024 12:24:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, xiyou.wangcong@gmail.com,
	victor@mojatatu.com, pctammela@mojatatu.com, idosch@idosch.org,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZfm3TbhyAfIMzDQ@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
 <ZZby7xSkQpWHwPOA@nanopsycho>
 <CAM0EoMmCn8DpMzPCt9GMW16C08n8mfM8N==pfPJy6c=XgEqMSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmCn8DpMzPCt9GMW16C08n8mfM8N==pfPJy6c=XgEqMSw@mail.gmail.com>

Thu, Jan 04, 2024 at 07:22:48PM CET, jhs@mojatatu.com wrote:
>On Thu, Jan 4, 2024 at 1:03 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jan 04, 2024 at 05:10:58PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Jan 4, 2024 at 7:58 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >>
>> >> Inserting the device to block xarray in qdisc_create() is not suitable
>> >> place to do this. As it requires use of tcf_block() callback, it causes
>> >> multiple issues. It is called for all qdisc types, which is incorrect.
>> >>
>> >> So, instead, move it to more suitable place, which is tcf_block_get_ext()
>> >> and make sure it is only done for qdiscs that use block infrastructure
>> >> and also only for blocks which are shared.
>> >>
>> >> Symmetrically, alter the cleanup path, move the xarray entry removal
>> >> into tcf_block_put_ext().
>> >>
>> >> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> >> Reported-by: Ido Schimmel <idosch@nvidia.com>
>> >> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> >> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
>> >> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
>> >> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> >> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> >> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> >> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> >> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> >> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >
>> >Did you get a chance to run the tdc tests?
>>
>> I ran the TC ones we have in the net/forwarding directory.
>> I didn't manage to run the tdc. Readme didn't help me much.
>> How do you run the suite?
>
>For next time:
>make -C tools/testing/selftests TARGETS=tc-testing run_tests

Unrelated to this patch.

Running this, I'm getting lots of errors, some seem might be bugs in
tests. Here's the output:

make: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests'
make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
TAP version 13
1..1
# timeout set to 900
# selftests: tc-testing: tdc.sh
# netdevsim
# act_bpf
# act_connmark
# act_csum
# act_ct
# act_ctinfo
# act_gact
# act_gate
# act_mirred
# act_mpls
# act_nat
# act_pedit
# act_police
# act_sample
# act_simple
# act_skbedit
# act_skbmod
# act_tunnel_key
# act_vlan
# cls_basic
# cls_bpf
# cls_cgroup
# cls_flow
# cls_flower
# cls_fw
# cls_matchall
# cls_route
# cls_u32
# Module em_canid not found... skipping.
# em_cmp
# em_ipset
# em_ipt
# em_meta
# em_nbyte
# em_text
# em_u32
# sch_cake
# sch_cbs
# sch_choke
# sch_codel
# sch_drr
# sch_etf
# sch_ets
# sch_fq
# sch_fq_codel
# sch_fq_pie
# sch_gred
# sch_hfsc
# sch_hhf
# sch_htb
# sch_teql
# considering category actions
# !!! Consider installing pyroute2 !!!
#  -- ns/SubPlugin.__init__
#  -- scapy/SubPlugin.__init__
# Executing 528 tests in parallel and 15 in serial
# Using 18 batches and 4 workers
# 
# -----> prepare stage *** Could not execute: "$TC actions add action pass index 1"
# 
# -----> prepare stage *** Error message: "setting the network namespace "tcut-3101919570" failed: Invalid argument
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=19> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 420, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# RTNETLINK answers: File exists
# Command failed -:20
# 
# -----> teardown stage *** Could not execute: "$TC action flush action ctinfo"
# 
# -----> teardown stage *** Error message: "setting the network namespace "tcut-518092810" failed: Invalid argument
# "
# 
# -----> teardown stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=21> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 465, in run_one_test
#     prepare_env(tidx, args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# Error: argument "v0p0id8295idbf47" is wrong: "name" not a valid ifname
# 
# -----> prepare stage *** Could not execute: "$TC actions add action simple sdata "Rock""
# 
# -----> prepare stage *** Error message: "setting the network namespace "tcut-1996746596" failed: Invalid argument
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=15> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 420, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# ..RTNETLINK answers: File exists
# Command failed -:425
# Test 1c3a: Flush police actions
# Test 7326: Add police action with control continue
# Test 34fa: Add police action with control drop
# Test 8dd5: Add police action with control ok
# Test b9d1: Add police action with control reclassify
# Test c534: Add police action with control pipe
# Test b48b: Add police action with exceed goto chain control action
# Test 689e: Replace police action with invalid goto chain control
# Test cdd7: Add valid police action with packets per second rate limit
# Test f5bc: Add invalid police action with both bps and pps
# Test 7d64: Add police action with skip_hw option
# Test 7d50: Add skbmod action to set destination mac
# Test 9b29: Add skbmod action to set source mac
# Test 1724: Add skbmod action with invalid mac
# Test 3cf1: Add skbmod action with valid etype
# Test a749: Add skbmod action with invalid etype
# Test bfe6: Add skbmod action to swap mac
# Test 839b: Add skbmod action with control pipe
# Test c167: Add skbmod action with control reclassify
# Test 0c2f: Add skbmod action with control drop
# Test d113: Add skbmod action with control continue
# Test 7242: Add skbmod action with control pass
# Test 6046: Add skbmod action with control reclassify and cookie
# Test 58cb: List skbmod actions
# Test 9aa8: Get a single skbmod action from a list
# Test e93a: Delete an skbmod action
# Test 40c2: Flush skbmod actions
# Test b651: Replace skbmod action with invalid goto_chain control
# Test fe09: Add skbmod action to mark ECN bits
# Test 696a: Add simple ct action
# Test e38c: Add simple ct action with cookie
# Test 9f20: Add ct clear action
# Test 0bc1: Add ct clear action with cookie of max length
# Test 5bea: Try ct with zone
# Test d5d6: Try ct with zone, commit
# Test 029f: Try ct with zone, commit, mark
# Test a58d: Try ct with zone, commit, mark, nat
# Test 901b: Try ct with full nat ipv4 range syntax
# Test 072b: Try ct with full nat ipv6 syntax
# Test 3420: Try ct with full nat ipv6 range syntax
# Test 4470: Try ct with full nat ipv6 range syntax + force
# Test 5d88: Try ct with label
# Test 04d4: Try ct with label with mask
# Test 9751: Try ct with mark + mask
# Test 2faa: Try ct with mark + mask and cookie
# Test 3991: Add simple ct action with no_percpu flag
# Test 3992: Add ct action triggering DNAT tuple conflict
# 
# Sent 1 packets.
# 
# Sent 1 packets.
# Test 2029: Add xt action with log-prefix
# exception iproute2 exited with an error code in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test ac2a: List actions
# Test 3edf: Flush gact actions
# Test 63ec: Delete pass action
# returncode 255; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 4 63ec Delete pass action stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# Test 68e2: Add tunnel_key unset action
# exception iproute2 exited with an error code in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test fa1c: Add mpls dec_ttl action with ttl (invalid)
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test a5a7: Add pedit action with LAYERED_OP eth set src
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 5a31: Add vlan modify action for protocol 802.1AD
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 8eb5: Create valid ife encode action with tcindex and continue control
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test a874: Add invalid sample action without mandatory arguments
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test d959: Add cBPF action with valid bytecode
# Test f84a: Add cBPF action with invalid bytecode
# Test e939: Add eBPF action with valid object-file
# Test 282d: Add eBPF action with invalid object-file
# Test d819: Replace cBPF bytecode and action control
# Test 6ae3: Delete cBPF action 
# Test 3e0d: List cBPF actions
# Test 55ce: Flush BPF actions
# Test ccc3: Add cBPF action with duplicate index
# Test 89c7: Add cBPF action with invalid index
# Test 7ab9: Add cBPF action with cookie
# Test b8a1: Replace bpf action with invalid goto_chain control
# Test 2893: Add pedit action with RAW_OP offset u8 quad
# Test 6795: Add pedit action with LAYERED_OP ip6 set payload_len, nexthdr, hoplimit
# Test cfcc: Add pedit action with LAYERED_OP tcp flags set
# Test b078: Add simple action
# Test 4297: Add simple action with change command
# Test 6d4c: Add simple action with duplicate index
# Test 2542: List simple actions
# returncode 255; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 5 2542 List simple actions stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# Test 5232: List ctinfo actions
# Test 7702: Flush ctinfo actions
# Test 3201: Add ctinfo action with duplicate index
# Test 8295: Add ctinfo action with invalid index
# returncode 255; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'setting the network namespace "tcut-518092810" failed: Invalid argument\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 5 8295 Add ctinfo action with invalid index stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# setting the network namespace "tcut-518092810" failed: Invalid argument
# 
# ---------------
# Test bf47: Add csum icmp action
# exception iproute2 exited with an error code in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# multiprocessing.pool.RemoteTraceback: 
# """
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 45, in prepare_test
#     self._proc_check()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 219, in _proc_check
#     raise RuntimeError("iproute2 exited with an error code")
# RuntimeError: iproute2 exited with an error code
# 
# During handling of the above exception, another exception occurred:
# 
# Traceback (most recent call last):
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 125, in worker
#     result = (True, func(*args, **kwds))
#                     ^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 48, in mapstar
#     return list(map(*args))
#            ^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 602, in __mp_runner
#     (_, tsr) = test_runner(mp_pm, mp_args, tests)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 419, in run_one_test
#     pm.call_pre_case(tidx)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 146, in call_pre_case
#     print('test_ordinal is {}'.format(test_ordinal))
#                                       ^^^^^^^^^^^^
# NameError: name 'test_ordinal' is not defined
# """
# 
# The above exception was the direct cause of the following exception:
# 
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 1028, in <module>
#     main()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 1022, in main
#     set_operation_mode(pm, parser, args, remaining)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 964, in set_operation_mode
#     catresults = test_runner_mp(pm, args, alltests)
#                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 624, in test_runner_mp
#     pres = p.map(__mp_runner, batches)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 367, in map
#     return self._map_async(func, iterable, mapstar, chunksize).get()
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 774, in get
#     raise self._value
# NameError: name 'test_ordinal' is not defined
# WARNING: Interface v0p0id7326 does not exist!
# WARNING: Interface v0p0id34fa does not exist!
# WARNING: more Interface v0p0id8dd5 does not exist!
# considering category qdisc
# !!! Consider installing pyroute2 !!!
#  -- ns/SubPlugin.__init__
#  -- scapy/SubPlugin.__init__
# Executing 294 tests in parallel and 33 in serial
# Using 11 batches and 4 workers
# 
# -----> prepare stage *** Could not execute: "echo "1 1 8" > /sys/bus/netdevsim/new_device"
# 
# -----> prepare stage *** Error message: "setting the network namespace "tcut-2202500200" failed: Invalid argument
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=15> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 420, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# RTNETLINK answers: File exists
# Command failed -:2
# 
# -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY handle 1: root"
# 
# -----> teardown stage *** Error message: "Error: Invalid handle.
# "
# 
# -----> teardown stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=21> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 465, in run_one_test
#     prepare_env(tidx, args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# 
# -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY handle 1: root bfifo"
# 
# -----> teardown stage *** Error message: "Cannot find device "dummy1ida519"
# "
# 
# -----> teardown stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=17> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 465, in run_one_test
#     prepare_env(tidx, args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# Error: argument "v0p0id20baid2958" is wrong: "name" not a valid ifname
# 
# -----> teardown stage *** Could not execute: "$TC qdisc del dev $DUMMY handle 1: root"
# 
# -----> teardown stage *** Error message: "setting the network namespace "tcut-2202500200-3305288203" failed: Invalid argument
# "
# 
# -----> teardown stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=15> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 465, in run_one_test
#     prepare_env(tidx, args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# 
# -----> prepare stage *** Could not execute: "$TC qdisc add dev $DUMMY handle 1: root choke limit 1000 bandwidth 10000"
# 
# -----> prepare stage *** Error message: "setting the network namespace "tcut-57801789-2243486144" failed: Invalid argument
# "
# 
# -----> prepare stage *** Aborting test run.
# 
# 
# <_io.BufferedReader name=6> *** stdout ***
# 
# 
# <_io.BufferedReader name=21> *** stderr ***
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 420, in run_one_test
#     prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 268, in prepare_env
#     raise PluginMgrTestFail(
# Error: argument "v0p0id30c4id0301" is wrong: "name" not a valid ifname
# RTNETLINK answers: File exists
# Command failed -:38
# Test a519: Add bfifo qdisc with system default parameters on egress
# exit: 1
# exit: 0
# Cannot find device "dummy1ida519"
# 
# returncode 1; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Cannot find device "dummy1ida519"\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 2 a519 Add bfifo qdisc with system default parameters on egress stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# Cannot find device "dummy1ida519"
# 
# ---------------
# Test 2385: Create CAKE with besteffort flag
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 0521: Show ingress class
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test b190: Create FQ_CODEL with noecn flag
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 5439: Create NETEM with multiple slot setting
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 30a9: Create SFB with increment setting
# exception [Errno 32] Broken pipe in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 20ba: Add multiq Qdisc to multi-queue device (8 queues)
# returncode 255; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 2 20ba Add multiq Qdisc to multi-queue device (8 queues) stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# Test 2958: Show skbprio class
# exit: 255
# exit: 0
# setting the network namespace "tcut-2202500200-3305288203" failed: Invalid argument
# 
# returncode 255; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'setting the network namespace "tcut-2202500200-3305288203" failed: Invalid argument\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 2 2958 Show skbprio class stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# setting the network namespace "tcut-2202500200-3305288203" failed: Invalid argument
# 
# ---------------
# Test fe0f: Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
# Test 1f91: Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
# exit: 255
# exit: 1
# setting the network namespace "tcut-3396639522" failed: Invalid argument
# 
# Test d248: Add prio qdisc on egress with invalid bands value (< 2)
# exit: 1
# exit: 2
# Cannot find device "dummy1idd248"
# 
# Test 1d0e: Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
# Test 1971: Replace default prio qdisc on egress with 8 bands and new priomap
# exception iproute2 exited with an error code in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 30c4: Add ETS qdisc with quanta + priomap
# exit: 1
# exit: 0
# Cannot find device "dummy1id30c4"
# 
# returncode 2; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Cannot find device "dummy1id30c4"\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 2 30c4 Add ETS qdisc with quanta + priomap stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# Cannot find device "dummy1id30c4"
# 
# ---------------
# Test 0301: Change CHOKE with limit setting
# returncode 255; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 2 0301 Change CHOKE with limit setting stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# multiprocessing.pool.RemoteTraceback: 
# """
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 38, in prepare_test
#     self._ipr2_ns_create()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 187, in _ipr2_ns_create
#     self._exec_cmd_batched('pre', self._ipr2_ns_create_cmds())
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 242, in _exec_cmd_batched
#     self._exec_cmd(stage, cmd)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 233, in _exec_cmd
#     proc.stdin.flush()
# BrokenPipeError: [Errno 32] Broken pipe
# 
# During handling of the above exception, another exception occurred:
# 
# Traceback (most recent call last):
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 125, in worker
#     result = (True, func(*args, **kwds))
#                     ^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 48, in mapstar
#     return list(map(*args))
#            ^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 602, in __mp_runner
#     (_, tsr) = test_runner(mp_pm, mp_args, tests)
#                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 536, in test_runner
#     res = run_one_test(pm, args, index, tidx)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 419, in run_one_test
#     pm.call_pre_case(tidx)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 146, in call_pre_case
#     print('test_ordinal is {}'.format(test_ordinal))
#                                       ^^^^^^^^^^^^
# NameError: name 'test_ordinal' is not defined
# """
# 
# The above exception was the direct cause of the following exception:
# 
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 1028, in <module>
#     main()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 1022, in main
#     set_operation_mode(pm, parser, args, remaining)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 964, in set_operation_mode
#     catresults = test_runner_mp(pm, args, alltests)
#                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 624, in test_runner_mp
#     pres = p.map(__mp_runner, batches)
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 367, in map
#     return self._map_async(func, iterable, mapstar, chunksize).get()
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/lib64/python3.11/multiprocessing/pool.py", line 774, in get
#     raise self._value
# NameError: name 'test_ordinal' is not defined
not ok 1 selftests: tc-testing: tdc.sh # exit=1
make[1]: Leaving directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
make: Leaving directory '/mnt/share156/jiri/net-next/tools/testing/selftests'

