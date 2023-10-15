Return-Path: <netdev+bounces-41070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D17C98C6
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E70B20B89
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559C23B9;
	Sun, 15 Oct 2023 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hA2QGmtp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B5185E
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 11:12:12 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7149D6
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 04:12:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32c9f2ce71aso2943596f8f.1
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697368328; x=1697973128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+hjinkWqLesBIH5rOJHsFyg5k2o7WwTYjEkLw7zCHA=;
        b=hA2QGmtpzgBqkX02RFFBEThVwHO9Ek4oV8fHy2gAOiAF0+Fyg3+gwfQYWhILylkFnw
         /5t+l3L0BZYDmPpJIuKzNEn63loY3hOTVYD8Q9tLNMDbhfEiqgc4i8nv8AF73EYEFT48
         tALGilxsyA9+L2Hp4CiGuqbSGKyHVGOEfcbEeYrggQm6WKeBzUNqSUW+eN8qw1c+ESZI
         IjisI+c9eczW4Rl88vOzFwpdzF4IGps88vLVHr+d3bmSBD0J4R7IHKClcq6h0x1zCPYO
         ffl9AyedLrat2ZojTYgbi/gKFKcUN3USdBIBkbc5S8eh7v26jY28XqbO8zkA+XW5trCj
         PuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697368328; x=1697973128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+hjinkWqLesBIH5rOJHsFyg5k2o7WwTYjEkLw7zCHA=;
        b=oRZZaMizVqyiHUnRdf1A7d4RTdMwPETN4mRwsrBNGGyGd6YR7WZru1NrsUWWtn9ig9
         2tDOOOyO+tDrCfz7KztFu9yDBk9+wJdPcEXIkZbGEyp7m5fpg0fRBFMruZWVSaC4LxVG
         hL060xDjjEa/p80P/WB6ivsQqlZsygz7rqj3Xe9d5suTOLlSBt4qTI58FgWVgUBLPPZ2
         JvOpp3d1rUTTu65XOJv6u2AxQ7703whFEvoFi1F6L0dxIs0EffNjIoBkE2WCDlbxDYXz
         hiUAHQo2VpRwrg4OjXEBAiFrHaTJPZX9Wib78X10L+IS5Whq61mIDiId1/+UFDlqyZD+
         NCpQ==
X-Gm-Message-State: AOJu0YzpeT6bS83yrTA6tCVeGr4WGJICWsNVqmAs1sFShWfzQkwG6DH5
	eQTI9P8oOHriNFazumgLWbbOFQ==
X-Google-Smtp-Source: AGHT+IHU0ckLcePXBdGjqPbnlj6ms+Fm0W3lDMNY7EKvDXOW55XJotTCBpTlqJ/yTjSXwSN/BqDPmA==
X-Received: by 2002:a05:6000:80b:b0:32d:a686:dedf with SMTP id bt11-20020a056000080b00b0032da686dedfmr3633105wrb.57.1697368327985;
        Sun, 15 Oct 2023 04:12:07 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm24790882wrw.103.2023.10.15.04.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 04:12:07 -0700 (PDT)
Date: Sun, 15 Oct 2023 13:12:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSvJBV2dWf1dTlWp@nanopsycho>
References: <ZST9yFTeeTuYD3RV@nanopsycho>
 <20231010075231.322ced83@kernel.org>
 <ZSV0NOackGvWn7t/@nanopsycho>
 <20231010111605.2d520efc@kernel.org>
 <ZSakg8W+SBgahXtW@nanopsycho>
 <20231011172025.5f4bebcb@kernel.org>
 <ZSeOq+I+Z12E/oRC@nanopsycho>
 <20231013083945.3f6d8efe@kernel.org>
 <ZSl5OS7bFsg/ahCK@nanopsycho>
 <20231013130100.0d08fb97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013130100.0d08fb97@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 13, 2023 at 10:01:00PM CEST, kuba@kernel.org wrote:
>On Fri, 13 Oct 2023 19:07:05 +0200 Jiri Pirko wrote:
>> >> Not sure what obvious bug you mean. If you mean the parent-child
>> >> lifetime change, I don't know how that would help here. I don't see how.
>> >> 
>> >> Plus it has performance implications. When user removes SF port under
>> >> instance lock, the SF itself is removed asynchonously out of the lock.
>> >> You suggest to remove it synchronously holding the instance lock,
>> >> correct?   
>> >
>> >The SF is deleted by calling ->port_del() on the PF instance, correct?  
>> 
>> That or setting opstate "inactive".
>
>The opstate also set on the port (i.e. from the PF), right?

Correct. But the problem is elsewehere. The actual SF auxdev lifecycle,
see below.


>
>> >> SF removal does not need that lock. Removing thousands of SFs
>> >> would take much longer as currently, they are removed in parallel.
>> >> You would serialize the removals for no good reason.  
>> >
>> >First of all IDK what the removal rate you're targeting is, and what
>> >is achievable under PF's lock. Handwaving "we need parallelism" without
>> >data is not a serious argument.  
>> 
>> Oh there are data and there is a need. My colleagues are working
>> on parallel creation/removal within mlx5 driver as we speak. What you
>> suggest would be huge setback :/
>
>The only part that needs to be synchronous is un-linking.
>Once the SF is designated for destruction we can live without the link,
>it's just waiting to be garbage-collected.

Yeah. Another flow to consider is SF unbind. When user unbinds the SF
manually, PF lock is not involved in at all (can't be really). SF needs
to be unlisted as well as the SF devlink instance goes away. That was
another reason for the rel infrastructure.


>
>> >> Not sure what you mean by that. Locking is quite clear. Why weird?
>> >> What's weird exactly? What do you mean by "random dependencies"?
>> >> 
>> >> I have to say I feel we got a bit lost in the conversation.  
>> >
>> >You have a rel object, which is refcounted, xarray with a lock, and 
>> >an async work for notifications.  
>> 
>> Yes. The async work for notification is something you would need anyway,
>> even with object lifetime change you suggest. It's about locking order.
>
>I don't think I would. If linking is always done under PF's lock we can
>safely send any ntf.

If is not. Manual bind called over sysfs of the SF auxiliary device is
called without any lock held.

There are multiple race conditions to consider the probing/removing the
SF auxiliary device in parallel operations like PF devlink reload, port
funcion removal etc. Rel infra is considering and resolving them all.


>
>> Please see the patchset I sent today (v3), I did put in a documentation
>> describing that (3 last patches). That should make it clear.
>
>It's unnecessarily complicated, but whatever, I'm not touching it.

