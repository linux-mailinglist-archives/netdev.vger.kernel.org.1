Return-Path: <netdev+bounces-284734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePJjBA3v+mlGUgMAu9opvQ
	(envelope-from <netdev+bounces-284734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C55864D7487
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FD7C302949C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E29E3B8BB9;
	Wed,  6 May 2026 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q/rOU7Fo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2403B7767;
	Wed,  6 May 2026 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052856; cv=none; b=ZMIGXP5HzQ8YWdnOygh53cTlVBvz1aBE+XXtPQDaNYx09wOUGAoK6Om2audpVFdz5Y+Sa7cU6yE4OfDmDmSeAGpZBycZb3ukJxlZ6/Z/6+fNBqdBLC4dTDntjVChH71CyDu62O6TONx5tgH+c87AezREHWa4IggcTJT/MccAlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052856; c=relaxed/simple;
	bh=jescdzTqVy71mAaVhpvl7GnAZRw5wMDU2gGU3Bm/7t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK9QzjVW4IMcbShvP1qkhTOojp6t0IobGBZCeaOXqpNhYDYCIiGECf7E/JWBaVT4DeIXGEzOuinsT6loDWkYFqYK5PYx3AkueXjf0eE9p1XhzcLpOec8Cu1GjtkSNCVNMIzT+XKzlbr6qfY5D0IetixcDvjIQaxu0aw7LL+9kMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q/rOU7Fo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 574B51A354A;
	Wed,  6 May 2026 07:34:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23B1A6053C;
	Wed,  6 May 2026 07:34:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0C7D11AD0158;
	Wed,  6 May 2026 09:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778052850; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6DaExmQkA12lgD5mBiLtRpo4ySqgh9l2ZIefgFXeFjs=;
	b=q/rOU7FoQM+EPWjCDRRITn1C5jGG+0c37hQQeOVtsNrV9yut6GCcvGDA8XAE8AKAijjd0e
	4hdGkItntO4kd4miv1vd3N0vavuF/fIJKKz5lqEndkk9osgpqJRIftZ2AQeOZknp3wK8PH
	ZEKden5VJXkQQ8EV+Pt+PquE5IivMMWwHeGePtWdr3XpAMjQgV2VZfJHjBwVTmKLvndJ9Q
	gSSwbajHGETRL+IGxNAuXbJvEvrL72XbY7FKNCB7II9pEZWUYwCOx7piY9TLvibJ0axBL/
	TJdBwTq3D+6rjocj/KPiiaFLHtZ0X0ASuxEaXIBCsQVSzeWhm7ngG+K5bDeSxw==
Message-ID: <c58758b0-8ac2-47aa-8a69-8a9c65876e91@bootlin.com>
Date: Wed, 6 May 2026 09:34:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: sfp: apply I2C adapter quirks to
 limit block size
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260505200647.1125311-1-jelonek.jonas@gmail.com>
 <20260505200647.1125311-2-jelonek.jonas@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260505200647.1125311-2-jelonek.jonas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C55864D7487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284734-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Jonas,

On 05/05/2026 22:06, Jonas Jelonek wrote:
> The SFP driver assumes all I2C adapters support reading and writing the
> pre-defined block size SFP_EEPROM_BLOCK_SIZE of 16 bytes. This constant
> was probably chosen based on good guesses and known limitations of a
> range of I2C adapters and SFP modules.
> 
> However, I2C adapters may even support less and usually need to specify
> this via I2C quirks. Theoretically, such an adapter may provide full
> functionality but only support a read and write length of e.g. 8 bytes.
> Currently, the SFP driver doesn't account for that.
> 
> Add handling for I2C quirks in SFP I2C configuration taking the fields
> max_read_len and max_write_len in struct i2c_adapter_quirks into account
> to further limit the maximum block size if needed.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Good to see this series moving forward, thank you :)

Maxime



