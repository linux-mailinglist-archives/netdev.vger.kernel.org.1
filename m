Return-Path: <netdev+bounces-258235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBf/IrBNjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:36:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC577122CD6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 441FC3004C8A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36563570C8;
	Wed, 11 Feb 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miwhChgn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B53570A3;
	Wed, 11 Feb 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770802602; cv=none; b=CCp5USrAJZqVDP6hW8pXonYO7OPATmyihmGFIBa7aQw0w9sbZhv/Bhi7C8fwWVF5jeOP+ayafT06pw9zfXSoKYIYit7Z5dfd5tpjO95vyxTpNSQwWSyL8vJFoNO0p9aHPddHgTr4RPHkvLiwRk0F1sNwpxHbnExxCvVir59cjPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770802602; c=relaxed/simple;
	bh=GESarjr2933u4U1pEAsYWs63nBlt+cEhT+tMQsK3K2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0DA7YOiQLYdEkOKXLnkKBF4VaTpqAEuH+RmeX7kNNqMdXfNQQADoUs229WZBJ9JASxqtjj8T5ILIkr9qAqfOJN8kOqY0cf2jpTF7DUtxbGk47e9tCvYT1eLKNcuTKeuMIZxrKcbIoLyxobgVw2oQMMXen3z84mqz6RcRJiqIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miwhChgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F0CC4CEF7;
	Wed, 11 Feb 2026 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770802602;
	bh=GESarjr2933u4U1pEAsYWs63nBlt+cEhT+tMQsK3K2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=miwhChgncWW4w6VZHc7hGPS0QebH1ii5+f4Qx1MSnU4u+x9DOd1Ja3Dee3SeTMhNP
	 lMqccOvBcCI+qTorLqfxflKGa/2/Do8Q2ISSnMhaHaUJJJEVgcfcp4BvMywEOd62oD
	 crHM+b0tfwpyzm0kjvC89cxN9Kgw5hsGbGaV+FCwT7v9u1cSj4Ef3YO2JnB+GbKr4Q
	 V2K3FZ1rqwT9prl69gUnONpQmqlYNXF+6qkAdyyfvC4EqkzPLOv705qx1qcz7EAroK
	 coUYKQDODit2/zbgDXF1in7rpvQcpibAsF0PthtSJLoTTfSp9ziTo+1JWqxbQu4um6
	 5LsgHHN6a7U7Q==
Message-ID: <3a9a158f-bb17-43fd-80ce-1d70839f795a@kernel.org>
Date: Wed, 11 Feb 2026 10:36:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/13] net: phy: initialize the port support
 based on the PHY's for OF ports
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
 <20260205092317.755906-2-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260205092317.755906-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258235-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AC577122CD6
X-Rspamd-Action: no action



Le 05/02/2026 à 10:23, Maxime Chevallier a écrit :
> With the phy_port infrastructure came an ethernet-connector binding,
> allowing to represent the MDI of a PHY in devicetree. This allows
> specifying the mediums and pairs of a port.
> 
> Let's initialize the port's supported list based on what the PHY
> reports, so that we can then filter it with what the connector allows
> using.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_device.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8a3eb1839a3d..9b8eaac63b90 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3499,6 +3499,9 @@ static int of_phy_ports(struct phy_device *phydev)
>   
>   		port->parent_type = PHY_PORT_PHY;
>   		port->phy = phydev;
> +
> +		linkmode_copy(port->supported, phydev->supported);
> +
>   		err = phy_add_port(phydev, port);
>   		if (err) {
>   			phy_port_destroy(port);


