Return-Path: <netdev+bounces-20129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665E275DC16
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22C7281F69
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8750C18B12;
	Sat, 22 Jul 2023 11:53:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982862A
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 11:53:08 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D93AB8;
	Sat, 22 Jul 2023 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gpMai+RGZVHO11XO50XWI3/EZ38TmKbr58h9zhvA2Ng=; b=wLJ2lxgjKeS0A5E5folJrJ1QmX
	ENdR+hijE1xMd2fkD0roQAMmMydabk+nSI7LKbibanWBfivtAqYdo2MPw2uXJS7Xi1zL+bi3nQCvr
	SfZt/5QFdOl4ZT+uNXsALE4jOzaFpKUEcrtH3xBCKQJMn5RoLiGx4IWeF28Li2DxgUaY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qNBA9-001vyL-VK; Sat, 22 Jul 2023 13:52:41 +0200
Date: Sat, 22 Jul 2023 13:52:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
	linux@armlinux.org.uk, devicetree@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	Arun.Ramadoss@microchip.com, edumazet@google.com,
	f.fainelli@gmail.com, conor+dt@kernel.org, olteanv@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next v2 6/6] net: dsa: microchip: ksz9477: make
 switch MAC address configurable
Message-ID: <95007aa6-a09b-4a05-93cb-65db405a2549@lunn.ch>
References: <20230721135501.1464455-1-o.rempel@pengutronix.de>
 <20230721135501.1464455-7-o.rempel@pengutronix.de>
 <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558A296C1D1830F15AC6BEFEC3FA@BYAPR11MB3558.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The DSA driver used to have an API to set the MAC address to the switch,
> but it was removed because nobody used it.

That is a long time ago, when Marvell was about the only supported
vendor. As far as i understood, it was used to set the MAC source
address used when sending pause frames. But since pause frames are
link local by definition, and the switches had a reasonable default,
it was removed.

    Andrew

