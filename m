Return-Path: <netdev+bounces-48489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7627EE903
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27392280F92
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94999495E4;
	Thu, 16 Nov 2023 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wargMnQ9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8DE11F;
	Thu, 16 Nov 2023 13:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qFIKJNMJZJjAnRhghhLsmURLh5LOneVJNgaAcBXW1Vo=; b=wargMnQ928QUz+HenrYGyhaI1x
	zEcRUcFJM1mDZrnR6TojJK+Hv7ESIHAjnd/hHDjjPXCGJWmBvckN9JKnRc7c/5OPsQtIPquhQuhx/
	MZIxt4118qNwUHtMsOFchWxNG7GJC2Oi3piMzl1ChEtc54albltJdfUnG9qokKtNgc2o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r3kLK-000OKe-Nn; Thu, 16 Nov 2023 22:56:10 +0100
Date: Thu, 16 Nov 2023 22:56:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 7/9] firmware_loader: Expand Firmware upload
 error codes
Message-ID: <014c6bb7-178f-44cf-872f-eb4d59a80756@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-7-be48044bf249@bootlin.com>
 <20231116-t-shirt-supreme-581c8882d5cc@squawk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-t-shirt-supreme-581c8882d5cc@squawk>

> This would be rather helpful to me for some stuff that I am currently
> working on and was hoping to send to Arnd for inclusion in 6.8:
> https://lore.kernel.org/all/20231020-series-uncooked-077b107af3ae@spud/
> 
> I'm currently returning a "HW_ERROR" for something that this would fit
> the bill for (in mpfs_auto_update_write()). What would the ETA for this
> stuff landing via the net tree be?
> Since I am not a netdev contributor its hard to tell how controversial
> these patches are!

It already has the needed ACKs, so it could be merged
anytime. However, it seems like two different subsystems are
interested in it. So rather than merge it via netdev, it might make
sense to merge it via its normal tree, driver-core. Then ask for a
stable branch which can be pulled into netdev and arm-soc.

      Andrew

