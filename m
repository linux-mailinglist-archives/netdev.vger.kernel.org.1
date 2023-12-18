Return-Path: <netdev+bounces-58572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B58171F5
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242441F26353
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64784239B;
	Mon, 18 Dec 2023 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wp0fuwZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895C37884
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2356bb40e3so88366066b.1
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 06:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702908117; x=1703512917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rWel21zj5Tsq8D2eZnmJZ1mwVfJEGiP5VX1zi9fGs8U=;
        b=Wp0fuwZODGdw4NNkixL1ta4U4GopEq9nLdAvuUfmvEENMDXJDXysxcgwpt1921SIVy
         YwPxzDw2e5U+vvNo0jy1cVE3Kexu0U+O8CMPwN63GoNe305mhIaqReMY9ay44LgfvfkI
         Nlg9O1HYhPsvVHH6I8QNPDARAY3d2eHCfCyiS2OKDw1lZ7TLMvquuupdatLLBpgc0msC
         upIdEwzdbKr/OFbS+6pPdShu3/Bs68Nh++WyWaWI8XvzaDy9ut6a2Ku7C6yJqMBbAzIf
         EVtr7jzesGLFk6gSUVApU5VN15500AIcA5a2xNAq5UxTHtp1qjkL3NNcC1ufldbyFJjr
         HPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908117; x=1703512917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWel21zj5Tsq8D2eZnmJZ1mwVfJEGiP5VX1zi9fGs8U=;
        b=ZKVyGa4MvRE27lPoqiNxho9Chha8mwlapJ1DvsqGH9NkwJGnFb0j0mus8bvaKO/yAd
         Gk3M7KvlGLHOft4Dg0U8HW0uEAcbq5uHoN6V5pEy3eTBIkZ0OEdTvfbY6pp0VTNQcOW7
         KPhNE1NMGPM2PjmHsChWezHDptmbrZG9LpM02Q4Svup4qTf9hArTGMhddHQsGBX+HIHs
         S+BFN3uiw/+14F3DQG8Wt5l8L8OkopP/0p2KgJcy2nDej9MzjaeZm+WCo/awttpRoAhl
         pONZDqCqePoboCJ065KYUZa/r7NQQDvOL471BK+MHo9lHhCTZSY+z9qcYANQA5HY0Y5X
         lotg==
X-Gm-Message-State: AOJu0YzIpjm13hA3il0J4RNRQKIS0IZlmqOYEQsenczdua5GkqfD41HR
	7uZ5tz/NOwq3/bH1luGcw/rZxg==
X-Google-Smtp-Source: AGHT+IEZZEQN38LLUK5Kss/UNyoJ12Erq/Q8DF3alUBf5T7nJ8F8q+/My7SW7GbKxNyTKX5I2X+ZBw==
X-Received: by 2002:a17:906:5205:b0:a23:58e5:da9e with SMTP id g5-20020a170906520500b00a2358e5da9emr739245ejm.36.1702908117323;
        Mon, 18 Dec 2023 06:01:57 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id cx7-20020a170907168700b009fc576e26e6sm14061893ejd.80.2023.12.18.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:01:56 -0800 (PST)
Date: Mon, 18 Dec 2023 15:01:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v8 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZYBQ0zcqufs-s6hk@nanopsycho>
References: <20231216123001.1293639-1-jiri@resnulli.us>
 <20231216123001.1293639-6-jiri@resnulli.us>
 <ZYAmdSSos_lIjAxH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYAmdSSos_lIjAxH@smile.fi.intel.com>

Mon, Dec 18, 2023 at 12:01:09PM CET, andriy.shevchenko@linux.intel.com wrote:
>On Sat, Dec 16, 2023 at 01:29:57PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce an xarray for Generic netlink family to store per-socket
>> private. Initialize this xarray only if family uses per-socket privs.
>> 
>> Introduce genl_sk_priv_get() to get the socket priv pointer for a family
>> and initialize it in case it does not exist.
>> Introduce __genl_sk_priv_get() to obtain socket priv pointer for a
>> family under RCU read lock.
>> 
>> Allow family to specify the priv size, init() and destroy() callbacks.
>
>...
>
>> +	void			(*sock_priv_init)(void *priv);
>
>Can in some cases init fail? Shouldn't we allow to propagate the error code
>and fail the flow?

Currently not needed. Easy to add when (if ever) this is going to be
needed.

>
>> +	void			(*sock_priv_destroy)(void *priv);
>
>...
>
>P.S> I'm fine with either, just consider above as a material to think about.

I always do consider these :)


>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

