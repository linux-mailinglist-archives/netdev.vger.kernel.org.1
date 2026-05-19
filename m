Return-Path: <netdev+bounces-289407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE5WO8NFDGoGcwUAu9opvQ
	(envelope-from <netdev+bounces-289407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:13:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 133A657D49E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC281301E377
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D13A960F;
	Tue, 19 May 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPUIODfC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B2369D44;
	Tue, 19 May 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188406; cv=none; b=MFiSrNX9maZN2v2hBL7EAKElY4IkG+KN9z3XxxRAQtlIByJOeyrIL64l71gIGiNzSFXIxTDMu1PcNGipR348g+BGd4qqU+h5M3Swd/rgAXc/+AKs9f7tDF888H1/4g9YEz52co8TvT9NA8emfkhGPXVeMnIg/Vn+h42JJDqZgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188406; c=relaxed/simple;
	bh=D70H8Z4eH+y64Ue+L6Bm0Ag7ZBzliT4c6WevcCypox4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bpeys8mO/pDs3w/2sRROqiIJqnJFzhD/KnIg4Xp9mNjmUQBSYV7nsdB70Al01d1GnAR9Qr0Y/HNnvyLc9EYy+gfEpuo2RCmRhAR0C2HwnXLjjNVfLHh/n0TejDwxq70C+oAhezxh7eG9N9iqrv/6/DqAe3jOMbBvp9I5rtuZRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPUIODfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA096C2BCB3;
	Tue, 19 May 2026 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779188404;
	bh=D70H8Z4eH+y64Ue+L6Bm0Ag7ZBzliT4c6WevcCypox4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iPUIODfCaMJLjvG1v/JW2fhHgzecuRBBH7AUIjfNTi71epV71OjlhZYJh4xCpQhJM
	 7e4Tqi1cmzpd7I71T6IoVh0qMQwmlMVcosJG0zIIwxfk49XfiwOVPmFTyBscfBCYDd
	 uVYF1E4N8df6Le51DRnK7qrx1BtvQtzKX6qCUs6fsL95KEWuf3fojbbLtgUcEOmOIP
	 ZofkHQxlkOvLQzcrAfXnc4fQIXhv9LLZ3+1XsLoWH+bc/1TXwoB1Ks/FM4spfRIuHs
	 78v6i5kEBUkvC77X5kJwTT6vhZlBM/0q3VlaagGXLEkZXJ9QJTmX1045li2XHmrVE7
	 F6KzNGZHPSrBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1995D3930E03;
	Tue, 19 May 2026 11:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] net: dsa: mt7530: assorted fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177918841597.2243186.15077319366803058468.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 11:00:15 +0000
References: <cover.1778766629.git.daniel@makrotopia.org>
In-Reply-To: <cover.1778766629.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dqfext@gmail.com, f.fainelli@gmail.com, arinc.unal@arinc9.com,
 sean.wang@mediatek.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289407-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 133A657D49E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 May 2026 15:04:06 +0100 you wrote:
> A batch of small, independent fixes for the MediaTek MT7530 family DSA
> driver, addressing long-standing correctness issues that surface on
> hardware with bridge VLAN filtering enabled, on link-local frame
> reception, and during bridge join/leave transitions.
> ---
> Changes since v1:
>  - rework patch 1/5 following up Paolo Abeni and Sashiko reviews
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net: dsa: mt7530: fix FDB entries not aging out with short timeout
    https://git.kernel.org/netdev/net/c/e824e40d0e84
  - [net,v2,2/5] net: dsa: mt7530: preserve VLAN tags on trapped link-local frames
    https://git.kernel.org/netdev/net/c/3ac85bcfd404
  - [net,v2,3/5] net: dsa: mt7530: fix CPU port VLAN not being reset to unaware
    https://git.kernel.org/netdev/net/c/2c4c76cacc9d
  - [net,v2,4/5] net: dsa: mt7530: clear flood flags on bridge leave
    (no matching commit)
  - [net,v2,5/5] net: dsa: mt7530: untag VLAN-aware bridge PVID
    https://git.kernel.org/netdev/net/c/4cb3cd670b2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



