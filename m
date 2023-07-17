Return-Path: <netdev+bounces-18435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72236756F16
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A304C1C20B83
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53338107BC;
	Mon, 17 Jul 2023 21:44:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870C107B9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 21:44:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3692
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PmsfWt3MiL8JbH69Te0ISNmMAsV9Q9QQ4hCzeojtx8w=; b=JnNOUHySHF9ftDJSPaE5CS1JuY
	H9B11mQP885m6DrClu46npVXQ4x+kAbymJmqVdvQF+X6MKN92pkLwYRKGm83RuIwe6l9wnLaUc3Lq
	pISV/560VgyL/yj3WeLNeIAIi9eZgrNfp1shu48ntPuMtZJT/MpBIm+Ce/Ygf/H8TISQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLW14-001a73-7t; Mon, 17 Jul 2023 23:44:26 +0200
Date: Mon, 17 Jul 2023 23:44:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 2/5] net: phy: c45: add support for
 1000BASE-T1 forced setup
Message-ID: <02908a61-640b-433c-989d-367aaedc189e@lunn.ch>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717193350.285003-3-eichest@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 09:33:47PM +0200, Stefan Eichenberger wrote:
> Add support to force 1000BASE-T1 by setting the correct control bit in
> the MDIO_MMD_PMA_PMD_BT1_CTRL register.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

