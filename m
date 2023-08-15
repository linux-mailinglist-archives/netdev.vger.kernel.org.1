Return-Path: <netdev+bounces-27679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF977CCFF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC60281375
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278EB11CAF;
	Tue, 15 Aug 2023 12:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3966FA9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:55:38 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F003E65
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:55:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6886d6895a9so190935b3a.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692104135; x=1692708935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d067KSgOSjoNZVRz8cbH79cw2gEv0Z7KgPIc17smKa0=;
        b=TVeHLZ2KusMupxaGO0Q1Szeb+WaPtrRMtSL7ktyNr1rnFXW1ARIDhT+V0OUNp22bBY
         q9mGyRVBIBaD82mYG3FnLNUIkupwSg2Pmo/O1xqWWbGMQxE0nC4nUZ027TTdQ0/Qsy3j
         uaZTzCd3kKMN5dKJXcPAR+DgehJoeKsUTFClf5uUbNE+JBBRBCZvS/8nC+qJH7xRYrBP
         BJ1H9rZF0PjedwqkQlYShV47LMWivRdiW8AHeGhn25lQl5W6EZ+rIA3K110N3QoKNjcS
         zGNeZrvrPP71YQ7ArJow+BR7S5K8rpAb5SVVNPq2o/mii6YfA713+zgk+fGAdsT51Z+i
         Tf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692104135; x=1692708935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d067KSgOSjoNZVRz8cbH79cw2gEv0Z7KgPIc17smKa0=;
        b=EEUSXr3bHF1nXXpQz05nOuimeh/DxJrSw3Z0szSB76A6O3vbl6qPDkV0flgZpaFwh+
         R0jWEHfnVV20Ht3wqGZE5jnvgga2M7GUTmEaMfIbbi/xgDH/o8vNfJmcUvVNkO7HJgza
         2dEgoRvzMvNyQyZEvemiLwCpv2VVTMLxAgrjd3KdYkFnllK+jyFXNSFdObHmxj3BJ8yI
         hC35zLo4iYKFjFjoYqGviTnq/f0G87O0j26yMxINWNy+8TM57oQ6xa9DrFa8HezOvGMO
         cLI21K8do9+KHFDRDtTzq2Mt9nJiQlE9T9pSeTwFbWYix3Z/vDq0W0k28bcFCHRmyvuK
         pGNQ==
X-Gm-Message-State: AOJu0Yxws4o/FTgTgPtt6WVKdfHYatCvBl9+kBzwzkiQ7yLybrNcX6Ka
	c5jRxTp6+dFrKlDMBnuSufI=
X-Google-Smtp-Source: AGHT+IF6L/5spo0tzothiwL7wWObOsA8zNJrb8mDfH8i14uTc/HCTPeBNwSLAmt0rzklJKLr/nMN6A==
X-Received: by 2002:a05:6a20:7da2:b0:133:fd64:8d48 with SMTP id v34-20020a056a207da200b00133fd648d48mr13706038pzj.4.1692104134964;
        Tue, 15 Aug 2023 05:55:34 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b006874a6850e9sm9339480pfc.215.2023.08.15.05.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 05:55:33 -0700 (PDT)
Date: Tue, 15 Aug 2023 20:55:28 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Thomas Haller <thaller@redhat.com>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source
 address routes
Message-ID: <ZNt1wOCjqj/k/zAW@Laptop-X1>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
 <20230809140234.3879929-3-liuhangbin@gmail.com>
 <ZNT9bPpuCLVY7nnP@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNT9bPpuCLVY7nnP@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 06:08:28PM +0300, Ido Schimmel wrote:
> On Wed, Aug 09, 2023 at 10:02:34PM +0800, Hangbin Liu wrote:
> > After deleting an interface address in fib_del_ifaddr(), the function
> > scans the fib_info list for stray entries and calls fib_flush() and
> > fib_table_flush(). Then the stray entries will be deleted silently and no
> > RTM_DELROUTE notification will be sent.
> > 
> > This lack of notification can make routing daemons like NetworkManager,
> > miss the routing changes. e.g.
> 
> [...]
> 
> > To fix this issue, let's add a new bit in "struct fib_info" to track the
> > deleted prefer source address routes, and only send notify for them.
> 
> In the other thread Thomas mentioned that NM already requests a route
> dump following address deletion [1]. If so, can Thomas or you please
> explain how this patch is going to help NM? Is the intention to optimize
> things and avoid the dump request (which can only work on new kernels)?
> 
> [1] https://lore.kernel.org/netdev/07fcfd504148b3c721fda716ad0a549662708407.camel@redhat.com/

In my understanding, After deleting an address, deal with the delete notify is
more efficient to maintain the route cache than dump all the routes.

Hi Thomas ,do you have any comments?

Thanks
Hangbin

