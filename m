Return-Path: <netdev+bounces-182652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D960AA897FD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BF57A2675
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED517284673;
	Tue, 15 Apr 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="XHCVQ/P1"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030428466A
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709387; cv=none; b=SZdt9Rpj7hbNZkcV97taNNdIpluHh9P6bxvvIxZ8itaZ0bqvPNQlyjL0CJ/FsDIMIDo1KwQYNMxN17fZP8lbd274obIdsPQ8s2h9A6x0xpZaBDorvfhP/aLZH2KvWnwob8dTHrCEjUEW94vF1sb4u5HNeisGcwXNNT8d2SywyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709387; c=relaxed/simple;
	bh=fIvX4K90QnzvcHrbsLpfxLYLZ0zU9LuMhu1ogutJ8vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cr3XLcVOj3RzOQOv+mpZnXaHWO4usFMT7i9bx+TYifIll3iqPV+9xIsGWBiZBrLE+B2J4ZCzJsK5OC8CXlcMK5CoaRR4EVECTLl0hU21ogrwu7taysR5jp0ZtL7he673Ksy+l8UHPf0PFz21bB3ezewICjujGetPQJdptgNKxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=XHCVQ/P1; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BB60A200DF81;
	Tue, 15 Apr 2025 11:29:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BB60A200DF81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744709383;
	bh=R9tcLzpBT1e66f/XqFclz0u4cq/unBnvVYkQTTwfPVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XHCVQ/P1laLl0QI5Xxcb+1GR5a5POhvQjE9Uo7Eqn1wq7b5wsUMbJUFjVtpt/MvLM
	 YZyNRKGU39yOosvSk4ThlDZrEGRPk7bG8a9m8oNm1+srVEK0ijUkd3qw8IfXQRho/v
	 +PGHjLrbommwAd/ta+nJzltkvHXY+6mu8HL0IYvIxKQ3A4NoIuhP2BgtsgpNk+O/8Z
	 km1QEJALqYR5u8k5JnC+a6+gioqJnMO8eNVscji24+c1HWKvxhKkFbQHwkEDD7Vdk5
	 U21cgQjnyTiyPCazA3XmoM1hlIaRK/idTGStiGDyQLIY8HLY8Z2yL6CKTmXVIai6mu
	 1A3nYAigZffoQ==
Message-ID: <e5a894e5-5637-4aba-89c2-66173df1a589@uliege.be>
Date: Tue, 15 Apr 2025 11:29:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] net: fix lwtunnel reentry loops
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20250314120048.12569-1-justin.iurman@uliege.be>
 <m2h62qwf34.fsf@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <m2h62qwf34.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 00:30, Eduard Zingerman wrote:
> Justin Iurman <justin.iurman@uliege.be> writes:
> 
>> v2:
>> - removed some patches from the -v1 series
>> - added a patch that was initially sent separately
>> - code style for the selftest (thanks Paolo)
>> v1:
>> - https://lore.kernel.org/all/20250311141238.19862-1-justin.iurman@uliege.be/
> 
> Hi Justin,
> 
> I've noticed a BUG splat likely introduced by this patch.
> The splat is reported when executing some BPF selftests,
> e.g. lwt_ip_encap_ipv4/egress
> (defined in tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c and
>              tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c).
> 
> Decoded splat is at the end of the email.
> Line numbers correspond to commit
> a27a97f71394 ("Merge branch 'bpf-support-atomic-update-for-htab-of-maps'")
> from the kernel/git/bpf/bpf-next.git tree.

Hi Eduard,

This is currently discussed in [1]. We have a solution, but no consensus 
on the fix yet.

   [1] 
https://lore.kernel.org/netdev/3cee5141-c525-4e83-830e-bf21828aed51@uliege.be/T/#t

Thanks for the report,
Justin

