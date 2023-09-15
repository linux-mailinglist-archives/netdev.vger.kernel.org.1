Return-Path: <netdev+bounces-34008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F87A1654
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 08:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7BF1C209C1
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23811613D;
	Fri, 15 Sep 2023 06:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C32591
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:45:35 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407326B8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 23:45:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c65820134so1543112f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694760331; x=1695365131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iid8k6i/7ugCP4LiXGAP3iTfZTR6oaJGyaJr18W15M=;
        b=WplxrfYqiyDMLZnf4oX7fZ3fZzfBoLKt30zp59n8Lx+0HOi2R8ijtlXsjv47SIKYlD
         HRbOEJ+PQK8WbR2AlsEIhXk3qjAlQZbZ1/vQBCj++QatQiHZMo4T4uZsNtLCOAs6EFSo
         xkzPjfhZHVNM23mR0r8HmFZbwrvjeNFyvXnIkG6g1g46NhGVgB8ox5dZCZSYt9gtxx1l
         SPtWwZK2T0PrwZTMoy904j9Ig12K9OFth2JShV2utcjhuovXG/Z9GLGondC237x7YJOP
         AhhzrSMoNuT/6xRfVee6vP+6D/yvFPMfe9Ytz7EWqUKlcZ9lMEp4KeOl/OL/74aQo3fP
         v2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694760331; x=1695365131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iid8k6i/7ugCP4LiXGAP3iTfZTR6oaJGyaJr18W15M=;
        b=aQP1YoMwmH5G5bYDo4ixwHbrTUmEV67G2Bjg188mhi3ZVk4hhOS1ZRXJ5UPKq2s+ct
         KOe9Ht1o5uWp2mL3rdAy/C2jp+C+eAnQnlYmQCVvv3MCZv+4TljCrygfV32XfyEfJ8X5
         rbzMF/aWNdRFsbVIkNms5Tp6NfN2h8PEbfpNzPHxGzkx8BEnv3GGuSJ8zSyy9XpPO+Dc
         OyMCjmzF1pRo/hSyX1yqLBBjfWNo7Sdc+TLDanEHa4JTgVLnVFOqXTrkokE/ZOuBOFd6
         D/pWpr2+96/i96Oat9iLBHte79FC3jZgRazkt27CwQuAAPzspOSPjON8OIBUflOxnVHA
         sB+g==
X-Gm-Message-State: AOJu0YxD/ys/8U8JoccG9ypMeuN8IiWaPYyXydT6gghx6cSn+F7h4z+O
	vDFXtQX7EzLbA5oKZWoxr7XiUg==
X-Google-Smtp-Source: AGHT+IE8Thgq+Szgaiwj/ucohZyW9eDpZBH7Q1t53swPZGciT9VZ3dn2zP3CW2L86IyMPCp+kCVKWQ==
X-Received: by 2002:a5d:67cf:0:b0:31f:a62d:264 with SMTP id n15-20020a5d67cf000000b0031fa62d0264mr583580wrw.37.1694760330972;
        Thu, 14 Sep 2023 23:45:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003fe17901fcdsm6630449wmf.32.2023.09.14.23.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:45:30 -0700 (PDT)
Date: Fri, 15 Sep 2023 09:45:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	dmaengine@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] dmaengine: ti: k3-udma-glue: fix
 k3_udma_glue_tx_get_irq() error checking
Message-ID: <62125aa6-e279-474c-a0d5-c63d226c6c40@kadam.mountain>
References: <5b29881f-a11a-4230-a044-a60871d3d38c@kili.mountain>
 <20230915063324.GC758782@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915063324.GC758782@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 08:33:24AM +0200, Simon Horman wrote:
> On Wed, Sep 13, 2023 at 02:05:31PM +0300, Dan Carpenter wrote:
> > The problem is that xudma_pktdma_tflow_get_irq() returns zero on error
> > and k3_ringacc_get_ring_irq_num() returns negatives.  This complicates
> > the error handling.  Change it to always return negative errors.
> > 
> > Both callers have other bugs as well.  The am65_cpsw_nuss_init_tx_chns()
> > function doesn't preserve the error code but instead returns success.
> > In prueth_init_tx_chns() there is a signedness bug since "tx_chn->irq"
> > is unsigned so negative errors are not handled correctly.
> 
> Hi Dan,
> 
> I understand that the problems are related, but there are several of them.
> Could they be handled in separate patches (applied in a specific order) ?
> I suspect this would aid backporting, and, moreover, I think it is nice
> to try to work on a one-fix-per-patch basis.
> 
> The above notwithstanding, I do agree with the correctness of your changes.
> 

Sure.  Let me write it like:

patch 1: fix first caller
patch 2: fix second caller
patch 3: re-write both callers to cleaner API

And we can push everything to net because it's nice to have one version
of the API instead of a version for net and a different version in
net-next.  Or we could apply patch 3 to only net-next.

regards,
dan carpenter


