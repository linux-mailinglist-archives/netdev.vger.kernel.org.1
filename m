Return-Path: <netdev+bounces-269273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDp8I6dhu2lujQIAu9opvQ
	(envelope-from <netdev+bounces-269273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:38:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1972C50D2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2763043FAD
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499438228E;
	Thu, 19 Mar 2026 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCI1Rg3u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C42F659F;
	Thu, 19 Mar 2026 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887908; cv=none; b=nTYSaEDJVkh/uyGZj48cUwijjw44J29N6KaXhK/x62Dybs2XdWpOxk1E1QB4Cv1S1zLqfgMEGK7VIRPwK8XyaCBtkmWjJQAZwxrXt3c2MmlN0BtXK3KHz+B79e95qH3lPwSJg8QXk/pO/3x4yyfyKf27eRCG55U9wN6yfu+g6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887908; c=relaxed/simple;
	bh=nOliYUlY1KKKYWaTjAQxVGwgPl+w/pv3U2mUzz4W/p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtoDz9G1+qAxu5CBSpEcZQe7tM47MwPBCXds1fLhq9DdIwRWW+A519vpzOLY/5QGcA1/amL/5ugst4QRQuWyDqDcNz+T6c7J9aPTneVGRTTaRjH5pIGkNEJHznBRd2PBC+yXtoj1OuLC32w185opDAcyRwD7xOvQFdzV8eMU7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCI1Rg3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51B7C19421;
	Thu, 19 Mar 2026 02:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773887907;
	bh=nOliYUlY1KKKYWaTjAQxVGwgPl+w/pv3U2mUzz4W/p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCI1Rg3u6BWf7+wYYIisJ5mZF4IQ7mRAaj16GJv+kaRHKkYZYF/+3IwfkghVavI1f
	 EQuEe70vZ+GdqAMS1nio63wsXJ9VgdLJ5nfcPlbWlvB4TwPnuv38mil1xrqZTRUsxg
	 cdx9AuHzLhpR6sgufK5uiID5Pe0iqRl3Uwm+9EZxoucq8mZW696McrCm3dlGvh9blT
	 m7a8/CCpV1GB4orZ0iMc+ZXBLFLOFkuD4jJEFol+VtOUstxsIBX93yeu2OZyjdrI7n
	 wkSyeyD9yku06kZdFTZMiXhSwq3aZgTCgH21RfIHvWrkXEhsA+z4xEdGF/Bv/kXeKG
	 nTpkAsHqo6+FA==
Date: Wed, 18 Mar 2026 19:38:26 -0700
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
Subject: Re: [PATCH net-next v4 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260318193826.2632c572@kernel.org>
In-Reply-To: <20260317-macb-set-channels-v4-1-1bd4f4ffcfca@bootlin.com>
References: <20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com>
	<20260317-macb-set-channels-v4-1-1bd4f4ffcfca@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269273-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA1972C50D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 17:19:08 +0100 Th=C3=A9o Lebrun wrote:
> +static int macb_set_channels(struct net_device *netdev,
> +			     struct ethtool_channels *ch)
> +{
> +	struct macb *bp =3D netdev_priv(netdev);
> +	unsigned int old_count =3D bp->num_queues;
> +	unsigned int count =3D ch->combined_count;
> +	int ret;
> +
> +	/*
> +	 * MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
> +	 * the per-queue RBQP register disables queue Rx. If we don't have that
> +	 * capability we can have multiple queues but we must always run with
> +	 * all enabled.
> +	 */
> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * An ideal .set_channels() implementation uses upfront allocated
> +	 * resources and swaps them in, bringing reliability under memory
> +	 * pressure. However, here we implement it for memory savings in
> +	 * setups with less than max number of queues active.
> +	 *
> +	 * Signal it by refusing .set_channels() once interface is opened.
> +	 */
> +	if (netif_running(bp->dev))
> +		return -EBUSY;
> +
> +	ret =3D netif_set_real_num_queues(bp->dev, count, count);
> +	if (ret)
> +		return ret;
> +
> +	bp->num_queues =3D count;
> +	return 0;
> +}

Looks like some left over here:

drivers/net/ethernet/cadence/macb_main.c:4173:15: warning: unused variable =
'old_count' [-Wunused-variable]
 4173 |         unsigned int old_count =3D bp->num_queues;
      |                      ^~~~~~~~~

