Return-Path: <netdev+bounces-17401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D94751732
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4107281AE0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9965254;
	Thu, 13 Jul 2023 04:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4041468C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:09:38 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED382114
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3+ufFCVRkF3iZYTHYJyjgWqPmSlBWrJ/mMYuOXxUKNY=; b=rAyP4o8nGUKmaOmPS6YaAE2uL0
	JrKQVOhnIlTKJMUSTMtxbUXSRvC8KuCEaKcnDHdzyNRh/qbB9PbZYxS8eqQhEWKuDyVkcgYRvuyqX
	dxMAdkZDKE/JEo+3i4DPO2+g1Dr8GPYA5j+WOYxHBZdtjpdkII8L610zyuzTWO4QWd5Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qJndl-001CXW-UV; Thu, 13 Jul 2023 06:09:17 +0200
Date: Thu, 13 Jul 2023 06:09:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn, linux@armlinux.org.uk, dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn, netdev@vger.kernel.org,
	loongarch@lists.linux.dev, chris.chenfeiyang@gmail.com
Subject: Re: [RFC PATCH 00/10] net: phy/stmmac: Add Loongson platform support
Message-ID: <2e10d9d1-e963-41fe-b55b-8c19c9c88bd5@lunn.ch>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689215889.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 10:46:52AM +0800, Feiyang Chen wrote:
> Add driver for Loongson PHY. Extend stmmac functions and macros for
> Loongson DWMAC. Add LS7A support for dwmac_loongson.

Why is this RFC? What do you actually want comment on?

    Andrew

