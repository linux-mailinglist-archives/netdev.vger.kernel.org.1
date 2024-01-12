Return-Path: <netdev+bounces-63287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8882C23F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A82856DB
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00A6DD09;
	Fri, 12 Jan 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OSzCfJrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7626E2A9
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso48442945ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705071315; x=1705676115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49KxL6Obx5+jxRtv5bJ9JLRo7erEIHPX8hN8OYI8/0k=;
        b=OSzCfJrt9UeBcm9a5Kz8l0yKE095KqvwPg1hyVvIpYJV5OokcINeaLpp9ULHrzdjI/
         SKFaSv64Pa4D1fnNm7jmzA77EiJVeXaFP3KIdCOngyn085KMqz1a4CQ84WTArKROcWt7
         baHOuMMFzFyo9tkhoz2HRI3kB074pahb4sWdx43oH5QFBsunyNObRBUEeMsX4ZfLlmUy
         HDgHLTz9YJgjB7x+Lv4ssqD6WYtn1ob9Lz1tw0heIqeb1RO0fkZu2W7Nzlp3u7SVVbZ4
         lpNydGN8ZASqotqjjCbxwDMu47xUTKzxzyVh++pjkz+D+sWVLZGk5+IOwhNoioZIrJ2n
         GALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071315; x=1705676115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49KxL6Obx5+jxRtv5bJ9JLRo7erEIHPX8hN8OYI8/0k=;
        b=M0JcqJDszlMRlhYxQWI5frCG32UWoaGHP721uJVh8t0T+pvWrPLAPLpJ5tiklOUVUN
         BwaHDHz8CUk+BMJkVzjziTGPPn7V/ogdSMnAlt+R9dMi6/VP9SjCRAtxk2IXwA+lEPp/
         TGIv/lNZDIiUNLEPb4EqSuQAjH0uqV8qnNbwZBIqLgG3ZiKqRTkqPSUhJ78V6rKI2LDX
         6NifNKp72O5UGdo73zqPmCPsTAQFbn7T8Yq1k3CGrQV3ksvtUJjiHWQ2emAz8ISM4Waq
         fR6ovQHY3mKKTbOJC+73PWJG4cbPalfkvi/EGHBVCJ3IMUnDcjj1bBq0Rm/M7xdAQXQg
         j45Q==
X-Gm-Message-State: AOJu0YxqR3uFK9D+dKh6DdpXAxkkCbHGbQZV3ksg2hRJEZzy+Zy4o7or
	v/BcfFRWLecuFL70qdUSohs6zCUD1Lhb
X-Google-Smtp-Source: AGHT+IHZKnnT/4gZuz0ZPHziG1wdRqFGvA/Naq4+URBSai6ioyghwD75k2JUj5gdewcW5qwpLEvFaQ==
X-Received: by 2002:a17:90b:3782:b0:28d:7674:bdff with SMTP id mz2-20020a17090b378200b0028d7674bdffmr3476320pjb.34.1705071315423;
        Fri, 12 Jan 2024 06:55:15 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:d725:4798:351e:83cf:27f2? ([2804:7f1:e2c0:d725:4798:351e:83cf:27f2])
        by smtp.gmail.com with ESMTPSA id sl3-20020a17090b2e0300b0028b6759d8c1sm4243921pjb.29.2024.01.12.06.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 06:55:15 -0800 (PST)
Message-ID: <a4b8480e-af22-4e6a-b1db-ac95ba9d9b31@mojatatu.com>
Date: Fri, 12 Jan 2024 11:55:11 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net] net: sched: track device in tcf_block_get/put_ext()
 only for clsact binder types
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pctammela@mojatatu.com, idosch@idosch.org, mleitner@redhat.com,
 vladbu@nvidia.com, paulb@nvidia.com
References: <20240112113930.1647666-1-jiri@resnulli.us>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240112113930.1647666-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> From: Jiri Pirko <jiri@nvidia.com>
> 
> Clsact/ingress qdisc is not the only one using shared block,
> red is also using it. The device tracking was originally introduced
> by commit 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
> sched: move block device tracking into tcf_block_get/put_ext()")
> mistakenly enabled that for red as well.
> 
> Fix that by adding a check for the binder type being clsact when adding
> device to the block->ports xarray.
> 
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Closes: https://lore.kernel.org/all/ZZ6JE0odnu1lLPtu@shredder/
> Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Tested-by: Victor Nogueira <victor@mojatatu.com>

