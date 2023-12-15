Return-Path: <netdev+bounces-57848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13B814512
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62BC1F22E86
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CE18B0E;
	Fri, 15 Dec 2023 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d5ffZ9qV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8D19454
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so564301a12.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702634621; x=1703239421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56mVcOurV+ZpI4KiJDKVHnndwqaB73yRAHtAX8Z6DO8=;
        b=d5ffZ9qV9EMOyLJgkG4b/aQwtnQ5HiuydgMFHE6iR4Qkla7Z6qm8rMf8JZRtnKeOjM
         3SCLiyNMtbPMa/PPDoVKs9mlZ6Yinw0dmlL/MAc0D2g3uEh2oupdVaaTBqQhF9I3Yfbc
         PMdevjgNdHAGdZrD2XBe6hXLjwc8XGi0wbz4PXT7ST5m0wQ+bF1yOtZ9eTk6oq35qEMV
         Wb1qr01Z9FkWsP5f+NlNeYQ+j623yArCJ1ZYLGEeGv0RykKQcUzuSgJ+70dgTRwG+1e0
         VoiENUtTobIYCtvboHD4kMeK8FmnbZSEjLTgjC8CggeT3hCGKY1WJ1RaYUYHvXmdZfNJ
         27iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702634621; x=1703239421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56mVcOurV+ZpI4KiJDKVHnndwqaB73yRAHtAX8Z6DO8=;
        b=cvrLcTFkoM2RmaX+iPue2fTr+hYMUI6OjJNiFpTZR5QhB9MLpDrAozA7SbaRIE4Emr
         vxGGrzLo2m0iD5RJqS1A8VJ37b+idQnZtD1+n69uRypmc7nZyIXbpHQD4i/Dtr5EFnWI
         MaxE9e6uytfBoNjIDuoUqG/giiCDmlsV0GHoeoj1goY+4X/8v4Msj822VsOKj13aKgx2
         78KwrtCa2bEJroJtJpHODtbaJqK1wwLg/5wnGuDipL+kgeP/AQyoDm8OT0PjUJl5ocJg
         jDPy4E4SMq5uK2Bdji0qziBLeb9Y8GDgAfUZOTTOkxNNDF278rPPdjIo0/rnikHonKa8
         CQcw==
X-Gm-Message-State: AOJu0YxJKFWrwsYKkaMJX5zeA+j/d1JBd6TlLOdM1Elmimg2Phj1M8Mw
	TsTr2rG2AHGKUc5ImE78OWtWSA==
X-Google-Smtp-Source: AGHT+IFakk7HKd1/w8eY7FbamYh2nhmDM6EiZxY4UHt3ysPT6LjF98hN7F7qLS1EFjn3+x7lPOFj3g==
X-Received: by 2002:a50:8d8a:0:b0:54c:e28c:2086 with SMTP id r10-20020a508d8a000000b0054ce28c2086mr6312806edh.38.1702634621057;
        Fri, 15 Dec 2023 02:03:41 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id dg12-20020a0564021d0c00b0054c9635b24esm7616141edb.21.2023.12.15.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:03:40 -0800 (PST)
Date: Fri, 15 Dec 2023 11:03:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXwkezPrcHlFdiS9@nanopsycho>
References: <20231214181549.1270696-1-jiri@resnulli.us>
 <20231214181549.1270696-6-jiri@resnulli.us>
 <20231214192358.1b150fda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214192358.1b150fda@kernel.org>

Fri, Dec 15, 2023 at 04:23:58AM CET, kuba@kernel.org wrote:
>On Thu, 14 Dec 2023 19:15:45 +0100 Jiri Pirko wrote:
>> - converted family->sock_priv_list to family->sock_privs xarray
>>   and use it to store the per-socket privs, use sock pointer as
>>   an xarrar index. This made the code much simpler
>
>Nice! 
>
>FWIW I think I remember Willy saying that storing pointers in xarray is
>comparatively inefficient / slow, but we can cross that bridge later.

I see an alternative in using rhashtable with sk pointer as a key. Not
sure if it is more efficient. Any other ideas?

But as you say, this can be addressed as a follow-up.


>
>> +void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> +{
>> +	if (WARN_ON_ONCE(!family->sock_privs))
>> +		return NULL;
>> +	return xa_load(family->sock_privs, (unsigned long) sk);
>> +}
>> +
>> +/**
>> + * genl_sk_priv_get - Get family private pointer for socket
>> + *
>> + * @family: family
>> + * @sk: socket
>> + *
>> + * Lookup a private memory for a Generic netlink family and specified socket.
>> + * Allocate the private memory in case it was not already done.
>> + *
>> + * Return: valid pointer on success, otherwise negative error value
>> + * encoded by ERR_PTR().
>
>nit: probably better if __genl_sk_priv_get() returned an error pointer
>     if family is broken, save ourselves the bot-generated "fixes"..

Okay, will fix and send v8 (hopefully the last one, uff).


>
>> + */
>> +void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
>> +{
>> +	void *priv, *old_priv;
>> +
>> +	priv = __genl_sk_priv_get(family, sk);
>> +	if (priv)
>> +		return priv;
>

