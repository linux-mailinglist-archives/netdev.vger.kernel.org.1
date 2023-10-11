Return-Path: <netdev+bounces-40078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32A7C59FE
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975FB2826D8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F839926;
	Wed, 11 Oct 2023 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tBgHU3V1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BA22317
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:04:46 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA7FB0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:04:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b98a699f45so975666b.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697043884; x=1697648684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkffYuqQPgpxUMKliWtiGvJVI0b+1huaX9eXcNx5GWE=;
        b=tBgHU3V1NNjkgNEINOV/578b4v24yV5Gjatzho5lnKoDOlm3XmhYg9ozYwdIdqh462
         L/G2jqumqDvnxVb8yyKqjstqsTf9XuUWMwq85uEirGYIhwVyPSwkOqO1sgNHMVkLncII
         shMVWmiqWRfx01dj0uWgfJ8Mj+aVBWUsPr4NFrmyZn1uy6oOvsIMhQs3ce8e+x1HrnPM
         DHg91dC+PRRsX20MRl4c5/nSyBHrJf3S3vvuUaXXwQBaraPJWXaBFZNxSHLiYOakVy6g
         P4EkEBu3m/iC7Th6ooEyzyRMjciJIe3lehunIHrRYDCYviRJA5VPzriPIjzn71PRcdhb
         Eqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043884; x=1697648684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkffYuqQPgpxUMKliWtiGvJVI0b+1huaX9eXcNx5GWE=;
        b=dLl9sSTub7fbfEjXEXmQKNZHKZ0CfFkR9f70Kul9g/u6Mx+duiZWrbBISLDWpj8ws/
         pzOFmgfdGQxfvQnXsQmhv2N9nAeaUrFcZhYYMQSHI3UJLNg3rMYzZkHbzwxJRINFBTms
         lA7+e6QVD4kKZSPBB74L+DscHPjwDyGbUEUeuCBIeRZedFuy3urm+ovB7QVbXcwvEoA1
         pkb9xmPN/vT2p4Y++G5D55BWWRi8hVWL2ARapBULNQyWROYwO9qECZG0u9RKW2NpU168
         smhPM8gZmjLsEK1WmqHETI2YLgJRlTltaLiN5B+Yo9WORX1coOHDx8C0DQ91OojsD9F6
         xJ/w==
X-Gm-Message-State: AOJu0YzLjQSoBwq9hOeb+jW+2GqizdYTubWV0cBVtCkcNdtwNRfLQXcj
	/f6MdysVr7Ij/4RwMwqxQ5hqisFre9CqnYH5gIA=
X-Google-Smtp-Source: AGHT+IGWgFch3CFsyMUTQLtS5tIxmPVsLnB+TG1wickChQPC0l3KzJpkvpqUgd0e5FSeOHkGI42PQQ==
X-Received: by 2002:a17:906:ef90:b0:9ae:673a:88b9 with SMTP id ze16-20020a170906ef9000b009ae673a88b9mr18168588ejb.22.1697043883896;
        Wed, 11 Oct 2023 10:04:43 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906240900b009b2b7333c8bsm9887461eja.81.2023.10.11.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:04:43 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:04:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <ZSbVqhM2AXNtG5xV@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010115804.761486f1@kernel.org>
 <ZSY7kHSLKMgXk9Ao@nanopsycho>
 <20231011095236.5fdca6e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011095236.5fdca6e2@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 06:52:36PM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 08:07:12 +0200 Jiri Pirko wrote:
>> >> Note that since the generated code works with struct nla_bitfiel32,
>> >> the generator adds netlink.h to the list of includes for userspace
>> >> headers. Regenerate the headers.  
>> >
>> >If all we need it for is bitfield32 it should be added dynamically.
>> >bitfiled32 is an odd concept.  
>> 
>> What do you mean by "added dynamically"?
>
>Scan the family, see if it has any bitfields and only then add 
>the include? It's not that common, no point slowing down compilation
>for all families if the header is not otherwise needed.

Got it. Will try.

>
>> >> diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
>> >> index f9366aaddd21..8192b87b3046 100644
>> >> --- a/Documentation/netlink/genetlink-c.yaml
>> >> +++ b/Documentation/netlink/genetlink-c.yaml
>> >> @@ -144,7 +144,7 @@ properties:
>> >>                name:
>> >>                  type: string
>> >>                type: &attr-type
>> >> -                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
>> >> +                enum: [ unused, pad, flag, binary, bitfield32, u8, u16, u32, u64, s32, s64,
>> >>                          string, nest, array-nest, nest-type-value ]  
>> >
>> >Just for genetlink-legacy, please.  
>> 
>> Why? Should be usable for all, same as other types, no?
>
>array-nest already isn't. I don't see much value in bitfiled32
>and listing it means every future codegen for genetlink will
>have to support it to be compatible. It's easier to add stuff
>than to remove it, so let's not.

Interesting. You want to somehow mark bitfield32 obsolete? But why is
it? I mean, what is the reason to discourage use of bitfield32?

