Return-Path: <netdev+bounces-44384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6A07D7C11
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD32B212F5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 05:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F6C134;
	Thu, 26 Oct 2023 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fga9VmEi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A1C14E
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:12:10 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2608410C9
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:12:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5071165d5so648891fa.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698297119; x=1698901919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d20Gh1Exh5bv9OwkK+0lMw7nEOWG7pHF6U/RfMyi/xg=;
        b=Fga9VmEiQ2ckfdQ+JJLZrvPK7Hm3SWrW+i0xEGT5t6D+ed3ZZLaq1EvApQsY8IdMfF
         UHwoaY1Yjt4qmUJU7JR02dX4Fbm3zOiUeAoIzzAvnN0Vz7pei4iccTnkuXgI/p8TtNMy
         x4R3R6LuNWRwlEcAb6ZVH27PkFw6MVLX2fJiqYmtnmt6W6j/LSTvOOOg80ff83fILjDA
         iuXzpOkURyAnaIBTXm5TPU9ghZrPE+yrFDeVM12N2e5MYPLPZtp+QSTaTeMVP8r2m/7p
         F8M2FEG+jUE3NpuP4tGAR2fT/HFnGLrTdHL0WIsBcgwpU7eNHK7mhEvd4DRC9NfGrDud
         3a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698297119; x=1698901919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d20Gh1Exh5bv9OwkK+0lMw7nEOWG7pHF6U/RfMyi/xg=;
        b=tuVx8gFFY9SelJTj/ybRbuGJqFJO/zU+QjDu8HhTdSet5Qs7un4AfxaoDQj1HvRQzD
         Z8TW1c6etwIdtiCvwf72qrZHdl7rmlRuQaVXHJILEE7KgbZVT6sd0FoPAJtSU0uKCE6a
         BW5cUEKbkoLC9zTNGTxOT9pUOlVCp1DTt30/ebd5XCf3SV6HcRbsUZBwUuZmgJzsEZUv
         pIFk38/XI9/p7R9Afsc7cKUApTG2rNx8KaQL4rtOBrhDiMxEX/qgsu6ScXoI4UeEO277
         mrN5UgglM4mQvxUfx/KobXHF52egtGS1OUHJKJkCcRX9t8rhO9jHRNbVFeN7R4OqMTve
         wd7A==
X-Gm-Message-State: AOJu0YybdN9+/u0J0fepr10IorHDt19rJT4izBPUyU3WIYdo5daEd9DN
	SWFcAePWFD0krznU1YrWt9VhrA==
X-Google-Smtp-Source: AGHT+IH8piZeWgRJm4y/kUeFvF4KlExbc0JdL1mZZnKtqoN918gz2utYpRh5Ypdp/L74NPptwxas4w==
X-Received: by 2002:a19:914a:0:b0:507:9b4a:21c0 with SMTP id y10-20020a19914a000000b005079b4a21c0mr11587032lfj.42.1698297119130;
        Wed, 25 Oct 2023 22:11:59 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id y16-20020a056402135000b005333922efb0sm10604849edw.78.2023.10.25.22.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:11:58 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:11:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: ipv6/addrconf: clamp preferred_lft
 to the maximum allowed
Message-ID: <ZTn1EKPzt4NaXN6y@nanopsycho>
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
 <20231024212312.299370-2-alexhenrie24@gmail.com>
 <ZTkIwIFKXe9aEkY4@nanopsycho>
 <CAMMLpeRcM2iv2oUDk4=zPehS_+qPh3eD1aa1adST300N_cHS5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMMLpeRcM2iv2oUDk4=zPehS_+qPh3eD1aa1adST300N_cHS5A@mail.gmail.com>

Wed, Oct 25, 2023 at 06:28:00PM CEST, alexhenrie24@gmail.com wrote:
>On Wed, Oct 25, 2023 at 6:23 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Oct 24, 2023 at 11:23:07PM CEST, alexhenrie24@gmail.com wrote:
>> >Without this patch, there is nothing to stop the preferred lifetime of a
>> >temporary address from being greater than its valid lifetime. If that
>> >was the case, the valid lifetime was effectively ignored.
>> >
>>
>> Sounds like a bugfix, correct? In that case, could you please
>> provide a proper Fixes tag and target -net tree?
>
>Paolo requested no Fixes tag, and Jakub seemed to agree:
>
>https://lore.kernel.org/all/60d9d5f57fdb55a27748996d807712c680c4e7f9.camel@redhat.com/

Okay, makes sense.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

