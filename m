Return-Path: <netdev+bounces-298137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CSYoL4y0KmpJvgMAu9opvQ
	(envelope-from <netdev+bounces-298137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527767242A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:13:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q5rIUOPk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298137-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F8A3096B71
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A869406285;
	Thu, 11 Jun 2026 13:10:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132693FE344;
	Thu, 11 Jun 2026 13:10:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781183440; cv=none; b=ORU0fr3IIYqbnO/pUJU0mqmXsuK0ELz/zL2e7s8jlOAtRBF+LK7YfrX5rmwa1ldcJDE9jsANR3QMKWGmMDL2e2GtDiRCSAa+i/OhfZzSQ6yPFhfC4SkOkfYxfXK8f8oiRDpTzIoRssZHcU+3Fr6iKkwP2Y4/8ceVUeDSPPImzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781183440; c=relaxed/simple;
	bh=UbPVOhpxd+byepTOQp1HKl+PdgCM/QXBN3qQgTQEYFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYMh2NHa2KTXZM3eXJQ5ALi0fxjREjdeBNIiswXG988zXhaUgNwsVjWtT95+HzSZTtz8uBS/n3utvFYnKoHHFdOu15w6BcCRFvMMalHpaHIim6og2LMcytrLgG3skRUie7OU4fBF0swh6HN7ojjXf1Fpw20/C7+fxGefuQTbGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5rIUOPk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF141F00893;
	Thu, 11 Jun 2026 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781183438;
	bh=uaTEN3kB2HJxSJttfepCdxyM5XDlYFdzNbqYENiI2Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5rIUOPk677MkmyKxmxmKvzoLmsfo8POCFrR0gNneCsfzxkcu4pZCUua/OS/YgKsV
	 DjSSKRdog6NVCkUfcCC/RgG1wnJaYDnuAplD/ReCqtnHT9yuhrVD92xWoB8D82RVkl
	 t3gWyhXUFy87JOx4AhgCLmJG2JJvlK/wiWrOpvx11zatd2jDchfQbMcUztiW5HPf4F
	 3CL9fmaJ9AOJkGdXferGnDYNpNUdUv3qWBCTKsFa019FWOVa/FAlYLOKloXdceWmN8
	 CcGV/JMpidbWzyXvOv+fZlWM5ItQ5FgwXCYBdJbNGZdx4GLkG7EAZ6uLiQaS6gSyFW
	 E+YXrHvPLxEiA==
From: Simon Horman <horms@kernel.org>
To: daniel@makrotopia.org
Cc: Simon Horman <horms@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/4] net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c
Date: Thu, 11 Jun 2026 14:07:51 +0100
Message-ID: <20260611130750.575946-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
References: <f551d90bf2f6820ed6785f5f8e6548d4fc3bd598.1780968180.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:horms@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298137-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0527767242A

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: dsa: mxl862xx: move phylink stubs to mxl862xx-phylink.c

Move the phylink MAC operations and get_caps callback from mxl862xx.c
into a dedicated mxl862xx-phylink.c file. This prepares for the SerDes
PCS implementation which adds substantial phylink/PCS code.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 2f22adedfbf67..a193f3c07d359 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but the crc_err_work can execute after
dsa_unregister_switch(), leading to a use-after-free of ds->dst and
dsa_port structures.

In mxl862xx_remove(), dsa_unregister_switch() is called before the
asynchronous crc_err_work is cancelled via mxl862xx_host_shutdown():

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_remove() {
	...
	dsa_unregister_switch(ds);

	mxl862xx_host_shutdown(priv);
	...
}

dsa_unregister_switch() tears down the DSA tree, frees all dsa_port
objects, and drops the reference to ds->dst.

If mxl862xx_crc_err_work_fn executes concurrently or after
dsa_unregister_switch() has returned, it traverses already freed
dsa_port entries:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_crc_err_work_fn() {
	...
	dsa_switch_for_each_cpu_port(dp, priv->ds)
		dev_close(dp->conduit);
	...
}

Could this order in mxl862xx_remove() result in a use-after-free, and
should mxl862xx_host_shutdown() be called before dsa_unregister_switch()?

