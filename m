Return-Path: <netdev+bounces-35045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321567A6A3D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDD3281B6F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033B347C8;
	Tue, 19 Sep 2023 17:53:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F7F509
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 17:53:25 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB795
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:53:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso13477366b.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146002; x=1695750802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SobCRVBWBiZshOjl92hEWU1P6I6lrGt/lK1MY9eemKI=;
        b=ayrT3U8tqKtOkX5d4/up82P0jRYoq3kXvugbG0vY5Mt7/37sHU1JZwqM4710ie7EzD
         9iZXuu48II6Y/NKVL5VTLwbRl4rxzBzEU4gpCySjbPr5uDLNIKwMSmnzKOUb03BvIgZx
         RRDfWuiAr5xN30HnL/b4cZRRKFkI2zLZdy5373QOYCcWkB0YeTD3SSwQOzx1IT6k35tT
         7zqUHsDP3R7OkIVa8UdX1dBygKcTBCZe6R/cEIrNmhgwa++tNuiQaIF3Pp2L8mmsy4ON
         5NdY9ATDGqBMEy2xH9izmwxzZPqIcErOOJ8+Il4iuOXc69KPZdcD4mCjk/0z88q4aofZ
         aRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146002; x=1695750802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SobCRVBWBiZshOjl92hEWU1P6I6lrGt/lK1MY9eemKI=;
        b=NSBB9gRZYB4WInU/CPx9TP6ooSzx6P9f6Pq7b4K5ZrUp7hmwUbHWOr83nUbh0qqEe6
         025H0sSPLOCFjdFa7qoaDSJbkKLwg/rFVDs+JAsE4fzBvpBow618KlBWZ+9ispCNqbHQ
         R54bi1niofxLMACE8ZsephCAFbknGtHwClVDafRK3lnQaPtoSRwlRUWx602ta4B6c1R4
         03aDgUVYwuig7tum+hFSXOccGyEZtveW/znrxwKOkG02PAMZFnGnMAqBuHVuBKLP626+
         yHtgfHFiz4XkpFa44LSBgZo8xJVGsCkgeuusWQEfPUuxRYU4/XasG31ZOh8GGCEULb+2
         2Cuw==
X-Gm-Message-State: AOJu0YzHZ761NXRu6Yh14ffC+nQHZrI6wS+eBJEkDWdA8kWY7IMd92oF
	3VxXrLTiER6KVIK/6eBsz5U=
X-Google-Smtp-Source: AGHT+IEfiX3n8F6lt99inntbSKcXtT57fwdREuW/iQxvaaB2mGsrm0Y/uG05AHOBUSIXhvDM3rXZjQ==
X-Received: by 2002:a17:907:97cb:b0:9aa:f7f:e276 with SMTP id js11-20020a17090797cb00b009aa0f7fe276mr4612478ejc.38.1695146002278;
        Tue, 19 Sep 2023 10:53:22 -0700 (PDT)
Received: from localhost (tor-exit-13.zbau.f3netze.de. [185.220.100.240])
        by smtp.gmail.com with ESMTPSA id l27-20020a1709060e1b00b00985ed2f1584sm8050520eji.187.2023.09.19.10.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:53:21 -0700 (PDT)
Date: Tue, 19 Sep 2023 20:53:20 +0300
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"nbd@nbd.name" <nbd@nbd.name>,
	"alexandre.torgue@st.com" <alexandre.torgue@st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>,
	kernel <kernel@axis.com>,
	"peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Message-ID: <ZQngEIh5Y9S1LzMw@mail.gmail.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
 <ZO-E2_A-UrC9127S@mail.gmail.com>
 <1b485fa168f2862adf3f0967a04a7f0e1a99ffe3.camel@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b485fa168f2862adf3f0967a04a7f0e1a99ffe3.camel@axis.com>
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sep 2023 at 12:56:31 +0000, Vincent Whitchurch wrote:
> On Wed, 2023-08-30 at 21:05 +0300, Maxim Mikityanskiy wrote:
> > On Wed, 30 Aug 2023 at 14:55:37 +0000, Vincent Whitchurch wrote:
> > > Any test results with this patch on the hardware with the performance
> > > problems would be appreciated.
> > 
> > TL/DR: it's definitely better than without the patch, but still worse
> > than fully reverting hrtimer [1].
> 
> Thank you for testing this.
> 
> Have you also had the chance to try out Felix's suggestion of completely
> disabling coalescing in the driver?  For that you will need to apply the
> patch at [0] (the command below may appear to work without the patch but
> the timer will continue to be programmed and expire immediately if the
> patch is not applied) and then run something like:
> 
>   ethtool -C eth0 tx-frame 1 tx-usecs 0

It's really good, yet not as perfect as reverting the hrtimer patch.
Aggregated summary over 15 20-second iperf3 tests (with XPS, RPS and
flow tables):

        | avg up | avg dn | std up | std dn
--------|--------|--------|--------|--------
Revert  |   931  |   939  |     6  |     2
No-coal |   925  |   916  |    13  |    26

I'd say it's almost as good as the full revert, but with more deviation,
numbers are less stable.

Kind of off topic, but I've also been testing PPPoE, and it's pretty bad
even with the available fixes:

        | avg up | avg dn | std up | std dn
--------|--------|--------|--------|--------
Revert  |   791  |   388  |    13  |    26
No-coal |   806  |   390  |    97  |    60

Thanks,
Max

> 
> [0] https://lore.kernel.org/all/20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com/
> 
> With coalescing disabled in the driver, there is also the option of
> playing with the generic software IRQ coalescing options available in
> NAPI in newer kernels (eg. gro_flush_timeout), which may work better for
> you than the one in the driver.

