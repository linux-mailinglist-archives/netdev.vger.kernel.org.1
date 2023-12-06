Return-Path: <netdev+bounces-54536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127FB807691
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14785281D07
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B163DF8;
	Wed,  6 Dec 2023 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hS5rueB/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47A84;
	Wed,  6 Dec 2023 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XZlK2oiq0c1d4tnzLcflwgGE+fdbw4Y3Ah3eo8MZaoI=; b=hS5rueB/cfpMaqar0PuBXkxaB5
	TyGKMNibNGyEKSb6gmdSgiChCoupduYvUZxSL4HQqfKqE2brILWX9YEfjPYPw1CrIaVdoRGWVYSgU
	kl7Sg3MRigEv2El1Y3/IjOIJHZwC31SdvNY4sOIATAF3+Ig1CPpMXpWeUPfIKUTXD3Ac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAvej-002EZv-Da; Wed, 06 Dec 2023 18:25:53 +0100
Date: Wed, 6 Dec 2023 18:25:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 11/12] net: phy: at803x: move at8035 specific
 DT parse to dedicated probe
Message-ID: <35221bc0-4f7d-436d-bfca-a56330682de0@lunn.ch>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
 <20231201001423.20989-12-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201001423.20989-12-ansuelsmth@gmail.com>

On Fri, Dec 01, 2023 at 01:14:21AM +0100, Christian Marangi wrote:
> Move at8035 specific DT parse for clock out frequency to dedicated probe
> to make at803x probe function more generic.
> 
> This is to tidy code and no behaviour change are intended.
> 
> Detection logic is changed, we check if the clk 25m mask is set and if
> it's not zero, we assume the qca,clk-out-frequency property is set.
> 
> The property is checked in the generic at803x_parse_dt called by
> at803x_probe.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

