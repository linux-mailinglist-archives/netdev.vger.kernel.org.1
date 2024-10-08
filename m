Return-Path: <netdev+bounces-133060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178AC994644
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2AB2812F4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB11CF2AD;
	Tue,  8 Oct 2024 11:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF51CDA26;
	Tue,  8 Oct 2024 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385793; cv=none; b=Ou3L/qG6wMnTe12h+evwUTkQ1jHD+Qu89wc3tHnAhvCvVi5iYi6k9dsCPhTbq03BBRagC94cFrEHB1AwNJ8BflknbRONXIbIOzxbBktt1wDn4y2gMOeTdJBGuEetv8DoFBZHkwJ1tbtetmOXdt/Io5P4r4GVnrpBVy6Y3IZ6PfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385793; c=relaxed/simple;
	bh=cZFvuRMU3bKhwHgatTTNcVdRWoUCtrnMkioTuWPZZTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4Ytl6A8fOO+yNmXdscNoR8b3rD0o/mlJZ4b5ZKyZOjxMZDAruUcr4PPcpQMudnM0wra7RNdCftXSG5CCQvnjG9ZpzKq/iLh3YwekmpzR9L8jr2b+BYZFaaTyWXxNdrxtbIABTPe5M0PRqlGR9VeqGp/KXSd6lKwlTmbIBmBlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so8084868a12.3;
        Tue, 08 Oct 2024 04:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728385790; x=1728990590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk2LPVRWwfVo1ytfLR9/NFnv/777FQJZyCgjBWZzL5I=;
        b=CkMpK9dLiAtR2SOUDPyvDH+GXgkm6HZL6W0gjckot08i04qDl6cq6llYGNTkVtKIJV
         97HwGfyMGWQn9hLAmV9U0Qr0VwkHmUYYlSi/P1Qn4NSFXf6ZrS8GUyuG75t3RolJK6mq
         BnDf/6Z6pXF6TFkQN5A++tlO20YUgRFVdrz5QE5td8nCFax7ygmpcpVQWf5p+OQiBxZs
         n08P95u9eVVP5RqK9B6Ea2CIb1yxmkBIWiuYOzDSlnyrWAsv/2OaozA4VxJTAUfNlye/
         z1qQCr4IZOc4mKIm2is58G0CSl4ta33oYBcPp266fwtZkgjO/uVH+h/bmnINPG1Iu5SI
         XhPw==
X-Forwarded-Encrypted: i=1; AJvYcCUvqWFcf6SizCijxoqCipdiUGHZbPSJVjEmR6JGsDeXTLAOPsB1wI3UTdKJctRsqanAAXNr2O73BygajlD9@vger.kernel.org, AJvYcCXT07J6YjvJeENjIVXzCdP+A803ZnpCjV/pWK2YuOAzvL9iKw1dH0oxZ7tz0vbrX5lkL4Esb1tP6fE=@vger.kernel.org, AJvYcCXUbasb5TQEkyxYbE4NtKYR0zVpXB2ytkNJL27hPYfNRTJcEnjqHUcMDCea96ZICtgXRblySQf1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PoXZOUSkvGLMU0qPqSfmTvTmTCcEMBzI85A7oRyZnO3wTg/T
	pqy+7HQTeNl/DyLjTFBc1bZIeIjaVpi0icwW6SX3oeyKCsn/LU9T
X-Google-Smtp-Source: AGHT+IErQX12w3ULwnlQwShHk0CaL/kZSZSk50Btw/QX2XVgeqCcFcnsHrHO0wzVw3KJcgIGpFT2CQ==
X-Received: by 2002:a17:907:7f87:b0:a99:5b55:1a75 with SMTP id a640c23a62f3a-a995b552229mr446151566b.29.1728385789601;
        Tue, 08 Oct 2024 04:09:49 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::7:e36b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9957bdeff6sm232511666b.159.2024.10.08.04.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 04:09:49 -0700 (PDT)
