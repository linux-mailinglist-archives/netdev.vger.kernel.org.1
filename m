Return-Path: <netdev+bounces-62157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF39825F54
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 12:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE1283A9F
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA46AAC;
	Sat,  6 Jan 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dt38b+z6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FE6FA4
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e37524fafso4282905e9.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704539655; x=1705144455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHM8E+FA/tht8t7MXB/Qayro+Zx2psTwTUduDTvKVXw=;
        b=dt38b+z6FR/Y70+fMeUQKMqw++34Y0yuy6/9neV3klIA5PK1nf3YcBS72S22I5LwH/
         MNvq7tB6CHy6aHVUfFQUqnKeRtJu6O2g7apjljNuNiUAF1EXTCIP8yktOHxrl6VUKdoI
         YNTzHPWmyQ8qjBE7CxmKlqoqSXQ2q7DYDp5Jl+wybP2V9EhTETHfODeMORPj/EPdg729
         /fqNcsrDmvbRiwZVFi+dGW2lEXbqDOg8oXT2DapRMi/RHv0AXj1YERjNKtEOHQo68Kpo
         yopYPR86Bu2mV6HDRiPIk0K/TpnariCj4KTQSY5G3n3dnP/3XY9mXo1UwrALT4YWhfWh
         oFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704539655; x=1705144455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHM8E+FA/tht8t7MXB/Qayro+Zx2psTwTUduDTvKVXw=;
        b=eQCDpjSZkmMUQICqufOR06RmPk6Gbv7jf9lX9iJDZOCHlK3eZ+qogkAAKi0UhQ51Fz
         3WIl6mGDGcmzbhT44MEYAqOJJ0zCwtTo7nNRt5rEhTth3zifKSEsvO7danUN+V8nUpLi
         9/ZUTytzY5QYON6Tg3jRWM+MMz6/zRiGafp15H1I2IsjCoo2DiLFvvJ7IQFc/5hQQmbU
         QK0dZZP9fgyt2UACooO/V7pGPPaIdd0k9mOsmvRauQy4cGI8Q+lyPpMjDixZykznGdBl
         Hm0k/YJOzjibxzhj5LG4FtfXKwfmWge1BxgSlIHdCAq0AknZqckDyORXPjrSE2FZ2jJZ
         6fhQ==
X-Gm-Message-State: AOJu0YwlWCIEW2phGQzD76rAePwGSG1uteuPG0gXBGfW1zxuF2fxxwtL
	77F0BkR93u0mNQEKkhaO2f3UJi/V60DPhQ==
X-Google-Smtp-Source: AGHT+IEUguh2E+BX4R5MwErgnRYeZMzJiQybjnZmLz3uN1W0BxGYXXgFPVqam4KhJDI2HVbDYSu4/A==
X-Received: by 2002:a05:600c:c1:b0:40e:38e7:89b8 with SMTP id u1-20020a05600c00c100b0040e38e789b8mr414608wmm.73.1704539654849;
        Sat, 06 Jan 2024 03:14:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b0040d91930f93sm4329823wmq.11.2024.01.06.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 03:14:14 -0800 (PST)
Date: Sat, 6 Jan 2024 12:14:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, xiyou.wangcong@gmail.com, victor@mojatatu.com,
	idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZk2BN8uz8SoxQYe@nanopsycho>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <CAM0EoMkDhnm0QPtZEQPbnQtkfW7tTjHdv3fQoXzRXARVdhbc0A@mail.gmail.com>
 <ZZby7xSkQpWHwPOA@nanopsycho>
 <CAM0EoMmCn8DpMzPCt9GMW16C08n8mfM8N==pfPJy6c=XgEqMSw@mail.gmail.com>
 <ZZfm3TbhyAfIMzDQ@nanopsycho>
 <828b8af7-8b4e-4820-bf78-41a8b7af16ce@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <828b8af7-8b4e-4820-bf78-41a8b7af16ce@mojatatu.com>

