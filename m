Return-Path: <netdev+bounces-62281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C138266C6
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 00:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69881C20968
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04A125A5;
	Sun,  7 Jan 2024 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FH+mMiWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6613AE3
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so14859941fa.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 15:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1704670311; x=1705275111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TS+kykkdltLDRirL+rXcv6MtUIxDqkAkNHKl9TdrtYI=;
        b=FH+mMiWRvo+omLGpK/Yf7i/M9xTFQPK1VXIpJUzvERiLzeTXrc2VhYxw1lEfGimr86
         oP/IHTAoiKF2x5fse3o9XvNO99oOI1nrxdz/XO7x70UmVibY7GBR6DlM/bJmMgIpBwmf
         QG5t6q2a121/4qKIKC4YItW/DZK06CkK4Cxyi0K6oNQN/vmK7O5uIzvSngCCZ2LRv4oE
         NdcJYfjApczSo8v18FYnrSagwDBqKdv7LKVGgZTmH0jqY0XPTwqz7sibIecsVw7fqbCO
         7siWgL+T6fa7HqH9aBn6m3OfBfEqBnZQ/jIjLJ++wG4ZaL19evW9aGMLSuxDLbp87zDF
         WMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704670311; x=1705275111;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS+kykkdltLDRirL+rXcv6MtUIxDqkAkNHKl9TdrtYI=;
        b=EUj1DZQoZP4ypyY5o7rxr088HUOvDlXVQruacrD/K+KXEeqpA2++GjtSQ8cq0e8ySC
         EcPgr7Sddk37/wtWZcDJO4wIvTzYS53OSEd3WD+/+8J0ffsssKui0gdwtNBPMsfVlBtQ
         EnY7qrULGrQaoci0Hl79Lp92kPb303+VEsvCQlLloxb3uiaBkFIEMF3yLtSjNSkqP+j8
         xMckxsA2y1nrNeLTEZjEsObRmfNSjuCPwDN/mcqNh8hvzJ5wm8sCD0ZU4GgHTAAIMAOo
         gr6tprFCVN82AmvEo8LzZqzYlrYags/WhtJO05Jv7ygbuw7tKtRe7MvFqAe6zh5hRApc
         7yXg==
X-Gm-Message-State: AOJu0YxfbrnOPF1ihSx8Lj0FZUkHn3GTs+ldeKJe0/+UNhGMg2LmjCZW
	a6RgXcy13Yg4BFTaJzJ9nPkYc7iTVIO4GLOxHzyitqXoikkIsA==
X-Google-Smtp-Source: AGHT+IFQZnV0vK7G2LO3VqPoRgdasQdOAKBQKbAmNHtWEtSJ4MjSpFvm7zonHd8SkI+wRyuLOWjmnA==
X-Received: by 2002:a05:651c:547:b0:2cc:ea5b:ba6b with SMTP id q7-20020a05651c054700b002ccea5bba6bmr1177910ljp.26.1704670311344;
        Sun, 07 Jan 2024 15:31:51 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:98ab:a4f3:94cf:e2e3? ([2001:67c:2fbc:0:98ab:a4f3:94cf:e2e3])
        by smtp.gmail.com with ESMTPSA id s20-20020aa7c554000000b0055537e76e94sm3665691edr.57.2024.01.07.15.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 15:31:50 -0800 (PST)
Message-ID: <68a6d8a0-e98f-4308-a1b8-c11b5fa09fdf@openvpn.net>
Date: Mon, 8 Jan 2024 00:32:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] Introducing OpenVPN Data Channel Offload
Content-Language: en-US
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
References: <20240106215740.14770-1-antonio@openvpn.net>
 <d807ea60-c963-43cd-9652-95385258f1ad@gmail.com>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <d807ea60-c963-43cd-9652-95385258f1ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sergey,

Thanks for jumping in

On 06/01/2024 23:29, Sergey Ryazanov wrote:
> Hi Antonio,
> 
> On 06.01.2024 23:57, Antonio Quartulli wrote:
>> I tend to agree that a unique large patch is harder to review, but
>> splitting the code into several paches proved to be quite cumbersome,
>> therefore I prefered to not do it. I believe the code can still be
>> reviewed file by file, despite in the same patch.
> 
> I am happy to know that project is ongoing. But I had stopped the review 
> after reading these lines. You need AI to review at once "35 files 
> changed, 5914 insertions(+)". Last time I checked, I was human. Sorry.
> 
> Or you can see it like this: if submitter does not care, then why anyone 
> else should?

I am sorry - I did not mean to be careless/sloppy.

I totally understand, but I truly burnt so much time on finding a 
reasonable way to split this patch that I had to give up at some point.

I get your input, but do you think that turning it into 35 patches of 1 
file each (just as a random example), will make it easier to digest?

Anyway, I will give it another try (the test robot complained about 
something, so it seems I need to resend the patch anyway) and I'll see 
where I land.

Cheers!

> 
>> ** KNOWN ISSUE:
>> Upon module unloading something is not torn down correctly and sometimes
>> new packets hit dangling netdev pointers. This problem did not exist
>> when the RTNL API was implemented (before interface handling was moved
>> to Netlink). I was hoping to get some feedback from the netdev community
>> on anything that may look wrong.
> 
> A small hint, if the series is not going to be merged, then it is better 
> to mark it as RFC.
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.

