Return-Path: <netdev+bounces-58206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A7815881
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DF71F24DD9
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0614010;
	Sat, 16 Dec 2023 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sKOuRxDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FF1400F
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3360ae2392eso1101144f8f.2
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702718279; x=1703323079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o50P5yKHSjVChN9ejG5Od5CmULBrsEn7Cc0EfR/tZlk=;
        b=sKOuRxDmcUJ81EY5G4Ezu8h5hwJONVhHSBRy8zHqKPSoPlXuxbyWYemUVkVlWKhJUw
         hHXqeI8RVv01mJAsKqE6EgNNf6EbfLycd0PYcZURbM+ndRUSsZUkA2UYxt/rK28L7/48
         a2vCna9CAyKw3n11qZ5H9pbt0flGyKdN3c89nt9gwhYjb+L9O10DoW28hjb2G3UiiSuz
         W+hzr3tS1aL4GIKazwm+vhhzPXsGhyUYCckUNNJCOOY51gwV/ah+lnQjN+OEbbRKrC4G
         +gwJqNB5cqHkPW7pCPb83W39fNJLnSu0vwP2/WWMDD1SY9HNPAGEmqi87S9sg7IvAjg3
         fmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702718279; x=1703323079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o50P5yKHSjVChN9ejG5Od5CmULBrsEn7Cc0EfR/tZlk=;
        b=J4YwsfwucfaMBKKz/wqSAEOujDnKsWjGueJAHwWUyZQrt87EIvwlgX9LYcrxjMn3Av
         iUFTrLbuqkPdiAxnAJwpiafgXmXk5mXulOIDBbdnZ57fUCfpWJhvi4wg5int+jKfyIbY
         tsDWORUNKbNLC7LrGA2Wjd05IPnB27KVGihhjdBuwz0Ym24KyZM35JtgroJweZ8vdlHZ
         5xO14oEHt5UUxDVXySt4kXCt87ewA95Fo1EMiMLv+dgcdKknCdz7K0ZEHYOm+etZl6qP
         ebHK6MH5o2w0bx9cSQE5lsA71v/gm+OC1ZqqlXTtWJkp81u+X1g6dhIZcbO4UFODhAg8
         iXqg==
X-Gm-Message-State: AOJu0YziffkDajqz0D5VOTcRaTmzRl7jwsFKq5GByVtRD9ML1jj+SV46
	O6hdMMgApc4pQZMPT/2Xq6Q8jA==
X-Google-Smtp-Source: AGHT+IGPs41WHz67N/vUQcaTnf3l51WIWY4MRNjzcBUSe7oOoN1bWFAn59rBHxECUr6NlClux44uXQ==
X-Received: by 2002:a05:600c:4f93:b0:40c:6b55:2a0e with SMTP id n19-20020a05600c4f9300b0040c6b552a0emr1145002wmq.75.1702718279165;
        Sat, 16 Dec 2023 01:17:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004064e3b94afsm35664685wmp.4.2023.12.16.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 01:17:57 -0800 (PST)
Date: Sat, 16 Dec 2023 10:17:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZX1rRL5BrkpcTXVq@nanopsycho>
References: <20231214181549.1270696-1-jiri@resnulli.us>
 <20231214181549.1270696-6-jiri@resnulli.us>
 <20231214192358.1b150fda@kernel.org>
 <ZXwnqqsFPDhRUNBy@nanopsycho>
 <20231215174707.6ae0a290@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215174707.6ae0a290@kernel.org>

Sat, Dec 16, 2023 at 02:47:07AM CET, kuba@kernel.org wrote:
>Sorry for the latency...

Np.

>
>On Fri, 15 Dec 2023 11:17:14 +0100 Jiri Pirko wrote:
>> Wait, let me make your suggestion clear. Do you suggest to remove the
>> WARN_ON_ONCE from __genl_sk_priv_get() as well?
>> 
>> To put it in code:
>> void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> {
>> 	if (WARN_ON_ONCE(!family->sock_privs))
>> 		return ERR_PTR(-EINVAL);
>> 	return xa_load(family->sock_privs, (unsigned long) sk);
>> }
>
>I meant this, although no strong feelings.

Got it. Will send v8. Hopefully that will be the last.

Thanks!

>
>> OR:
>> void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> {
>> 	if (!family->sock_privs)
>> 		return ERR_PTR(-EINVAL);
>> 	return xa_load(family->sock_privs, (unsigned long) sk);
>> }
>> ?