Fri, Jan 05, 2024 at 12:51:04PM CET, pctammela@mojatatu.com wrote:
>On 05/01/2024 08:24, Jiri Pirko wrote:
>> Thu, Jan 04, 2024 at 07:22:48PM CET, jhs@mojatatu.com wrote:
>> > On Thu, Jan 4, 2024 at 1:03 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > 
>> > > Thu, Jan 04, 2024 at 05:10:58PM CET, jhs@mojatatu.com wrote:
>> > > > On Thu, Jan 4, 2024 at 7:58 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > > 
>> > > > > From: Jiri Pirko <jiri@nvidia.com>
>> > > > > 
>> > > > > Inserting the device to block xarray in qdisc_create() is not suitable
>> > > > > place to do this. As it requires use of tcf_block() callback, it causes
>> > > > > multiple issues. It is called for all qdisc types, which is incorrect.
>> > > > > 
>> > > > > So, instead, move it to more suitable place, which is tcf_block_get_ext()
>> > > > > and make sure it is only done for qdiscs that use block infrastructure
>> > > > > and also only for blocks which are shared.
>> > > > > 
>> > > > > Symmetrically, alter the cleanup path, move the xarray entry removal
>> > > > > into tcf_block_put_ext().
>> > > > > 
>> > > > > Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
>> > > > > Reported-by: Ido Schimmel <idosch@nvidia.com>
>> > > > > Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
>> > > > > Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
>> > > > > Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
>> > > > > Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
>> > > > > Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
>> > > > > Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
>> > > > > Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
>> > > > > Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
>> > > > > Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
>> > > > > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> > > > 
>> > > > Did you get a chance to run the tdc tests?
>> > > 
>> > > I ran the TC ones we have in the net/forwarding directory.
>> > > I didn't manage to run the tdc. Readme didn't help me much.
>> > > How do you run the suite?
>> > 
>> > For next time:
>> > make -C tools/testing/selftests TARGETS=tc-testing run_tests
>> 
>> Unrelated to this patch.
>> 
>> Running this, I'm getting lots of errors, some seem might be bugs in
>> tests. Here's the output:
>> 
>> make: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests'
>> make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
>> make[1]: Nothing to be done for 'all'.
>> make[1]: Leaving directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
>> make[1]: Entering directory '/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing'
>> TAP version 13
>> 1..1
>> # timeout set to 900
>> # selftests: tc-testing: tdc.sh
>> # netdevsim
>> # act_bpf
>> # act_connmark
>> # act_csum
>> # act_ct
>> # act_ctinfo
>> # act_gact
>> # act_gate
>> # act_mirred
>> # act_mpls
>> # act_nat
>> # act_pedit
>> # act_police
>> # act_sample
>> # act_simple
>> # act_skbedit
>> # act_skbmod
>> # act_tunnel_key
>> # act_vlan
>> # cls_basic
>> # cls_bpf
>> # cls_cgroup
>> # cls_flow
>> # cls_flower
>> # cls_fw
>> # cls_matchall
>> # cls_route
>> # cls_u32
>> # Module em_canid not found... skipping.
>> # em_cmp
>> # em_ipset
>> # em_ipt
>> # em_meta
>> # em_nbyte
>> # em_text
>> # em_u32
>> # sch_cake
>> # sch_cbs
>> # sch_choke
>> # sch_codel
>> # sch_drr
>> # sch_etf
>> # sch_ets
>> # sch_fq
>> # sch_fq_codel
>> # sch_fq_pie
>> # sch_gred
>> # sch_hfsc
>> # sch_hhf
>> # sch_htb
>> # sch_teql
>> # considering category actions
>> # !!! Consider installing pyroute2 !!!
>> #  -- ns/SubPlugin.__init__
>> #  -- scapy/SubPlugin.__init__
>> # Executing 528 tests in parallel and 15 in serial
>> # Using 18 batches and 4 workers
>> #
>
>Hi Jiri,
>
>Can you also try running after installing pyroute2?
>`pip3 install pyroute2` or via your distro's package manager.
>
>Seems like in your kernel config + (virtual?) machine you are running into
>issues like:
> - create netns
> - try to use netns (still "creating", not visible yet)
> - fail badly
>
>Since pyroute2 is netlink based, these issues are more likely to not happen.
>
>Yes I agree the error messages are cryptic, we have been wondering how to
>improve them.
>If you are still running into issues after trying with pyroute2, can you also
>try running tdc with the following diff? It disables the parallel testing for
>kselftests.
>
>Perhaps when pyroute2 is not detected on the system we should disable the
>parallel testing completely. tc/ip commands are too susceptible to these
>issues and parallel testing just amplifies them.
>
>diff --git a/tools/testing/selftests/tc-testing/tdc.sh
>b/tools/testing/selftests/tc-testing/tdc.sh
>index c53ede8b730d..89bb123db86b 100755
>--- a/tools/testing/selftests/tc-testing/tdc.sh
>+++ b/tools/testing/selftests/tc-testing/tdc.sh
>@@ -63,5 +63,5 @@ try_modprobe sch_hfsc
> try_modprobe sch_hhf
> try_modprobe sch_htb
> try_modprobe sch_teql
>-./tdc.py -J`nproc` -c actions
>-./tdc.py -J`nproc` -c qdisc
>+./tdc.py -J1 -c actions
>+./tdc.py -J1 -c qdisc
>

