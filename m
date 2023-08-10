Return-Path: <netdev+bounces-26449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87438777D80
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475FD1C21613
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061220CBF;
	Thu, 10 Aug 2023 16:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552641E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:07:37 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512C3583
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:07:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbc64f9a91so9669345ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691683619; x=1692288419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bkl7A8nIZ4dLxOcY6GpHpFtX+viPmkaZX3wq6XxPfxg=;
        b=JL9PB5YetmewwFt4dDybaPdzwmRNljhoEiaIvSyobmvxBnbUSrib0/OLZrInyO+/1c
         WxEb27kvGab0U19ny3qjovhvp4KPMhmrM2Jqtl/Sybe5g/zIKFpOOF62rMgIkHHf4UbB
         VKhhEHQLs4ges87nYRT9ch0zp7xExv1gT874o21HXlD6fq1w4HfWb5w6aIB4k6n17BS6
         sHwCkyxjqIF/8NI5kQBcfC3SRO7xYSESm9CyKct1e2y0kTPD1OEFcZVOieF6bi0mgKVN
         nkDDYLgPl8A0tzyRQn+5DPmETmTTMEvWVvuuyb3zFt2rluHyUxJ0uPc6WGGARgxW4JyZ
         JPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683619; x=1692288419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkl7A8nIZ4dLxOcY6GpHpFtX+viPmkaZX3wq6XxPfxg=;
        b=ISxAAmyGzqpft80ZRltDljmo3YUxqO4/vpbFA6sjFakjpEn+EKm8ImuHbh7T6L5TG9
         OhDr4F6RZ9B8PVpYabB4wwPbV2xtVvT3WKqqPZ9Cds4+TcsX8TYHMZnTWfpxMUGJkmLO
         2JCiTwTLuthkIjRObgozsweikNCda0WpYW+cv+398Ph15afBa8egFZiIS3Q5u+BFsv+w
         UQr79NZFIHJFjj7FcpN/iQi0FNERRVZS7AAh7ssXoYQLj65Mhu7t4eecASFwwMVBHCFc
         0Fd4UQqF6fq0XaLRUnu6e01MJMhgdMN2Nz4297ConKnkTrjJMZLDyYQKSt/uSZ3PtDwP
         w5xQ==
X-Gm-Message-State: AOJu0Yw8ekB5c+7mc6R6HuZ7mzrFEnDBmqW3lCtUkXItT1cYwmoLL5yk
	9vdJPUVki6FSdlVu832/0GaqPA==
X-Google-Smtp-Source: AGHT+IF4hyqWBe3EdaSGly2P8UCzQ7nDhJe1xj0NdzWbJpW3WsvHw4tGYB8oXfKwdLOgDTGQE6RMzw==
X-Received: by 2002:a17:903:182:b0:1bb:ed65:5e0d with SMTP id z2-20020a170903018200b001bbed655e0dmr3656999plg.56.1691683619216;
        Thu, 10 Aug 2023 09:06:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b001b8a1a25e6asm1955107plx.128.2023.08.10.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:06:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qU8Bc-005Glp-95;
	Thu, 10 Aug 2023 13:06:56 -0300
Date: Thu, 10 Aug 2023 13:06:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Hari Ramakrishnan <rharix@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org,
	sdf@google.com
Subject: Re: [RFC PATCH v2 00/11] Device Memory TCP
Message-ID: <ZNULIDzuVVyfyMq2@ziepe.ca>
References: <20230810015751.3297321-1-almasrymina@google.com>
 <1009bd5b-d577-ca7b-8eff-192ee89ad67d@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1009bd5b-d577-ca7b-8eff-192ee89ad67d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 12:29:08PM +0200, Christian König wrote:
> Am 10.08.23 um 03:57 schrieb Mina Almasry:
> > Changes in RFC v2:
> > ------------------
> > 
> > The sticking point in RFC v1[1] was the dma-buf pages approach we used to
> > deliver the device memory to the TCP stack. RFC v2 is a proof-of-concept
> > that attempts to resolve this by implementing scatterlist support in the
> > networking stack, such that we can import the dma-buf scatterlist
> > directly.
> 
> Impressive work, I didn't thought that this would be possible that "easily".
> 
> Please note that we have considered replacing scatterlists with simple
> arrays of DMA-addresses in the DMA-buf framework to avoid people trying to
> access the struct page inside the scatterlist.
> 
> It might be a good idea to push for that first before this here is finally
> implemented.
> 
> GPU drivers already convert the scatterlist used to arrays of DMA-addresses
> as soon as they get them. This leaves RDMA and V4L as the other two main
> users which would need to be converted.

Oh that would be a nightmare for RDMA.

We need a standard based way to have scalable lists of DMA addresses :(

> > 2. Netlink API (Patch 1 & 2).
> 
> How does netlink manage the lifetime of objects?

And access control..

Jason

