Return-Path: <netdev+bounces-61461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286F823E72
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338281F24E11
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBE200D8;
	Thu,  4 Jan 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lLx5a4iS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCED2030A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d858c56cbso3092195e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704359930; x=1704964730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xzvXsqtXoBqLLUQ409l/3T3uMW6S5JZhprzEseQcfw=;
        b=lLx5a4iS3hAE85+I70p6p5gk7yS6QH+QbV/2vS7VyJTBftqQdQnqQUXtUAPXOhXCnt
         EpncXdfA8LI21wLqmDq/u2LmFCifDkadJ/ueaGDBvM34AT5r3pGVZAjXdT+qP9gyCb3L
         yfqwrmdC8MGXHoy3D0oyZ8+HaE55PUVGw8pSgxiV7gJgPzs7JEyqK38XneOpV1AribnQ
         KSBxXrprUVrIWr8BN1V0q3cCbnSFJBkMwtx1ghdWyCyvoQulIUyvvqslAb8QY1PWBht8
         gPeaQ/pec+qnvFjxC6aLPnsbZPR5g/a5sD5Viljss5OCkU3oHzaNYxGetHCLH3xd7Qoi
         dm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359930; x=1704964730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xzvXsqtXoBqLLUQ409l/3T3uMW6S5JZhprzEseQcfw=;
        b=FLtuUfKSBsgS9m2U0GGc7d3IE1VbRxaVUK/YO8+Z5jEYfUYXagstu6e/+lkVy3xnn/
         gnFd0fm01cQYKFl3KrikwTxQuzCgZSmrWyc4cRZNjLc+k5vgid1eziYiEgaSrRZWCV3M
         SJm0zMC5kDal8nBvKr2GXJd91SBvJEFxlCcIcFSeSINX+vMngTXwuZO3JB+WyUJVoPNT
         IxU6QWIlOvIiktNM5ECDE8cBD3BGKYgwo2ZRt9hq6DyVo+pOuGaAU0dZyOSl+6QOXy7J
         SzbQeTAAFwxqED7d8mlAnXn4hC799/dwbWNauxDR6RiGdO+nC80XwCESdCKvg5niUJgj
         cHtQ==
X-Gm-Message-State: AOJu0YxhJT6N9/aNlsS9DqdP52ihyxpMETJo+ik442sH3zhafdeF6PRg
	QZgOru5oTTG0TCflZ69hkaJGVao7top0ZHZGhMeFuuVwMJIl8Q==
X-Google-Smtp-Source: AGHT+IEFcHLmfME55S/kPYC32Ri1c9+9SYm/Itv112K+bQAbCgt3+FMzBSM8OWJ59ZQxJsidCVscoA==
X-Received: by 2002:a05:600c:c05:b0:40d:5ab8:5758 with SMTP id fm5-20020a05600c0c0500b0040d5ab85758mr197706wmb.186.1704359930143;
        Thu, 04 Jan 2024 01:18:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0040c3dcc36e6sm5059495wmq.47.2024.01.04.01.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:18:49 -0800 (PST)
Date: Thu, 4 Jan 2024 10:18:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kui-Feng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org,
	victor@mojatatu.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	pctammela@mojatatu.com, "David S. Miller" <davem@davemloft.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: net/sched - kernel crashes when replacing a qdisc node.
Message-ID: <ZZZ3-DrwQxChByGC@nanopsycho>
References: <ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com>
 <20240103180426.2db116ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103180426.2db116ea@kernel.org>

Thu, Jan 04, 2024 at 03:04:26AM CET, kuba@kernel.org wrote:
>On Wed, 3 Jan 2024 17:41:54 -0800 Kui-Feng Lee wrote:
>> The kernel crashes when running selftests/bpf/prog_tests/lwt_reroute.c. 
>> We got the error message at end of this post.
>> 
>> It happens when lwt_reroute.c running the shell command
>> 
>>    tc qdisc replace dev tun0 root fq limit 5 flow_limit 5
>> 
>> The kernel crashes at the line
>> 
>>    block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
>
>This is the same as
>https://lore.kernel.org/all/20231231172320.245375-1-victor@mojatatu.com/#r
>right?

Yes.

