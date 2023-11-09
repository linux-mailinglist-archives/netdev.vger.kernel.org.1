Return-Path: <netdev+bounces-46852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D97E6AEA
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5274281385
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854E107AD;
	Thu,  9 Nov 2023 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC3wTXIz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4A1944B
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 13:04:39 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1152D78
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 05:04:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso827211b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699535078; x=1700139878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNN4Ti2/b/aCKojI5Dy/8MBJD1H4K6GA+tsWX4E6cOo=;
        b=QC3wTXIzZ8E9nz4JIYI5f/wAYO6QQ1jvHtn8lgBoWZshiuaD+Gyd2YQ2bk+RGn0dJV
         xqmZGI6o+laVEWihCd1qLu8TQPdzSTGGokScTwoU0CoFOxZawH0FpAm9LHnc4XoCXcp8
         Q7MzJ/nDLsp6xbgKXcB1tLvxSGWltqcetZ8+i+y/XSpk1xEDhBxdaL49Aen3y+I1zYUl
         EkduhyUyu1UHtEaWH+zmx/w3ZWTOiWYtNf5GaXZzulJXl5fLn9HBZZH7gOw3SDQT2388
         b5QY2WgB66foR8fBcrizxcU+dB1Ad/26bFaO3v5hRsumftro+JKr/hxJOmIPMtQmzLt+
         wkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535078; x=1700139878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNN4Ti2/b/aCKojI5Dy/8MBJD1H4K6GA+tsWX4E6cOo=;
        b=MeIFeF1GiiWWl6XQck3oLABSNEMwD59OCV5PdGmrmN1pNT7JKyQKc0pEovrTxImqG8
         8CVPK/45FA8rItnyLAzwCVfBoVJ8okvddXsFuIE3QHRKzn516NZFsVExecUkLvE0hE82
         FBNFkxnYoUMpeNxcWyEjQPeA2eRmN+R5MEgOozcT4tZ722QQd9YZsC4gpYDCyNTai8Ys
         a+OvYyIjWo31IhrYR1Fejv1aTJFRdXPwA3kGjuQyTIo1XUL9nkabzMcRzutgxgQvU0yN
         qg/YrqgVHEgpMBpVYFQu7fz9IqziRweVkKva2ydNv1+waTCwrxOUeoQVXh8E43pd0RET
         gKKg==
X-Gm-Message-State: AOJu0YxDDruvgPI2pi1vXRvcF1f1fwde91dLs/8I2o226HMYrKnJ4grQ
	VToCFwbE9vGYHPOBhh9wMWM=
X-Google-Smtp-Source: AGHT+IHxZ8/ZrrCWcrzmWJ++wSfj6gwQhUgMZJx1Okz3HQDWJEKcfLiTJ5t8dDQKvO8lCzm0GhnSSg==
X-Received: by 2002:a05:6a00:1ad1:b0:690:d620:7801 with SMTP id f17-20020a056a001ad100b00690d6207801mr4982851pfv.11.1699535077806;
        Thu, 09 Nov 2023 05:04:37 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m29-20020a634c5d000000b005bd2b3a03eesm4757010pgl.6.2023.11.09.05.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:04:36 -0800 (PST)
Date: Thu, 9 Nov 2023 21:04:32 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Message-ID: <ZUzY4NXXasJAdEFF@Laptop-X1>
References: <20231027071842.2705262-1-liuhangbin@gmail.com>
 <68045f82-4306-165b-c4b2-96432cc8c422@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68045f82-4306-165b-c4b2-96432cc8c422@blackwall.org>

Hi Nikolay,

On Wed, Nov 01, 2023 at 01:29:34PM +0200, Nikolay Aleksandrov wrote:
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index fac351a93aed..6adc0c70e345 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -461,6 +461,238 @@ enum in6_addr_gen_mode {
> >   /* Bridge section */
> > +/**
> > + * DOC: The bridge emum defination
> 
> s/emum/enum/
> 
> Below the time is not in seconds though. It is expected in clock_t (seconds
> multiplied by USER_HZ) and also exported. That should be
> better explained as it has caused confusion a lot.

I have done most of the update. But for this I'm not sure how to update.
Should I explain the clock_t defination before all the enum definations?
And how should I describe the time in the enums?
> > + *
> > + * @IFLA_BR_MCAST_LAST_MEMBER_CNT
> > + *   Set multicast last member count, ie the number of queries the bridge
> > + *   will send before stopping forwarding a multicast group after a "leave"
> > + *   message has been received.
> 
> This needs to be explained better. Remove "ie", "It is the number of queries
> the bridge will send", this part needs to be extended what are these queries
> and are they group-specific or general etc. The interval
> and time values below need better explanations of their units and what
> they represent in general. I won't add a comment below each.
> 
> Also please remove the extra new lines between the comments and the
> definitions.

And this one. Which extra new lines do you mean? Are you meaning no blank line
after each enum? e.g.

@IFLA_BR_...
  some comments
@IFLA_BR_...
  some comments

Thanks
Hangbin

