Return-Path: <netdev+bounces-21397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3697637E6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4781C2120C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093A12B9C;
	Wed, 26 Jul 2023 13:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32517BA4F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:45:10 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0110CB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:45:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso7370445e9.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690379107; x=1690983907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+jNakEFn9/qqjzKn7/L12W7ZVHM0REFXJJ2LBBHm/A=;
        b=BIS/JiSEFSOYQZGou5+nMQRArM5RskH/QvMHdJWTkiBXcXOAgNwvKiW/JV83QrMEWt
         A/UywcbKi62gmHWcnZI8pgLNHf8ZEf/H1/UenaQ3SolJTi//Jp3dIW7SPvqzX1Bx4h19
         6eYlVCGvvi/azEE9NUSQIip9rqwLXQBcU1z9LkIWrTUbLdSlzQB9G1EG6suUmGsdvrFq
         8cjyuUmt44NqpjlACadFHrSh0pKuMXpewpomiIgxp81qteeopDEmb11iJClq4PVJHtEP
         X49ViGDi8qE3Pdd99vhWgQxe4Cxh/ZC9n9OF+Drq0ax3SJYwsGiml/PgPxgjd1xSLgrH
         uLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379107; x=1690983907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+jNakEFn9/qqjzKn7/L12W7ZVHM0REFXJJ2LBBHm/A=;
        b=P3IdVfkLzrvuH03VwgTXM1YE68MssG3iw1nyVOWn1SlW4ECThch79CQevSJBFTrP0G
         TzfiDNHyQH9gLLYaMfbLLzuiWRAD+WRUr0x7mb+iyTe5T4494BgdrpdFXaeWefNR8PsW
         7J6rUr6Z3Ky6LcO0rsx3y2mT+PFI0gAGfrOLdHsD0GazX4GT1GnkaChPXRRlstbhZpBn
         53u5FBLGw7a58Bty87jjK+8sj3J6zh33GNDKN2tHGklRj6gQwcvUB7wxB3L7soL+AiZ5
         56czhe5M6meEAO4Fuj0rADTtOxyFuu4fkGHGbNAFa5i06YhDGo+Wlbp4xAFF90Efo32l
         RRUA==
X-Gm-Message-State: ABy/qLbJFEGdqTG4KjcLGCEFXoMUGtz8+Ap/wlHTdJHGQ0/W1h7BzmDa
	9R9rG/8BwHlIWmi2rO2CQw+vfQ==
X-Google-Smtp-Source: APBJJlEdRwll4HCrb/SrI25+SHD1gKHKIj224dpt2UqrDSHxNVeQQu//I0av4NRBnloADnXCvbdW3w==
X-Received: by 2002:a7b:c40f:0:b0:3fb:f0b2:20eb with SMTP id k15-20020a7bc40f000000b003fbf0b220ebmr2109232wmi.1.1690379106266;
        Wed, 26 Jul 2023 06:45:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003fc07e17d4esm2071792wme.2.2023.07.26.06.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:45:05 -0700 (PDT)
Date: Wed, 26 Jul 2023 16:45:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <simon.horman@corigine.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	dccp@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dccp: Allocate enough data in
 ccid_get_builtin_ccids()
Message-ID: <c962e03c-6091-483a-90f2-4db8afe5283a@kadam.mountain>
References: <35ed2523-49ee-4e2b-b50d-38508f74f93f@moroto.mountain>
 <ZMEX4VOYzz8IvRUQ@corigine.com>
 <ZMEY9aPRSpiy+qie@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEY9aPRSpiy+qie@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 03:00:37PM +0200, Simon Horman wrote:
> On Wed, Jul 26, 2023 at 02:56:01PM +0200, Simon Horman wrote:
> > On Wed, Jul 26, 2023 at 01:47:02PM +0300, Dan Carpenter wrote:
> > > This is allocating the ARRAY_SIZE() instead of the number of bytes.  The
> > > array size is 1 or 2 depending on the .config and it should allocate
> > > 8 or 16 bytes instead.
> > > 
> > > Fixes: ddebc973c56b ("dccp: Lockless integration of CCID congestion-control plugins")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> Sorry, I was a bit hasty there.
> 
> > > --- a/net/dccp/ccid.c
> > > +++ b/net/dccp/ccid.c
> > > @@ -48,7 +48,8 @@ bool ccid_support_check(u8 const *ccid_array, u8 array_len)
> > >   */
> > >  int ccid_get_builtin_ccids(u8 **ccid_array, u8 *array_len)
> > >  {
> > > -       *ccid_array = kmalloc(ARRAY_SIZE(ccids), gfp_any());
> > > +       *ccid_array = kmalloc_array(ARRAY_SIZE(ccids), sizeof(*ccid_array),
> > > +                                   gfp_any());
> 
> The type of *ccid_array is u8.
> But shouldn't this be something more like sizeof(struct ccid_operations)
> or sizeof(ccids[0]) ?

Aw crud.  Actually the code is fine isn't it.  I thought it was saving
pointers but actually it's saving char.  *Embarrassing*.

regards,
dan carpenter


