Return-Path: <netdev+bounces-265026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMFFBwOXq2l6egEAu9opvQ
	(envelope-from <netdev+bounces-265026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7102229C11
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDD853022987
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938227E06C;
	Sat,  7 Mar 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oykrld9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6283336894;
	Sat,  7 Mar 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852990; cv=none; b=VRyUf3pL2zjYqf2g+RgFy8yeUHfvsD/iK9Xa/MofNEha47SlxGKkNKFKcDTABoUz8JGT/6Qogvrdqn/DEDcVDtkQwvuEqGSKY3B+05HXAobnfGTFipJPHSpYChJP+Cmf+aQOFFaxyIkZHiBFk8WVy2dgjH+z5lU/ta/kygj8JbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852990; c=relaxed/simple;
	bh=CNeI1/Xc6MtX5369TAyxhovOo5WiU/EQV1TSEUzTYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqov99OsxwMI+fHbXLQdJrF5X0QTT1DQC74oB3CuWdOUwidywQFymXSk1UljwK7gp7RNPhONJwJOD2w+8XL2LdoAVNb+UeBGP3pwP4tp9vOaHJVoNWV1FxZuM6FjgALRFK6Agkom45JGveiguUzbyDu9avsTOyRqHsNjzWMIvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oykrld9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30CBC4CEF7;
	Sat,  7 Mar 2026 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772852990;
	bh=CNeI1/Xc6MtX5369TAyxhovOo5WiU/EQV1TSEUzTYuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oykrld9Z1pb4Wej1JTdqZIgcuNymLWb8VggJru03S5xGsKTda2r7fPEc70P0ehEAV
	 Pnflo9keYnw9JiYvuk2C5AKq5JMBpEtAXa/PDlnG/oR1DbI1Tg+5u44aUJuRzxUcDJ
	 CiYmR4qxrTfi7pCfMlbehFgWFJxen4h08tN8rJajgiRvWuwvnBE22S4FDf8xPZauwh
	 vksH607w7IlWNUgQfLwfnnqBbdOSA+2RndwGL9bV4C/M7BE7VHjJW5GkBikkLWWsUg
	 zI9qPWn9/s0Wg2w7Voykpl3usQcM+kJex7I50E/J+qjONXMLsWM9UEL3MxB/ak9VYV
	 oDuN/sNc8GddQ==
Date: Fri, 6 Mar 2026 19:09:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Paolo Valerio
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260306190948.44d23f8f@kernel.org>
In-Reply-To: <20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
References: <20260305-macb-set-channels-v1-0-28e3a96a3dc3@bootlin.com>
	<20260305-macb-set-channels-v1-1-28e3a96a3dc3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B7102229C11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 18:20:14 +0100 Th=C3=A9o Lebrun wrote:
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +		return -EOPNOTSUPP;

Why not set max to 1 in this case?

> +	if (!count || ch->rx_count || ch->tx_count)
> +		return -EINVAL;

Core should check this for you already

> +	if (count > bp->max_num_queues)
> +		return -EINVAL;

and this

> +	if (count =3D=3D old_count)
> +		return 0;
> +
> +	if (running)
> +		macb_close(bp->dev);
> +
> +	bp->num_queues =3D count;
> +	netif_set_real_num_queues(bp->dev, count, count);
> +
> +	if (running) {
> +		ret =3D macb_open(bp->dev);
> +		if (ret) {
> +			bp->num_queues =3D old_count;
> +			netif_set_real_num_queues(bp->dev, old_count, old_count);
> +			macb_open(bp->dev);

both macb_open() calls may fail under memory pressure
For new functionality we ask drivers to allocate all necessary
resources upfront then just swap them in and reconfigure HW
--=20
pw-bot: cr

