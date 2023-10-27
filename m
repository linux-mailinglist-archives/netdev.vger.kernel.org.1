Return-Path: <netdev+bounces-44674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F97D915A
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6DEB212CC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DE14AB2;
	Fri, 27 Oct 2023 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mCRgoUvp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AB15496
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:25:12 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D8196
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:25:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so6093965a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698395108; x=1698999908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxhehoaH72TzkhJ139f5JoEVtiI7ttDjQ10MikI3Wmw=;
        b=mCRgoUvpbFZ6rmOof3WkPsP+I70ooa/rj9DBmTtw8DS1dXQBxO2aULTsCUIDGBylys
         tdAqDyDUy+iLhSBSVXEF8MkERD91SIFM/e610g9vJ89BAjuXxviPPvjx7dY2U5p2r0SU
         4e+CVv6w03d9jMHtAuYFcPPv4ThdGKarkRIiHM8Em+blXw03acRYeN5bKN2q//m1UdGK
         NZ9efSR2OnpN38gLEk2JAjZHZlrwxM/JT4wqqV9s8vc74l3psR4D8W0Ke5yDR3iSabVL
         els7FQk3oLl2ttZHTic9KmHGn1fYDegFYjVQ7QvGBYzOuDvHBZQQV7muu3obfUAxjxjB
         6KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395108; x=1698999908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxhehoaH72TzkhJ139f5JoEVtiI7ttDjQ10MikI3Wmw=;
        b=D5p3KuvmNttgSJ11Lb4OjFfYDchC49EZAcCR5ny91jItnJgLfEZFJtWcGTRktkA3yV
         06GIUHpz5brkEC/I2G9K7CSjnczbUDDGlFqIs3gp6nI2QPvUpi3ZSal9fZ37kEgVFpiE
         oe5KldmwPWmb0AmlD150c0Tg/28LVrsBMauTsyXvh6vYCNM/GXdU6X22ULWs4GohiN50
         sjEQlP+EChn15y6LeX+TYNRoEQ9EuUDb9JvWuYjEHpqvFih7Y3dnhJaUGbmzlpAkT/zI
         wYD4hWDGRedcVzmOo0L/ODclXkLUuH1dMJ/Fe4euusbzjLs7Qd2wMrpz4gblW4OD20SY
         rUCg==
X-Gm-Message-State: AOJu0Yyd8nvPiEGxy+5bxE24TsQ1G0BmZfT7fxa/2bUN2N3vR70CXQdw
	0jbZwR8EJbOtRfMWmL+hYXxswQ==
X-Google-Smtp-Source: AGHT+IGmbEhqNqeRBhQKc5yCtZfXZfcnSaRRDMe7WoL/BLYQD8r8dLMsGwlVS4h6pl/yoI+gwqFHdg==
X-Received: by 2002:a17:907:96a3:b0:9a5:dc2b:6a5 with SMTP id hd35-20020a17090796a300b009a5dc2b06a5mr4322395ejc.35.1698395107887;
        Fri, 27 Oct 2023 01:25:07 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id lx21-20020a170906af1500b0099bd1a78ef5sm821825ejb.74.2023.10.27.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:25:07 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:25:06 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
	daniel.machon@microchip.com
Subject: Re: [patch iproute2-next v3 1/6] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Message-ID: <ZTtz4lq7NzvVC0Nt@nanopsycho>
References: <20231024100403.762862-1-jiri@resnulli.us>
 <20231024100403.762862-2-jiri@resnulli.us>
 <1d25df23-3ef6-40f0-a9f0-844da8e17f57@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d25df23-3ef6-40f0-a9f0-844da8e17f57@gmail.com>

Thu, Oct 26, 2023 at 06:56:20PM CEST, dsahern@gmail.com wrote:
>On 10/24/23 4:03 AM, Jiri Pirko wrote:
>> diff --git a/include/namespace.h b/include/namespace.h
>> index e47f9b5d49d1..e860a4b8ee5b 100644
>> --- a/include/namespace.h
>> +++ b/include/namespace.h
>> @@ -8,6 +8,8 @@
>>  #include <sys/syscall.h>
>>  #include <errno.h>
>>  
>> +#include "namespace.h"
>
>??? including this file into itself?

Interesting. Must have been done during code move. Will fix.


>
>> +
>>  #ifndef NETNS_RUN_DIR
>>  #define NETNS_RUN_DIR "/var/run/netns"
>>  #endif
>> @@ -58,4 +60,6 @@ struct netns_func {
>>  	void *arg;
>>  };
>>  
>> +int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
>> +
>>  #endif /* __NAMESPACE_H__ */
>

