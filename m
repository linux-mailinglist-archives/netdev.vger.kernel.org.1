Return-Path: <netdev+bounces-38775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8417BC6C7
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A11B1C203BC
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78858182DD;
	Sat,  7 Oct 2023 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UZLIuUjx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB2256A
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:29:52 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6C9E
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:29:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2597243f8f.3
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696674589; x=1697279389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UG+hsX9hPN3W+5HioqXm2wenW+sadTD1b3Qm+tfgnSY=;
        b=UZLIuUjx2ohTWM34V0I/Cnoc/Afxt3WHKQTsdU1wrIE3NYsB2ZOCMsNFwpocype4J7
         kgkMaTVvryEVvWpoWC1ck+YgH3dFzXC1rZjglZF9PD1KO7JzWiB9x0pZEFLa+Yebakwj
         GkW1I/+JzAc1qNPtaBJgfQFXwJBW/IcNGgRmWFuBtp3pWlgxl1QXkk30wF7fuCFWRWBV
         buawxCW+8pX5Ld0rdCjMv/lqMH7nISjJhZG8u0IKvEXlK9sVybhAKxhnpOy8w89pt6YK
         jRuYZZs93cjSUc4Cki2yE0e4s/IkSq5se/Blu88AZ94ltq0xHJgbDPPNgRCgb7utb/s+
         6W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674589; x=1697279389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG+hsX9hPN3W+5HioqXm2wenW+sadTD1b3Qm+tfgnSY=;
        b=k2I/FUbxKH37r7KXWA+uUygF3z8raQH3csrk0/dicZd2CEfvHnE5eyVf9gYQUhxFeT
         JcZUVbxIdkv5sWYWKABg/A1/wxHrJzWvL/mIEOHhijsBkBIIz0unA2uorI8hJ+ljQ23I
         sxaeELwRdRr91wd0EQoIyAJhdjAXvZZMKY3S6vj5fCapAVO49mA3nXXPBwiTDgbo6eLc
         WfuzCosS27IsAQpVlg2uvKgCvdLh8qRwaScvS8gxjhykUX8zYecgdYOaIolOshO1jKF6
         GSz0SJprwXJAad0fxmTUrD9zOj+5DbsULp9ffr4xZBiPM4OgVwce1vk3RwAgakXIoE5x
         EVyQ==
X-Gm-Message-State: AOJu0Yz7GCFKsSOYLr1E4OKu4vSYwt69Mt2krYatdxrGaZIz9YMW5F0o
	ie3nsmhzGOEyitK7gNGUiBk5QA==
X-Google-Smtp-Source: AGHT+IFCuMFxbiqcnF20Qq6FWZXXKcM304kVgx1Fkg5wNG86dJ8nKaYsW62Ajy0W8xgkaauUSCLIfA==
X-Received: by 2002:a5d:6450:0:b0:315:ad1a:5abc with SMTP id d16-20020a5d6450000000b00315ad1a5abcmr9606048wrw.5.1696674589035;
        Sat, 07 Oct 2023 03:29:49 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b003279518f51dsm3920808wro.2.2023.10.07.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:29:48 -0700 (PDT)
Date: Sat, 7 Oct 2023 12:29:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Kuba Kicinski <kuba@kernel.org>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
	davem@davemloft.net, pabeni@redhat.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <ZSEzG0TpTI6W9+tL@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
 <20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
 <ZR/9yCVakCrDbBww@nanopsycho>
 <20231006075536.3b21582e@kernel.org>
 <ZSA7cEEc5nKl07/z@nanopsycho>
 <20231006124457.26417f37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006124457.26417f37@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 09:44:57PM CEST, kuba@kernel.org wrote:
>On Fri, 6 Oct 2023 18:53:04 +0200 Jiri Pirko wrote:
>> Fri, Oct 06, 2023 at 04:55:36PM CEST, kuba@kernel.org wrote:
>> >> I'm confused. Didn't you say you'll remove this? If not, my question
>> >> from v1 still stands.  
>> >
>> >Perhaps we should dis-allow setting version in non-genetlink-legacy
>> >specs? I thought it may be a useful thing to someone, at some point,
>> >but so far the scoreboard is: legit uses: 0, confused uses: 1 :S
>> >
>> >Thoughts?  
>> 
>> I don't know what the meaning of version is. I just never saw that being
>> touched. Is there any semantics documented for it?
>> 
>> Kuba, any opinion?
>
>/me switches the first name in From :P

I messed up a bit. Kuba* confusion, sorry :)


>
>I think it basically predates the op / policy introspection,
>and allows people to break backward compat.
>
>drop_monitor bumped to 2 in 2009:
>
>  683703a26e46 ("drop_monitor: Update netlink protocol to include
>netlink attribute header in alert message")
>
>which breaks backward compat.
>
>genetlink ctrl went to 2 in 2006:
>
>  334c29a64507 ("[GENETLINK]: Move command capabilities to flags.")
>
>which moves some info around in attrs, also breaks backward compat
>if someone depended on the old placement.
>
>ovs did it in 2013:
>
>  44da5ae5fbea ("openvswitch: Drop user features if old user space
>attempted to create datapath")
>
>again, breaks backwards compat.
>
>
>I guess it may still make one day to bump the version for some proto
>which has very tight control over the user space. But it hasn't
>happened for 10 years.

But since by the policy we cannot break uapi compat, version should be
never bumped. I wonder howcome it is legit in the examples you listed
above...

Let's forbid that in genetlink.yaml. I have a patch ready, please ack
this approach.

Thx!

