Return-Path: <netdev+bounces-286073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Jhz6C+aR/mnKswAAu9opvQ
	(envelope-from <netdev+bounces-286073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAC04FD5E6
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C570C30151F9
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F21917CD;
	Sat,  9 May 2026 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vM5uqZMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0E2F8E8D;
	Sat,  9 May 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291170; cv=none; b=UXfeDlOwrlVOu/bbbQNR0ILaXdMFHOChk39N0LdcHUoD4NVy/QekQlN4giuQMSyRuQviB8pMDfyZKXkQ2T+zWGKaFfXajDu232c17hBsj1WzmrQ3/gaMA4we5Czo0V0sXJLGOgC4cwR470PI9he7r0nKpz2qwNGbqRlp82WQJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291170; c=relaxed/simple;
	bh=emN9I4dE2aoxQzpvVrwUfIhdo8UBKuater7jkdYqjpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSsBSxYUDMyww6mXdMExRDUDmy9cIl+akJM36NguFPzvq++hIR6XWXTofI2KuDw8m6erLZWFvI8qiyjKQpHDVYtwOXu3aCpRoaXF9fPN/O7xscblTgLXRK0zQGBPWE1KLWQ8q6BGQVw3UPZ02FPbYlJGA6DmNZLfnkq4boqYYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vM5uqZMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B59C2BCB0;
	Sat,  9 May 2026 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778291169;
	bh=emN9I4dE2aoxQzpvVrwUfIhdo8UBKuater7jkdYqjpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vM5uqZMedY9Qkh5eyYP7uWgGEa0qCOkcOV6KLwb2/f6UBbXuFrmefKpUua32wtk35
	 gkuyZv9Q5NOtJ5LoYFqCYal4bR70j8XHQ5g6vOQaFmlAVQoGLYvr8ggjQzMRDpVX7Y
	 TdQUPZxI4+NW89lcOtSivEHgNL95pa48hjuMSJ/aKARvHqZBM13S5iHvX0jRGXqVkx
	 MDNKnRwmV15aG+6DdvL0jz4VLHxvwKEG1Abx9F/KxHxNI1S6Vgmya+MlMI/LeEBkYa
	 8Zuvc7y9wWV7z+BFOwIYbgqPrWCddzQiep7XTySGMU6Iiev159iRpfNy0vKUevXlAR
	 aZXrkfObq5B4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: lorenzo@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	benjamin.larsson@genexis.eu,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	madhur.agrawal@airoha.com
Subject: Re: [PATCH net-next v4 03/10] net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct
Date: Fri,  8 May 2026 18:46:06 -0700
Message-ID: <20260509014606.3558018-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507-airoha-eth-multi-serdes-v4-3-af613b61ae02@kernel.org>
References: <20260507-airoha-eth-multi-serdes-v4-3-af613b61ae02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EAC04FD5E6
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-286073-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
Subject: net: airoha: Move airoha_qdma pointer in airoha_gdm_dev struct

This patch moves the airoha_qdma pointer from struct airoha_gdm_port into
struct airoha_gdm_dev, as a preparation for allowing multiple net_devices
to share the same GDM{3,4} port via an external hw arbiter.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 4af64f182968..1798b4a6cf5d 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c

[ ... ]

> @@ -854,7 +855,8 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
>  		if (!port)
>  			continue;
>  
> -		if (port->qdma != qdma)
> +		dev = port->dev;
> +		if (dev->qdma != qdma)
>  			continue;
>  
>  		dev = port->dev;

[Low]
The resulting loop body assigns dev = port->dev; twice with nothing in
between that could change port->dev:

	dev = port->dev;
	if (dev->qdma != qdma)
		continue;

	dev = port->dev;
	for (j = 0; j < dev->dev->num_tx_queues; j++) {

Is the second dev = port->dev; intentional, or leftover from the
refactor that should be removed?

[Medium]
Can the new dev->qdma dereference run while port->dev is still NULL?

Looking at airoha_alloc_gdm_port(), eth->ports[p] = port is stored before
airoha_alloc_gdm_device() runs, and airoha_alloc_gdm_device() only sets
port->dev = dev at its very end, after several failure points
(devm_alloc_etherdev_mqs, netif_set_real_num_tx_queues,
of_get_ethdev_address).

The existing cleanup in airoha_probe's error_napi_stop path and in
airoha_remove guards accesses with if (dev && ...) when reading
port->dev, which suggests port->dev can legitimately be NULL while
eth->ports[i] is non-NULL.

Before the patch the equivalent check read port->qdma (an embedded field
zeroed by devm_kzalloc), so the compare was NULL-tolerant. After the
patch:

	struct airoha_gdm_port *port = eth->ports[i];
	struct airoha_gdm_dev *dev;
	...
	if (!port)
		continue;

	dev = port->dev;
	if (dev->qdma != qdma)
		continue;

would dereference a NULL dev if port->dev has not yet been assigned when
airoha_qdma_wake_netdev_txqs() runs. Would a NULL check on port->dev (or
reverting to the original port-field-based test) be appropriate here to
preserve the prior robustness?

