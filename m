Return-Path: <netdev+bounces-21859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F776515A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE63A28112C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2698FBEE;
	Thu, 27 Jul 2023 10:38:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A8D539
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:38:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA07269E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gUQMzQyKjcDc8bRIA4Rye4QCND40jXimAuOGpygqhkw=; b=5ixRRImxB2bwzy7gCHeIwm/wbq
	m0YRjf8ihmcT9SaxKzhGucyFHvwhLLpGi/KhmsmLL6cVtL4HUpbfdr+H9NRGMQbSw/AHSbZXCGGP5
	FN9IGi3NZMR76acEXeB2WuZNWqCMsE2nNsuuuc4eK6BYKJXIWJE8M6er6QXXgS1VBjME=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOyNW-002RTV-LB; Thu, 27 Jul 2023 12:37:54 +0200
Date: Thu, 27 Jul 2023 12:37:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 09/10] net: stmmac: dwmac-loongson: Add 64-bit DMA and
 multi-vector support
Message-ID: <26015def-bee6-4427-9da4-ca27de8c1d87@lunn.ch>
References: <cover.1690439335.git.chenfeiyang@loongson.cn>
 <f626f2e1b9ed10854e96963a14a6e793611bd86b.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f626f2e1b9ed10854e96963a14a6e793611bd86b.1690439335.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +	case DWMAC_CORE_3_50:
> +		fallthrough;
> +	case DWMAC_CORE_3_70:

You don't need fallthrough here.

    Andrew

