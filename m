Return-Path: <netdev+bounces-18854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758F758E15
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 08:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8192281635
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B25242;
	Wed, 19 Jul 2023 06:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65E1844
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:47:50 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273611BFC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:47:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so8905552a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689749266; x=1692341266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjN0tLMfhhbwPG0cD5N+BU3Ej/18jrzjOMkzaASLGXk=;
        b=3oLaMtulUk+KibeojFShc+KJpkHml93hjuBgMyE2IDuJFoOc/Hpr7M7S1io78YR+tZ
         i+a2wwQJKo0qCY2sfQ9o3MOgK1iXkYYfco4poWTO85ucwBnqpBbOQMow9cxWvXde/OX0
         g67fxCSXBEzUBtsNSGhR+z9rAvTfcB//VZfgzH+bflgzu2NovFxJmaXmXpHLjQFteSMq
         jwmRPUGzfXoIuaBO86QgcKQbtpuXLd/8RtKk8uoQEBLQcaThpVJGrhuPDVE8suWwcNyY
         CG8otl5Cdz0Q6XqKxAowat/1ury3XHNI18E5LwL4Wr/dNzW+UOsxbYdkBqyBQpna9Rug
         wHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749266; x=1692341266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjN0tLMfhhbwPG0cD5N+BU3Ej/18jrzjOMkzaASLGXk=;
        b=UKqS+Z6Ed8TVLDPbU6EUzORxeh5IGJ2Vt67I3CVyhJ3F+xGqBJfzcq+f5zbiJTIWCM
         lVrzrenPJhJi1EUpWCvFuu5D8yjdeH9yj8CaE1idNYZ6HNBaM6HstD48Yd9wb0VQNJQO
         gyS8BEgiJlRxAhw8UiU/eso5UV3get8WekoWVo8DTyGO8FPEs6DhfOkIRg6Qfkj+xLVm
         lVDnJVo4kcTpV+CEgbxHFYyCq5lrktGIMQID0MHU4BV6ZD5uTrg9j/n9/pPvH13lS4nm
         810U+vEHp+33nrEgfHWex5uwqWia3rotG1/EWhuIBpwESrakirTS0u9uVeNPE4NXbXJx
         wTuw==
X-Gm-Message-State: ABy/qLaWVSSQRValB+TlpYsi6mDMFAMlMD/V6XqtIANehcQFUHQh1sA+
	H47jyVSwreHilFY7qpBUw/6WQzEFLp4h2kSVgoA=
X-Google-Smtp-Source: APBJJlF170M9fXHN/tZM63CDcIwqRn/P8fMM0z78/vcIdodNexSgRaO1fRx7+WlHwGcmYZtOLeKwaA==
X-Received: by 2002:a17:907:75c3:b0:993:e94e:7234 with SMTP id jl3-20020a17090775c300b00993e94e7234mr1468369ejc.77.1689749266528;
        Tue, 18 Jul 2023 23:47:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o22-20020a1709062e9600b009937dbabbd5sm1862229eji.220.2023.07.18.23.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:47:45 -0700 (PDT)
Date: Wed, 19 Jul 2023 08:47:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Message-ID: <ZLeHEDdWYVkABUDE@nanopsycho>
References: <20230712135520.743211-1-maze@google.com>
 <ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
 <CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
 <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
 <20230718160832.0caea152@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718160832.0caea152@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jul 19, 2023 at 01:08:32AM CEST, kuba@kernel.org wrote:
>On Fri, 14 Jul 2023 08:49:55 -0600 David Ahern wrote:
>> > I did consider that and I couldn't quite convince myself that simply
>> > removing "|| list_empty()" from the if statement is necessarily correct
>> > (thus I went with the more obviously correct change).
>> > 
>> > Are you convinced dropping the || list_empty would work?
>> > I assume it's there for some reason...  
>> 
>> I am hoping Jiri can recall why that part was added since it has the
>> side effect of adding an address on a delete which should not happen.
>
>Did we get stuck here? Jiri are you around to answer?

Most probably a bug. But, this is 10 years since the change, I don't
remember much after this period. I didn't touch the code since :/


