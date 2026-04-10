Return-Path: <netdev+bounces-277334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HxRGlrb2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E53D605E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48B3330125A6
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174838F633;
	Fri, 10 Apr 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj96enwI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C337EFFE;
	Fri, 10 Apr 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819604; cv=none; b=VXQqKdqApfDOkJugUrvGAztYTkXQEM3WRPdEeta3Ok/EZHuUeVpwGXiEehO0+WFzlfpl9+rodKAW95BRSAFGlSo60Y4IDML9ncOaopelOrvNsh19KvCnXmPT56v/UitjX7tuMaS33vbblBdK4vtWryeCA9gSpuPu0DDJTAyLauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819604; c=relaxed/simple;
	bh=AQPeXi1aoQgGM8nK0LxMPVH1DZGL9c5t02oOQpq3BS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=E23zvSLxGCVM3UIG/+SoQR8nhzXG/ATI0VvV6eTRYT5cRxtHlV3LByEEIw2pT2OUH/0g65Gm21Gwq02vFT/NZNnvLr8c/6vDEza9yss63HCxmhn2+lP/x54PRmm/WZEAuageLTU6eBarG0QWUO9rNsepS4FEKl5OrDwrrjJU8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj96enwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD1C19421;
	Fri, 10 Apr 2026 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819604;
	bh=AQPeXi1aoQgGM8nK0LxMPVH1DZGL9c5t02oOQpq3BS8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=Xj96enwIbyhLeNEpPKkua5HcdXt5CcAvLVgG33GySaF/R+9xs/qNbYvG0nf7xBzNh
	 Ml4KWJuVLHTqlVOO9YqjayOxajpXWGQxhM+wVQ1DhVh/SLmImXKGlNmrZyLRiOtcbH
	 uFDd6tPt9pZjBYciIPOTGy8L69ds7n5tYX3aFwQdMi2J1+ij9SrO6Oa8kFOBDd3GCl
	 rTO5zn8VOvktDmpZzA1rRrskz/geiOi+rccMymHlkfThICvtKlk67Fo5KSjHW+mURb
	 O0q10Rz5MYVAKj6EwfPAFF2h+1S+XcMzD4sZDM2z2CtUudPznMMDvY8PdHyQlrD0zi
	 BxKmYuYCKYoRg==
Message-ID: <72122fb3-c1db-4dde-8f89-0ad4011badea@kernel.org>
Date: Fri, 10 Apr 2026 13:13:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] possible deadlock in mptcp_pm_mp_prio_send_ack
Content-Language: fr
To: syzbot <syzbot+2204dbe6a049b3218db9@syzkaller.appspotmail.com>
References: <69d7de34.050a0220.3030df.0019.GAE@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <69d7de34.050a0220.3030df.0019.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277334-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2204dbe6a049b3218db9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5E3E53D605E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On 09/04/2026 19:13, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1caa871bb061 Merge branch 'net-stmmac-fix-tegra234-mgbe-cl..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d74e06580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6754c86e8d9e4c91
> dashboard link: https://syzkaller.appspot.com/bug?extid=2204dbe6a049b3218db9
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/014aae23b990/disk-1caa871b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c574a710638c/vmlinux-1caa871b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b29909f4efc4/bzImage-1caa871b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2204dbe6a049b3218db9@syzkaller.appspotmail.com
> 
> netlink: 8 bytes leftover after parsing attributes in process `syz.2.2034'.
> netlink: 8 bytes leftover after parsing attributes in process `syz.2.2034'.
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.2.2034/13659 is trying to acquire lock:
> ffff888031173560 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_mp_prio_send_ack+0xaf8/0xba0 net/mptcp/pm.c:296
> 
> but task is already holding lock:
> ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
> ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags_all net/mptcp/pm_kernel.c:1482 [inline]
> ffff88807e300ea0 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_pm_nl_set_flags+0x795/0xc90 net/mptcp/pm_kernel.c:1551
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_sock_nested+0x48/0x100 net/core/sock.c:3780
>        lock_sock include/net/sock.h:1709 [inline]
>        inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:919
>        nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318

If I'm not mistaken, it looks like this issue is also due to nbd
introducing a lockdep dependency between reclaim and af_socket, and this
is similar to a previous report:

#syz dup: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_create_socket (2)

If that's not correct, please unduplicate it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


