Return-Path: <netdev+bounces-38475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FB7BB1BC
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6EC28207D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 06:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CD05399;
	Fri,  6 Oct 2023 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p57BjTEB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8035382
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 06:49:19 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B3F9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:49:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3248e90f032so1742074f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574957; x=1697179757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKyYQbXkv0DN4EBuZMI04wTrChTBXwJCOcKCksVCFqk=;
        b=p57BjTEBzhJ9I+OcTZ9dAsLW0ToPT8QKKyb4qupfxIctDC5MaezZIVTCeaKfRyD28k
         V/mCYDrtqEuzDfS6P2xsOez1D2u6ASLBREWF42z9t1ukEey5hEHcuJtXjQMH/k0MZtrr
         WhS6bx7sKgeSwvWg6hgp5QRNQOrKw1hakLm107LR96E6pftrS6LnHArlWt3yPyd5K5C+
         crOtvuzABGZIDGjh+988+RmFS9jk6ozGAUyRRLuZ/Zh0qu2or3H/XPymQjqhlmsrgNGM
         eHqKUw/yW31ymBPgb7an6MY6n3PSGRMnEcpYHogashClIboJ4GSykVGHRftvcsC7t6nY
         Lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574957; x=1697179757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKyYQbXkv0DN4EBuZMI04wTrChTBXwJCOcKCksVCFqk=;
        b=NmiFJSeAtx2GG3v7D8EhuYhP9gMWVGq2yjpKzp5CGr0wxLcBiwOpAeMJEBxg6d6nx5
         ouo+JiCXutXn5tEdxfTJGqbV10+pgVQ8zcVNsjEl23oxPRQrZ8DRPEAg0e0ueouLjwVW
         GhnKoJUuqOc/9qHWD5k7U2/GPX3KJJl7nxe+zk/giqqYOCTPI+UHDv2HjadNL5aHp4Nv
         IdFFaxnqk0Qq9/dLqqjYFD429b42qoQr0vYvxRKuDBC1vXpSoBRN/EEA+EvEtDfTg6P/
         ZcCHEwT1PCf+5BaRrr/AKYI284CfrBXRj0kUuAZYNpmX0gxT6WfLl/YQsBIu7h8Hn6/A
         hjfw==
X-Gm-Message-State: AOJu0YyMtbyeIhMTo0YUIlH8XHexbZfjquQjF0HjnSd5fNhf2cfA2ULL
	cVDmE9vhmCEe13IuqCY3Y7KPbQ==
X-Google-Smtp-Source: AGHT+IF2+kDKPp/gG06BUTDJC2DNcBwdzig6GHZZVXuDvKfDdbwG8DLu26BMKaY1cWPMGKa08l4QMQ==
X-Received: by 2002:adf:fcc8:0:b0:31f:e19e:a2c with SMTP id f8-20020adffcc8000000b0031fe19e0a2cmr6558632wrs.32.1696574956859;
        Thu, 05 Oct 2023 23:49:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q8-20020adff508000000b003200c918c81sm886963wro.112.2023.10.05.23.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:49:16 -0700 (PDT)
Date: Fri, 6 Oct 2023 09:49:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <869f4059-1fce-49e3-9edf-8bfa42aba4a6@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
 <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b78b29f-2a84-487c-a43b-f8d3fa20d935@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 09:42:41AM +0300, Dan Carpenter wrote:
> On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> > Avoid read overflows and other misbehavior due to missing termination.
> > 
> 
> There aren't any read overflows in the current code.
> 

So when you're reviewing these to look for read overflows, a string
literal isn't going to overflow.  So that makes the last two obvious.
But for the first one you have to review the caller qlge_gen_reg_dump()
and the last parameter passed to qlge_build_coredump_seg_header() is
always a string literal so that's obvious too.

It's not really that much work to check for this.

regards,
dan carpenter


