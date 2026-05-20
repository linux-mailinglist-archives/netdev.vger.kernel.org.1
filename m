Return-Path: <netdev+bounces-289671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICvfArYEDWoLsQUAu9opvQ
	(envelope-from <netdev+bounces-289671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668895865EE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DB53300EF6B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339E2571A9;
	Wed, 20 May 2026 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQRizg74"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1E248891;
	Wed, 20 May 2026 00:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238067; cv=none; b=NdZYDUh9z8I7U8CiW8eKqe6aN0o83QdTZhXn7H8jHVuj6Kna/4ykA5iku9XGi+ggdC80guNU3OYMpueGQ8xCK0B8Ccw0vYTaClL6Zilq3sMtLXjv5NFCxlPoCryr/YApVpauZteWVzxOSt3ljKZpv7PZ619kdOEsUpPPgskNd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238067; c=relaxed/simple;
	bh=AlfeGIex8acgaQlBvVAJC3Hn7prtf8cr9o1AsZjmSHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nebLrM96f1OpvQN3PUsBet9r+BEYbboQ0Di8DBj9EIe4OFhVNdSFi3Xxmz7oDJIrhM2dOPnngOJ+vUkb0BexOpE06au1rA+VosiZKT796ratndKW+jLrl8IOfAF4GYEDIxOCs1ck7SzfKQi2Hte8jzt775xwUdxKgOQF7JQbkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQRizg74; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB761F000E9;
	Wed, 20 May 2026 00:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238066;
	bh=nuuKFj60ZRWnxMPfd6Npm27bww2j10ECDUt/wSu+QTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SQRizg74chhPQa21LJ72S+JpA1iGw6xE0JO7HAfxC7LeREFjo7w7TcK+odaCfJaiK
	 Iitb4zNLhnO+XE3XMuhDotpXo6wKhCXyXmxsrYd9tdY4HMxdfcTAm0qwc6o/ZYriPx
	 qQwRwlajoAR7qKY05Ru4KicHC0VG8RdVeWLCmmP5JgbnKW/u4sfhbvbw6l6TeF+/Hy
	 W0pB9oiWsmi58qkYvGtEp53U+/YfpmSJ4YCW+pv7A4MqjPOVmywW5+fjvPA+/f5kIc
	 MsrgHRshP5bl4G660A2NRvN1n/458ZqalC2KlEOjGMvioDbDf9aePzR2r/D0iPFxxC
	 AqdIGSTeWeDwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: robert.marko@sartura.hr
Cc: Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v2 2/2] net: pse-pd: pd692x0: support disabling disable ports GPIO
Date: Tue, 19 May 2026 17:47:36 -0700
Message-ID: <20260520004735.4027213-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515115050.691119-2-robimarko@gmail.com>
References: <20260515115050.691119-2-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-289671-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 668895865EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email says "nit picks but why not.."
---
net: pse-pd: pd692x0: support disabling disable ports GPIO

This commit adds support for parsing the disable ports GPIO on Microchip
PSE controllers and configuring its default state to enable PoE during probe.

> So lets support parsing that GPIO and using the GPIO flags to set it to
> output high by default and enable PoE on all ports during probe.

Does the commit message contradict the implementation? 

The message mentions setting the GPIO to "output high by default", but the
code below uses GPIOD_OUT_LOW. 

While setting a "disable-ports" pin low to enable PoE makes logical sense,
could the commit message be updated to accurately reflect the code's behavior?

> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index 4a3c852780f58..6c5c5a26bbaa6 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
[ ... ]
> @@ -1780,6 +1782,11 @@ static int pd692x0_i2c_probe(struct i2c_client *client)
>  	priv->client = client;
>  	i2c_set_clientdata(client, priv);
>  
> +	disable_ports = devm_gpiod_get_optional(dev, "disable-ports", GPIOD_OUT_LOW);
> +	if (IS_ERR(disable_ports))
> +		return dev_err_probe(&client->dev, PTR_ERR(disable_ports),
> +				     "Failed to get disable ports GPIO\n");

This isn't a bug, but should this use the local 'dev' variable instead of
dereferencing '&client->dev' again? 

The 'dev' variable is used in the devm_gpiod_get_optional() call just above
this line.
-- 
pw-bot: cr

