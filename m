Return-Path: <netdev+bounces-97905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016368CDD1D
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 01:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5D11F21108
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1C584D25;
	Thu, 23 May 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6eMtWCt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E83763E6
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505689; cv=none; b=tGgtcFv86tXoOyLVxfEIJIsch2DRBWwI1+X0UBEHZltTGcnQ1XnXBbNs0XE4prU18m3oGo/kHzX/0il77g1Rncx+Q5IO8blY3ZW1YcpeNMnN+ruEsUXOObWYNpufZdH15PI/Qq40LF7KokmLkM/qjYfEP3vLcuL0dTfZSlU7j+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505689; c=relaxed/simple;
	bh=gihntfmlXSCPgySU39ZDL42EWptVVVgV5ckQPtL5RqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJjwvyb+U3YePgI2+W/U5eMd+z0s5jlRdpDDveMT70ZUTXuttOUgFklxGPKa6PObvwGsPoNyr4cJSoOMjUJPCC/xvasE/3zJ2EvZvndJFfbDBW3MEPKEPGGL+ATRCFk43amma7eFygUves9HF+bzojYZO1yGI6a3Cl++H60PjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6eMtWCt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716505687; x=1748041687;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gihntfmlXSCPgySU39ZDL42EWptVVVgV5ckQPtL5RqY=;
  b=Q6eMtWCtv2EDv4jdGQSnQ2iOlIVdpC1p8ZoPRW6JzNjaJeVBDBA4jAsA
   d6DeCODI1w8zFgEXMza9TpKje8JE6gJy8JuzU89epOttsVhr4OI49QCnn
   QdouDYz7sQFemDZL44n7vIKN9RfLnRe28VY7Q5/Tu7dvJJpoSqBJLzpnG
   0fj0jVe1aymYNg3ZSXDMjdGBCEoc9buepAQR1iffdnPnsoBA+ly+BTl4Q
   6uWghR///gOgbA6nIwlrnEvTUaNIk+Ygy5XSPo9hlR3BZBgOUOF8OdY1V
   +50LZ3Al3CxpbDffwneMe/Xtr7WogHXwSbggB26hJuWGD35Zc4EaJ9B7W
   A==;
X-CSE-ConnectionGUID: n7ZZZCRBQpqqnHaAvrSjmg==
X-CSE-MsgGUID: yUobLwj3QeyEfiIeIuHUZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13092596"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="13092596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 16:08:07 -0700
X-CSE-ConnectionGUID: MXB6VdeTRGe2tPL3cShl0w==
X-CSE-MsgGUID: FKL+uV7pScuf91j++mUn/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="65035725"
Received: from kinlongk-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.79])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 16:08:06 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
In-Reply-To: <20240523134549.160106-1-edumazet@google.com>
References: <20240523134549.160106-1-edumazet@google.com>
Date: Thu, 23 May 2024 16:08:06 -0700
Message-ID: <87o78w1609.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> duration_to_length() is incorrectly using div_u64()
> instead of div64_u64().
>
> syzbot reported:
>
> Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 15391 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
>  RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
>  RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
>  RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
>  RIP: 0010:taprio_update_queue_max_sdu+0x287/0x870 net/sched/sch_taprio.c:288
> Code: be 08 00 00 00 e8 99 5b 6a f8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 13 59 6a f8 48 8b 03 89 c1 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 83 7c 24 50 00 4c 8b 74 24 30 74 47 e8 c1 19
> RSP: 0018:ffffc9000506eb38 EFLAGS: 00010246
> RAX: 0000000000001f40 RBX: ffff88802f3562e0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802f3562e0
> RBP: 0000000000001f40 R08: ffff88802f3562e7 R09: 1ffff11005e6ac5c
> R10: dffffc0000000000 R11: ffffed1005e6ac5d R12: 00000000ffffffff
> R13: dffffc0000000000 R14: ffff88801ef59400 R15: 00000000003f0008
> FS:  00007fee340bf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2c524000 CR3: 0000000024a52000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   taprio_change+0x2dce/0x42d0 net/sched/sch_taprio.c:1911
>   taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2112
>   qdisc_create+0x9d4/0x11a0 net/sched/sch_api.c:1355
>   tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1777
>   rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
>   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>   netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x221/0x270 net/socket.c:745
>   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>   ___sys_sendmsg net/socket.c:2638 [inline]
>   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fee3327cee9
>
> Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius

