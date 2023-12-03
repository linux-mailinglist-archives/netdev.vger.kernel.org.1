Return-Path: <netdev+bounces-53331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC1802635
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853BDB20939
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5A17743;
	Sun,  3 Dec 2023 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AOv5N8a0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEBE7;
	Sun,  3 Dec 2023 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yGXjs7wEKgueS6v+FaTEskIskjzuTLjEstmKQFfF4KI=; b=AOv5N8a0gDtiB1XPqQSL5e54BQ
	6cK49RzBb0pl59+o5C/iDENlLQvAnuK0L6NtQ3gamsyfIQuy9UhmwLq5rN9F06IAX0oHvYz8GZH5E
	yLEG+vgp+xG1DQl6ivhg2x1KwPkx5dU3/oXZKSh5Ff04Z52YsNb9E67Uee6BG2vcy3h0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9r3z-001uKd-LD; Sun, 03 Dec 2023 19:19:31 +0100
Date: Sun, 3 Dec 2023 19:19:31 +0100
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
Subject: Re: [PATCH net-next v2 1/8] net: pse-pd: Rectify and adapt the
 naming of admin_cotrol member of struct pse_control_config
Message-ID: <97ac9982-9cb1-47b7-9bad-80db69287c6c@lunn.ch>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-1-56d8cac607fa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-1-56d8cac607fa@bootlin.com>

On Fri, Dec 01, 2023 at 06:10:23PM +0100, Kory Maincent wrote:
> In commit 18ff0bcda6d1 ("ethtool: add interface to interact with Ethernet
> Power Equipment"), the 'pse_control_config' structure was introduced,
> housing a single member labeled 'admin_cotrol' responsible for maintaining
> the operational state of the PoDL PSE functions.
> 
> A noticeable typographical error exists in the naming of this field
> ('cotrol' should be corrected to 'control'), which this commit aims to
> rectify.
> 
> Furthermore, with upcoming extensions of this structure to encompass PoE
> functionalities, the field is being renamed to 'podl_admin_state' to
> distinctly indicate that this state is tailored specifically for PoDL."
> 
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

