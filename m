Return-Path: <netdev+bounces-278454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PtkICY/3mlJpwkAu9opvQ
	(envelope-from <netdev+bounces-278454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C43FA69E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA478300E58A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D703E5ECF;
	Tue, 14 Apr 2026 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5XSbWwJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E034EF08
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172835; cv=none; b=XgtpbAc8BgwMXBGeoXuG4jimHHAofHd2VkDOgAqj4O6ZDFgJephxrENuUUeEaRIOsaQOxL6gX8qc5wQOr/RSU9o1hd7GdqMVJIh2SmjtIlBfcv3drJK2Riamz6TorMv1GyhpJGvva+XofAlXo97bUcrq0JuXZST24TfeJR+a4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172835; c=relaxed/simple;
	bh=cMCDkATKBmtmieFp8QBU6yJuQwNr3qs20Cfx6XJdEWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZkiaeZOah4tybKqD0t59TvUDmrqqc8gzRWPSTaiv9r2UgHdZ54zamqKvsNozrzliiDTKxgMesvrVeS0p1Lja15FoAErQDHoz78SIQNuecIxN3mAeUt0eqMKVOKVGsIqeZYB2vIqUfAH8tgHtje/U9EsDhrmB/yF+eysj4YPdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5XSbWwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F0C19425;
	Tue, 14 Apr 2026 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172834;
	bh=cMCDkATKBmtmieFp8QBU6yJuQwNr3qs20Cfx6XJdEWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5XSbWwJ+9hKnt5Xdh2YU+VP2rCKj5FPUW3me8pSMUUaW79hQUMGZt49iZI5aT9E7
	 rxBm8aJxvQ9rj54iGEC3ZEuMaxoliVjLY3C7f71WvRLJnNYaygyHfH0eWzLGQdNmBJ
	 M2PI6lBOvRnlDhsNlJQxZ7vUC36QlYFleT0bT/WGe5hVi5A4K6WRvU93BXZs8t8It/
	 WoI3t4Ul5bfy71peBBJlX6b2ZFY0QKnRxF1ricuYosCd5cSMokKQxOqKZt6wN/wfO3
	 0JEyaMxbwJzBlqO6CaimbfarHs88jz25P2ikU2og/bSMK+vko+elJKTu6ZjA9XyCxV
	 i9t8cjufkt0Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE743808205;
	Tue, 14 Apr 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add missing PPE configurations in
 airoha_ppe_hw_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177617280505.878864.13821756004828787817.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 13:20:05 +0000
References: 
 <20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org>
In-Reply-To: 
 <20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278454-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 171C43FA69E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Apr 2026 10:43:26 +0200 you wrote:
> Add the following PPE configuration in airoha_ppe_hw_init routine:
> - 6RD hw offloading is currently not supported by Netfilter flowtable.
>   Disable explicitly PPE 6RD offloading in order to prevent PPE to learn
>   6RD flows and eventually interrupt the traffic.
> - Add missing PPE bind rate configuration for L3 and L2 traffic.
>   PPE bind rate configuration specifies the pps threshold to move a PPE
>   entry state from UNBIND to BIND. Without this configuration this value
>   is random.
> - Set ageing thresholds to the values used in the vendor SDK in order to
>   improve connection stability under load and avoid packet loss caused by
>   fast aging.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add missing PPE configurations in airoha_ppe_hw_init()
    https://git.kernel.org/netdev/net/c/b9d8b856689d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



