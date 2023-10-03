Return-Path: <netdev+bounces-37795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D97B7366
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 42864281339
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3C3D965;
	Tue,  3 Oct 2023 21:33:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5A3D3BF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:32:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D509B4;
	Tue,  3 Oct 2023 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TmbG19q/l6/TFhKwKoaT2kkqg5Pf6ybIjYHQ4sb+b0E=; b=hMtsoqqkFPxb0Y+BJj5Rfp98pt
	fYY2xiiKLzIX2P50gjJTJShB8inGExSLn10LzC0NQfLJXnI0+oz6J7GDxeE45CwozSypKvp5c7kvy
	25kQHRewyzXq/epzfTZlwu2UiEiigs8ZWDsxEWQAGabBlQ5cK9SfKmf1pPR+dF4BlbHM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qnn0T-0089lk-Ja; Tue, 03 Oct 2023 23:32:41 +0200
Date: Tue, 3 Oct 2023 23:32:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <simon.horman@corigine.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: dsa: vsc73xx: convert to PHYLINK
Message-ID: <52dd8a1c-e0f0-4a24-b6d7-6ba1c9482525@lunn.ch>
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-3-paweldembicki@gmail.com>
 <ZQCWoIjvAJZ1Qyii@shell.armlinux.org.uk>
 <20230926230346.xgdsifdnka2iawiz@skbuf>
 <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJN1KkwktmT_aV5s8+7i=6CW08R48V4Ru9D+QzwpiON+XF8N_g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> I plan to make rgmii delays configurable from the device tree. Should I?
> a. switch to phy_interface_is_rgmii in the current patch?
> b. add another patch in this series?
> c. wait with change to phy_interface_is_rgmii for patch with rgmii
> delays configuration?

Do you actually need this feature? Does the PHY you are using already
support fine tuning of the delays?

	Andrew