Date: Tue, 8 Oct 2024 12:09:46 +0100
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Jonathan Corbet <corbet@lwn.net>, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <ZwUDnGlhB09Widej@gmail.com>
References: <20241002113316.2527669-1-leitao@debian.org>
 <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
 <20241007-flat-steel-cuscus-9bffda@leitao>
 <9386a9fc-a8b5-41fc-9f92-f621e56a918d@gmail.com>
 <20241007-phenomenal-literate-hog-619ad0@leitao>
 <058e38c4-ead9-42bf-8a11-a97d0ead35fb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <058e38c4-ead9-42bf-8a11-a97d0ead35fb@gmail.com>

On Mon, Oct 07, 2024 at 07:00:28PM +0100, Pavel Begunkov wrote:
> On 10/7/24 18:09, Breno Leitao wrote:
> > Hello Pavel,
> > 
> > On Mon, Oct 07, 2024 at 05:48:39PM +0100, Pavel Begunkov wrote:
> > > On 10/7/24 17:20, Breno Leitao wrote:
> > > > On Sat, Oct 05, 2024 at 01:38:59PM +0900, Akinobu Mita wrote:
> > > > > 2024年10月2日(水) 20:37 Breno Leitao <leitao@debian.org>:
> > > > > > 
> > > > > > Introduce a fault injection mechanism to force skb reallocation. The
> > > > > > primary goal is to catch bugs related to pointer invalidation after
> > > > > > potential skb reallocation.
> > > > > > 
> > > > > > The fault injection mechanism aims to identify scenarios where callers
> > > > > > retain pointers to various headers in the skb but fail to reload these
> > > > > > pointers after calling a function that may reallocate the data. This
> > > > > > type of bug can lead to memory corruption or crashes if the old,
> > > > > > now-invalid pointers are used.
> > > > > > 
> > > > > > By forcing reallocation through fault injection, we can stress-test code
> > > > > > paths and ensure proper pointer management after potential skb
> > > > > > reallocations.
> > > > > > 
> > > > > > Add a hook for fault injection in the following functions:
> > > > > > 
> > > > > >    * pskb_trim_rcsum()
> > > > > >    * pskb_may_pull_reason()
> > > > > >    * pskb_trim()
> > > > > > 
> > > > > > As the other fault injection mechanism, protect it under a debug Kconfig
> > > > > > called CONFIG_FAIL_SKB_FORCE_REALLOC.
> > > > > > 
> > > > > > This patch was *heavily* inspired by Jakub's proposal from:
> > > > > > https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
> > > > > > 
> > > > > > CC: Akinobu Mita <akinobu.mita@gmail.com>
> > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > > 
> > > > > This new addition seems sensible.  It might be more useful to have a filter
> > > > > that allows you to specify things like protocol family.
> > > > 
> > > > I think it might make more sense to be network interface specific. For
> > > > instance, only fault inject in interface `ethx`.
> > > 
> > > Wasn't there some error injection infra that allows to optionally
> > > run bpf? That would cover the filtering problem. ALLOW_ERROR_INJECTION,
> > > maybe?
> > 
> > Isn't ALLOW_ERROR_INJECTION focused on specifying which function could
> > be faulted? I.e, you can mark that function as prone for fail injection?
> > 
> > In my the case I have in mind, I want to pass the interface that it
> > would have the error injected. For instance, only inject errors in
> > interface eth1. In this case, I am not sure ALLOW_ERROR_INJECTION will
> > help.
> 
> I've never looked into it and might be wrong, but I view
> ALLOW_ERROR_INJECTION'ed functions as a yes/no (err code) switch on
> steroids enabling debug code but not doing actual failing. E.g.

Right. I think there are two things here:

1) A function that could fail depending on your failure injection
request. For instance, you can force ALLOW_ERROR_INJECTION functions to
fail in certain conditions. See the documentation:

	/*
	 * Whitelist generating macro. Specify functions which can be error-injectable
	 * using this macro. (ALLOW_ERROR_INJECTION)

For instance, you can mark any random function as part error injectable.
This is not the case for the problem this patch is solving.

2) There are helpers that will query the fault injection mechanism to
decide if a given function should fail or not. This is exactly what
should_fail_bio() does. These are helpers that will eventually call
should_fail().

in my patch, this is done by skb_might_realloc() function, where it
calls should_fail(), and if the fault injection mechanism says it is
time to "fail", then it does (in this patch context, failure means
forcing the skb to be reallocated).

That said, it is unclear to me how ALLOW_ERROR_INJECTION could help to
solve the skb reallocation mechanism.

