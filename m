Return-Path: <netdev+bounces-295030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yl4gFWLjIGqa8wAAu9opvQ
	(envelope-from <netdev+bounces-295030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:30:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F1C63C84D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:30:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mYT/Gk6l";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295030-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295030-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88DBF3012211
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DB3932CE;
	Thu,  4 Jun 2026 02:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAD3876BF
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 02:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540210; cv=none; b=fRsT3+NjfvaaepS/IFQMgrQDZdg+wRjRt9+C1M/hQMgq6BlRk/j6Ve4ibkXp8bz9F+uatoF7qymBqjN5kW0RQbYzAFysWzYLafpPFcADpMec0QhX504hjgOJWjyTmZllZcerJqQdRyaE7+AbyVwiJwkie1n94KWpSk3myjquZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540210; c=relaxed/simple;
	bh=TKa1HUW7M4p98jKYnxCp9xHQ9LQnAYhR8oIx4ug8Bp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u3teYiE12gb94l2LlBo6G9z0joL96y6NN40u4xa0Z0Tosca0JuofW5g6Dv/Tpey2gmgW+m7zk5ilvgf7hlxq7EqcCi7z157AP949rKDsBBLEbpm4jsA+CfiWQJkI+MLNef0G289FxU0F2uj9ONlwPCBVKiFFaWgmW7sJEu5IskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYT/Gk6l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8241F00893;
	Thu,  4 Jun 2026 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780540207;
	bh=pYfJh+51yj2R4Kc20BEo/16TMlYX/OGjxFXaijOHj2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mYT/Gk6lgBe5ptQyD8lFkyNRyBmkUESqSu/6n2CRrDLBo77wah3HAlrHvI1FkTp4w
	 pOP6FtIHww39OAkIkXAmx9e99BOT8/eqbCVM6YcNgXf0kVseuxCFNge5MjPmDIwp1h
	 tpcuaj/IX1ohCVlszxLmr6U6Rk7uxt75lAfJ+h3Pxja+UxQwG3IHFsZzdRpFTUuN+J
	 Wdorom7dBgeCytDsxAHMV78iEUxukQ7ZeVKV0hP4XFV+43jyFl8dcht1I4AVv0DlVK
	 +g3zLkIsCEOxpndhxapyywVr0GBN6OV2psac2jsNQhXXZ5QvLh8dPBLdAhAaf4WHR/
	 U3ZzvNdBJVgXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5739308E6;
	Thu,  4 Jun 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix use-after-free in metadata dst teardown in
 airoha_eth and mtk_eth_soc drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178054020839.2211213.18332239171948439867.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:30:08 +0000
References: 
 <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
In-Reply-To: 
 <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, fw@strlen.de,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295030-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nbd.name,gmail.com,collabora.com,strlen.de,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:nbd@nbd.name,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:fw@strlen.de,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3F1C63C84D

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Jun 2026 11:21:03 +0200 you wrote:
> airoha_metadata_dst_free() and mtk_free_dev() call metadata_dst_free()
> which frees the metadata_dst with kfree() immediately, bypassing the RCU
> grace period.
> Replace metadata_dst_free() with dst_release() which properly goes
> through the refcount path and runs call_rcu_hurry() if refcount goes to
> zero.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: airoha: Fix use-after-free in metadata dst teardown
    https://git.kernel.org/netdev/net/c/b38cae85d1c4
  - [net,2/2] net: ethernet: mtk_eth_soc: Fix use-after-free in metadata dst teardown
    https://git.kernel.org/netdev/net/c/80df409e1a48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



