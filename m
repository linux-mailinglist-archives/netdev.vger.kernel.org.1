Return-Path: <netdev+bounces-53335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D814A80264E
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737DC1F20FF0
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A9171D9;
	Sun,  3 Dec 2023 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="maVOiZen"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D029ADA;
	Sun,  3 Dec 2023 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HLV8YOVDigNgWOz0plPakVj5s9mqkHpb2at7e7OE9i8=; b=maVOiZenfrED7JgoNTkfQoYl6E
	xnjzKhI7F2GN6XDMO1Dy2rjMf3sVIlFb1qsKR6FYxdxRR46ZRliG+7ekpTyC40QnvmRBMUT7Ze6Md
	aFoKgrKfZGMWlHEHSndFe/iVqCgjt1O4OpTznUqPS0iA7cYAt0plIPyUSxW1MEjsAtb0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9rLw-001uPa-IS; Sun, 03 Dec 2023 19:38:04 +0100
Date: Sun, 3 Dec 2023 19:38:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 3/8] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <69292ed5-63d3-4316-9bab-630bd00ce807@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>

> +/**
> + * enum - Types of PSE controller.
> + *
> + * @PSE_UNKNOWN: Type of PSE controller is unknown
> + * @PSE_PODL: PSE controller which support PoDL
> + * @PSE_C33: PSE controller which support Clause 33 (PoE)
> + */
> +enum {
> +	PSE_UNKNOWN = BIT(0),
> +	PSE_PODL = BIT(1),
> +	PSE_C33 = BIT(2),
> +};

Maybe this should be in the netlink API?

I think you can imply it by looking at what properties are in the
netlink reply, but having it explicitly is probably better.
ethtool(1) can default to PSE_PODL if the property is missing for an
older kernel.

      Andrew

