Return-Path: <netdev+bounces-256602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNMtO8P3gmmTfwMAu9opvQ
	(envelope-from <netdev+bounces-256602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:39:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B33BE2C19
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F49300C80C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6169238BF82;
	Wed,  4 Feb 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ASFt7iAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F8536D51E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190784; cv=none; b=i7aUKGaRAHxnA2zieeOZByP9+2FdhPSF2ydE+pwA8SxRRRPqQcCieqpeW3ak2s9xhQHo3slV83ohlCuOHBC5voHs23YT+pJR+o8zHO70WlwqxOEpfUNP1h0fUq5OdiFcOWCdNvPeWphqXFaNrxETrwEyX1LTKyItalZtbaPppv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190784; c=relaxed/simple;
	bh=/1pxWx644C8TLU/UaJGS1RYvZTIa3ThwwJW1g34kVq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=of4sxyr7yx6waZlj2KhPFPypFTg8PFlxTr4tlpa8bb91ZExjysUOhDyDJzqSMoMqCCtD7Km36+aS1fmGo1S0X8FG9kJnwDNGWG1S2rNO0RHsGZg3Hjj1WEvCO3elbXfF1FBVqRtXJOXqRlcVRIeXAXGfXktKZAcAu7ARTlT6lMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ASFt7iAv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7B5FE1A2BE8;
	Wed,  4 Feb 2026 07:39:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4540260745;
	Wed,  4 Feb 2026 07:39:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1E87119A865B;
	Wed,  4 Feb 2026 08:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770190779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=a1s1BXXCx27PuGqRuU7j6OliqPV6LuqtZN5Wh+JmuyY=;
	b=ASFt7iAvoEKBxUocM2AO600jqKvck4UhY8zGTKbvjSzRK0yyuCNeVZ3PZorwm7AXzlsV/A
	k5iEVUVSRRxMPEPUl6EwQZogTkvuzwro1D+2C6okuuqtwavmpa5tVDjccqV4fRG2o9FUD0
	cS7adwFEB6gaMH0mUNBBccv3/mM1TmIFL25xL4Bj/polMeqbkE0OtDmISQfuYTsCkvRVBc
	lm0q7/pYc8aynp9QHWUojbMWBxCSeF/lNC8SkW9Aqyc7eg567v1+DPF2TkYi9ARFPIXZZ8
	Eex6W9al2o2Ts83FG3y0vdDgLqrltdIw1mkb2JNZz0sEROV7aTdtVXfg0f6HaA==
Message-ID: <8d6a8d0a-77e1-47cd-8562-ae852e22a62a@bootlin.com>
Date: Wed, 4 Feb 2026 08:39:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 03/13] net: phy: phy_port: Correctly recompute
 the port's linkmodes
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260203172839.548524-1-maxime.chevallier@bootlin.com>
 <20260203172839.548524-4-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260203172839.548524-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256602-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B33BE2C19
X-Rspamd-Action: no action



On 03/02/2026 18:28, Maxime Chevallier wrote:
> a PHY-driven phy_port contains a 'supported' field containing the
> linkmodes available on this port. This is populated based on :
>  - The PHY's reported features
>  - The DT representation of the connector
>  - The PHY's attach_mdi() callback
> 
> As these different attrbution methods work in conjunction, the helper
> phy_port_update_supported() recomputes the final 'supported' value based
> on the populated mediums, linkmodes and pairs.
> 
> However this recompute wasn't correctly implemented, and added more
> modes than necessary by or'ing the medium-specific modes to the existing
> support. Let's fix this and properly filter the modes.
> 
> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy_port.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
> index a269e9ea12c4..ad2580529842 100644
> --- a/drivers/net/phy/phy_port.c
> +++ b/drivers/net/phy/phy_port.c
> @@ -108,16 +108,10 @@ EXPORT_SYMBOL_GPL(phy_of_parse_port);
>   */
>  void phy_port_update_supported(struct phy_port *port)
>  {
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0 };
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {0};
>  	unsigned long mode;
>  	int i;
>  
> -	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
> -		linkmode_zero(supported);
> -		phy_caps_medium_get_supported(supported, i, port->pairs);
> -		linkmode_or(port->supported, port->supported, supported);
> -	}
> -
>  	/* If there's no pairs specified, we grab the default number of
>  	 * pairs as the max of the default pairs for each linkmode
>  	 */
> @@ -127,6 +121,23 @@ void phy_port_update_supported(struct phy_port *port)
>  			port->pairs = max_t(int, port->pairs,
>  					    ethtool_linkmode_n_pairs(mode));
>  
> +	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
> +		pr_info("Adding mode for medium %d pairs %d\n", i, port->pairs);

Bah. That print statement doesn't belong here...

Maxime


