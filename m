Return-Path: <netdev+bounces-40175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D928E7C60DC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12D61C20990
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6382231E;
	Wed, 11 Oct 2023 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XpNHneBP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341B249FE
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:10:24 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D9AF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:10:22 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4194d89a6dfso2555681cf.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697065822; x=1697670622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pE4C1PjtBwHfwQnQ/BWQr6OrTGyHylYmZgGyzqVL5/U=;
        b=XpNHneBPrWUvofoEizNZP5HzzkxU8yrUIF5sl8cT5G4aG1Xkz2P0UFrCMgc9bJ4nkG
         bdsQYfFwU58uIjlunSvwTAgF2ioZ5AShGdrxfo6Jucnsu+109NrrkLvNdtEq1wuMLFF/
         hwGYLJO7swgyeEgJzvnScORJWDbPq3vrP6481X/nRK1Hz5pxAz0dmtYyBvYO8qTKyofZ
         urG+miT8HC/sRHNpGRGV3vCxudRWHOsE1j0NTO4lRXE+9PpoYKfiOGxaj1mEZrkqK6Ku
         d0MczA8VO9WOpMSpa+ES97K8sk1B3r21AHqx3f9bKgvQh5eqN4BYhgMgAavAefuoL1Uj
         x+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065822; x=1697670622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE4C1PjtBwHfwQnQ/BWQr6OrTGyHylYmZgGyzqVL5/U=;
        b=wds9hkmAOSx1OQC/UMs8B8Ek95j+cm6DxuwuYe/A88nrzUk98my1A+gP+0JNaiwGOK
         XLDICFsPpnE1y2RY86gAYRmK0iyH/v5uVEf2id3VdDwBxwmjlRy6628j145ejINn3KAk
         8iQCOXPCLsF02Fb1w6VzoLC6Za75p/5Czf5Dh6ZDZ99Ui5CixrCM6otrrjqWWP2dFn8r
         rIxPSPpS5PlalhhbMbG7c9kLfCCMbpcGzCWqXfJkNCt7/jMiYbi4vx7tNK6aX+5F3go1
         P+g7gPRPzwblvNN3Y8VMi+qMzBLd70UkSl0/z5MRs9DiQARWmpbAK49eGj1LvXT0l6R/
         OwKw==
X-Gm-Message-State: AOJu0YzJd4VVIG53nGXI0mEEdLPIyShFncBsXiTfQggtXJ2fC9WOdOuj
	uVZjgPOAD/sTFJVs5BZMlmNlNQ==
X-Google-Smtp-Source: AGHT+IEsBh106ERG5fcZutotax71+to9I7W4F2Eq39+fQZfREWil8ZfLKHw8e5yzZK96gO3ySOZs3g==
X-Received: by 2002:ac8:5d8f:0:b0:410:60a4:ffbc with SMTP id d15-20020ac85d8f000000b0041060a4ffbcmr26726688qtx.66.1697065821813;
        Wed, 11 Oct 2023 16:10:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id l17-20020ac81491000000b004181d77e08fsm5699199qtj.85.2023.10.11.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:10:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qqiLM-0014Y3-H6;
	Wed, 11 Oct 2023 20:10:20 -0300
Date: Wed, 11 Oct 2023 20:10:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <20231011231020.GG55194@ziepe.ca>
References: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
 <20230928175959.GU1642130@unreal>
 <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
 <20230929103117.GB1296942@unreal>
 <ZSbtMO8AWLx29RBS@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbtMO8AWLx29RBS@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 11:45:04AM -0700, Saeed Mahameed wrote:
> > > The above works too. Maybe for consistency within probe_one() it would
> > > then make sense to also rename set_dma_caps() to mlx5_dma_init()?
> > 
> > Sounds great, thanks
> > 
> > BTW, I was informed offlist that Saeed also has fix to this issue,
> > but I don't know if he wants to progress with that fix as it has wrong
> > RCA in commit message and as an outcome of that much complex solution,
> > which is not necessary.
> > 
> > So I would be happy to see your patch with mlx5_dma_init().
> > 
> > Thanks
> > 
> 
> Actually I prefer the internal patch, it moves the dma parts out of
> mlx5_cmd_init() into mlx5_cmd_enable() which happens after dma caps are
> set. since it is using the current mlx5 function structure and breakdown, I
> prefer it over adding new function to the driver.
> 
> I will share the patch, I will let Niklas test it and approve it before
> submission.

Let's hurry please, mlx5 will be broken on S390 in rc1 if this is not
fixed soon.

Jason

