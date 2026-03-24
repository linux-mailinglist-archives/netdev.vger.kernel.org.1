Return-Path: <netdev+bounces-271009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEXTOAl2wmnqdAQAu9opvQ
	(envelope-from <netdev+bounces-271009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B430755D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609573083351
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B393EB81A;
	Tue, 24 Mar 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sub/QWq9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F284363097
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351827; cv=none; b=fgXfCo0whJpdH7PYDXWlYQM9dMP3WVpSdEScyF7E27+IG+WyjEyI3mQBXD7C1vLM5Dg8sD1TgFfj/YRuHJ4azxo95huQJS6G1g2IviWeYm2xmC+cblpVjkQN3vPNyNeVrmAJdmTWJGIsFXKC5WccLZFVKUmlDDIfCpZrAug52mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351827; c=relaxed/simple;
	bh=ACHRu09XIYxTt0zZYe2MJ/mWwqJKU/RLKTwYfjozmYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MCZLb/1u+hJkh1sE+v5V1U25lzBCpGN/kLgC4UB+X5zYhcCzKtITGQIaLERkBtx/gbneCI8tB4zKNvOr+mUZYc7gGNz6QCrSMFkMlY7egXZhLgbvrRYivgmUrbwTTpUUoIM2ij3+PjROedvB3bkDkHN3IisAE7MsYtTY4n0cJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sub/QWq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD77FC2BCB1;
	Tue, 24 Mar 2026 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774351826;
	bh=ACHRu09XIYxTt0zZYe2MJ/mWwqJKU/RLKTwYfjozmYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sub/QWq98WrFtQfyM4SLLQypjahpUE0G3D2Lmu9UWp4GJtxEafRYdHdSaiFoDAjWr
	 o86Jfi3dx3MfvWCmwEMboUF9BRJJ8nb1eq7V95nVCgXW4i+zyoiQ6mNtE2qlCfULqs
	 4jmn+oemFpLaBJAjS9pHbjm7P3MtwCG06jtz7ioFb2QQA984kGB3h8O97V9TuvO151
	 dC9DH7CV5A1wW7DHlMq+/7o7qdjKxFe2yJJUagP+D3Q8FLb9yz6Z4B/dKHZlSBRuXU
	 GDT25G0m8zcM2q7bdzbbIRwiP3DI1LH1b+A/JcwbJB4NUc12JGx7wpjaNqduxJBggI
	 yc3LGs1pSxhHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DF43808200;
	Tue, 24 Mar 2026 11:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI
 descriptor
 in RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435181453.632762.9983445279705514953.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 11:30:14 +0000
References: <20260320174439.41080-1-devnexen@gmail.com>
In-Reply-To: <20260320174439.41080-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271009-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 481B430755D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 17:44:39 +0000 you wrote:
> cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
> In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
> freed via k3_cppi_desc_pool_free() before the psdata pointer is used
> by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
> This constitutes a use-after-free on every received packet that goes
> through the timestamp path.
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
    https://git.kernel.org/netdev/net/c/eb8c426c9803

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



