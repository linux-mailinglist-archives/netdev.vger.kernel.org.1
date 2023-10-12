Return-Path: <netdev+bounces-40304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DC7C69A6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A96B282B9F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84921345;
	Thu, 12 Oct 2023 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RVND3lOw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6E21347
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:28:47 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBEA9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:28:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b974955474so112757266b.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697102922; x=1697707722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PqUCxj5eLwzRrTgXT0yNS+BMBTGe+4yyNTwp4NiR6w=;
        b=RVND3lOw2KXXF1jj/Vw1JafnZySVQq3a3aJ/NiYvRXw4zEA+Us/++D9O+mHvQP/I7L
         BZZVqhC1aEnd7quc90e/rlm2/K5NJzBgsAJxQQTHtXd0ZB4Ns+KHmMxaa9YgXJVLInPX
         Sh+EePPyptWOP0jRymLL/c2SZOivJP7bnp++xOWNu5/f2B6ZHaf9DsYCafYDiWwqRqVD
         XuFTbp7vdtHIhy2MNyxz2bgbeIterUiHc0U1GmISp89PDrQuk2x2tnjPA5yO6d3RuCb3
         NWnqHghEIvMp3qTvUuQ+sM8O123WM34+8Z4/jv/kBJlBOv7VhJrQ9SM7JLHHlf3UXcXT
         HCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697102922; x=1697707722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqUCxj5eLwzRrTgXT0yNS+BMBTGe+4yyNTwp4NiR6w=;
        b=DSM8Di+SIROSNT7KVcQ0c71veyzqHvkEOu1ZMCdMdFpqiuunO75Y0zSfaX9fZKqKVb
         d95x1JYVRIpjfwVKXRORpvMwM4EoM78c/NmK/RQShRiUo2ZegSerjx93FNn7k47/rRHe
         0kmuS28gsrLVm5/uM/48bd7oKEk0meisrZX/TckGb6/c2u96utofBRyp0njwTdt654a6
         UqZOUSEYSW3C4BHH0sOF6ayJRSSEPka1wKpJFoHoyka6/noTJuue+F+Qb3VQaA9DSNik
         4su/6CnzYIercci9MhUd8H7dqQ1UZMpImo0pZ/ztvhgya0HIURpcyAUowu8tftqVVH3o
         rr1Q==
X-Gm-Message-State: AOJu0YzgP33VVXHmdYWx5BAkAR57fVa3yqY8wdilMKOWHhHZZorMn58W
	SYSUrj7lIK2cO4DM+fvkhfj4dA==
X-Google-Smtp-Source: AGHT+IFpK46MO083H5ibDkbxduL5zsJoAEN6ufiFu4YNqSsc8mMX1u3OMTRyu1JzMlguwkliYF+cvQ==
X-Received: by 2002:a17:906:29a:b0:9b2:b750:4a67 with SMTP id 26-20020a170906029a00b009b2b7504a67mr21158222ejf.67.1697102922435;
        Thu, 12 Oct 2023 02:28:42 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b00997cce73cc7sm10793641eja.29.2023.10.12.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:28:41 -0700 (PDT)
Date: Thu, 12 Oct 2023 11:28:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Message-ID: <ZSe8SGY3QeaJsYfg@nanopsycho>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010115804.761486f1@kernel.org>
 <ZSY7kHSLKMgXk9Ao@nanopsycho>
 <20231011095236.5fdca6e2@kernel.org>
 <ZSbVqhM2AXNtG5xV@nanopsycho>
 <20231011112537.2962c8be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011112537.2962c8be@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 08:25:37PM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 19:04:42 +0200 Jiri Pirko wrote:
>> >> Why? Should be usable for all, same as other types, no?  
>> >
>> >array-nest already isn't. I don't see much value in bitfiled32
>> >and listing it means every future codegen for genetlink will
>> >have to support it to be compatible. It's easier to add stuff
>> >than to remove it, so let's not.  
>> 
>> Interesting. You want to somehow mark bitfield32 obsolete? But why is
>> it? I mean, what is the reason to discourage use of bitfield32?
>
>It's a tradeoff between simplicity of base types and usefulness.
>bitfield32 is not bad in any way, but:
>
> - it's 32b, new features/caps like to start with 64b

That's fun. Back when Jamal (I think it was him) was pushing bitfield32,
I argued that it would be better to make it flexible bitfield so it it
future proof. IIRC DavidM said that it should be enough and that you can
use extra attr in case the current one overflows.

Sigh :/

> - it doesn't support "by name" operations so ethtool didn't use it

It follows the original Netlink rule: "all uapi should be well defined in
enums/defines".


> - it can be trivially re-implemented with 2 attrs

Yeah, it's basically a wrapper to avoid unnecessary boilerplate and
re-implementations. But I think that is a good thing. Or do you say it
is not desirable to rather re-implement this with 2 attrs instead of
using bitfield32 directly? 


>
>all in all there aren't very many new uses. So I think we should
>put it in legacy for now. Maybe somehow mark it as being there due
>to limited applicability rather than being "bad"?

I think it is odd, but if you insists, sure. Your the boss.


