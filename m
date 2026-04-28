Return-Path: <netdev+bounces-281577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGOuFKEJ8GkINgEAu9opvQ
	(envelope-from <netdev+bounces-281577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:13:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8347C55F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 741723068D67
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C82D46C0;
	Tue, 28 Apr 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxNKPCOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D01D5174;
	Tue, 28 Apr 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338654; cv=none; b=eiroGRZpBFNAOYRpIp2zutQejHeaHhibdwvUDAKuE9xpFlWx5PYKbe6fztfI+IW2E2wnSipJ+dRiLE9Wgfq/N9isdDYV1K4eydGDFnxQKkCVFqlWUX5coToCF84IxnJe0oCMvZcWjuMYSfX53BssSZqavrxAmMrIb6BXRquwRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338654; c=relaxed/simple;
	bh=7PQTc3JV/304lxrcmdmON+IOuynWVA6CpijXxW5+DkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ICGzPTXyRhSBt+rIhtFKLKfTJRJIpJb5l8mp4s7hseAg/2wcvmnCNfKLKQqgPY7p6vwv4kIB5Xd1mru4Jr399pdLHNoN6Xd8VBQXoJGu9H45lABqvMm2tA0sPfmSduN7NWrBDf2xdmeL+j4NtQwMPl5d21FGAJYJc+Zxjikyehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxNKPCOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B90EC4AF09;
	Tue, 28 Apr 2026 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777338654;
	bh=7PQTc3JV/304lxrcmdmON+IOuynWVA6CpijXxW5+DkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IxNKPCOCf0LdsnQVtgNtVioLS/MdnajaEMfzgP3cF+biS7odtJgzXtBjNQVh74/kE
	 TmsK0pd7M31Gwuxu35Ym7/L/HStFgVSsocvruV75obhMYSd7rwpPE0P7Ka9GXm17bd
	 BmhB5S4hrC0RFPO0Mw5Y4wW81Hz38aegkEZ+53Cb1kt4r1InhatYto5YY/vU0+hN36
	 JgJMdzB06tgWqTemxF13VphLjGWgqMIxx5029CI04FWvg75Npo2vgOa2foKVGUkjxH
	 /cpVB/5WOhRc39sQ6K+6f1x8ugoJyYDfFYu8FWuLvjd7E1NOyLjOGs5Pl1HL4l3NmN
	 17OsK2gC0MqXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DAC392FFDE;
	Tue, 28 Apr 2026 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: rtl8150: fix use-after-free in
 rtl8150_start_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733861179.182819.5366012507561325638.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:10:11 +0000
References: 
 <809895186B866C10+20260423004913.136655-1-zhangdandan@uniontech.com>
In-Reply-To: 
 <809895186B866C10+20260423004913.136655-1-zhangdandan@uniontech.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: petkan@nucleusys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 michal.pecio@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zhanjun@uniontech.com, syzbot+3f46c095ac0ca048cb71@syzkaller.appspotmail.com
X-Rspamd-Queue-Id: ABE8347C55F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281577-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[nucleusys.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,vger.kernel.org,googlegroups.com,uniontech.com,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3f46c095ac0ca048cb71];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 08:49:12 +0800 you wrote:
> From: Zhan Jun <zhanjun@uniontech.com>
> 
> syzbot reported a KASAN slab-use-after-free read in rtl8150_start_xmit()
> when accessing skb->len for tx statistics after usb_submit_urb() has
> been called:
> 
>   BUG: KASAN: slab-use-after-free in rtl8150_start_xmit+0x71f/0x760
>     drivers/net/usb/rtl8150.c:712
>   Read of size 4 at addr ffff88810eb7a930 by task kworker/0:4/5226
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: rtl8150: fix use-after-free in rtl8150_start_xmit()
    https://git.kernel.org/netdev/net/c/23f0e34c64ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



