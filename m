Return-Path: <netdev+bounces-295551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1n3PEiopImpKTQEAu9opvQ
	(envelope-from <netdev+bounces-295551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF264477D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:40:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DCFmOPDa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295551-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B27313404A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225453C9EFE;
	Fri,  5 Jun 2026 01:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EF33557D
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:30:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623018; cv=none; b=gueeGixtcjprrTc+x1SU0s7zil6bclJqpQ+W8B5r+rvAJzuQyZqAQFv09P02jr9l/OC81n5IAlhLiYmDrcdxV5ai163zatEMo/Js7weqpzGW2z3Oq4DRfNBup+52IHQ775EVwPdF4OzuL8I+tL+++wK5zqK7CUPAOYCJ3bCWenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623018; c=relaxed/simple;
	bh=5kV280KPpbrtrlQBD4AGUpPoVy0AfDM+cwEdL+HhqKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tozOJtYulxuviSE/p1AgWOxKhhVJ2RmRk5+ENarGkujxyF0YZYbdbpuEMkwyJlM1bGAOW4iUuGJiMyOnJb+nZIEq/cO+h20jw6xeDJqwVfeZV2tyz4psQkWEv2VXxk5sOsd4AHrTcsJZMNTShSnLM3nhUqXNImhRRQ0YYQu2R8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCFmOPDa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED28B1F00899;
	Fri,  5 Jun 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623014;
	bh=weNg96zxEw0YQOLnRM6yhlBqLpFSoIZgsDdg6LWSa4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DCFmOPDaH6XNj24ToBjQJOCu2J6zcZoRZ6/WA1oskRuKTU9HiobgVsYJOk+q2zeFS
	 gQLDtlTTZ8nI/T0p/K7X59cuTglFDyAmG6YQgPbRAanP3mNHUu0mgh2S/O20r8jsbL
	 jTnq8oZxr9QOPo6NcFpjjK3icE0LC4U1Ged+52VL6vQ4FUDKEMgj2cKyUgkkcsx2F2
	 CtxLesaj54PR1KdHOkf4C+2Cjk+QJl8G+iCxwh0Yfql/qWarr7y9dNhcOfvyoMIQAK
	 VcOSSHgkVDvt0fClGN/zlG31QrB5GWxfOaBMfrPIsVu3X57AD5BW9ze9bnOBOrHb3C
	 FtaV/n9CdHWxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094E3930A8A;
	Fri,  5 Jun 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Report extack error to the user if
 airoha_tc_htb_modify_queue() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062301439.3093327.853203913546216659.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:30:14 +0000
References: 
 <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
In-Reply-To: 
 <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295551-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64AF264477D

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jun 2026 12:30:01 +0200 you wrote:
> Report an extack error message in airoha_tc_htb_modify_queue routine if
> airoha_qdma_set_tx_rate_limit() fails.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Report extack error to the user if airoha_tc_htb_modify_queue() fails
    https://git.kernel.org/netdev/net-next/c/144969cd80c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



