Return-Path: <netdev+bounces-20956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3959576200A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7293528185A
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736225902;
	Tue, 25 Jul 2023 17:25:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FD1F932
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:25:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62491BDA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FI0iDGEr6DiMUd8Cd01rw8E6i3/t/Gqg7zN5WZWsmL8=; b=wUZfdjU5uC7LwBRTIDAsMmYRhl
	zCbqdoZydW5myR2bSG85DOn7jvTdz4l3FUtxc/bvCwCCIU+avp5ghbP0GSlmz4dWJmSOLxMOYKsvw
	ooaLO/3Ni1TLCxFs+vb9YHyLfqUGYSnTL7o0FWHh1It53LY9jw3fUMow9UlAtsZC7mQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOLmI-002IAT-8D; Tue, 25 Jul 2023 19:24:54 +0200
Date: Tue, 25 Jul 2023 19:24:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/7] net: pcs: xpcs: add specific vendor supoprt
 for Wangxun 10Gb NICs
Message-ID: <875a4fb7-7b54-490b-930b-4bf4f6ac7cae@lunn.ch>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724102341.10401-2-jiawenwu@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static bool xpcs_dev_is_txgbe(struct dw_xpcs *xpcs)
> +{
> +	if (!strcmp(xpcs->mdiodev->bus->name, DW_MII_BUS_TXGBE))
> +		return true;
> +
> +	return false;
> +}

> +#define DW_MII_BUS_TXGBE	"txgbe_pcs_mdio_bus"

I don't see much value in using a #define here. Just use the string
directly.

	Andrew

