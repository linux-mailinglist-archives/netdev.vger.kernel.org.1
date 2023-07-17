Return-Path: <netdev+bounces-18438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91D756F28
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A91F281343
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738FD10958;
	Mon, 17 Jul 2023 21:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F742F52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 21:54:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084F6E4C
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NZJIj1X+DBo91bX1gqqRwpT4oxaPVl6qDB2CahYfQx0=; b=pvt1Cx36684CKTXP89wi2eQxDK
	dY5FUAdSSs5dCLaKUZHqHSQcTe3R4oYP2wLUQBekZhuoOinlpHDwiiWuaYydM45cSn/PwNU+TBIfX
	znAV2hT5H7ajnDNiQDHu0HmkyQcIqRotdAowwEg6Zp25LYoHVSkKvvDj1qPtWD1ti12w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLWAx-001a9Z-0o; Mon, 17 Jul 2023 23:54:39 +0200
Date: Mon, 17 Jul 2023 23:54:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <dbd85f63-6abc-4824-a5ec-3ed5f270ffeb@lunn.ch>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-6-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193350.285003-6-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +#define MARVELL_PHY_ID_88Q2110	0x002b0981

> +
> +static struct phy_driver mv88q2xxx_driver[] = {
> +	{
> +		.phy_id			= MARVELL_PHY_ID_88Q2110,
> +		.phy_id_mask		= MARVELL_PHY_ID_MASK,

Probably not an issue...

The ID you have above is for revision 1 of the PHY. But the mask will
cause the revision to be ignored. Do you want to ignore the revision?
Are there different errata for revision 0 and 1?

    Andrew

