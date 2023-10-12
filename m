Return-Path: <netdev+bounces-40434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961C7C7693
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CF6282678
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517538DE6;
	Thu, 12 Oct 2023 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du3O6PWT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED938BD4
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:18:42 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857D5B7
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:18:41 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b635e3fd9so692378eaf.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697138321; x=1697743121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lly61ot32j8FoDDoJ6cWEByOKtkJuuXw1V179YkQ+qQ=;
        b=du3O6PWThPusSxdcUIm2H0Pbo1+I66NnP73BCgExsVUKYznH/9xm3GvV9jnmIYzckU
         TFO6nlpM4cN0GICCV4+IGdT7FJ/J7SRrjlurgWcE8Rjm8R+9Yz/n5AkQt0lJe5zBlWw3
         wdFS1lJCZ+Z/aFRqjiVkAi3qs4IObpiUCrHNVvDzjGHKFRPuLz4E3S6mPcvvckWf+YLq
         zqIlhM1Y1nCu3Ts0r7oIUAX7YVYP/MyQgUPR3xzaJmTWv30DIuLZz/F3d/OyRs4WZLUL
         VpMVO6hLep0neDjwdKH0ObcO4huIRBtBt5z7WLZSSJjr33XQxEL4Tofsb7kboiDbDkNX
         3sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138321; x=1697743121;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lly61ot32j8FoDDoJ6cWEByOKtkJuuXw1V179YkQ+qQ=;
        b=OhrfSaELzLw4+fWiWZHNcWkRSscL0kFC3UMLXGclB0E9S92QHrPDuXriKHlecuDy83
         PheWwZuJVI7Rf7UqIdebamJbfha5HlMhzjFKoGv7ebq1OPRBkKlE2HpUVI0NpwE/a94o
         iiMVILSBmOyNMdxskWD4igb5LoA3yAgk0RVkkaf0cN2WZV5bREVVQdJ9H/aUQVGrkJOu
         it3zv2N4dyD75yZVXaKMWmgotQs0P0XhqsPe/dMUvZyGOl+1/4nY0cg2lHHpLJt7AlcM
         BRo2H2pPD5x+yEAH0OQNA0LbQrgdRjs6LmGUYL4tenG58VOSU+c+QKUqjVrAuGVYp0c5
         GpgA==
X-Gm-Message-State: AOJu0Yzhx2J8A3RB7o2YtuU9X7G6tHsrLOoS2vF5wboxehBf09IZ5LzH
	FWVsnB6KR2jpgfbsGOqMFbs=
X-Google-Smtp-Source: AGHT+IFQ/8tRfh231wBImO6e9gycJ9gLPybhZL4tPQAP4HmrzWQeBUlcNv5nsoXTDJkx7CggGPiXrA==
X-Received: by 2002:a05:6358:998e:b0:13c:dd43:f741 with SMTP id j14-20020a056358998e00b0013cdd43f741mr17793249rwb.24.1697138320720;
        Thu, 12 Oct 2023 12:18:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:a953:6b0a:23f3:fb73? ([2001:df0:0:200c:a953:6b0a:23f3:fb73])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b0068c006dd5c1sm12133698pfn.115.2023.10.12.12.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 12:18:40 -0700 (PDT)
Message-ID: <2627cc80-f431-b47c-68aa-fc818785808f@gmail.com>
Date: Fri, 13 Oct 2023 08:18:32 +1300
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
 <12c7b0db-938c-9ca4-7861-dd703a83389a@gmail.com>
 <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <e16ac0a4-3e4a-4e8c-98ba-7b600a8c6768@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Greg,

On 13/10/23 02:25, Greg Ungerer wrote:
> Hi Michael,
>
> On 12/10/23 04:21, Michael Schmitz wrote:
>> Hi Greg,
>>
>> On 12/10/23 02:09, Greg Ungerer wrote:
>>>
>>> I think this needs to be CONFIG_COLDFIRE is set and none of 
>>> CONFIG_HAVE_CACHE_CB or
>>> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set.
>>>
>>>
>>>> in the fec driver do the alloc_noncoherent and global cache flush
>>>> hack if:
>>>>
>>>> COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)
>>>
>>> And then this becomes:
>>>
>>> CONFIG_COLDFIRE && (CONFIG_HAVE_CACHE_CB || CONFIG_CACHE_D || 
>>> CONFIG_CACHE_BOTH)
>>
>> You appear to have dropped a '!' there ...
>
> Not sure I follow. This is the opposite of the case above. The 
> noncoherent alloc
> and cache flush should be performed if ColdFire and any of 
> CONFIG_HAVE_CACHE_CB,
> CONFIG_CACHE_D or CONFIG_CACHE_BOTH are set - since that means there 
> is data
> caching involved.

Now I see - I had read that definition to correspond to the 'select 
coherent allocations on m68k' case, not the latter 'use non-coherent 
allocations in the fec driver'.

Your definitions are correct as written (and for all I can see, 
Christoph's implementation is correct, too).

Apologies for the noise - I blame jet leg for getting my wires crossed ...

Cheers,

     Michael

>
> Regards
> Greg
>

