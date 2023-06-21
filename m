Return-Path: <netdev+bounces-12821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE7739066
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0303281779
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD05E1B911;
	Wed, 21 Jun 2023 19:49:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E017724
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:49:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ECD1731
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VeYZnv5zbc/CsGIpJVIVuO6f7Fr+oQbsPSn1cobuDbo=; b=x7xCU8LXycVQaXojfPVw/ejAj4
	MFUpX0SgE1kFAiRkvCmB1o7a94u2/omCt/Qh+wySocpdy6zIvHEq+VFYu29/MiMp7cYH8OcwP7hHN
	DhNHceHLB/EB0VNj/tnchgucSPtnrWcWEO5Zv67XZtwOx84Rugtlp5wSG0BZIHARRSHo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qC3pI-00HBTl-Qd; Wed, 21 Jun 2023 21:49:12 +0200
Date: Wed, 21 Jun 2023 21:49:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>
Subject: Re: imx8mn with mv88e6320 fails to retrieve IP address
Message-ID: <61bbef84-731f-4096-82a8-e5d5eacd050b@lunn.ch>
References: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AdPZfQQEfSgW-Cgw2GySerc0oxUu4OEcQoxwVeB+wQWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> When the Trendnet switch is used, DHCP fails and ethtool reports just
> these lines differently:
> 
>         Link partner advertised link modes:  10baseT/Half 10baseT/Full
>                                              100baseT/Half 100baseT/Full
>                                              1000baseT/Half 1000baseT/Full
>         Link partner advertised pause frame use: Symmetric

So all the local link modes are missing?

What does mii-tool -vvv show?

     Andrew


