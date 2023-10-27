Return-Path: <netdev+bounces-44805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EC47D9EB2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4771C20FE6
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24339867;
	Fri, 27 Oct 2023 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5b92Ctr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8938DCB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:16:46 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9228B10DA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:16:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a6889f33b9so64489039f.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698427003; x=1699031803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84juV9gdXEUct3u5vxaNV/zNwUSNSy+9tLDqWtspySw=;
        b=Y5b92Ctr7A0lkmkgaRcUN0P+vdCabQH+pK3bQsjBkkUejahxmRDdOycbWYtOqPHT5i
         UWtYQ/4OJeJf6Jwlx7/z+o+dC+/xieIShBnQs2QJtGhEAyDkjmi7SwPfjYitluBCpBFi
         7HRuTnnN9h6HxsvYwClvnfGGaPKvlTKb26XnXHTOCDB4RYznVDc5lvvC0bcRS/ZMvyVA
         HaMbzk6bFnkZZj0ihLkv6Zy9CbJf9n2DPQ14hzMvcMS3th8V/ACQBoG1AjOkgcFpGwbS
         L7OnGxaNBejfS6MdWvkjCN7kyHCPgwQnpVQ18jyBTAuPLKuiNzHoVwqS4OVCz8ULUNvB
         g6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698427003; x=1699031803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84juV9gdXEUct3u5vxaNV/zNwUSNSy+9tLDqWtspySw=;
        b=SuiXelLYI08hdavfNH1fLfgereL6Wm0v7i2Y2tSMNg8BUNcy42VX9/RCkq3N86o9ew
         HSvJjCNjlYNTPEpn2xal+3GOTuHTY/zYnb+RQ3xr7Rz8XB9DReWjg3P+i070Y1INzRrO
         SLeb5+uEmZ2eQWhKvuIXiSPespVar9s8NbWIsmNyb3Qghj31xotzN6zr75zGh5MDaVLB
         zMo+9o5cizaqROr3e7E4qy/DkoGfnOsY+RfK71/ZtmwuSOLtc1QDujuaZlgZViwQo19t
         olSHLdK6qVwcQO9OUzu0qzj3GB+zYe7YtgB3SuQ0G6GvS3g+x7ITwGC7zUdwn/w8J3ow
         gz6A==
X-Gm-Message-State: AOJu0YyxpQBhQxBSK8CxpAnk4/JCUtJ+wPqgWB2jwOzKl+MydebFiONi
	d3xdr7E77ZrWIy8TX+PAz2nxBwLqEDk=
X-Google-Smtp-Source: AGHT+IHZ2jJxQBZYvQjuiJAaWspjHJDONlv2m14uEgHUwritjXcQaCL6fbh2ELsDueUxyh1QSA0PrA==
X-Received: by 2002:a05:6602:1684:b0:7a9:8dfb:3ed0 with SMTP id s4-20020a056602168400b007a98dfb3ed0mr4048420iow.14.1698427002918;
        Fri, 27 Oct 2023 10:16:42 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:542:b658:250a:2f23? ([2601:282:1e82:2350:542:b658:250a:2f23])
        by smtp.googlemail.com with ESMTPSA id e15-20020a02a50f000000b00457a6f281ddsm507212jam.59.2023.10.27.10.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 10:16:42 -0700 (PDT)
Message-ID: <a9b610e6-b0ce-46b6-89ea-faef78c5a4f2@gmail.com>
Date: Fri, 27 Oct 2023 11:16:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch iproute2-next v3 3/6] devlink: extend
 pr_out_nested_handle() to print object
Content-Language: en-US
To: Petr Machata <me@pmachata.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 stephen@networkplumber.org, daniel.machon@microchip.com
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-4-jiri@resnulli.us>
 <61a6392e-5d77-4f15-bcd2-7bd26326d805@gmail.com> <878r7o5dht.fsf@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <878r7o5dht.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/23 7:12 AM, Petr Machata wrote:
> I was wondering whether somehing like this might make sense in the
> iproute2 library:
> 
> 	#define alloca_sprintf(FMT, ...) ({					\
> 		int xasprintf_n = snprintf(NULL, 0, (FMT), __VA_ARGS__);	\
> 		char *xasprintf_buf = alloca(xasprintf_n);			\
> 		sprintf(xasprintf_buf, (FMT), __VA_ARGS__);			\
> 		xasprintf_buf;							\
> 	})
> 
> 	void foo() {
> 		const char *buf = alloca_sprintf("%x %y %z", etc.);
> 		printf(... buf ...);
> 	}
> 
> I'm not really happy with it -- because of alloca vs. array, and because
> of the double evaluation. But all those SPRINT_BUF's peppered everywhere
> make me uneasy every time I read or write them.

agreed.

> 
> Or maybe roll something custom asprintf-like that can reuse and/or
> realloc a passed-in buffer?
> 
> The sprintf story is pretty bad in iproute2 right now, IMHO.

It is a bit of a mess. If you have a few cycles, want to send an RFC?
Just pick 1 or 2 to convert to show intent with a new design.

