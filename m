Return-Path: <netdev+bounces-30276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39135786B26
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9751C20DA5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6DBD505;
	Thu, 24 Aug 2023 09:08:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5ACD2FF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:08:59 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D171986
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:08:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4018af103bcso1834025e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692868137; x=1693472937;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUc/Cv2OkEiyYX7xCFXe4Ptk+hBJ2RXc4IETa+Q50dg=;
        b=pEbJEY80FTZoAeDlwLjdzWmLlmuYCe9LdBh+AGJitV3DFrsbA64sunckOutgY8eBMW
         /g6B+Bqk/9xC7Wniey7/udc/662XBUbJcVhQWMCVvpcLzo/6if8WMpS/G6jgsNh3pyI/
         fwgbDrBEbvBY1N8TqHyQLk/yomzJAE82dxHyeGWYs0Gvf1ruO5hSHjCsHYSfZXHMIn+T
         qwf+6EmI654PJYyKSZam55EC6AGOwJREizL2ZgKkYB5CD7AMkAy5qjk4Hlx9rgZieyc8
         IIPL++fxJDDDC4Fa0uEQ5G7i9uN0EhU5w86Pxay3Ua5OpcNE2A2KNCsY1hFum+W9urJB
         UC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692868137; x=1693472937;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUc/Cv2OkEiyYX7xCFXe4Ptk+hBJ2RXc4IETa+Q50dg=;
        b=LcMLytJBUX91P327miEOeQ4sLBHccchnHaLADP596NvBvfGaCIT51dDwXsojHDMdMx
         EDSglpIdP84LgYKZFZXjJIrqGyi6xFRCme7rYVZQw4nvq2gLCBo1Cs9Jl7f/cJ2bqHEW
         Q/MFpVwGoWmekMztJCWGC3VqGMCFk9tHLxpKFx+2LzDKseqkH+O594Kr1fuJ4MAfkC8M
         2SmhB8kiUJ+PlWr8euos24tz9ZYM3/LeujG+jzMGrvIKOtfSk8vrMVIap8d5NHh79n3i
         moc2UCx6FdQRminkb2ea65uZSV6kRaHoJCeknLyL5il0J6+w6Tw1SoIxzEPKyFe08N+I
         pieg==
X-Gm-Message-State: AOJu0Yz7H34OpyrisSmUqzZnEaV62T59RxjSrEBZtHRk6UBp5A+aMSBD
	hqFQFYG0llW8bXwZU0GEw0Q=
X-Google-Smtp-Source: AGHT+IEQlT2xVR5bRcIMneJtEoRBPZbY7L+MpDtOZOGZUlpFHV1+vx61NaQjC0h6vu1EaBICwjHzvw==
X-Received: by 2002:a7b:c8d0:0:b0:3f6:d90:3db with SMTP id f16-20020a7bc8d0000000b003f60d9003dbmr12196390wml.3.1692868136701;
        Thu, 24 Aug 2023 02:08:56 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id l5-20020a1ced05000000b003fc01495383sm2032373wmh.6.2023.08.24.02.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 02:08:56 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:08:54 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] docs: netdev: recommend against --in-reply-to
Message-ID: <20230824090854.GA464302@gmail.com>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20230823154922.1162644-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823154922.1162644-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 08:49:22AM -0700, Jakub Kicinski wrote:
> It's somewhat unfortunate but with (my?) the current tooling
> if people post new versions of a set in reply to an old version
> managing the review queue gets difficult. So recommend against it.

Is this something NIPA could catch?

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  Documentation/process/maintainer-netdev.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 2ab843cde830..c1c732e9748b 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -167,6 +167,8 @@ Asking the maintainer for status updates on your
>  patch is a good way to ensure your patch is ignored or pushed to the
>  bottom of the priority list.
>  
> +.. _Changes requested:
> +
>  Changes requested
>  ~~~~~~~~~~~~~~~~~
>  
> @@ -359,6 +361,10 @@ Make sure you address all the feedback in your new posting. Do not post a new
>  version of the code if the discussion about the previous version is still
>  ongoing, unless directly instructed by a reviewer.
>  
> +The new version of patches should be posted as a separate thread,
> +not as a reply to the previous posting. Change log should include a link
> +to the previous posting (see :ref:`Changes requested`).
> +
>  Testing
>  -------
>  
> -- 
> 2.41.0
> 

