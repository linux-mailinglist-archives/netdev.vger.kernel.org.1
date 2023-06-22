Return-Path: <netdev+bounces-13184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B873A8D7
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AA7281AB0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8D821062;
	Thu, 22 Jun 2023 19:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043B1E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:15:01 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2725F1A3;
	Thu, 22 Jun 2023 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rVSwZmo6YEMkdlAPeqhXmjbT6Y0ePJFEJuTxqSTX/cQ=; b=PkGkRIXAnmqLYLAYpkHI2sw6ch
	9nynT/LGXi3r3B+1GAXY/1xXvzmG02v7rm3tPKVl0LTY6PGWLyF6mQp4p24WIcdXeHPAIvWj8HwfO
	RD1mJ6tdXCi89In/4wh/n/Bt/MfhZZME0A52SrXelToIvYRw6+AOrXgQ1e1zJsM5hQFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCPlU-00HIIH-OI; Thu, 22 Jun 2023 21:14:44 +0200
Date: Thu, 22 Jun 2023 21:14:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, ansuelsmth@gmail.com,
	rmk+kernel@armlinux.org.uk, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
Message-ID: <6ecd7203-30a7-4806-94be-eb77b3ba68b1@lunn.ch>
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
 <533872e1-b323-4bca-aacc-4d3cfbed53bd@lunn.ch>
 <463a64a4-d629-27bc-2269-3fcdbf8b7e50@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463a64a4-d629-27bc-2269-3fcdbf8b7e50@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Since this is a fix, I went with the more targeted approach here.

Yes, this is fine for stable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

