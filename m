Return-Path: <netdev+bounces-258238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MJ5HXZOjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:40:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB6122D1E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76C583004936
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC91357710;
	Wed, 11 Feb 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVoi48re"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD3357706;
	Wed, 11 Feb 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802803; cv=none; b=U27W4a2TqR3JFjuRipbnK1IFXvBGfFciQmjF4LHWWs46foJe0DoIjG6mhPBiST+oYmfluvnUszl1Dp31SfnX/Gw4WZ6C9YvP1EtZnxKRfaxwBpaSlGOIZVJZ0NVoquOH9hed6u4Ixh4/+ucKR0HAU0TAYS/TaGhcYtRy4rV+IIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802803; c=relaxed/simple;
	bh=Q4waBNpupqyQVBWTyFJufE9FHYc2T+I4CNoB9b8FVqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7PbubdxQ0sOD0sOoM3qcgCZ6FkxGtmxDYV3103UlOXTNoOSku8eOLx39PHPgkAqMQFl1prhqogWAji6b01QZfUI+mg6ENpvpEHgQJhA64hOSo8ZLeYFWGSkXEGIXD8WMZy3smzL9MsYBb844ERCeFuOSxZrdEjhYUbYpqQRIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVoi48re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEDBC19423;
	Wed, 11 Feb 2026 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770802803;
	bh=Q4waBNpupqyQVBWTyFJufE9FHYc2T+I4CNoB9b8FVqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVoi48re5zM0FvlYMZcK83+SdFfPd1I6heREhZf2l1hKHAsk+WkOOX9VmCEqkwDxI
	 q4Af1s/Xdff7jaAim48Bky2FKZuJuQ5tT2ArVpbloVmQ2/0yqgVGyyS/YdQcnXXt78
	 SsppZAPE2pNq2Gy3C4ce+qvgzNe3PmoAwIjZrd9KAWWmQO96B0B70SrsMXBjhP+6Qd
	 NAf/K9bf35jTHUU0ROWzEixuv7NzpUc4tKikvBPqdF2fHfoXDsONSE71MvQ22vesac
	 5NbARIkg2dlJcQLMe64sF/kjY6bQrQg4lrXhkIxycigziv+TMYL4ynGg1BO54cUmjp
	 10mXXiaLiCBNQ==
Message-ID: <31bde1a4-adaf-4a1d-8b88-6075189a6af4@kernel.org>
Date: Wed, 11 Feb 2026 10:39:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 03/13] net: phy: phy_port: Correctly recompute
 the port's linkmodes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
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
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
 <20260205092317.755906-4-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260205092317.755906-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3BAB6122D1E
X-Rspamd-Action: no action



Le 05/02/2026 à 10:23, Maxime Chevallier a écrit :
> a PHY-driven phy_port contains a 'supported' field containing the
> linkmodes available on this port. This is populated based on :
>   - The PHY's reported features
>   - The DT representation of the connector
>   - The PHY's attach_mdi() callback
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

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_port.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
> index a269e9ea12c4..63d1bb154dc7 100644
> --- a/drivers/net/phy/phy_port.c
> +++ b/drivers/net/phy/phy_port.c
> @@ -108,16 +108,10 @@ EXPORT_SYMBOL_GPL(phy_of_parse_port);
>    */
>   void phy_port_update_supported(struct phy_port *port)
>   {
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0 };
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = {0};
>   	unsigned long mode;
>   	int i;
>   
> -	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
> -		linkmode_zero(supported);
> -		phy_caps_medium_get_supported(supported, i, port->pairs);
> -		linkmode_or(port->supported, port->supported, supported);
> -	}
> -
>   	/* If there's no pairs specified, we grab the default number of
>   	 * pairs as the max of the default pairs for each linkmode
>   	 */
> @@ -127,6 +121,22 @@ void phy_port_update_supported(struct phy_port *port)
>   			port->pairs = max_t(int, port->pairs,
>   					    ethtool_linkmode_n_pairs(mode));
>   
> +	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
> +
> +		phy_caps_medium_get_supported(med_supported, i, port->pairs);
> +		linkmode_or(supported, supported, med_supported);
> +	}
> +
> +	/* If port->supported is already populated, filter it out with the
> +	 * medium/pair support. Otherwise, let's just use this medium-based
> +	 * support as the port's supported list.
> +	 */
> +	if (linkmode_empty(port->supported))
> +		linkmode_copy(port->supported, supported);
> +	else
> +		linkmode_and(port->supported, supported, port->supported);
> +
>   	/* Serdes ports supported through SFP may not have any medium set,
>   	 * as they will output PHY_INTERFACE_MODE_XXX modes. In that case, derive
>   	 * the supported list based on these interfaces


