Return-Path: <netdev+bounces-49825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201407F3975
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA81C20D2D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8751018;
	Tue, 21 Nov 2023 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foP2OqiC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63AB9
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 14:49:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc0e78ec92so40045675ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 14:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700606973; x=1701211773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykyNwdcxbG9rnNUbBtSr0Hpk5kwmnVBkYCnY6KA9QSk=;
        b=foP2OqiCVd/GTcSIGRzg1EvpZzV6FuPrGCOqL7/f+eGJVdrT7D9AJWX0cgfvbRnMOw
         Z2DYCa2eeq5sYsaZozBtjXR8OOQs/BOrh3eC4taBWwSvFZt2pMBpH+e2XRfzATCCnmho
         EBz1my+z903ULHAnsiZFYGVXg06iI6iRuN/FD4WxW9Lx+SmFaEKhU8P5+HFLXg3UXpB8
         BXjEIp1f/Tr0TmjyKzHghfU1dJXA/aY1x4MQ4rDs2jFGic1wy7fSlFZsN/jqxRPMHJEr
         QjEa104f/7w+AvlHT2tNes337YydUZscXFlRRz1DE5NyEQP9LFqsnVpQnu7DeACI3yQO
         ilAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606973; x=1701211773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykyNwdcxbG9rnNUbBtSr0Hpk5kwmnVBkYCnY6KA9QSk=;
        b=gqG8hen2bU32Wwcv9W1S/2Lx3NIiikDWxysIo9ic2yFONs+2PbeqQIhP2cXNJHjCaM
         RuS/o7Zj7RHIupc+v3xwMQim1qpQu/z8z8760VrUGZ3ZVQy+oEP4yrw7fJHhA340Gg1E
         xT6tQCTBX1TIHbrV8hwuvz08nFI3kqRschucRqaKSwPICr0sqxZIm8UshgRodPRAY8wq
         hwFgesr5qydiQUGg+TL4PuSRLuL09NO0SoqxjncsKu2Erlg3eq0rSdC555JrnERgWcfP
         Qo33QUFzcJ02wk1nt0hbKnlR8szL96BLwYOfVp3v8Ht2cvBYwHnSFd7v8UUEmL+0t9gB
         MYzg==
X-Gm-Message-State: AOJu0Yy3loWmaOtIEPhxB2kwpZ52QjYn+g3IJci2BG6tnxCG7RZI+w1d
	kYVWyB8uaaJXRFQ6fzqHqgI=
X-Google-Smtp-Source: AGHT+IFWlmTgAgH28eHNYSVudWRSPDK6xp+SlCdRJBdXncqmJWw6Jcu0phr65L1LcGB+RU45jzYEUw==
X-Received: by 2002:a17:902:724b:b0:1c6:b83:4720 with SMTP id c11-20020a170902724b00b001c60b834720mr540167pll.63.1700606973316;
        Tue, 21 Nov 2023 14:49:33 -0800 (PST)
Received: from [192.168.0.223] ([63.155.112.173])
        by smtp.googlemail.com with ESMTPSA id f14-20020a170902ce8e00b001c60c3f9508sm8408957plg.230.2023.11.21.14.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:49:32 -0800 (PST)
Message-ID: <c6e47c66-46d9-4006-8311-fb2d2fef8f20@gmail.com>
Date: Tue, 21 Nov 2023 14:49:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, dtatulea@nvidia.com
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121000048.789613-9-kuba@kernel.org>
 <655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
 <20231121123721.03511a3d@kernel.org>
 <655d22256ba8e_37e85c294c8@willemb.c.googlers.com.notmuch>
 <20231121140049.045b8305@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231121140049.045b8305@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/23 2:00 PM, Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 16:33:25 -0500 Willem de Bruijn wrote:
>>> That does not work for "destroyed" pools. In general, there is
>>> no natural key for a page pool I can think of.  
>>
>> Pools for destroyed devices are attached to the loopback device.
>> If the netns is also destroyed, would it make sense to attach
>> them to the loopback device in the init namespace?
> 
> I remember discussing this somewhere in person... netconf?

I asked why not blackhole_dev for just that problem.

