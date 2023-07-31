Return-Path: <netdev+bounces-22841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933BD7698DF
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E8F28123C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14118AF7;
	Mon, 31 Jul 2023 14:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86C17AD9
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 14:01:00 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2855B3
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:00:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso384281cf.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690812029; x=1691416829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5ijRtp4iBRB0BnhlyPyjktnH3kk03wFb3p+B4QF4do=;
        b=spYpHaK1ogbVgysyF7i+vICYOPKkhZSkPYW+Q7b1Ll5be0sV73H+3TWcqaSpkwSiWS
         c1OtbmOsCYfPUtK2WyrraaskFKs7flQD77P6Yw0PkUUPuWAf10/7Sd0f/cDcUZIytuqm
         eL7vsjU9lP1Aiqs81LK5XVwQjZNbqpUTffyD+Bv+3ysw4Id2+r5XSfOxk8jtyQ+d+N1S
         5UPhhd9ohRLlcnHPfSMalWIeRq9qKv39BDcQu0a4Yd47E166jeFyDaaUrG3ttb6lZyoh
         fmgYw+R6zpzRSY+7INaJGhBPESF6QZbRKpuNwMJjLk4jDlq9F5V7Zd7W44Jv/AR78Uup
         lOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812029; x=1691416829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5ijRtp4iBRB0BnhlyPyjktnH3kk03wFb3p+B4QF4do=;
        b=eUp5qOSEm1JSAqms0bX9qIERnnK5p8bG3tYaIrCNx8Pq+RUsCUO9zV52541t+6PcGL
         aKS1wX38bChup2Z0LqKPdD0UvZCGfpzi9R24qUAozAK9hwGeDWo2OEsQCRh6NbzC2z2h
         2qd3UU72OOy3eAYyiuZZScIiZEduabEw9ZQKZLMx4N/7G5gPjA4OnSy8LTURQGoqtU7Q
         PmYxwkqqdR6PnXr2bs2yyfhVoh7Vk74YfmThEcoFAbFpnbCCKsNBJzeR3R2jm8+rAgh9
         m5FPLsfDH2oLYUWoPVUiun6v2wFAjihrm/0MJ8bOzV41+ek4eGskrAwOTdfovr0iKq/k
         478Q==
X-Gm-Message-State: ABy/qLZ8fu39irQQX971Nu0uQCyhDmSFAcuzKL2e4rZK/5eqURGJNsfu
	FP30FiR8WA/fIkGGCNHT+14w1PmsdvdzYAB1uWfsaA==
X-Google-Smtp-Source: APBJJlFbq4zHio5mQ+cFVpbRr1kc+DjINLazJKx0bdf+RpT6a6UwCJas8ssF9DJ/D6DHFnC4N9vNTVrYWn7yyclmpTM=
X-Received: by 2002:a05:622a:1493:b0:404:8218:83da with SMTP id
 t19-20020a05622a149300b00404821883damr429985qtx.1.1690812029198; Mon, 31 Jul
 2023 07:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202307312121.d8479e5e-oliver.sang@intel.com>
In-Reply-To: <202307312121.d8479e5e-oliver.sang@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Jul 2023 16:00:17 +0200
Message-ID: <CANn89iLoBdbV55Ws0KJaizgmmcG1YYXKzT9iTM+y07bBTQ9SvQ@mail.gmail.com>
Subject: Re: [linux-next:master] [tcp] dfa2f04833: stress-ng.sock.ops_per_sec
 -7.3% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 3:35=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -7.3% regression of stress-ng.sock.ops_per_se=
