Return-Path: <netdev+bounces-264988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEpwKeJ8q2lUdgEAu9opvQ
	(envelope-from <netdev+bounces-264988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:18:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9822950D
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6343730055D7
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D428C87D;
	Sat,  7 Mar 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmbOQbHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B12741C9;
	Sat,  7 Mar 2026 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846299; cv=none; b=HwOf6njRpahfpqXsjJUx12LaVmiKzHkkAR4b3jAbDSDqOkkOtyBQsUUeotkq8ahimdbIHfwgoOkbF5sV5tT65BQkUtPhUCPpgD2uFLxuiZC2uSkCtavGQ6RtaiYfvUY+80n91e5maOyzKPcHpqrfqzRy5K3lBZ8L933JzTrnLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846299; c=relaxed/simple;
	bh=dJPREhHEqg/9V2L2tTiRQa0B8jLxBb3+vg/KvKSJPGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sB4nIJsboMyElTLH4qhJsX5Ytpb/OLMO0ucFlMKCEPfI87wxE639TBl7tbiLuAvhUCazwSJ+Lc/AZWjhcXXV+iQTlFW/KNXqKi1xJbyu7FVTkg/Ups//jO9N5RxvUetuW82/C+L/FuKWcIlA7DBxHb+14DzPlvG3OtR+G8cJ1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmbOQbHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4B1C4CEF7;
	Sat,  7 Mar 2026 01:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846298;
	bh=dJPREhHEqg/9V2L2tTiRQa0B8jLxBb3+vg/KvKSJPGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmbOQbHixDQ6h++Bt1C3KQ5nfFZHrIIaICcOWfrcdBj3bEyip5Wa6dmaK2kzQdsNY
	 NZtG3Hbrrk5g/wgJRnE81ylaUpV4Lco0hrQ84n0OZy9FXM28Fx1QCeyTzZcj4gpI2B
	 6eUggfJpH1qXdiRGU89O4AMomTBz70uSruKwsI+KqUMjYYkVdqtGww10xQ5ffb47Pq
	 jhI68Oa0WG8Q3kZr7X7buSmJiZqncbN5yRj3owUR2XJDjDaUHLYuVoN04ez8I58dAf
	 kHsC6aj3s6ZZaKATtdtC6fWRjo9v347eZT+LrXdvrzsVj+ukSgHPfDUeCOFzfv4oO8
	 RMEsvEOl8loow==
From: Jakub Kicinski <kuba@kernel.org>
To: rosenp@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org (open list),
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	marcin.s.wojtas@gmail.com
Subject: Re: [net-next] net: mvneta: fix NVMEM mac address
Date: Fri,  6 Mar 2026 17:18:16 -0800
Message-ID: <20260307011816.1223696-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224643.14524-1-rosenp@gmail.com>
References: <20260305224643.14524-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A6D9822950D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,google.com,davemloft.net,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264988-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mvneta: fix NVMEM mac address

This commit adds handling for EPROBE_DEFER from of_get_ethdev_address()
to avoid falling back to a random MAC address when the NVMEM module loads
after the ethernet driver.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 9ba4aef7080c..18bc13dd4e58 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5620,6 +5620,8 @@ static int mvneta_probe(struct platform_device *pdev)
>  	}
>
>  	err = of_get_ethdev_address(dn, dev);
> +	if (err == -EPROBE_DEFER)
> +		goto err_free_ports;

Does this leak the per-CPU stats? Earlier in mvneta_probe(), stats are
allocated:

	pp->stats = netdev_alloc_pcpu_stats(struct mvneta_pcpu_stats);
	if (!pp->stats) {
		err = -ENOMEM;
		goto err_free_ports;
	}

	err = of_get_ethdev_address(dn, dev);

When of_get_ethdev_address() returns -EPROBE_DEFER, this code jumps to
err_free_ports which only frees pp->ports but not pp->stats.

The err_free_ports label only calls free_percpu(pp->ports) and does not
free pp->stats. Stats are only freed at the err_netdev label which is
skipped by this error path. This causes a memory leak on every deferred
probe attempt when NVMEM loads after the ethernet driver.

>  	if (!err) {
>  		mac_from = "device tree";
>  	} else {
-- 
pw-bot: cr

