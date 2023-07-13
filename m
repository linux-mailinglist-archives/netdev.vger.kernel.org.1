Return-Path: <netdev+bounces-17696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AB752BB8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7D281F28
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29EB1F929;
	Thu, 13 Jul 2023 20:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9F1DDFB
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 20:35:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B395A2127;
	Thu, 13 Jul 2023 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jsEwjRCLcUzZXVjUufRDoXbDL5QJ0GEeDAMUjtLbxPM=; b=kju7V7PEPoyZYwcaj6/YJxq9is
	Iau6NU8Es1Lugcj9hQS1apcDH3CmTlQTmDpsMpC1K6oaH7CHn299gjdRJLYlsB1se/kqIshH1Gh2k
	73k61Kmf7R8nr9oAnCiPX/ujXdRs+kGPgqWj+OFLVUALiQXbRWsBS7IAWn3t49PY1okI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qK32N-001Hyd-CM; Thu, 13 Jul 2023 22:35:43 +0200
Date: Thu, 13 Jul 2023 22:35:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
Message-ID: <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
References: <20230713202123.231445-1-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713202123.231445-1-alex@shruggie.ro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +set_reg:
> +	mutex_lock(&phydev->lock);
> +	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> +			      VSC8531_CLKOUT_CNTL, mask, set);
> +	mutex_unlock(&phydev->lock);

What is this mutex protecting?

     Andrew

