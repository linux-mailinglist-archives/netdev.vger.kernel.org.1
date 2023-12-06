Return-Path: <netdev+bounces-54493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE880748B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5F21C209EC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448146453;
	Wed,  6 Dec 2023 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EA2utCKa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC8A3;
	Wed,  6 Dec 2023 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2UxyokxjmvPqTPrwXVDTubcv9FjJjWbq5cXUewEFM/8=; b=EA2utCKaEEQSejX04+tFYkmXwb
	85hgwyHF3vqhtZASDp5nrvD4ZaA6G6QgUVPXI44lWW1bMfudK4kWUxbXLRZNN8qFMlwiMActnh83l
	ixitF1/S4J/B0zC162rn9bIjsgUohlZkcmzPyiCLD7RVNNJABdhW7iAd7xZmNNjAQCN0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAuRH-002E1s-5A; Wed, 06 Dec 2023 17:07:55 +0100
Date: Wed, 6 Dec 2023 17:07:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO
 without _VALUE define
Message-ID: <488c0037-0cbb-43a6-8d02-0b5ac3eb84bd@lunn.ch>
References: <20231206160124.1935451-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206160124.1935451-1-sean@geanix.com>

On Wed, Dec 06, 2023 at 05:01:23PM +0100, Sean Nyekjaer wrote:
> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> DSA_TAG_PROTO_LAN937X to improve readability.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

