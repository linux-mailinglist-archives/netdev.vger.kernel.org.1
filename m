Return-Path: <netdev+bounces-54999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BB80923E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DC61F21153
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEE5026E;
	Thu,  7 Dec 2023 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdouKteb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58474171B
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 12:24:56 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d77a1163faso9879497b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 12:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701980695; x=1702585495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMyzG6/LQ9fJFBhiWd82aTNJpqAKqu5WvC38KtmseZQ=;
        b=VdouKtebihw+7+SPLbpKEdbMN8d68rZEsDFvmUnD18bSkttdl2nhNxm/TMqnbpvUMI
         b9dzRnK11BaU5GB7nHAQb6WeWX0UV7p0qSD5Xg+DiGqJ6pLvCyNOGOCDRp5prDq3tlqY
         D+PO2HtOBxlNKlceKKjXOTKyyDQUcDTDwFP1zUkmlNyRZk9vsfOGfqnHhjhh6GIUf5ml
         97kywXyVMRPHsFSIwCj7WGrzi5icH0HetSZKmigDRV/tmeGBVzl1HBbsn7K7kLjlelXA
         Le7UxI78B2tbfUlselk91cuNbai11sKt8HIyjTSWxtXSbhkZzGkOOX+fVKZ1n4FVD2bM
         hJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980695; x=1702585495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMyzG6/LQ9fJFBhiWd82aTNJpqAKqu5WvC38KtmseZQ=;
        b=ksbtREzfUYt+7ELxqB+XwjYcF2N5g2cRnoFxn4deqncmaumS2k818YK5HhKoeVo3iK
         HCPv+Kt2a5eGUQg+RWJ09qK64TxU9l2kXUT6s40KyBK/1G1XlYj0BZBZ1TeQmLZypnJW
         mzbEoNBPDARvzgEoQqcqF2wxwmz8Iv6zDid10on8Ln7yxSAfrxDk5OX/c4JnTG7auWWP
         svV002Z8DFS9kCHbLRs12Grqn5ora6j/XgDeapEfuU4CdIvSUwWWM9BuXRbuXhF/Ofya
         qK4GdGr20oaP5OFekRTDs/bt0ysp2Kuc7CygIM72yRnkAKaPsWPkfF04NrQbECNgafOT
         5tgg==
X-Gm-Message-State: AOJu0Yz+hTYPUSGFzvpXUVzGyw0ZLL3rARzq75yV0mDmvc70cuHjxOCj
	iEgfU3GFFtWccGAZ4Rg+X/Q=
X-Google-Smtp-Source: AGHT+IEM9dWJM8ql04Ou9wUgUY5GqAbR5WnxTdsydCs0bW1IA+ILaeOytHiTuDOU2TyNlUuoKdxSLg==
X-Received: by 2002:a0d:d4c5:0:b0:5d7:f227:55d0 with SMTP id w188-20020a0dd4c5000000b005d7f22755d0mr2279787ywd.42.1701980695543;
        Thu, 07 Dec 2023 12:24:55 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id h197-20020a816cce000000b005ccf7fc2197sm136872ywc.24.2023.12.07.12.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 12:24:55 -0800 (PST)
Message-ID: <e4d86104-0b66-4535-85bc-87bea2409a7e@gmail.com>
Date: Thu, 7 Dec 2023 12:24:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] ipv6: fix warning messages in
 fib6_info_release().
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 kuifeng@meta.com
References: <20231207195051.556101-1-thinker.li@gmail.com>
 <CANn89i+CTAYZft=LT+ZH8bg__9p63URnQH=s9=AL7MO4rbvPJg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89i+CTAYZft=LT+ZH8bg__9p63URnQH=s9=AL7MO4rbvPJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 12:04, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 8:50 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The previous patch doesn't handle the case in ip6_route_info_create().
>> Move calling to fib6_set_expires_locked() to the end of the function to
>> avoid the false alarm of the previous patch.
>>
>> Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
> 
> This looks quite wrong.
> 
> Let's separate things to have clean stable backports.
> 
> I will submit my single liner, you will submit a patch fixing your prior commit,
> otherwise linux-6.6 and linux-6.7 will still have a bug.

Sure, I am working on that.

