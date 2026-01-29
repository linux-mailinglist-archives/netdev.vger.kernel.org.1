Return-Path: <netdev+bounces-254562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAAWM9LremmE/wEAu9opvQ
	(envelope-from <netdev+bounces-254562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DBFABD56
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9D0301AD03
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA62D9EEF;
	Thu, 29 Jan 2026 05:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpQ3X6zk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC422D9797;
	Thu, 29 Jan 2026 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663407; cv=none; b=lhMApsrhC+ALXumfpDrNF3xv9oS2GE1So2CfgRjVFjpgn3t5+Ef6fFFKwPQpTyD7CpYgH7cr3bpy/sKZquk3qM3PNYd2qIfDGy8w1q1vZK4OpOwtqfjs2WgNe/CipCHlunOWXfEVKAVNlEobU14AYWeTnF/k9Pt83Wbyld35xAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663407; c=relaxed/simple;
	bh=V1WyJa/+x8maDd98PLvupLgjlQf1OoyhIzqUlPtgYLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t91unGlY7uRvvkK9DFiq6bC62195S8W3KsTRMPEf2V3z2fECnyazHqLSwOSbJ48fqN0vOinI6Xi7SvwEeXDmOKb23hkxZxZ/O3iDy0AVWu1HnrFb0kjpx8jLiFutUZD/wFIbAX5KnRXvIeeQkDCOjyVwYbnRe0+CMN5uiMWJUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpQ3X6zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B6BC2BC86;
	Thu, 29 Jan 2026 05:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769663406;
	bh=V1WyJa/+x8maDd98PLvupLgjlQf1OoyhIzqUlPtgYLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpQ3X6zk+gL1Wx50TzMtcI76mAAf8Ah6EKpXtVSXOwRjvoWd0AabiiReG8cf1v+W7
	 jIYPzKrRPw3KeFWEnpgYZMNDAe6aRyiQMx0142Lcg2zAijkEvpaigl+3NETebFCusz
	 Xy3ZD3WRI8ba0Qdw23s+ONgYj8frRub+x76ImHnqFHb633GdDwI7y3QD8D3a5K8W4k
	 l3pdQMEEKCDxqkMIlpFh0G3gDaej/eEKJEgZ/+Xncd/jg+WdgWNvys2vLWTGu154fN
	 9p47BG3C8Zbu39hTXfBj53lXo9glNR9aSkoWUrysIdleeLCGjJOYGAntQx2za44CGd
	 JtVa66b5mWTpQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jan.petrous@oss.nxp.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andrew+netdev@lunn.ch,
	mbrugger@suse.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	s32@nxp.com,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	s.hauer@pengutronix.de,
	conor+dt@kernel.org,
	chester62515@gmail.com,
	festevam@gmail.com,
	mcoquelin.stm32@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	devicetree@vger.kernel.org,
	alexandre.torgue@foss.st.com
Subject: Re: [v4,4/4] stmmac: s32: enable support for Multi-IRQ mode
Date: Wed, 28 Jan 2026 21:10:04 -0800
Message-ID: <20260129051004.375682-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128-dwmac_multi_irq-v4-4-82fa34fcf2f2@oss.nxp.com>
References: <20260128-dwmac_multi_irq-v4-4-82fa34fcf2f2@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,pengutronix.de,lunn.ch,suse.com,davemloft.net,redhat.com,vger.kernel.org,lists.infradead.org,nxp.com,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com,oss.nxp.com,foss.st.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-254562-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 24DBFABD56
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
stmmac: s32: enable support for Multi-IRQ mode

Enables Multi-IRQ mode for the S32 GMAC driver when per-queue IRQs
are present and more than one RX queue is configured.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> index 5a485ee98fa7..37a5b7b46973 100644

[ ... ]

> @@ -149,6 +149,16 @@ static int s32_dwmac_probe(struct platform_device *pdev)
>  	plat->core_type = DWMAC_CORE_GMAC4;
>  	plat->pmt = 1;
>  	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
> +
> +	/* Check for multi-IRQ config. Assumption: symetrical rx/tx queues */
                                                   ^^^^^^^^^^

This isn't a bug, but "symetrical" should be "symmetrical".

