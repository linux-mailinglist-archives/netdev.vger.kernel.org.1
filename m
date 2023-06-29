Return-Path: <netdev+bounces-14499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FEA742017
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 07:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C49A1C208EB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245B5235;
	Thu, 29 Jun 2023 05:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFC4C9A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:51:04 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5E297C
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 22:51:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31297125334so201666f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688017862; x=1690609862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peZonunRaJ95r6T1skx2hyGoFsSu6wDgzOW9qrfM4Kc=;
        b=tgfy8qGSD65HWBeWSIUrq2wWBy9Vd26n+4f51LYynMfXR3xx01skrGd0sgmMs9OpTA
         cDfcerpQwY09qL8vel86+NmxTEhQm3d7DtER7CT5WcpLGRGcWN4tn6MU+ZAPaOy5EGMt
         9ONOUxTd0gHb4ERi6CPsC0jpfU6kqDRFQ/VbLOZJpmY/DHvICxEkLpC5RzneK7k7+bAs
         +5P3tk4Bk0OmQUYahxXdYCKj+cg1pSHaWjtPI7661o5+BEAMmXdiPABIbXPe8IcwZ37r
         nsFbf99Gk5ZwMYha6mtBhmDaM4auoL9kE8but4ai5jRteblHx2prqqfj8oZ6nV1zQtTz
         APoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688017862; x=1690609862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peZonunRaJ95r6T1skx2hyGoFsSu6wDgzOW9qrfM4Kc=;
        b=AeE2LDJOmHUPf4UHn0TZ0y38e+5N7+fcHc6JPjroZySjTmsyT6s5eAXCx6r0EeQXvJ
         RMZ4iXYNg2phGTimNAzFr7i2iUy69PDPvDF5WeL7A9V3TIWoUNbIjPiJYqPAQGQ5JfWV
         NDdaqsgW8iVUUSfitKvGsEvtOWLtJ5MIFYeXax14VBdZS7ibxzrMpqdKdTYEDkq8Lf2+
         6HsC8/z6Goz84V1RL4m/B4eCaBDMxkq3DZgN+vSI7gjK0tZQSPEodfAo7hNRGMtfVo57
         fUgKpcQ1KlzvMf7GziXf4xuUEO0UXKlJOp33LJmax5iba1HNkrRdh1OLZnQ0sFZCKkza
         QyAQ==
X-Gm-Message-State: AC+VfDxcf5u7rEI42ugT1WcRgxxaJp8upq1+/8PnvXYS3JV0i5Itmzj3
	nh1sbRXsq6VG0wUeDbM8vRhU8g==
X-Google-Smtp-Source: ACHHUZ46bnTv4fp7Jqwr00dopnJCmcDpYeZN2PzIZLASW0OP/E6OKDKyB66Uq90f9l+06/VSKbnd8w==
X-Received: by 2002:adf:fd51:0:b0:313:eeb0:224c with SMTP id h17-20020adffd51000000b00313eeb0224cmr3055104wrs.28.1688017861739;
        Wed, 28 Jun 2023 22:51:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b00313eeca9f4asm11425249wrt.14.2023.06.28.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 22:50:59 -0700 (PDT)
Date: Thu, 29 Jun 2023 08:50:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: yunchuan <yunchuan@nfschina.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
	quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] net: mdio: Remove unnecessary (void*)
 conversions
Message-ID: <3fda1d81-e350-42e9-8fec-6f107ae75932@kadam.mountain>
References: <ZJwCcWgi0d6kEepI@shell.armlinux.org.uk>
 <325f00e3-1dfd-f77b-9795-6f89e44c0417@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325f00e3-1dfd-f77b-9795-6f89e44c0417@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 09:59:56AM +0800, yunchuan wrote:
> On 2023/6/28 17:50, Russell King (Oracle) wrote:
> > On Wed, Jun 28, 2023 at 10:45:17AM +0800, wuych wrote:
> > > @@ -211,7 +211,7 @@ static void xgene_enet_wr_mdio_csr(void __iomem *base_addr,
> > >   static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
> > >   				int reg, u16 data)
> > >   {
> > > -	void __iomem *addr = (void __iomem *)bus->priv;
> > > +	void __iomem *addr = bus->priv;
> > >   	int timeout = 100;
> > >   	u32 status, val;
> > > @@ -234,7 +234,7 @@ static int xgene_xfi_mdio_write(struct mii_bus *bus, int phy_id,
> > >   static int xgene_xfi_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> > >   {
> > > -	void __iomem *addr = (void __iomem *)bus->priv;
> > > +	void __iomem *addr = bus->priv;
> > >   	u32 data, status, val;
> > >   	int timeout = 100;
> > These probably cause Sparse to warn whether or not the cast is there.
> 
> Hi, Russell King,
> 
> I didn't notice this Sparse warning.
> Should I remove this cast although it cause Sparse warning?

No.  Don't introduce new Sparse warnings.

regards,
dan carpenter


