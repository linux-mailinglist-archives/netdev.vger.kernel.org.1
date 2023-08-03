Return-Path: <netdev+bounces-24014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2D176E775
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D38281D6B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B71DDF6;
	Thu,  3 Aug 2023 11:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455701DDC5
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:55:54 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2332D43
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:55:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so13393741fa.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691063751; x=1691668551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuvtjFHgGZRCUW+TNZUXEj9FboRSSdVikwCBlQKozb8=;
        b=um8DGDDrx5jcxCuTnwU8y2C9BiWgz53J9iDsEnoEdXrb0rSzV1cLiTvubypdDEOIAE
         Yt2RZ6OhGqtwH5OjJNKQR52a/HN3QUtQAZK+O7uuyEmExqjLHd36yQR2X5ZaIkJf+N3T
         LAhHijUjDZE3OvU3mNygRNESoWgaBx9h9UKUZxTh/KTN3o41kZe/ERuLXn3R0tu3UKKD
         tp7OPRNqMF1fLQ2sMMnMwnCe9nlZR1VfqAN3LlkQW6hlYQKV9Z7gXtzEuoF5GjI1gowh
         Yl7zJNDyPi/ZwuSC2nwMTz4EdWT61gt2K99z7imvQyTZuScsiaQCd2BTk2AOFZDp3pKD
         Pq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691063751; x=1691668551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuvtjFHgGZRCUW+TNZUXEj9FboRSSdVikwCBlQKozb8=;
        b=l1b29/qkwQu7sy9evYNSZ0WjVrAD6muUd+CowWoBhaDzWlhoRVnbZmPgEJHlCiLTSn
         a1kadLcWLeRJ1nTPa+pjsuCIzSjxnDqPaYEWwkDcRJ0OZwoGl9hrw54lebq064tlBYwr
         kx9+Pys+uMjP9PyYKxgG2i1150n+JtKDLjoO8a4HIsmV1bTp7ukSe038HaM2+8kqNM5e
         X/9JsDbJYgWx2ZELhtWlo7ddaGhrHnRaiJTZm8aSxB/Sw6EsuVXPUMtj8kYY+5CUdYDb
         cD/lhn58iOw+J1wrC+FURYvkkEI1k/Wynu00Bfd5HKzU/5IInlJ/h5LZLH6bXqY67VCl
         7DkA==
X-Gm-Message-State: ABy/qLZiBsCRyr08pyWdiO6Jb5pIFt1PLfydGTz//wNcmCz+1Hz8wDvc
	+6WW9xccPeb38+CJmkr3R4WGGw==
X-Google-Smtp-Source: APBJJlFWGoIUMSgVABFfyRwhqKQbCqOPZkTHFobX4YNdNaIU5YKQKCbMlGlBuMrTUW5rYLsNQ6PJVA==
X-Received: by 2002:a2e:889a:0:b0:2b9:df53:4c2a with SMTP id k26-20020a2e889a000000b002b9df534c2amr8022168lji.20.1691063751522;
        Thu, 03 Aug 2023 04:55:51 -0700 (PDT)
Received: from localhost (h3221.n1.ips.mtn.co.ug. [41.210.178.33])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b009929ab17bdfsm10330191ejb.168.2023.08.03.04.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:55:50 -0700 (PDT)
Date: Thu, 3 Aug 2023 14:55:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH v1 net-next 2/4] tc: flower: support for SPI
Message-ID: <664b202a-d126-4708-a2af-94f768fe3abd@kadam.mountain>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
 <20230801014101.2955887-3-rkannoth@marvell.com>
 <ZMqpd2DyHz4O/v17@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMqpd2DyHz4O/v17@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 09:07:35PM +0200, Simon Horman wrote:
> + Dan Carpenter
> 
> On Tue, Aug 01, 2023 at 07:10:59AM +0530, Ratheesh Kannoth wrote:
> > @@ -1894,6 +1915,12 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
> >  			return ret;
> >  	}
> >  
> > +	if (tb[TCA_FLOWER_KEY_SPI]) {
> > +		ret = fl_set_key_spi(tb, key, mask, extack);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> Hi Dan,
> 
> I'm seeing a warning from Smatch, which I think is a false positive,
> but I feel that I should raise. Perhaps you could take a look at it?
> 
> net/sched/cls_flower.c:1918 fl_set_key() error: buffer overflow 'tb' 106 <= 108
> 

You're using the cross function database, right?  What happens is that
when someone adds a new type of net link attribute, it takes a rebuild
for the database to sync up.

I can't think of a good way to fix this.  This information is passed as
a BUF_SIZE.  Each database rebuild passes the BUF_SIZE one call further
down the call tree.

$ smdb fl_set_key | grep BUF_SIZE
net/sched/cls_flower.c |            fl_change |           fl_set_key |           BUF_SIZE |  1 |              tb | 864
net/sched/cls_flower.c |      fl_tmplt_create |           fl_set_key |           BUF_SIZE |  1 |              tb | 864

This is a flaw in how Smatch works, and theoretically it affects
everything, but in practical terms it affect netlink attribute tables
the most.  Other places are not modified as often or they pass the size
as a parameter.  I could modify check_index_overflow.c to silence
warnings where it's a netlink attribute table and the offset is less
than __TCA_FLOWER_MAX.

regards,
dan carpenter


