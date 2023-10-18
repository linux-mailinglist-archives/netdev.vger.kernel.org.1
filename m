Return-Path: <netdev+bounces-42303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D717CE1E4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F2D281D5A
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F893B7B1;
	Wed, 18 Oct 2023 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GQiUFRDc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075A347D0
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 15:57:22 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDF11C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:57:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d45f5658fso4249060a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697644640; x=1698249440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UruBDXRQS7jPcNe0E70TXx3ruy8Wb51bnBvMyopkdbE=;
        b=GQiUFRDc9HPy9AyfJEnsi9Smvb0Maos4NEI1PreeLVTRaHE8KlNJnJiUJzulGZ4682
         CW3SlEAJuAWBBS20F8oihgXEx2OtiQOMQS4BWZaRLuoBlQYbvGTspOazXyDSsbP8a4x0
         cR7lOCQ5MJPrymlauhJecudLahQv3mjkWjh8jTChTpLzzwpr8yXuryeyKCJ6L5nIcoSj
         yIKhOohQ92sSaeGthk/S6RyYMGH2r0cQndNCkjLTQDUoYU3z1zYTbRuThvRsOHghgkuA
         yIJjeLkGGt4n1Y2F1I5UZ+tf09lqsExFavwRNWtQoXxNVeE1C6ayFrZkRFm1JnafB92x
         Xu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697644640; x=1698249440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UruBDXRQS7jPcNe0E70TXx3ruy8Wb51bnBvMyopkdbE=;
        b=FRZgu/5FN6fvVih8R7tzKgl1cp8tOYZdP314LgNVtPlnAm8PHEf/6GMBOLknqAd3Uc
         p1KEX4i8sDtMZdT0ln21CxBqYKQ/z8fzlYowxXE9qtoUZjHfOvTQx0sONdkmgQLlFykP
         YDQSMcv72Eg/DVJXCbF5jpbGJo4gF4p8A8T7ZTUtAPlyRToPZ2ZSNeBCD24LrSJVvN68
         EJAWJJ8g1AhMo/3EhYm7T7LiDES3NO2Iw3m1rp4pYg8L9T/iyr7b0bzd5XXFd1kx/RUj
         8o0Cbpjpp4Tb94/eITSh4XavN6Q/hdnqVLRFalff2iF8bZR7n6sG80dd1mslpooNlr1C
         D4jQ==
X-Gm-Message-State: AOJu0YxsN5qVbfP4wWFsn8dKPnhcNRAPAKdiih2/rM3OjYqTxBck0hkp
	fqEBBj19QEAu63D+4VHiiLoQc4KuoFKn8eh/HUfIXg==
X-Google-Smtp-Source: AGHT+IEzGR9qAHjBrGpnWQ+Al4Zf1I+C7JOwmbzXQ8LuC8wH0U5MfJMor5cSjsLm+XnwGBfENB76Ug==
X-Received: by 2002:a17:90a:19c2:b0:27d:d9c2:6ee5 with SMTP id 2-20020a17090a19c200b0027dd9c26ee5mr2074402pjj.9.1697644639827;
        Wed, 18 Oct 2023 08:57:19 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id d62-20020a17090a6f4400b002772faee740sm107444pjk.5.2023.10.18.08.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:57:19 -0700 (PDT)
Date: Wed, 18 Oct 2023 08:57:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org,
 mhocko@suse.com
Subject: Re: [RFC PATCH net-next 0/4] net-sysfs: remove
 rtnl_trylock/restart_syscall use
Message-ID: <20231018085717.454931c3@hermes.local>
In-Reply-To: <20231018154804.420823-1-atenart@kernel.org>
References: <20231018154804.420823-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 17:47:42 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> Hi,
> 
> This is sent as an RFC because I believe this should be discussed (and
> some might want to do additional testing), but the code itself is ready.
> 
> Some time ago we tried to improve the rtnl_trylock/restart_syscall
> situation[1]. What happens is when there is rtnl contention, userspace
> accessing net sysfs attributes will spin and experience delays. This can
> happen in different situations, when sysfs attributes are accessed
> (networking daemon, configuration, monitoring) while operations under
> rtnl are performed (veth creation, driver configuration, etc). A few
> improvements can be done in userspace to ease things, like using the
> netlink interface instead, or polling less (or more selectively) the
> attributes; but in the end the root cause is always there and this keeps
> happening from time to time.
> 
> That initial effort however wasn't successful, although I think there
> was an interest, mostly because we found technical flaws and didn't find
> a working solution at the time. Some time later, we gave it a new try
> and found something more promising, but the patches fell off my radar. I
> recently had another look at this series, made more tests and cleaned it
> up.
> 
> The technical aspect is described in patch 1 directly in the code
> comments, with an additional important comment in patch 3. This was
> mostly tested by stress-testing net sysfs attributes (read/write ops)
> while adding/removing queues and adding/removing veths, all in parallel.
> 
> All comments are welcomed.

The trylock was introduced to deal with lock inversion.
It is not clear how this more complex solution prevents that.

