Return-Path: <netdev+bounces-38644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA727BBD77
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719D81C2093E
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB32AB4A;
	Fri,  6 Oct 2023 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KbPrwnmU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD54BE4F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 17:08:00 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC55D8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:07:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso406339366b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696612076; x=1697216876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TotTWJ9FLZOEytuhHPQip8sNfRdZArllOx/ZZ9bhxf0=;
        b=KbPrwnmUlrc/SxVnK9XEorRP89TuD17LQLsD5frYaYt8thEOco1qcYyHUhpGlsPd/+
         KPQm0VzGj5romorNTNs69D4Ttu+3mJjrUPSFxVBS1M6Mf9YolocgcAZn4qzx0+HdY95P
         xGexwbPornKrZ+YH80isRUv4j8T35EB4cV4RldyO3rGGABgGyJ5xZx/I5P5ljJC/assu
         On2OqLQDuXqInqNCLHZXFNdragtpItDPLw3jU49853isqtw87UGgYiNK/8TBq/sci/0R
         aS8l8Sp3yDxIsoE31UOJ+Y98fubZiCraMMiv7jza/T5Aybu/hlUj/Zz7iFXV2OMdmUWd
         jutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612076; x=1697216876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TotTWJ9FLZOEytuhHPQip8sNfRdZArllOx/ZZ9bhxf0=;
        b=WlyXvCpit7GtwAn0SvsKQcZZ3lnfa72UE7XwfUFNG/bU4sPt86umEqyd116wItxeu5
         LFeRdu8CUN2biJ1Taj+QtGij85LqhcE1f8AOoSYDRQtfBC7eq+wL9FS0jAtpMMgO0XIu
         +6paS3Av3zv8JPgrk+DBEE7XVSdXoqEQkzgzvNSP457soGjdeCpOQjTKU59zMzbEUtAx
         UhcHvMYXRbpBb+Oxr1i/TjovUpqBzVfZ97tiUhb5LiHw70pkM63TWIbfYCWXQLEm1DUX
         cg3/QVDh+cJLWempKyFnJXqzFeaUypnjNMhf2NIIxME90ILIrcR0wWynI/WiIbtzeLOX
         j5Og==
X-Gm-Message-State: AOJu0YzuK3TjffSx6sDdzcKLa1s7VCM+zdYf+H/I1cVNF+ANs11KxOtG
	d/dSQklOGJyQIo6bNgPoT8Txlg==
X-Google-Smtp-Source: AGHT+IE2LEFRDc+Z2g4M4zL7La4P5YOe9vTxzmHpfaJh/TlFaw0LaRvpG3I1Or1J8pUDvO8SUKeSRw==
X-Received: by 2002:a17:907:7787:b0:9b2:6f52:586d with SMTP id ky7-20020a170907778700b009b26f52586dmr8203489ejc.50.1696612076224;
        Fri, 06 Oct 2023 10:07:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906230c00b009920e9a3a73sm3149821eja.115.2023.10.06.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:07:47 -0700 (PDT)
Date: Fri, 6 Oct 2023 19:07:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSA+1qA6gNVOKP67@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
 <20231005183029.32987349@kernel.org>
 <ZR+1mc/BEDjNQy9A@nanopsycho>
 <20231006074842.4908ead4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006074842.4908ead4@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 04:48:42PM CEST, kuba@kernel.org wrote:
>On Fri, 6 Oct 2023 09:22:01 +0200 Jiri Pirko wrote:
>> Fri, Oct 06, 2023 at 03:30:29AM CEST, kuba@kernel.org wrote:
>> >> @@ -310,6 +299,7 @@ static void devlink_release(struct work_struct *work)
>> >>  
>> >>  	mutex_destroy(&devlink->lock);
>> >>  	lockdep_unregister_key(&devlink->lock_key);
>> >> +	put_device(devlink->dev);  
>> >
>> >IDK.. holding references until all references are gone may lead 
>> >to reference cycles :(  
>> 
>> I don't follow. What seems to be the problematic flow? I can't spot any
>> reference cycle, do you?
>
>I can't remember to be honest. But we already assume that we can access
>struct device of a devlink instance without holding the instance lock.
>Because the relationship between devlink objects is usually fairly
>straightforward and non-cyclical.
>
>Isn't the "rel infrastructure"... well.. over-designed?
>
>The user creates a port on an instance A, which spawns instance B.
>Instance A links instance B to itself.
>Instance A cannot disappear before instance B disappears.

It can. mlx5 port sf removal is very nice example of that. It just tells
the FW to remove the sf and returns. The actual SF removal is spawned
after that when processing FW events.


>Also instance A is what controls the destruction of instance B
>so it can unlink it.
>
>We can tell lockdep how the locks nest, too.
>
>> >Overall I feel like recording the references on the objects will be
>> >an endless source of locking pain. Would it be insane if we held 
>> >the relationships as independent objects? Not as attributes of either
>> >side?   
>> 
>> How exactly do you envision this? rel struct would hold the bus/name
>> strings direcly?
>
>No exactly, if we want bi-directional relationships we can create 
>the link struct as a:
>
>rel {
>	u32 rel_id;
>	struct devlink *instanceA, *instanceB; // hold reference

Sometimes port, sometimes linecard is one one side (A).


>	struct list_head rel_listA, rel_listB; // under instance locks
>	u32 state;
>	struct list_head ntf_process_queue;
>}
>
>Operations on relationship can take the instance locks (sequentially).
>Notifications from a workqueue.

That is pretty much how that works now.


>Instance dumps would only report rel IDs, but the get the "members" of
>the relationship user needs to issue a separate DL command / syscall.

Oh! At least with process listening on notifications, this may be a bit
painful :/
I need some time to digest this.

