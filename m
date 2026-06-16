Return-Path: <netdev+bounces-299907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NfmZN9R1MWqLjwUAu9opvQ
	(envelope-from <netdev+bounces-299907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 441ED691CBD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:12:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=asB4JZ9r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299907-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299907-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D233A30038FE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F14508F2;
	Tue, 16 Jun 2026 16:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0044DB64
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625622; cv=none; b=pdFWQpUeCEvBjy/v8VF79jeJaVH1GGYnhyJ/nMCoWhS+f8NCJZQpTknWXJZiHN0R3lj0fvRGj7DJONH74Lpc08AVqkHWEW9o6SIeT34ELc2PIQGRPp9MLKnOyPDy2lxjToVxqFSq5LJUYQ0axaaW6mGOpUy3P/UBJMAet/wupxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625622; c=relaxed/simple;
	bh=PHMCrEFYzHjppXmJid0lTN5dvvmXcBIHvVcdlZMp3xM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F4v2eo0KjSRTiJmnhcXR588c8Asz1fN8wQVX24bP3GWDv3eUjfANO26aHs6FjROaMsFQ8vI/7bxoWgZ8qG9jv4kPml8hMirJSBwuJ2M3VoHwhCB/Xu5Ljm1hex/CUyH99NbSBmDWQS0QjflFaV2elsuQHHxMBLzJuVc2Fhf9BQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asB4JZ9r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3E91F000E9;
	Tue, 16 Jun 2026 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625621;
	bh=cTfFoVnti5c+jy0tVcTKWOoKjhkNiwdBIvYu+j8avlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=asB4JZ9rTyG7IV8GbqfEcwkUxTDQmNwPhQeH1jM0/SQZqwEx5lhuGSnk9oE7a/JiZ
	 St/G74irjy0zYYsGPBY37exeasbNdhcTukj9pzOLVjc65lW9i6DzqoJ/koB9Tkpg8d
	 eWD5SXNwn3lnXCAZ80FXNoJ8BxisGO2mXpQtoxMbhPZJkFHLw6bSBi+cq5h8uJIY2k
	 BhFUX/Nz8/jmrb3Oo8smt0irOE9RELyZVLVnsaIQlE9EvYo1W5inXMxkhgfD3tfSo6
	 3bhc4jpjoJ4YL29HPMA+zf6Lb9Be0TsCQ0cW9Q7pHOJkjysD4u71eVBOXEnTp3zZsl
	 7VSo+eDL9dgLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939033930ABA;
	Tue, 16 Jun 2026 16:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] atm: remove more dead code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178162561614.1139138.15979699037640823309.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 16:00:16 +0000
References: <20260615194416.752559-1-kuba@kernel.org>
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 3chas3@gmail.com,
 mitch@sfgoth.com, linux-atm-general@lists.sourceforge.net,
 dwmw2@infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299907-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 441ED691CBD

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 12:44:07 -0700 you wrote:
> Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
> ATM device drivers") removed a good chunk of old ATM drivers.
> Our goal going forward is to limit the ATM support to PPPoATM
> used in ADSL deployments.
> 
> A recent burst of AI generated fixes for net/atm/signaling.c and
> net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
> over permanent virtual circuits (PF_ATMPVC) with a statically
> configured VPI/VCI. We can drop switched virtual circuits (SVCs)
> and user-space signaling (atmsigd) support. While digging around
> I noticed a few more obviously dead pieces of code.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] atm: remove AAL3/4 transport support
    https://git.kernel.org/netdev/net-next/c/c1468145ce75
  - [net-next,v2,2/9] atm: remove the unused send_oam / push_oam callbacks
    https://git.kernel.org/netdev/net-next/c/b20aa9eded10
  - [net-next,v2,3/9] atm: remove dead SONET PHY ioctls
    https://git.kernel.org/netdev/net-next/c/277fb497d101
  - [net-next,v2,4/9] atm: remove the local ATM (NSAP) address registry
    https://git.kernel.org/netdev/net-next/c/a5a12d76d2cb
  - [net-next,v2,5/9] atm: remove SVC socket support and the signaling daemon interface
    https://git.kernel.org/netdev/net-next/c/aa582dc25ace
  - [net-next,v2,6/9] atm: remove the unused change_qos device operation
    https://git.kernel.org/netdev/net-next/c/6719d57ee047
  - [net-next,v2,7/9] atm: remove the unused pre_send and send_bh device operations
    https://git.kernel.org/netdev/net-next/c/ae6e653514d1
  - [net-next,v2,8/9] atm: remove unused ATM PHY operations
    https://git.kernel.org/netdev/net-next/c/e44e224e2f44
  - [net-next,v2,9/9] atm: remove orphaned uAPI for deleted drivers, protocols and SVCs
    https://git.kernel.org/netdev/net-next/c/8f9616500c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



