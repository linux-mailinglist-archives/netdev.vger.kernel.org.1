Return-Path: <netdev+bounces-35165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A042E7A770F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D41281C55
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70211739;
	Wed, 20 Sep 2023 09:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2113D63
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:19:57 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92F83
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:19:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so468689b3a.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695201595; x=1695806395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbOXZ7kg7Opr6CF1abdamvImGpK3b39kh0dT7JxSauU=;
        b=dOxAzfuzQ20eU/LLlWBjXq1rvHlEn3kx8oOMFYD2IEq/oYPKnxb2+i5UwcNmrLzFZd
         pgDqLkfD6NIF0Ekw19oVn32ucnwWdi9U51C1m2p6e1VI9hzqaHq2xk5WF4ZwaWcNwyGx
         4VSdnnOANmxoum2gA8o1T2eCs1i7fyIw2SJYWepYnxjAzRrK5EtALYQgs3hzi4Qyhh0w
         AggAgtLc44ZnD4ifNFwVfVfB6kXeHkP5mnmCFc+rtTyqxrGDNjfTHzsfjTevzJ3e3615
         5glIogAjfIFhgvtN03sk1NgxbNpqTG5aOAMAwXVyjkPlGSmjSRr8es7fLwL0KYcHfA4j
         gW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201595; x=1695806395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbOXZ7kg7Opr6CF1abdamvImGpK3b39kh0dT7JxSauU=;
        b=nwrj0n3KpcUbbii+GrgogBPYmZ1i74wUI1IZryJu1d5jaazwUKkqQcwedHDvk0qW49
         /L0JSffSBrOCyfcN87TkjCuh0i70j2f+4h1lHvpZ/RCTdLE7aBAlG9YRy2JCvfCdlalL
         VQz1zBCeGw/YEYFwVjsNAcmbuSBtDlJ1ckIF1IY14ZcJUwCT23T5nXH57rkVp9FKVM0d
         OwBW7tmrE1+bwWFNQCAjmPA1wKP3B9W0TPl7NNuUNSXHuHmVwDgxQMFFrfd0++XoWuNi
         ytT9bHQhFm7mhFbdx1+x36M9QH14MN4ZlooKpFL/C+RM9OD+f9a0Q+LGrw5jWi7tf9nm
         SS4Q==
X-Gm-Message-State: AOJu0YxbCd0zztLD3BbyUhjagNYDC/GEUKBP6Bqoe4O17R4cRO/we9lh
	K7B0uHygvHtPj6bKCerEj/Q=
X-Google-Smtp-Source: AGHT+IGvOcMmADzB+tjClatW9fzjYPtZ6i5aNirXhe9MsFtPOqRbwshQx8A6JxP5MxYXYZc4wUchgw==
X-Received: by 2002:a05:6a20:144c:b0:13e:90aa:8c8b with SMTP id a12-20020a056a20144c00b0013e90aa8c8bmr2988056pzi.4.1695201595186;
        Wed, 20 Sep 2023 02:19:55 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id dc10-20020a056a0035ca00b00690c926d73bsm2186916pfb.79.2023.09.20.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 02:19:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 17:19:48 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC Draft PATCH net-next 0/1] Bridge doc update
Message-ID: <ZQq5NDqPAbwi98yU@Laptop-X1>
References: <20230913092854.1027336-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913092854.1027336-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Nikolay, Roopa,

Do you have any comments for this RFC?

Thanks
Hangbin
On Wed, Sep 13, 2023 at 05:28:52PM +0800, Hangbin Liu wrote:
> Hi,
> 
> After a long busy period. I got time to check how to update the bridge doc.
> Here is the previous discussion we made[1].
> 
> In this update. I plan to convert all the bridge description/comments to
> the kernel headers. And add sphinx identifiers in the doc to show them
> directly. At the same time, I wrote a script to convert the description
> in kernel header file to iproute2 man doc. With this, there is no need
> to maintain the doc in 2 places.
> 
> For the script. I use python docutils to read the rst comments. When dump
> the man page. I do it manually to match the current ip link man page style.
> I tried rst2man, but the generated man doc will break the current style.
> If you have any other better way, please tell me.
> 
> [1] https://lore.kernel.org/netdev/5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org/
> 
> 
> Hangbin Liu (1):
>   Doc: update bridge doc
> 
>  Documentation/networking/bridge.rst |  85 ++++++++++--
>  include/uapi/linux/if_bridge.h      |  24 ++++
>  include/uapi/linux/if_link.h        | 194 ++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+), 10 deletions(-)
> 
> -- 
> 2.41.0
> 

