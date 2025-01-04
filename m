Return-Path: <netdev+bounces-155183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4494FA01609
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 18:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164233A4240
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5D1CEAD1;
	Sat,  4 Jan 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOkMOTyA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA91922E6
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736010013; cv=none; b=RSIJ2B6b2n4Mq1kQLyTouOb0KR2oWDv3IndjXNVdenjkRnvADWbrlYWCcVqkS0P1FqskP4Kw2xAaT+dykaU99Z4CKMeKLjxxVFmsj+k0P1mMRPbvWJaGjti1oHTyn9w74XfoL5YyELU+4R5sEMN+xcqtPtiVQPXCvGGJT2ujCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736010013; c=relaxed/simple;
	bh=/XrO9+mJltCxN5jcOy6MMCmsVswOd6dNkbca0YFdyYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pVh8PKNMLEyxQYMSetunFQFyPnZHlKi+kIHYnD2MJ2drRbGoDGxYcrSBPSVn95WmWjBYaX1PTKvNH9nZnrLyB8pyyJg7nJHr9SoeGyyCBLamek/5z2KHPycrtTJxXkAwLUHFhHypI3FQhOQwTGjJxQ/O/nW2IqWsSOW+NHX5Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOkMOTyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417BFC4CED1;
	Sat,  4 Jan 2025 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736010013;
	bh=/XrO9+mJltCxN5jcOy6MMCmsVswOd6dNkbca0YFdyYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MOkMOTyADUzGzqWfTl/gJbmant5xjWXlfebg9NP5PSpLMajUbZ8zJTPioqFED99Kd
	 aVhQd79JXAGTKe+dBfZal5+WqM0g1NTwsMtMBqKqACY0TFcfTVqyNNIkTXzghNbGbT
	 HYGABMa52u5uhsNS2fx1DNuuc0BW3asScd0ckxphw8v+vEFwD9EmgwFiXLNqx60gtp
	 0LUqfw14dq6ZvRTnEa37RvHr/xuyRcGGGpzAWaIIwSsyvolzey1xdoZLlgHZyyrd/d
	 1Aa3fLLq4ealzNgjIeEO81nVbxhOpaxEOcZwT7L1aBiDSWBUhlWCm/K1k4Pv9jrvG1
	 xyDUVeFqTSULA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE6380A96F;
	Sat,  4 Jan 2025 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173601003376.2470506.3933525415980979129.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 17:00:33 +0000
References: <20250103104546.3714168-1-edumazet@google.com>
In-Reply-To: <20250103104546.3714168-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 victor@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1dbb57d994e54aaa04d2@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Jan 2025 10:45:46 +0000 you wrote:
> syzbot found that TCA_FLOW_RSHIFT attribute was not validated.
> Right shitfing a 32bit integer is undefined for large shift values.
> 
> UBSAN: shift-out-of-bounds in net/sched/cls_flow.c:329:23
> shift exponent 9445 is too large for 32-bit type 'u32' (aka 'unsigned int')
> CPU: 1 UID: 0 PID: 54 Comm: kworker/u8:3 Not tainted 6.13.0-rc3-syzkaller-00180-g4f619d518db9 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: ipv6_addrconf addrconf_dad_work
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   ubsan_epilogue lib/ubsan.c:231 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>   flow_classify+0x24d5/0x25b0 net/sched/cls_flow.c:329
>   tc_classify include/net/tc_wrapper.h:197 [inline]
>   __tcf_classify net/sched/cls_api.c:1771 [inline]
>   tcf_classify+0x420/0x1160 net/sched/cls_api.c:1867
>   sfb_classify net/sched/sch_sfb.c:260 [inline]
>   sfb_enqueue+0x3ad/0x18b0 net/sched/sch_sfb.c:318
>   dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3793
>   __dev_xmit_skb net/core/dev.c:3889 [inline]
>   __dev_queue_xmit+0xf0e/0x3f50 net/core/dev.c:4400
>   dev_queue_xmit include/linux/netdevice.h:3168 [inline]
>   neigh_hh_output include/net/neighbour.h:523 [inline]
>   neigh_output include/net/neighbour.h:537 [inline]
>   ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:236
>   iptunnel_xmit+0x55d/0x9b0 net/ipv4/ip_tunnel_core.c:82
>   udp_tunnel_xmit_skb+0x262/0x3b0 net/ipv4/udp_tunnel_core.c:173
>   geneve_xmit_skb drivers/net/geneve.c:916 [inline]
>   geneve_xmit+0x21dc/0x2d00 drivers/net/geneve.c:1039
>   __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5011 [inline]
>   xmit_one net/core/dev.c:3590 [inline]
>   dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3606
>   __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4434
> 
> [...]

Here is the summary with links:
  - [net] net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute
    https://git.kernel.org/netdev/net/c/a039e54397c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



