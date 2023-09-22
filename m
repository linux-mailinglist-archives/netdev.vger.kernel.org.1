Return-Path: <netdev+bounces-35637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB267AA687
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7E69F2812B2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCDC38C;
	Fri, 22 Sep 2023 01:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4B377
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:29:52 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2538F4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:29:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5dd017b30so8859965ad.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695346190; x=1695950990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVVILEudndVLpVL8jThaDKeRUP/QOeiczWaB81a+4Fg=;
        b=Q0kBGEvp1iZ+j5Ce6nOcC6MqvezWhlQL9gkB6/KT52A5L3oPRuAIM16EoJcS/idVM7
         HjFTXPv3RgG5RVZsvsIHONEo0a0CmN8XB5TF33j4LSTiBAJW+alrf6pnfXPEsMFOQmfD
         XHv2YRDV5UJIqD1lqS4UOf4oZH9pVxRFZxxlnnPEfX3p6lWvaeEe4fv1cm5sxeMl55//
         xaj38/uobv7KSpeGyLvVwk3SfD6Edsv/e+84GxPAjULBWn0bpMUJXFTjYf7BE45OkWZ4
         G1u9+7+MEclBwkm20otlKVJXsP0pQPgyJlmph6oYZfg/y1m8k5WOiZaQtAfsAGtNg1M1
         L81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695346190; x=1695950990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVVILEudndVLpVL8jThaDKeRUP/QOeiczWaB81a+4Fg=;
        b=VwnzEIBvMlvsC4CQ6jrLGo7wgJe3NaZZXs3lwpOm1PNZmi/HLUNrUU32TwTfHvURYk
         BuXwU7/wADin7V4e8oUq3Z3GN/1XjXljuvpIM1c5CL2ZGU5IiBsRIRFbg32Ep1hTh/bH
         bprIYz3rYWYN066syYMB4frXv27U3PibgbBUUwVMzyCuIcsV9VrRL0+4aA9m6UVqbc2V
         Am3TAQRmsgVCH1ZDbObByNS9rpGGaiFNX16jBz4dALM3X76Vh9iNDKsPQI38ST4vup/N
         BRIQK66mRk8a2dDrhOGJ+uqQ9iO+nZPEfqAISbiqFAd1zBzH9eWeMbwnhC1SX53Kg4fV
         5ppg==
X-Gm-Message-State: AOJu0YwEpw0LtN1mlN/ehfBrV1LkvsSEFTSbxacy0kph64czjROnj2+i
	WnC56QlyA64uPLaqm/UOz2k=
X-Google-Smtp-Source: AGHT+IGHjCTZa+J/RnDnliKHVCrTwuKMt76sISgWAB+gCUaIViUdc5W4s0Vn/cCdFuhlkE8iZMdbAw==
X-Received: by 2002:a17:902:da86:b0:1c3:e2eb:f79d with SMTP id j6-20020a170902da8600b001c3e2ebf79dmr1923562plx.8.1695346190178;
        Thu, 21 Sep 2023 18:29:50 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b891259eddsm2194373plg.197.2023.09.21.18.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:29:48 -0700 (PDT)
Date: Fri, 22 Sep 2023 09:29:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCHv3 net 1/2] fib: convert fib_nh_is_v6 and nh_updated to
 use a single bit
Message-ID: <ZQzuB00CJpr51C+N@Laptop-X1>
References: <20230921031409.514488-1-liuhangbin@gmail.com>
 <20230921031409.514488-2-liuhangbin@gmail.com>
 <21c58c78-1b76-745a-0a12-7532a569374b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c58c78-1b76-745a-0a12-7532a569374b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 07:03:20AM -0600, David Ahern wrote:
> On 9/20/23 9:14 PM, Hangbin Liu wrote:
> > The FIB info structure currently looks like this:
> > struct fib_info {
> >         struct hlist_node          fib_hash;             /*     0    16 */
> >         [...]
> >         u32                        fib_priority;         /*    80     4 */
> > 
> >         /* XXX 4 bytes hole, try to pack */
> > 
> >         struct dst_metrics *       fib_metrics;          /*    88     8 */
> >         int                        fib_nhs;              /*    96     4 */
> >         bool                       fib_nh_is_v6;         /*   100     1 */
> >         bool                       nh_updated;           /*   101     1 */
> > 
> >         /* XXX 2 bytes hole, try to pack */
> 
> 2B hole here and you want to add a single flag so another bool. I would
> prefer the delay to a bitfield until all holes are consumed.
> 

OK, just in case I didn't misunderstand. I should add a `bool pfsrc_removed`
here and drop the first patch, right?

Thanks
Hangbin