I installed pyroute2. It looks some of the error went away, still having
a couple:

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
#  -- ns/SubPlugin.__init__
#  -- scapy/SubPlugin.__init__
# Executing 528 tests in parallel and 15 in serial
# Using 18 batches and 4 workers
# ..
# -----> teardown stage *** Could not execute: "$TC actions flush action xt"
# 
# -----> teardown stage *** Error message: "Error: Cannot flush unknown TC action.
# We have an error flushing
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
# Test 5232: List ctinfo actions
# Test 7702: Flush ctinfo actions
# Test 3201: Add ctinfo action with duplicate index
# Test 8295: Add ctinfo action with invalid index
# Test 3964: Replace ctinfo action with invalid goto_chain control
# Test 5124: Add mirred mirror to egress action
# Test 6fb4: Add mirred redirect to egress action
# Test ba38: Get mirred actions
# Test d7c0: Add invalid mirred direction
# Test e213: Add invalid mirred action
# Test 2d89: Add mirred action with invalid device
# Test 300b: Add mirred action with duplicate index
# Test 8917: Add mirred mirror action with control pass
# Test 1054: Add mirred mirror action with control pipe
# Test 9887: Add mirred mirror action with control continue
# Test e4aa: Add mirred mirror action with control reclassify
# Test ece9: Add mirred mirror action with control drop
# Test 0031: Add mirred mirror action with control jump
# Test 407c: Add mirred mirror action with cookie
# Test 8b69: Add mirred mirror action with index at 32-bit maximum
# Test 3f66: Add mirred mirror action with index exceeding 32-bit maximum
# Test a70e: Delete mirred mirror action
# Test 3fb3: Delete mirred redirect action
# Test 2a9a: Replace mirred action with invalid goto chain control
# Test 4749: Add batch of 32 mirred redirect egress actions with cookie
# Test 5c69: Delete batch of 32 mirred redirect egress actions
# Test d3c0: Add batch of 32 mirred mirror ingress actions with cookie
# Test e684: Delete batch of 32 mirred mirror ingress actions
# Test 31e3: Add mirred mirror to egress action with no_percpu flag
# Test 6d84: Add csum iph action
# Test 1862: Add csum ip4h action
# Test 15c6: Add csum ipv4h action
# Test bf47: Add csum icmp action
# Test cc1d: Add csum igmp action
# Test bccc: Add csum foobar action
# Test 3bb4: Add csum tcp action
# Test 759c: Add csum udp action
# Test bdb6: Add csum udp xor iph action
# Test c220: Add csum udplite action
# Test 8993: Add csum sctp action
# Test b138: Add csum ip & icmp action
# Test eeda: Add csum ip & sctp action
# Test 0017: Add csum udp or tcp action
# Test b10b: Add all 7 csum actions
# Test ce92: Add csum udp action with cookie
# Test 912f: Add csum icmp action with large cookie
# Test 879b: Add batch of 32 csum tcp actions
# Test b4e9: Delete batch of 32 csum actions
# Test 0015: Add batch of 32 csum tcp actions with large cookies
# Test 989e: Delete batch of 32 csum actions with large cookies
# Test d128: Replace csum action with invalid goto chain control
# Test eaf0: Add csum iph action with no_percpu flag
# Test a933: Add MPLS dec_ttl action with pipe opcode
# Test 08d1: Add mpls dec_ttl action with pass opcode
# Test d786: Add mpls dec_ttl action with drop opcode
# Test f334: Add mpls dec_ttl action with reclassify opcode
# Test 29bd: Add mpls dec_ttl action with continue opcode
# Test 48df: Add mpls dec_ttl action with jump opcode
# Test 62eb: Add mpls dec_ttl action with trap opcode
# Test 09d2: Add mpls dec_ttl action with opcode and cookie
# Test c170: Add mpls dec_ttl action with opcode and cookie of max length
# Test 9118: Add mpls dec_ttl action with invalid opcode
# Test 6ce1: Add mpls dec_ttl action with label (invalid)
# Test 352f: Add mpls dec_ttl action with tc (invalid)
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
# exit: 255
# exit: 0
# Warning: Extension LOG revision 0 not supported, missing kernel module?
# Error: Failed to load TC action module.
# We have an error talking to the kernel
# 
# returncode 1; expected [0]
# "-----> teardown stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('teardown', 'Warning: Extension LOG revision 0 not supported, missing kernel module?\nError: Failed to load TC action module.\nWe have an error talking to the kernel\n', '"-----> teardown stage" did not complete successfully') (caught in test_runner, running test 17 2029 Add xt action with log-prefix stage teardown)
# ---------------
# traceback
# ---------------
# accumulated output for this test:
# Warning: Extension LOG revision 0 not supported, missing kernel module?
# Error: Failed to load TC action module.
# We have an error talking to the kernel
# 
# ---------------
# Test a5a7: Add pedit action with LAYERED_OP eth set src
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 5a31: Add vlan modify action for protocol 802.1AD
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 8eb5: Create valid ife encode action with tcindex and continue control
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test a874: Add invalid sample action without mandatory arguments
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test ac2a: List actions
# Test 3edf: Flush gact actions
# Test 63ec: Delete pass action
# Test 46be: Delete pipe action
# Test 2e08: Delete reclassify action
# Test 99c4: Delete drop action
# Test fb6b: Delete continue action
# Test 0eb3: Delete non-existent action
# Test f02c: Replace gact action
# Test 525f: Get gact action by index
# Test 1021: Add batch of 32 gact pass actions
# Test da7a: Add batch of 32 gact continue actions with cookie
# Test 8aa3: Delete batch of 32 gact continue actions
# Test 8e47: Add gact action with random determ goto chain control action
# Test ca89: Replace gact action with invalid goto chain control
# Test 95ad: Add gact pass action with no_percpu flag
# Test 7f52: Try to flush action which is referenced by filter
# Test ae1e: Try to flush actions when last one is referenced by filter
# Test 2b11: Add tunnel_key set action with mandatory parameters
# Test dc6b: Add tunnel_key set action with missing mandatory src_ip parameter
# Test 7f25: Add tunnel_key set action with missing mandatory dst_ip parameter
# Test a5e0: Add tunnel_key set action with invalid src_ip parameter
# Test eaa8: Add tunnel_key set action with invalid dst_ip parameter
# Test 3b09: Add tunnel_key set action with invalid id parameter
# Test 9625: Add tunnel_key set action with invalid dst_port parameter
# Test 05af: Add tunnel_key set action with optional dst_port parameter
# Test da80: Add tunnel_key set action with index at 32-bit maximum
# Test d407: Add tunnel_key set action with index exceeding 32-bit maximum
# Test 5cba: Add tunnel_key set action with id value at 32-bit maximum
# Test e84a: Add tunnel_key set action with id value exceeding 32-bit maximum
# Test 9c19: Add tunnel_key set action with dst_port value at 16-bit maximum
# Test 3bd9: Add tunnel_key set action with dst_port value exceeding 16-bit maximum
# Test 68e2: Add tunnel_key unset action
# Test 6192: Add tunnel_key unset continue action
# Test 061d: Add tunnel_key set continue action with cookie
# Test 8acb: Add tunnel_key set continue action with invalid cookie
# Test a07e: Add tunnel_key action with no set/unset command specified
# Test b227: Add tunnel_key action with csum option
# Test 58a7: Add tunnel_key action with nocsum option
# Test 2575: Add tunnel_key action with not-supported parameter
# Test 7a88: Add tunnel_key action with cookie parameter
# Test 4f20: Add tunnel_key action with a single geneve option parameter
# Test e33d: Add tunnel_key action with multiple geneve options parameter
# Test 0778: Add tunnel_key action with invalid class geneve option parameter
# Test 4ae8: Add tunnel_key action with invalid type geneve option parameter
# Test 4039: Add tunnel_key action with short data length geneve option parameter
# Test 26a6: Add tunnel_key action with non-multiple of 4 data length geneve option parameter
# Test f44d: Add tunnel_key action with incomplete geneve options parameter
# Test 7afc: Replace tunnel_key set action with all parameters
# Test 364d: Replace tunnel_key set action with all parameters and cookie
# Test 937c: Fetch all existing tunnel_key actions
# Test 6783: Flush all existing tunnel_key actions
# Test 8242: Replace tunnel_key set action with invalid goto chain
# Test 0cd2: Add tunnel_key set action with no_percpu flag
# Test 3671: Delete tunnel_key set action with valid index
# Test 8597: Delete tunnel_key set action with invalid index
# Test 6bda: Add tunnel_key action with nofrag option
# Test c826: Add ctinfo action with default setting
# Test 0286: Add ctinfo action with dscp
# Test 4938: Add ctinfo action with valid cpmark and zone
# Test 7593: Add ctinfo action with drop control
# Test 2961: Replace ctinfo action zone and action control
# Test e567: Delete ctinfo action with valid index
# Test 6a91: Delete ctinfo action with invalid index
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
# Test ea67: Delete simple action
# Test 8ff1: Flush simple actions
# Test b776: Replace simple action with invalid goto chain control
# Test 8d07: Verify cleanup of failed actions batch add
# Test a68a: Verify cleanup of failed actions batch change
# Test 49aa: Add valid basic police action
# Test 3abe: Add police action with duplicate index
# Test 49fa: Add valid police action with mtu
# Test 7943: Add valid police action with peakrate
# Test 055e: Add police action with peakrate and no mtu
# Test f057: Add police action with valid overhead
# Test 7ffb: Add police action with ethernet linklayer type
# Test 3dda: Add police action with atm linklayer type
# Test 551b: Add police actions with conform-exceed control continue/drop
# Test 0c70: Add police actions with conform-exceed control pass/reclassify
# Test d946: Add police actions with conform-exceed control pass/pipe
# Test ddd6: Add police action with invalid rate value
# Test f61c: Add police action with invalid burst value
# Test 6aaf: Add police actions with conform-exceed control pass/pipe [with numeric values]
# Test 29b1: Add police actions with conform-exceed control <invalid>/drop
# Test c26f: Add police action with invalid peakrate value
# Test db04: Add police action with invalid mtu value
# Test f3c9: Add police action with cookie
# Test d190: Add police action with maximum index
# Test 336e: Delete police action
# Test 77fa: Get single police action from many actions
# Test aa43: Get single police action without specifying index
# Test 858b: List police actions
# Test fa1c: Add mpls dec_ttl action with ttl (invalid)
# Test 6b79: Add mpls dec_ttl action with bos (invalid)
# Test d4c4: Add mpls pop action with ip proto
# Test 91fb: Add mpls pop action with ip proto and cookie
# Test 92fe: Add mpls pop action with mpls proto
# Test 7e23: Add mpls pop action with no protocol (invalid)
# Test 6182: Add mpls pop action with label (invalid)
# Test 6475: Add mpls pop action with tc (invalid)
# Test 067b: Add mpls pop action with ttl (invalid)
# Test 7316: Add mpls pop action with bos (invalid)
# Test 38cc: Add mpls push action with label
# Test c281: Add mpls push action with mpls_mc protocol
# Test 5db4: Add mpls push action with label, tc and ttl
# Test 7c34: Add mpls push action with label, tc ttl and cookie of max length
# Test 16eb: Add mpls push action with label and bos
# Test d69d: Add mpls push action with no label (invalid)
# Test e8e4: Add mpls push action with ipv4 protocol (invalid)
# Test ecd0: Add mpls push action with out of range label (invalid)
# Test d303: Add mpls push action with out of range tc (invalid)
# Test fd6e: Add mpls push action with ttl of 0 (invalid)
# Test 19e9: Add mpls mod action with mpls label
# Test 1fde: Add mpls mod action with max mpls label
# Test 0c50: Add mpls mod action with mpls label exceeding max (invalid)
# Test 10b6: Add mpls mod action with mpls label of MPLS_LABEL_IMPLNULL (invalid)
# Test 57c9: Add mpls mod action with mpls min tc
# Test 6872: Add mpls mod action with mpls max tc
# Test a70a: Add mpls mod action with mpls tc exceeding max (invalid)
# Test 6ed5: Add mpls mod action with mpls ttl
# Test 77c1: Add mpls mod action with mpls ttl and cookie
# Test b80f: Add mpls mod action with mpls max ttl
# Test 8864: Add mpls mod action with mpls min ttl
# Test 6c06: Add mpls mod action with mpls ttl of 0 (invalid)
# Test b5d8: Add mpls mod action with mpls ttl exceeding max (invalid)
# Test 451f: Add mpls mod action with mpls max bos
# Test a1ed: Add mpls mod action with mpls min bos
# Test 3dcf: Add mpls mod action with mpls bos exceeding max (invalid)
# Test db7c: Add mpls mod action with protocol (invalid)
# Test b070: Replace existing mpls push action with new ID
# Test 95a9: Replace existing mpls push action with new label, tc, ttl and cookie
# Test 6cce: Delete mpls pop action
# Test d138: Flush mpls actions
# Test 319a: Add pedit action that mangles IP TTL
# Test 7e67: Replace pedit action with invalid goto chain
# Test 377e: Add pedit action with RAW_OP offset u32
# Test a0ca: Add pedit action with RAW_OP offset u32 (INVALID)
# Test dd8a: Add pedit action with RAW_OP offset u16 u16
# Test 53db: Add pedit action with RAW_OP offset u16 (INVALID)
# Test 5c7e: Add pedit action with RAW_OP offset u8 add value
# Test 3a07: Add pedit action with RAW_OP offset u8-u16-u8
# Test ab0f: Add pedit action with RAW_OP offset u16-u8-u8
# Test 9d12: Add pedit action with RAW_OP offset u32 set u16 clear u8 invert
# Test ebfa: Add pedit action with RAW_OP offset overflow u32 (INVALID)
# Test f512: Add pedit action with RAW_OP offset u16 at offmask shift set
# Test c2cb: Add pedit action with RAW_OP offset u32 retain value
# Test 1762: Add pedit action with RAW_OP offset u8 clear value
# Test bcee: Add pedit action with RAW_OP offset u8 retain value
# Test e89f: Add pedit action with RAW_OP offset u16 retain value
# Test c282: Add pedit action with RAW_OP offset u32 clear value
# Test c422: Add pedit action with RAW_OP offset u16 invert value
# Test d3d3: Add pedit action with RAW_OP offset u32 invert value
# Test 57e5: Add pedit action with RAW_OP offset u8 preserve value
# Test 99e0: Add pedit action with RAW_OP offset u16 preserve value
# Test 1892: Add pedit action with RAW_OP offset u32 preserve value
# Test 4b60: Add pedit action with RAW_OP negative offset u16/u32 set value
# multiprocessing.pool.RemoteTraceback: 
# """
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
#     self._nl_ns_create()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
#     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/iproute/linux.py", line 1696, in link
#     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 870, in nlm_request
#     return tuple(self._genlm_request(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 1214, in nlm_request
#     for msg in self.get(
#                ^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 873, in get
#     return tuple(self._genlm_get(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 550, in get
#     raise msg['header']['error']
# pyroute2.netlink.exceptions.NetlinkError: (34, 'Numerical result out of range')
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
# considering category qdisc
#  -- scapy/SubPlugin.__init__
#  -- ns/SubPlugin.__init__
# Executing 294 tests in parallel and 33 in serial
# Using 11 batches and 4 workers
# 
# -----> prepare stage *** Could not execute: "$IP link add dev $ETH type dummy"
# 
# -----> prepare stage *** Error message: "RTNETLINK answers: File exists
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
# ......................Test 30c4: Add ETS qdisc with quanta + priomap
# Test e8ac: Add ETS qdisc with strict + priomap
# Test 5a7e: Add ETS qdisc with quanta + strict + priomap
# Test cb8b: Show ETS class :1
# Test 1b4e: Show ETS class :2
# Test f642: Show ETS class :3
# Test 0a5f: Show ETS strict class
# Test f7c8: Add ETS qdisc with too many quanta
# Test 2389: Add ETS qdisc with too many strict
# Test fe3c: Add ETS qdisc with too many strict + quanta
# Test cb04: Add ETS qdisc with excess priomap elements
# Test c32e: Add ETS qdisc with priomap above bands
# Test 744c: Add ETS qdisc with priomap above quanta
# Test 7b33: Add ETS qdisc with priomap above strict
# Test dbe6: Add ETS qdisc with priomap above strict + quanta
# Test bdb2: Add ETS qdisc with priomap within bands with strict + quanta
# Test 39a3: Add ETS qdisc with priomap above bands with strict + quanta
# Test 557c: Unset priorities default to the last band
# Test a347: Unset priorities default to the last band -- no priomap
# Test 39c4: Add ETS qdisc with too few bands
# Test 930b: Add ETS qdisc with too many bands
# Test 406a: Add ETS qdisc without parameters
# Test e51a: Zero element in quanta
# Test e7f2: Sole zero element in quanta
# Test d6e6: No values after the quanta keyword
# Test 28c6: Change ETS band quantum
# Test 4714: Change ETS band without quantum
# Test 6979: Change quantum of a strict ETS band
# Test 9a7d: Change ETS strict band without quantum
# Test 283e: Create skbprio with default setting
# Test c086: Create skbprio with limit setting
# Test 6733: Change skbprio with limit setting
# Test fe0f: Add prio qdisc on egress with 4 bands and priomap exceeding TC_PRIO_MAX entries
# Test 1f91: Add prio qdisc on egress with 4 bands and priomap's values exceeding bands number
# Test d248: Add prio qdisc on egress with invalid bands value (< 2)
# Test 1d0e: Add prio qdisc on egress with invalid bands value exceeding TCQ_PRIO_BANDS
# Test 1971: Replace default prio qdisc on egress with 8 bands and new priomap
# Test d88a: Add duplicate prio qdisc on egress
# Test 5948: Delete nonexistent prio qdisc
# Test 6c0a: Add prio qdisc on egress with invalid format for handles
# Test 0175: Delete prio qdisc twice
# Test 2410: Show prio class
# Test 0385: Create DRR with default setting
# Test 2375: Delete DRR with handle
# Test 3092: Show DRR class
# Test e90e: Add ETS qdisc using bands
# Test b059: Add ETS qdisc using quanta
# Test e8e7: Add ETS qdisc using strict
# Test 233c: Add ETS qdisc using bands + quanta
# Test 3d35: Add ETS qdisc using bands + strict
# Test 7f3b: Add ETS qdisc using strict + quanta
# Test 4593: Add ETS qdisc using strict 0 + quanta
# Test 8938: Add ETS qdisc using bands + strict + quanta
# Test 0782: Add ETS qdisc with more bands than quanta
# Test 501b: Add ETS qdisc with more bands than strict
# Test 671a: Add ETS qdisc with more bands than strict + quanta
# Test 2a23: Add ETS qdisc with 16 bands
# Test 8daf: Add ETS qdisc with 17 bands
# Test 7f95: Add ETS qdisc with 17 strict
# Test 837a: Add ETS qdisc with 16 quanta
# Test 65b6: Add ETS qdisc with 17 quanta
# Test b9e9: Add ETS qdisc with 16 strict + quanta
# Test 9877: Add ETS qdisc with 17 strict + quanta
# Test c696: Add ETS qdisc with priomap
# Test 20ba: Add multiq Qdisc to multi-queue device (8 queues)
# Test 4301: List multiq Class
# Test 7832: Delete nonexistent multiq Qdisc
# Test 2891: Delete multiq Qdisc twice
# Test 1329: Add multiq Qdisc to single-queue device
# Test 84a0: Create TEQL with default setting
# Test 7734: Create TEQL with multiple device
# returncode 2; expected [0]
# "-----> prepare stage" did not complete successfully
# Exception <class '__main__.PluginMgrTestFail'> ('setup', None, '"-----> prepare stage" did not complete successfully') (caught in test_runner, running test 8 7734 Create TEQL with multiple device stage setup)
# ---------------
# traceback
# ---------------
# ---------------
# Test 2958: Show skbprio class
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 0301: Change CHOKE with limit setting
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 2385: Create CAKE with besteffort flag
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 0521: Show ingress class
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test b190: Create FQ_CODEL with noecn flag
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 5439: Create NETEM with multiple slot setting
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# Test 30a9: Create SFB with increment setting
# exception (34, 'Numerical result out of range') in call to pre_case for <class 'plugin-lib.nsPlugin.SubPlugin'> plugin
# multiprocessing.pool.RemoteTraceback: 
# """
# Traceback (most recent call last):
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/./tdc.py", line 142, in call_pre_case
#     pgn_inst.pre_case(caseinfo, test_skip)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
#     self.prepare_test(test)
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
#     self._nl_ns_create()
#   File "/mnt/share156/jiri/net-next/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
#     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/iproute/linux.py", line 1696, in link
#     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
#           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 870, in nlm_request
#     return tuple(self._genlm_request(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 1214, in nlm_request
#     for msg in self.get(
#                ^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 873, in get
#     return tuple(self._genlm_get(*argv, **kwarg))
#            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#   File "/usr/local/lib/python3.11/site-packages/pyroute2/netlink/nlsocket.py", line 550, in get
#     raise msg['header']['error']
# pyroute2.netlink.exceptions.NetlinkError: (34, 'Numerical result out of range')
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

