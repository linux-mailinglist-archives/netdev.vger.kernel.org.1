Return-Path: <netdev+bounces-40093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B87C5B2E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B781C20FF1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED322328;
	Wed, 11 Oct 2023 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9RyY747"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24182231A
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:22:11 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13766A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:22:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso260117a91.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048525; x=1697653325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hN3Y1Gx/7diunP62IVxUnXD4EF9Jlv9k/rCp+joDrQ=;
        b=F9RyY747R5dYuBkwljHEsFwQkmwBZiMM2mdVT6v9XV5DA5X/6cFZlufymsMrdpeI+d
         9nlQDwtpEQz4lgpP0o4sH/jV3ZMRw3UmUJ732HfH/XSBPPl2WtfpbY9BrDq+ScZWysiz
         FMsGEGKWYUOEL4tlXfWN+K3sIKBx6XmYJaLJfrgKJD3KFNbS0yc+nh7Xk3GMjjlqXBqE
         FMD245YiNTdsDPeiBKfq2UTZQJEvMyw5wg0Eyfp9w3VzfWyeuBuM/cWvdi2ZqV+BGj6J
         qcnL0fRaHS6yKpAyc48PgcHLiOgvlUvhTtjpXoMw3BcMXzGeFqJ0W9MNfTOLWIQnu6YL
         zTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048525; x=1697653325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hN3Y1Gx/7diunP62IVxUnXD4EF9Jlv9k/rCp+joDrQ=;
        b=avqGpwoC+xcADoJk8p3oeUoUKiLnMrLkxcRH6AZyAAhNXmz3+3hEgBGMcpPKsm6aZN
         g7OFwl2SXQweVPLm0bFLJx3u0pqOXREWTflQgTzO0GiRQQ0n5fHifXzpa3kqtktceZiY
         nmPhE52oUcpPy6XVqAAddlnzL8tXUjCHRTGqpLCBX9tUQQAWz1ou38KqFLBxAbXWNbhm
         fcanfgNsybtlXQCx/fgbzl7HPOZjR0W7VvkUa1YNiKxLh3vWXMsiFc5pfH1uQhYvdGTa
         peaLM3SVwV6orVIdys81/lV6kceQoRLeemxWoYwaisSMrrIvTHkvD2HHTmlBMndEOkSX
         QqVA==
X-Gm-Message-State: AOJu0Ywpkh3ityVGEfsxCgj8tuBzer3Cza6EbrOiSzp+f78V5Lehzkgi
	P7V5nFwtIx25HR75NyS1tZo=
X-Google-Smtp-Source: AGHT+IE5i9kcTlfZR2H5tYKcfbjlJT+Ckal6PZYpU1eGohJyt0+C8lji4HPCyFEuAw/5DTaKt+dj2g==
X-Received: by 2002:a17:90a:348b:b0:27d:c5b:747c with SMTP id p11-20020a17090a348b00b0027d0c5b747cmr2765992pjb.2.1697048525371;
        Wed, 11 Oct 2023 11:22:05 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:298e:308c:8339:ebb8? ([2001:df0:0:200c:298e:308c:8339:ebb8])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00692acfc4b3csm10246601pfd.136.2023.10.11.11.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:22:04 -0700 (PDT)
Message-ID: <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
Date: Thu, 12 Oct 2023 07:21:52 +1300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Content-Language: en-US
To: Greg Ungerer <gerg@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
 netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
References: <20231009074121.219686-1-hch@lst.de>
 <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
 <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
 <20231011055213.GA1131@lst.de>
 <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <cff2d9f0-4719-4b88-8ed5-68c8093bcebf@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Greg,

On 12/10/23 02:09, Greg Ungerer wrote:
>
> I think this needs to be CONFIG_COLDFIRE is set and none of 
> CONFIG_HAVE_CACHE_CB or
> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.
>
>
>
>> in the fec driver do the alloc_noncoherent and global cache flush
>> hack if:
>>
>> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
>
> And then this becomes:
>
> CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || 
> CONFIG_CACHE_BOTH)

You appear to have dropped a '!' there ...

Cheers,

     Michael




