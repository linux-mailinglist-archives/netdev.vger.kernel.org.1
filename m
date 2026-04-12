Return-Path: <netdev+bounces-277822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBFFOg7A22mTGAkAu9opvQ
	(envelope-from <netdev+bounces-277822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:53:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B03E49FD
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26142303675C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F90EEC3;
	Sun, 12 Apr 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mw2beybE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0915D531
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009054; cv=none; b=HlkY+Lz/LJflwzShAkrlxMoonq6UahyaiqRhl1Xn8idiozU4T1IaLGeP6Xvprh9bCFVuwX/j44P2xqMGxuo4kKSokG7PEgZNnFbPdVeM72fcdnDakzopKR9bi+ZevxIfmpLxXDaQtkHj+e3gtGqKLcmNG+U7Xuz7C1huiY2eCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009054; c=relaxed/simple;
	bh=AealylWH9G4oEmm0WQ9MfAo7flIiNHZDW0itdTYeTbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LmC8F57Q2YYFRuzz5sTmCdn5Nj29/5GcJAMitZmJzGSQoE0qukzjno4ShAjAGrhbsgcsv+V10aPv868mjAEDTxo7QaBNv72JwzriHsK5x5dfNEmlYee/julpN8jXHR1ayCrn6MJHDr6uw6RPQ37AE2jaNLM9TqcbEMlHdVQmIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mw2beybE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB1BC19424;
	Sun, 12 Apr 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009054;
	bh=AealylWH9G4oEmm0WQ9MfAo7flIiNHZDW0itdTYeTbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mw2beybEIZJwmbXjs3UIhPRCRt732jeQA+mnbqHGov/Tx3dsVwPiCYV0zE2QM2vBB
	 puBTYszXJGqyU7cE5sUwDXSOgeilOopoONRDXGMIUBQMtN87WGcByD3RuFlYW39KU9
	 LpxWxH9Im39OqaGTeVZ2onwdgrOL1Tdkfj85GPpk3yoocpL0mEjEjM+0DSjfywtaeV
	 BpNZq01KX6+i8my5JuPoh+2lZ0M6EggsMsU0I7Hc3Qvup4YKTZO7rZhCSjeb0W2SYW
	 2DeJg+UiYouv5It8owJyDvTsymmB5tBJXMsa7cMGInax0JZt5ll2bQZcTXbmUq1pwa
	 STTqMmuNUbfZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD553809A8B;
	Sun, 12 Apr 2026 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/9] Wangxun improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177600902705.3323732.13521125726241629784.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 15:50:27 +0000
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, horms@kernel.org, michal.swiatkowski@linux.intel.com,
 jacob.e.keller@intel.com, kees@kernel.org, joe@dama.to,
 larysa.zaremba@intel.com, abdun.nihaal@gmail.com, leitao@debian.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277822-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 634B03E49FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 10:56:07 +0800 you wrote:
> This patch series cleans up the code and enhances the implementation.
> 
> v7:
> - Drop the patches about Tx timeout, pci_error_handlers and ngbe reset.
> - Replace busy-wait reset flag with kernel mutex.
> - Reorder timer and work sync cancellations.
> - Add spin lock to protect wx_update_stats().
> - Enhance the reading of the registers which are not clear-on-read.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/9] net: ngbe: remove netdev->ethtool->wol_enabled setting
    https://git.kernel.org/netdev/net-next/c/4d19654dacef
  - [net-next,v7,2/9] net: ngbe: move the WOL functions to libwx
    https://git.kernel.org/netdev/net-next/c/752157d9eded
  - [net-next,v7,3/9] net: ngbe: remove redundant macros
    https://git.kernel.org/netdev/net-next/c/9bc29a87fbc6
  - [net-next,v7,4/9] net: wangxun: replace busy-wait reset flag with kernel mutex
    https://git.kernel.org/netdev/net-next/c/d48df7e7c3fb
  - [net-next,v7,5/9] net: wangxun: move ethtool_ops.set_channels into libwx
    https://git.kernel.org/netdev/net-next/c/b736ebed937e
  - [net-next,v7,6/9] net: wangxun: reorder timer and work sync cancellations
    https://git.kernel.org/netdev/net-next/c/58f6303572ec
  - [net-next,v7,7/9] net: wangxun: schedule hardware stats update in watchdog
    https://git.kernel.org/netdev/net-next/c/dc33e52b8ce6
  - [net-next,v7,8/9] net: libwx: wrap-around and reset qmprc counter
    https://git.kernel.org/netdev/net-next/c/1dd9b0dafd21
  - [net-next,v7,9/9] net: libwx: improve flow control setting
    https://git.kernel.org/netdev/net-next/c/40637e4a4477

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