> Thanks,
> Eduard
> 
> ---
> 
> [  193.993893] BUG: using __this_cpu_add() in preemptible [00000000] code: test_progs/206
> [  193.994292] caller is lwtunnel_xmit (net/core/dev.h:340 net/core/lwtunnel.c:408)
> [  193.994601] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  193.994603] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.el9 04/01/2014
> [  193.994605] Call Trace:
> [  193.994608]  <TASK>
> [  193.994611] dump_stack_lvl (lib/dump_stack.c:122)
> [  193.994622] check_preemption_disabled (lib/smp_processor_id.c:0)
> [  193.994630] ? lwtunnel_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/core/lwtunnel.c:403)
> [  193.994637] lwtunnel_xmit (net/core/dev.h:340 net/core/lwtunnel.c:408)
> [  193.994648] ip_finish_output2 (net/ipv4/ip_output.c:222)
> [  193.994655] ? ip_skb_dst_mtu (./include/net/ip.h:517)
> [  193.994659] ? ip_skb_dst_mtu (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 ./include/net/ip.h:471 ./include/net/ip.h:512)
> [  193.994669] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.994672] ? __ip_finish_output (net/ipv4/ip_output.c:306)
> [  193.994683] ? __ip_queue_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/ipv4/ip_output.c:470)
> [  193.994688] __ip_queue_xmit (net/ipv4/ip_output.c:527)
> [  193.994693] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.994711] ? __ip_queue_xmit (./include/linux/rcupdate.h:331 ./include/linux/rcupdate.h:841 net/ipv4/ip_output.c:470)
> [  193.994726] __tcp_transmit_skb (net/ipv4/tcp_output.c:1479)
> [  193.994800] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.994804] ? __asan_memset (mm/kasan/shadow.c:84)
> [  193.994810] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.994824] tcp_connect (net/ipv4/tcp_output.c:0 net/ipv4/tcp_output.c:4155)
> [  193.994890] tcp_v4_connect (net/ipv4/tcp_ipv4.c:343)
> [  193.994926] __inet_stream_connect (net/ipv4/af_inet.c:678)
> [  193.994944] ? __local_bh_enable_ip (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:119 kernel/softirq.c:412)
> [  193.994950] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.994953] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4473)
> [  193.994967] inet_stream_connect (net/ipv4/af_inet.c:748)
> [  193.994976] ? __pfx_inet_stream_connect (net/ipv4/af_inet.c:744)
> [  193.994981] __sys_connect (./include/linux/file.h:62 ./include/linux/file.h:83 net/socket.c:2058)
> [  193.995013] __x64_sys_connect (net/socket.c:2063 net/socket.c:2060 net/socket.c:2060)
> [  193.995022] do_syscall_64 (arch/x86/entry/syscall_64.c:0)
> [  193.995026] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
> [  193.995030] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4473)
> [  193.995038] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  193.995042] RIP: 0033:0x7faec2d0f9cb
> [ 193.995047] Code: 83 ec 18 89 54 24 0c 48 89 34 24 89 7c 24 08 e8 4b 70 f7 ff 8b 54 24 0c 48 8b 34 24 41 89 c0 8b 7c 24 08 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 08 e8 a1 70 f7 ff 8b 44
> All code
> ========
>     0:	83 ec 18             	sub    $0x18,%esp
>     3:	89 54 24 0c          	mov    %edx,0xc(%rsp)
>     7:	48 89 34 24          	mov    %rsi,(%rsp)
>     b:	89 7c 24 08          	mov    %edi,0x8(%rsp)
>     f:	e8 4b 70 f7 ff       	call   0xfffffffffff7705f
>    14:	8b 54 24 0c          	mov    0xc(%rsp),%edx
>    18:	48 8b 34 24          	mov    (%rsp),%rsi
>    1c:	41 89 c0             	mov    %eax,%r8d
>    1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
>    23:	b8 2a 00 00 00       	mov    $0x2a,%eax
>    28:	0f 05                	syscall
>    2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>    30:	77 35                	ja     0x67
>    32:	44 89 c7             	mov    %r8d,%edi
>    35:	89 44 24 08          	mov    %eax,0x8(%rsp)
>    39:	e8 a1 70 f7 ff       	call   0xfffffffffff770df
>    3e:	8b                   	.byte 0x8b
>    3f:	44                   	rex.R
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>     6:	77 35                	ja     0x3d
>     8:	44 89 c7             	mov    %r8d,%edi
>     b:	89 44 24 08          	mov    %eax,0x8(%rsp)
>     f:	e8 a1 70 f7 ff       	call   0xfffffffffff770b5
>    14:	8b                   	.byte 0x8b
>    15:	44                   	rex.R
> [  193.995050] RSP: 002b:00007fff992d3a20 EFLAGS: 00000293 ORIG_RAX: 000000000000002a
> [  193.995054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faec2d0f9cb
> [  193.995057] RDX: 0000000000000010 RSI: 00007fff992d3ad8 RDI: 0000000000000035
> [  193.995059] RBP: 00007fff992d3ac0 R08: 0000000000000000 R09: 0000000000000004
> [  193.995062] R10: 00007fff992d39b0 R11: 0000000000000293 R12: 00007fff992d7b78
> [  193.995064] R13: 000000000095f760 R14: 0000000002e38b90 R15: 00007faec373d000
> [  193.995091]  </TASK>
> 

