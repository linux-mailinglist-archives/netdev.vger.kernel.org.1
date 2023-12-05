Return-Path: <netdev+bounces-53951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0995380560F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8128281BCA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C725D90C;
	Tue,  5 Dec 2023 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t8N6FPro"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8764181;
	Tue,  5 Dec 2023 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f+lsdlAVUE5UtJ7lznC8cnI4y3fdQnoo6Z3B38BLcgw=; b=t8N6FProS95FvKZosHFBPYfaTF
	jAJktDdEo23x6WMltbKip+c04oOvXtgw+0hxAdmIjysqtjtUtZOyRDvSmJlwx8/cfaFiICFhm5MMB
	fRK3u/kggCmLyw7tp5153GQVrO7PPxEeMLEm3SxE0w1qqZxa2wLFhBv2LJ0V1P1YrzOM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAVZI-0026AI-G0; Tue, 05 Dec 2023 14:34:32 +0100
Date: Tue, 5 Dec 2023 14:34:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	openbmc@lists.ozlabs.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/16] net: pcs: xpcs: Return EINVAL in the
 internal methods
Message-ID: <b460100c-8ce1-4958-9396-cd2545e85012@lunn.ch>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205103559.9605-4-fancer.lancer@gmail.com>

On Tue, Dec 05, 2023 at 01:35:24PM +0300, Serge Semin wrote:
> In particular the xpcs_soft_reset() and xpcs_do_config() functions
> currently return -1 if invalid auto-negotiation mode is specified. That
> value can be then passed to the generic kernel subsystems which require a
> standard kernel errno value. Even though the error conditions are very
> specific (memory corruption or buggy implementation) using a hard-coded -1
> literal doesn't seem correct anyway.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

