Return-Path: <netdev+bounces-59444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E081ADD7
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC20B23B44
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7D525F;
	Thu, 21 Dec 2023 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Ov0E6gZW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D6522D
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-593ea4c2baaso280775eaf.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 19:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131185; x=1703735985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh3RxW5iAy9BGkR7jZmXDcqgJQXO5QmKDLopR9Gg6oE=;
        b=Ov0E6gZW/RpLLvdojPkCNGOKG1iz/YZ+OuGc6IAup4ubg2tgTn3CtD/dOCH7MI9y5m
         N8cea2J0M9ksMjnzpxkEH+SpxjjchR3NBGqO0xOWbreavuD1UIrYEdSFBf9NVH8vhKNs
         V7B1abSS2hYzOZYpJO2j4A9NjE6mT8KRxHrZLmT4Wr/HFVaJZGSspWYM1c+43OCHEUFq
         1hNFbdklhbyDL/BCgxLvV/gVSIsoqrnlGMoPUwhokDeFINdUXLsGOcY8MJxMl3qnQhUz
         HBsf2lfayimnTk6uQyxUc2XbOSYLf9QxD9dkI09Vt39IziIsU/VP7LiJqdhfwgm0ybGS
         lzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131185; x=1703735985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nh3RxW5iAy9BGkR7jZmXDcqgJQXO5QmKDLopR9Gg6oE=;
        b=XnUZ6MhS9g979OxVuEVH76IyI12FCesr9+0WIHCrDZbs4/SDRtzUmq7ayb1i9QQx2q
         er9fBEOddP+IAyKJKZFyNnE3PKXcmnYIhKSBurx2N8LZAZQxunbuD6NXsuwSIJs1ZjLp
         xvG8yCpGLpwZGuXbvujjR863X5O2YaSlj6wy6NuvPdD/9Xy4howMdjgoNmL06ryeiake
         VIhXcvITexHNz9rIyCJ9hipbHrsdp5uRjs6nImyuwD8B+dubKPW6k22L3Q3rs6qZmDkc
         CfBIaHoPwaEd6oI5soerWrtxCRS64hxIvRgBR88Hi7o2CkuGdke6LMkUMI7QP5/OJqqe
         w9Uw==
X-Gm-Message-State: AOJu0Yxnl/1PR1hwX4n/cGqm7GRguyLVq/w116t9+4FrMnVQOGcN84r+
	urm2IK9Ity+nS70ZPrOEcGGJVg==
X-Google-Smtp-Source: AGHT+IFlHD/9UIbo8/8hhzrVMdRELhIomFfCJdBUCcAi+rf/WWul8XUALYN2fUKpz7lua1rBUfmN2w==
X-Received: by 2002:a05:6808:2028:b0:3b8:b063:5d6b with SMTP id q40-20020a056808202800b003b8b0635d6bmr24953542oiw.82.1703131184993;
        Wed, 20 Dec 2023 19:59:44 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006d9415b769csm523806pff.169.2023.12.20.19.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:59:44 -0800 (PST)
Date: Wed, 20 Dec 2023 19:59:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 04/20] bridge: vni: Report duplicate vni
 argument using duparg()
Message-ID: <20231220195943.381072b1@hermes.local>
In-Reply-To: <20231211140732.11475-5-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-5-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:16 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> When there is a duplicate 'vni' option, report the error using duparg()
> instead of the generic invarg().
> 
> Before:
> $ bridge vni add vni 100 vni 101 dev vxlan2
> Error: argument "101" is wrong: duplicate vni
> 
> After:
> $ ./bridge/bridge vni add vni 100 vni 101 dev vxlan2
> Error: duplicate "vni": "101" is the second value.
> 
> Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

