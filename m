Return-Path: <netdev+bounces-40579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B317C7B51
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CA81C20B13
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1F81D;
	Fri, 13 Oct 2023 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wctTAqWM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D081C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:45:12 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0DCC0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:45:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690fe1d9ba1so329646b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697161510; x=1697766310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkKDwESUMv6DmJniI4kRJ0Fze3BlCpWsKbtTeuEzRoQ=;
        b=wctTAqWM+C+AavijPGVNcXf4bwP+E/t8KAOEKi+zZG4WomkiYnQOuVGojNwl+bo1Fy
         kfVb9Y0l2NAq0k2sjYQSOnJdfEbR134ajyLXqORuY+Qph83AwRWE/6T3z7aTb1ubtMtQ
         xKOQ2jc67GIJXMkuJliRocizaVmoAx2MyjAfUzU4XvUrgvEAaSHQ/2qOqXxJEJF+abvJ
         sfERUcLnEhb6LnDv0ya5fLIlGmUwirNgqnIlxI7WdWz5s5xnwAmlnkvHmHGb4SqYVjul
         y5u9bI9EGvU8QWeR6dqxsq6h04/a32jq64ZNoIeYqn9uj1ezriMuQoRbHEs3K8KIZNSE
         pbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697161510; x=1697766310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkKDwESUMv6DmJniI4kRJ0Fze3BlCpWsKbtTeuEzRoQ=;
        b=nu4aEwy+4eU8xeuls3FBoDyzgULFavhakaY9mN1iq9U0jUWA4JNUmGV9bZ/3aRw2DI
         dNA8xqvkPzUPA0aHunFmPS63W1tN13DTN9Bhdp+B3mb+wovhMfrLQemcXaEJyACEewZW
         o8XhihIGiLv2ZPn8lI5ocC9L5NiL5F0wJRMEyZ1pnsuukrE1Gr93ZpySgOyhwsroS+Ss
         203pmjDdKxc8lw+koj+XeXGJxWjG66xnbnGFiFNGf6peG4HOigsBHHCtxMppVMyPJW8Q
         bF2zQtl1o/dYBzpvcBwCJxoA3nU6R4md26lDmhql3GjO/rAtvCEk8wHRzOmRXkEFOrmu
         +1uQ==
X-Gm-Message-State: AOJu0YzCkfUPcJBeY7qtOZa2tjYF8tiAwGMWsIQNWEMj7ASqedOh7DVP
	erYe0DTvEbyJB1KiA9G1AMAYYg==
X-Google-Smtp-Source: AGHT+IFOeU/L1UU0SiBejqeHPkF2yLffG9fB6o7ii0U1VZbx4ZnCvJrB7MjXM1YaKAbTSIdFVKU0ZQ==
X-Received: by 2002:a05:6a20:7da2:b0:15d:6fd3:8e74 with SMTP id v34-20020a056a207da200b0015d6fd38e74mr31715422pzj.3.1697161509881;
        Thu, 12 Oct 2023 18:45:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm2659672plk.2.2023.10.12.18.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 18:45:09 -0700 (PDT)
Message-ID: <f39ef992-4789-4c30-92ef-e3114a31d5c7@kernel.dk>
Date: Thu, 12 Oct 2023 19:45:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with io_uring splice and KTLS
Content-Language: en-US
To: Sascha Hauer <sha@pengutronix.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20231010141932.GD3114228@pengutronix.de>
 <d729781a-3d12-423b-973e-c16fdbcbb60b@kernel.dk>
 <20231012133407.GA3359458@pengutronix.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231012133407.GA3359458@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 7:34 AM, Sascha Hauer wrote:
> In case you don't have encryption hardware you can create an
> asynchronous encryption module using cryptd. Compile a kernel with
> CONFIG_CRYPTO_USER_API_AEAD and CONFIG_CRYPTO_CRYPTD and start the
> webserver with the '-c' option. /proc/crypto should then contain an
> entry with:
> 
>  name         : gcm(aes)
>  driver       : cryptd(gcm_base(ctr(aes-generic),ghash-generic))
>  module       : kernel
>  priority     : 150

I did a bit of prep work to ensure I had everything working for when
there's time to dive into it, but starting it with -c doesn't register
this entry. Turns out the bind() in there returns -1/ENOENT. For the
life of me I can't figure out what I'm missing. I tried this with both
arm64 and x86-64. On the latter there's some native AES that is higher
priority, but I added a small hack in cryptd to ensure it's the highest
one. But I don't even get that far...

-- 
Jens Axboe