c on:
>
>
> commit: dfa2f0483360d4d6f2324405464c9f281156bd87 ("tcp: get rid of sysctl=
_tcp_adv_win_scale")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> testcase: stress-ng
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.0=
0GHz (Cascade Lake) with 128G memory
> parameters:
>

TCP 'performance' on some tests depends on initial values for
tcp_rmem[] (and many others sysctl)

The commit changed some initial RWIN values for some MTU/MSS setings,
it is next to impossible to make a change that is a win for all cases.

If you care about a particular real workload, not a synthetic benchmark,
I think you should give us more details.

Thanks.

>         nr_threads: 1
>         disk: 1HDD
>         testtime: 60s
>         fs: ext4
>         class: os
>         test: sock
>         cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307312121.d8479e5e-oliver.san=
g@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_gr=
oup/test/testcase/testtime:
>   os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/1/debian-11.1-x86_64-20=
220510.cgz/lkp-csl-d02/sock/stress-ng/60s
>
> commit:
>   63c8778d91 ("Merge branch 'net-mana-fix-doorbell-access-for-receive-que=
ues'")
>   dfa2f04833 ("tcp: get rid of sysctl_tcp_adv_win_scale")
>
> 63c8778d9149d5df dfa2f0483360d4d6f2324405464
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    8094125           +21.5%    9832824 =C4=85 18%  cpuidle..usage
>       5.04            -6.1%       4.73 =C4=85 10%  iostat.cpu.system
>     330990 =C4=85  2%     -32.3%     223958 =C4=85  3%  turbostat.C1
>    4685666           +22.3%    5729557        turbostat.POLL
>      23600 =C4=85  8%     +51.9%      35849 =C4=85 25%  sched_debug.cfs_r=
q:/.min_vruntime.max
>       4907 =C4=85  7%     +44.2%       7073 =C4=85 45%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>       4911 =C4=85  7%     +44.1%       7075 =C4=85 45%  sched_debug.cfs_r=
q:/.spread0.stddev
>      43.08 =C4=85 15%     -41.0%      25.42 =C4=85 32%  perf-sched.wait_a=
nd_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_ite=
r.vfs_write.ksys_write
>     269948 =C4=85  2%      +8.1%     291932 =C4=85  2%  perf-sched.wait_a=
nd_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
>      43.08 =C4=85 15%     -41.0%      25.42 =C4=85 32%  perf-sched.wait_t=
ime.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs=
_write.ksys_write
>       0.02 =C4=85 31%     +35.0%       0.03 =C4=85  5%  perf-sched.wait_t=
ime.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_sendmsg._=
_sys_sendto
>      93552            -7.3%      86706        stress-ng.sock.ops
>       1559            -7.3%       1445        stress-ng.sock.ops_per_sec
>     139.17            -3.4%     134.50        stress-ng.time.percent_of_c=
pu_this_job_got
>    5092570           +18.6%    6039727        stress-ng.time.voluntary_co=
ntext_switches
>       1.45            +1.4        2.83 =C4=85105%  perf-stat.i.branch-mis=
s-rate%
>    1620951 =C4=85 30%     -39.7%     977769 =C4=85 37%  perf-stat.i.dTLB-=
store-misses
>     911.68            -3.6%     878.55        perf-stat.i.instructions-pe=
r-iTLB-miss
>       1.54            +0.2        1.69 =C4=85 15%  perf-stat.overall.bran=
ch-miss-rate%
>       0.16 =C4=85 30%      -0.1        0.10 =C4=85 22%  perf-stat.overall=
.dTLB-store-miss-rate%
>     742.16            -4.3%     710.16        perf-stat.overall.instructi=
ons-per-iTLB-miss
>    1595258 =C4=85 30%     -39.6%     962800 =C4=85 37%  perf-stat.ps.dTLB=
-store-misses
>      67709           +12.6%      76211 =C4=85 14%  proc-vmstat.nr_active_=
anon
>      73849           +11.0%      81975 =C4=85 11%  proc-vmstat.nr_shmem
>      67709           +12.6%      76211 =C4=85 14%  proc-vmstat.nr_zone_ac=
tive_anon
>    6320969            -6.7%    5895784        proc-vmstat.numa_hit
>    6314894            -6.8%    5885708        proc-vmstat.numa_local
>     102508            +5.9%     108525        proc-vmstat.pgactivate
>   48068383            -7.3%   44558110        proc-vmstat.pgalloc_normal
>   47937851            -7.3%   44421205        proc-vmstat.pgfree
>       0.70 =C4=85 14%      +0.2        0.88 =C4=85 14%  perf-profile.call=
trace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.flush_sm=
p_call_function_queue.do_idle.cpu_startup_entry
>       0.48 =C4=85 47%      +0.2        0.70 =C4=85 14%  perf-profile.call=
trace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.sec=
ondary_startup_64_no_verify
>       2.76 =C4=85  9%      +0.5        3.30 =C4=85  2%  perf-profile.call=
trace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_de=
liver_rcu.ip_local_deliver_finish
>       0.39 =C4=85 72%      +0.6        0.95 =C4=85 24%  perf-profile.call=
trace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_=
def_readable.tcp_data_queue
>       3.32 =C4=85 10%      +0.7        4.00        perf-profile.calltrace=
.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_delive=
r_finish.__netif_receive_skb_one_core
>       6.88 =C4=85  7%      +0.8        7.71 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.ne=
t_rx_action.__do_softirq
>       7.18 =C4=85  7%      +0.8        8.02 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__napi_poll.net_rx_action.__do_softirq.do_softirq.__local_b=
h_enable_ip
>       7.16 =C4=85  7%      +0.9        8.02 =C4=85  2%  perf-profile.call=
trace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__do_softirq.do_s=
oftirq
>       8.90 =C4=85  6%      +1.0        9.89        perf-profile.calltrace=
.cycles-pp.net_rx_action.__do_softirq.do_softirq.__local_bh_enable_ip.__dev=
_queue_xmit
>       9.37 =C4=85  6%      +1.0       10.40        perf-profile.calltrace=
.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_que=
ue_xmit.__tcp_transmit_skb
>       9.33 =C4=85  6%      +1.0       10.37        perf-profile.calltrace=
.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_outpu=
t2.__ip_queue_xmit
>       9.26 =C4=85  6%      +1.0       10.30        perf-profile.calltrace=
.cycles-pp.__do_softirq.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip=
_finish_output2
>       2.48 =C4=85 17%      +1.3        3.82 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_pus=
h_pending_frames.tcp_sendmsg_locked
>       2.61 =C4=85 17%      +1.3        3.96 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames=
.tcp_sendmsg_locked.tcp_sendmsg
>       0.80 =C4=85 15%      -0.4        0.43 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.tcp_rcv_space_adjust
>       1.35 =C4=85  5%      -0.2        1.19 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.__entry_text_start
>       0.56 =C4=85 15%      -0.2        0.40 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__x64_sys_connect
>       0.56 =C4=85 15%      -0.2        0.40 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__sys_connect
>       0.55 =C4=85 14%      -0.2        0.40 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.inet_stream_connect
>       0.55 =C4=85 15%      -0.1        0.40 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.__inet_stream_connect
>       0.38 =C4=85 11%      -0.1        0.28 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.exit_to_user_mode_loop
>       0.44 =C4=85  9%      -0.1        0.33 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.__close
>       0.37 =C4=85 12%      -0.1        0.27 =C4=85 20%  perf-profile.chil=
dren.cycles-pp.task_work_run
>       0.77 =C4=85  5%      -0.1        0.68 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.34 =C4=85 12%      -0.1        0.26 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.__fput
>       0.31 =C4=85 11%      -0.1        0.23 =C4=85 18%  perf-profile.chil=
dren.cycles-pp.tcp_v4_connect
>       0.22 =C4=85 14%      -0.1        0.16 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.__sock_release
>       0.22 =C4=85 14%      -0.1        0.16 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.sock_close
>       0.23 =C4=85 19%      -0.1        0.16 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.tcp_try_coalesce
>       0.09 =C4=85 14%      -0.0        0.05 =C4=85 48%  perf-profile.chil=
dren.cycles-pp.new_inode_pseudo
>       0.07 =C4=85 12%      -0.0        0.04 =C4=85 72%  perf-profile.chil=
dren.cycles-pp.__ns_get_path
>       0.17 =C4=85  8%      +0.0        0.22 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.ip_send_check
>       0.23 =C4=85  7%      +0.0        0.28 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.ip_local_out
>       0.09 =C4=85 22%      +0.0        0.14 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.available_idle_cpu
>       0.22 =C4=85  9%      +0.1        0.26 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__ip_local_out
>       0.46 =C4=85 11%      +0.1        0.56 =C4=85  4%  perf-profile.chil=
dren.cycles-pp.ttwu_queue_wakelist
>       0.92 =C4=85  3%      +0.1        1.06 =C4=85  5%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       7.10 =C4=85  2%      +0.7        7.76 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.tcp_v4_rcv
>       7.21 =C4=85  2%      +0.7        7.90 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.ip_protocol_deliver_rcu
>       7.42 =C4=85  2%      +0.7        8.12 =C4=85  3%  perf-profile.chil=
dren.cycles-pp.ip_local_deliver_finish
>       8.00 =C4=85  2%      +0.7        8.71 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__netif_receive_skb_one_core
>       8.34 =C4=85  2%      +0.7        9.06 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__napi_poll
>       8.32 =C4=85  2%      +0.7        9.05 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.process_backlog
>      11.71 =C4=85  3%      +0.9       12.63 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__dev_queue_xmit
>      13.86 =C4=85  2%      +0.9       14.78 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__tcp_transmit_skb
>      11.92 =C4=85  2%      +0.9       12.86 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.ip_finish_output2
>      10.05 =C4=85  3%      +0.9       10.99 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.net_rx_action
>      12.66 =C4=85  2%      +1.0       13.62 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__ip_queue_xmit
>      10.56 =C4=85  3%      +1.0       11.53 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.do_softirq
>      10.82 =C4=85  3%      +1.0       11.80 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__local_bh_enable_ip
>      10.94 =C4=85  4%      +1.0       11.94 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__do_softirq
>       0.52 =C4=85 21%      -0.4        0.16 =C4=85 16%  perf-profile.self=
.cycles-pp.tcp_rcv_space_adjust
>       0.62 =C4=85  7%      -0.1        0.48 =C4=85 10%  perf-profile.self=
.cycles-pp.tcp_sendmsg
>       0.63 =C4=85  5%      -0.1        0.55 =C4=85  7%  perf-profile.self=
.cycles-pp.__entry_text_start
>       0.10 =C4=85 15%      +0.0        0.14 =C4=85 13%  perf-profile.self=
.cycles-pp.schedule_timeout
>       0.10 =C4=85 20%      +0.0        0.14 =C4=85 16%  perf-profile.self=
.cycles-pp.enqueue_entity
>       0.08 =C4=85 22%      +0.1        0.14 =C4=85 11%  perf-profile.self=
.cycles-pp.available_idle_cpu
>       0.37 =C4=85  8%      +0.1        0.44 =C4=85  4%  perf-profile.self=
.cycles-pp.net_rx_action
>       0.92 =C4=85  3%      +0.1        1.06 =C4=85  5%  perf-profile.self=
.cycles-pp._raw_spin_lock_irqsave
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

