Return-Path: <netdev+bounces-51813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40A7FC520
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614131C20DFE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696940BFC;
	Tue, 28 Nov 2023 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wOk0Xk/U"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700010F4;
	Tue, 28 Nov 2023 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2CeW/Odz8x9jn8UzcgIPzzytCgTSCiS8MoreUC+k6Jk=; b=wOk0Xk/UT372hSMBw+y2JAh6Xn
	Iu/krV12bSqcynrLXBJOcfiaHZeCuL0njz4I4W4dIQL+dWDnMuNv9VqgywtxIRuaOAkacvTBEE5VI
	esQZTDCJer/7tKXAyBK4rrqzjOcRPLTGpGb2Kh6C1RwZjIyyrO2GbdgJMYTbm+MKdPbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r84Wu-001UMY-Gf; Tue, 28 Nov 2023 21:18:00 +0100
Date: Tue, 28 Nov 2023 21:18:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@axis.com
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
Message-ID: <452f1e1c-1afd-4a36-bf60-11b7de291d2f@lunn.ch>
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>

On Mon, Nov 27, 2023 at 04:31:39PM +0100, Vincent Whitchurch wrote:
> Add support to allow Fast Link Down (aka "Enhanced link detection") to
> be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
> have this feature enabled by default.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Is there anything in the datasheet about how fast it is? It would be
nice to return the number of milliseconds, if its known.

    Andrew

