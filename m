Return-Path: <netdev+bounces-40673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F17C845F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 13:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F06A1C20F88
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA913ADD;
	Fri, 13 Oct 2023 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KSeigh4h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D913AD6
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 11:28:08 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F49B7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:28:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b9a494cc59so305935566b.3
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697196484; x=1697801284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cnMw53+R47+MFib4YB36nR2q3eoIS+UUIxGL66EDm0=;
        b=KSeigh4huxGOVvgKqThI/z0jBmGos4wZ4HUh2xquYMaCj7bzRkeX2GZrt2cPWybzqv
         GlxGYXs4lEuodNzwHiSbYU1ZBINOcK0HjdkL+fh2ZY5PUm1nkUWQAmwQhhTzl/G5zFCw
         yxFfvxWWfpKG5hLz7RvNky/xNQtlO0N1BIjuLYisaU7tmcxQ2scVn/IrwcCT+VGEOPQ/
         Y9F6XR0CRtx9NWyPovr+O/8N/tLi7I8GoRAUO23pQ/Yp/mM1Eko9NJKfeZdkye27YuNA
         T43zNSPSNBBZd9oydHMwVGD8xDdaXMIgWWAR3GGTUH8i7pSeu5QufzVnbvYfBC1Uvu+E
         Y78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697196484; x=1697801284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cnMw53+R47+MFib4YB36nR2q3eoIS+UUIxGL66EDm0=;
        b=QyJKLFpuiMtrfYd7Q5ojoZBk1zFn0+T59cxEg7hYBG0lPO1h+kQDRja3u0mFgQsGY2
         BW6bgeEyGUdl12F9rUHEHgUlyxhfb/miRfN+prDvh369L0/VIZXbM8HBtuy1kwK0j96M
         YRcGoiNm69RuAfutK6j3drEdVCn1Ffaa3tH6LxmbtYwDiHFuUfUHaxR9b93MACpZdyXI
         a9SvjDT4/UMFT34RR1VCqM3+yF0swJpe4mr3Z1jDPDONCFZlDsRfpSigg8LVpKk8Eeks
         /pNk2gJ7LSTZz3VkWnO5Z5hd8TIZ0OGb8vI0ohsoPjVcv060Vq36zXwsUF6+5XYKdht2
         B9rA==
X-Gm-Message-State: AOJu0YymtzDR1DOjSmKitQP/BVXMvSya/cqj5xhjYDIOzmmD6PXbfF2l
	qk89Se8GLWkrZyDPPbstr8FTHg==
X-Google-Smtp-Source: AGHT+IHkskFgOYDfIrfH9HExdl1LoghSxriG0P6FhrNfNjYQ8e9kxcoswcqoBEESrbiOty9NwflvJw==
X-Received: by 2002:a17:906:259:b0:9ad:c763:c3fd with SMTP id 25-20020a170906025900b009adc763c3fdmr23585879ejl.28.1697196483672;
        Fri, 13 Oct 2023 04:28:03 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0098d2d219649sm12453383ejq.174.2023.10.13.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:28:03 -0700 (PDT)
Date: Fri, 13 Oct 2023 13:28:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netlink: clean up after deprecating
 version
Message-ID: <ZSkpwRJfk4NDmdMd@nanopsycho>
References: <20231012154315.587383-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012154315.587383-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 12, 2023 at 05:43:15PM CEST, kuba@kernel.org wrote:
>Jiri moved version to legacy specs in commit 0f07415ebb78 ("netlink:
>specs: don't allow version to be specified for genetlink").
>Update the documentation.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
> .../userspace-api/netlink/genetlink-legacy.rst     | 14 ++++++++++++++
> Documentation/userspace-api/netlink/specs.rst      |  5 -----
> 2 files changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
>index 40b82ad5d54a..11710086aba0 100644
>--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
>+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
>@@ -11,6 +11,20 @@ the ``genetlink-legacy`` protocol level.
> Specification
> =============
> 
>+Gobals
>+------
>+
>+Attributes listed directly at the root level of the spec file.
>+
>+version
>+~~~~~~~
>+
>+Generic Netlink family version, default is 1.
>+
>+``version`` has historically been used to introduce family changes
>+which may break backwards compatibility. Since breaking changes
>+are generally not allowed ``version`` is very rarely used.

"should never be used" perhaps?


>+
> Attribute type nests
> --------------------
> 
>diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
>index cc4e2430997e..40dd7442d2c3 100644
>--- a/Documentation/userspace-api/netlink/specs.rst
>+++ b/Documentation/userspace-api/netlink/specs.rst
>@@ -86,11 +86,6 @@ name
> Name of the family. Name identifies the family in a unique way, since
> the Family IDs are allocated dynamically.
> 
>-version
>-~~~~~~~
>-
>-Generic Netlink family version, default is 1.
>-
> protocol
> ~~~~~~~~
> 
>-- 
>2.41.0
>

