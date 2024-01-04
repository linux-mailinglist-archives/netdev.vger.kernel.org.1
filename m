Return-Path: <netdev+bounces-61527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6E82431D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684A71F25251
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B9224FA;
	Thu,  4 Jan 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Yuc/5jBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBE224E3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3374d309eebso383201f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 05:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704376270; x=1704981070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hu9wd786rx12aT/oHaTbS5ETRw/tZeb3iQfhejwi4Q=;
        b=Yuc/5jBYzSJiT8os/wiHV/ghhAyV8w+Dpj6vXefQahYnuvRF0AvIKHs6dT8NbkbSDq
         Mkv8DewF/z2Yvbzvh/YUPa0Lawsc91Hzlo1AZoORBXDgjHntB/b9M2XrRHwgj2SAH54K
         Kf0zJJnLvMwxArvvLJQZPyK3xpfUoM90S+mfcnwFQhpsaK6FruXOCHAN+9+nmqdyNK+i
         ONq9heGnJGmA0LjLF2SioFWu7fyq9hR9IF5n7INhJw0aC2vj7EZPCqPXagC0k47OvvXN
         rflawQ2SYHogsUE9jauascINFx0ZGA8K2l+ThgkOLDHyMBMHnUrECv/lOUn6UykV5FJ2
         oX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376270; x=1704981070;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hu9wd786rx12aT/oHaTbS5ETRw/tZeb3iQfhejwi4Q=;
        b=tth9iJ0S10QZtFuak+PkzShrb510h4+UyQPRjkXFt4ALTkmrlQFVzw8ICfXF0MtbQT
         NvFKuMLbJxisV3sYZWWTv9yc5h3Gh00FzA1iOMKrMx356sPAp9078YpHA/1maEyxFs7N
         1gc1ka9yGb2O9HQt3hJo92xQcY8Mj4d98Wj9axEyhWNzAdLJ6Zo1R4TTKybBU9qw/y7c
         Cdd4cXY4YCNwI7YC/WEupCw/QKCqzYoy+Xkyu9K+6V5DXkrUcD/N8RClFkE/k+CIMmTD
         NSMYXuNB43c5kjd5pHTh8NnPdruQbzprYI5F9HSNXvfFrsbDgxFlsvqXmkCEnXe22tK1
         kPiw==
X-Gm-Message-State: AOJu0YzC3P+69yEKGIq7cE73tVaZRyDFggPuBbO1G2T+oxFeDU0qIvj1
	8J5XIyWYfAgsBepg2v3E5mguNkE4sRVMXA==
X-Google-Smtp-Source: AGHT+IE7e958b8FjvDSmG6a5JCgdMoo2Ay28rzJusdTZlXygfYyLernAqcK/0brIr8hiq8vW8bD9Cg==
X-Received: by 2002:adf:e282:0:b0:337:9e8:f578 with SMTP id v2-20020adfe282000000b0033709e8f578mr342464wri.37.1704376269884;
        Thu, 04 Jan 2024 05:51:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:1b61:be9c:86ee:5963? ([2a01:e0a:b41:c160:1b61:be9c:86ee:5963])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm32882289wrv.89.2024.01.04.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 05:51:09 -0800 (PST)
Message-ID: <4e1d5b11-6fec-4ee2-a091-479e480476be@6wind.com>
Date: Thu, 4 Jan 2024 14:51:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
 <ZZVaVloICZPf8jiK@Laptop-X1> <0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
 <20240103132120.2cace255@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240103132120.2cace255@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/01/2024 à 22:21, Jakub Kicinski a écrit :
> On Wed, 3 Jan 2024 15:15:33 +0100 Nicolas Dichtel wrote:
>>> The net-next added new function setup_ns in lib.sh and converted all hard code
>>> netns setup. I think It may be good to post this patch set to net-next
>>> to reduce future merge conflicts.  
>>
>> The first patch is for net. I can post the second one to net-next if it eases
>> the merge.
>>
>>> Jakub, Paolo, please correct me if we can't post fixes to net-next.  
>>
>> Please, let me know if I should target net-next for the second patch.
> 
> Looks like the patch applies to net-next, so hopefully there won't 
> be any actual conflicts. But it'd be good to follow up and refactor
> it in net-next once net gets merged in. As long as I'm not missing
> anything - up to you - I'm fine with either sending the test to
> net-next like Hangbin suggests, or following up in net-next to use
> setup_ns.
I will send a follow-up once net gets merged in net-next.


Thank you,
Nicolas

