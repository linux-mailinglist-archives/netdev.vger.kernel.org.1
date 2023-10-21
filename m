Return-Path: <netdev+bounces-43205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175547D1B74
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFA21F21B78
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C662C2F9;
	Sat, 21 Oct 2023 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NjtO508P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A56AC0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:02:02 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EEDD57
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:02:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083740f92dso12406475e9.3
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697871720; x=1698476520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9u7EMAUYRIEUmAq057JtBR45mMU0yVGpEbtTL4706A=;
        b=NjtO508PCvoJUCWZMfBLWrc2jyJgnyX/BBujvHXywU3GuS8+dsLEkHvYMFYnVoB0dS
         1aeDOqFFXVZ8mRFzj+AwSW3S9mRVtdTCCvoWb4cEPpAK+xNX8CbRehwt29g0iFesAtYQ
         CxkfyviBSuI5qJtzd0E1z5TF1HShXepenQ5wdPTI5FDHUjUQ4EIju6aIUSsPIwfo3kZj
         SznphO1MDAUUZJ4v9ADdlV4qzk1IZZeLlurWuuTnBNmfNysM0ohk72G0hkgszWNQnL+7
         mFCz1ReeA5+Oihk+3u98LJo35eVOUwuXYWuYkM938RxEPAEZDYjBU8llaX0lKgaFbOew
         JsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697871720; x=1698476520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9u7EMAUYRIEUmAq057JtBR45mMU0yVGpEbtTL4706A=;
        b=mudT0ESCGuRR4Lca735E/S55iVNV9xXHMhi3L2Fvqs0apC7PQO8nfQRSR6go56rYkm
         e9YiqaEDUf/D121mrUux+I4emA6dE4gvuejDTy4sVVw1/uZpsxTr7wM8+HpX8qWV/iM6
         hDTzx/d1UlMbYIzybl7+ylnOpHKBIQMvjPix0XzUOwOY98QDfeVSqQrf7bvdXTyUSQc2
         fyavXvjayJl0kHu/hnPjuH/dd6924Bnd50gR45ZC1MMxi3xFs+g+qtEVt+3CBNRHaVgp
         6gWla5L8gJc59v/muRctLi39J7qX3QWOtYLdumfw5RF959hRRApHLMrODr1w1e7M427R
         Y6Nw==
X-Gm-Message-State: AOJu0YyDX8l2Ac4tFk+zDY6BTLn1S7YrstUUTA5wjZd8JS7FP4x2LrhP
	xvyjjM/MjVQoghAAf3k2M8vtTQ==
X-Google-Smtp-Source: AGHT+IEJv2MxnU/1V2gO67OA7Eg28cF9i7f3+zcq5YVmAm4RxbomeSSZEQyC4/zxUdpcst1t5yEfIw==
X-Received: by 2002:a5d:58ee:0:b0:32d:9850:9e01 with SMTP id f14-20020a5d58ee000000b0032d98509e01mr2971183wrd.61.1697871719829;
        Sat, 21 Oct 2023 00:01:59 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g18-20020adfa492000000b003232380ffd5sm3127479wrb.106.2023.10.21.00.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:01:59 -0700 (PDT)
Date: Sat, 21 Oct 2023 09:01:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 2/6] net: make dev_alloc_name() call
 dev_prep_valid_name()
Message-ID: <ZTN3ZpsLdApUgc9w@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-3-kuba@kernel.org>
 <ZTJVeUJy9WhOgiAU@nanopsycho>
 <20231020120149.3a569db7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020120149.3a569db7@kernel.org>

Fri, Oct 20, 2023 at 09:01:49PM CEST, kuba@kernel.org wrote:
>On Fri, 20 Oct 2023 12:24:57 +0200 Jiri Pirko wrote:
>> > static int dev_get_valid_name(struct net *net, struct net_device *dev,
>> > 			      const char *name)
>> > {
>> >-	return dev_prep_valid_name(net, dev, name, dev->name);
>> >+	int ret;
>> >+
>> >+	ret = dev_prep_valid_name(net, dev, name, dev->name, EEXIST);
>> >+	return ret < 0 ? ret : 0;  
>> 
>> Why can't you just return dev_prep_valid_name() ?
>> 
>> No caller seems to care about ret > 0
>
>AFACT dev_change_name() has some weird code that ends up return 
>the value all the way to the ioctl and user space. Note that it
>has both err and ret variables :S

Ah, blah. Guess we are stick to this crap :/

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


