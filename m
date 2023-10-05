Return-Path: <netdev+bounces-38301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CB7BA1DD
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4D53B281F7C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5602E63A;
	Thu,  5 Oct 2023 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="b5HkRgXM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF462374C
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:01:39 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01514DF51
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:50:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3c8adb27so193325766b.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696517416; x=1697122216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2yZsVHLsd9Gf/3G1xrb7hl5PCatHdGXYN1ZP/+N1NI=;
        b=b5HkRgXMj3jmeQT5iMXeMvlf9SbepJfm7eP1LHWKkirYxx5jKs9SARunaW+c+jhG20
         mvauXQAmLcQx2Eq0fa5WJCCFvfpIoFEV3vBAJxxps2cOOJbRoRYh7BCHsOCw0d12gXKF
         DM+3XEDG9PCSG4IkAVUikVJoMco/L01+9Tet6nBRs74yHNQhhUAubbFFr9Jw0cn0kjpI
         IKbiJWdjyYmmMfCKeoT1NyBvRtlGCPJromTLg9xuP6vAzvtz7gs3cUPJXmWzNaWgSX0M
         ubeob9I2WNgqslRMa5aOzOTw+U+vJXY0TFzFx31tep4iy8lEjA+Vmrg4SVZgsaNqsGxR
         Xehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517416; x=1697122216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2yZsVHLsd9Gf/3G1xrb7hl5PCatHdGXYN1ZP/+N1NI=;
        b=DownvKentRB9QsI79gYiK71Yv3nBcfHD/BddVqU8ussyoJoHvvdtqHFdvvyJKCKyAg
         BA1xmB0DP4ki9cqTvTTjmM/NftYrHliKK7TAsQl6MRi3q7msw/4hwhhBdZzSTK3D1tvm
         HFUQKbAryXndTL8TaD9PxkGyMVelo3rIcdjs978zWmEgNtTPvgO+CfR07sNDFC92L8ig
         F7K/Geb5JnE8dJhxW4azD+JKfn+R14t5AYKkI+0WVKq2kpzA88ovrlvbsVNDfKr08NgC
         Ibyio9Ogt+MnIhfzVcORQWYJeiiaGNcuE28D7hV0vUBc9Rz7VKWX7Q6a7n8FxERFspmQ
         hW+w==
X-Gm-Message-State: AOJu0YztE/MjorgAisoWRsl2D6qLZL3sTGi+v+/VpxwNhbib+ygIjMmH
	fYJjWtLwIl+X4aCjWSs7Zs+nKQ==
X-Google-Smtp-Source: AGHT+IFtoI1WxOWEk94azb2QahBk3G0jJM/LiFiNWFSgFTWGqRY5y/B24N9dAuodukIrMkAw9bemkQ==
X-Received: by 2002:a17:907:780d:b0:9b6:4df9:e5b5 with SMTP id la13-20020a170907780d00b009b64df9e5b5mr5136647ejc.61.1696517416200;
        Thu, 05 Oct 2023 07:50:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b00992b510089asm1309860ejc.84.2023.10.05.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:50:15 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:50:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl-gen: raise exception when
 subset attribute contains more than "name" key
Message-ID: <ZR7NJt3tdviFqb2a@nanopsycho>
References: <20230929134742.1292632-1-jiri@resnulli.us>
 <20230929134742.1292632-4-jiri@resnulli.us>
 <20231004171350.1f59cd1d@kernel.org>
 <ZR5lA7SwQr3ecUp9@nanopsycho>
 <20231005072151.2a71ec59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005072151.2a71ec59@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 05, 2023 at 04:21:51PM CEST, kuba@kernel.org wrote:
>On Thu, 5 Oct 2023 09:25:55 +0200 Jiri Pirko wrote:
>> >> The only key used in the elem dictionary is "name" to lookup the real
>> >> attribute of a set. Raise exception in case there are other keys
>> >> present.  
>> >
>> >Mm, there are definitely other things that can be set. I'm not fully  
>> 
>> Which ones? The name is used, the rest is ignored in the existing code.
>> I just make this obvious to the user. If future show other keys are
>> needed here, the patch adding that would just adjust the exception
>> condition. Do you see any problem in that?
>
>Just don't want to give people the impression that this is what's
>intended, rather than it was simply not implemented yet.
>If you want to keep the exception please update the message
>(and the if, no outer brackets necessary in Python ;)).

I don't mind dropping the patch entirely. I just thought it would be
nice to do some sanitization so the user is not surprised that other
possible keys are ignored. I tried and I was :)

