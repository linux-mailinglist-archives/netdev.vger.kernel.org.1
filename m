Return-Path: <netdev+bounces-60439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202B81F47F
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 04:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2E11C21752
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA31106;
	Thu, 28 Dec 2023 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8AbI+cU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08340136F
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2046dee3c14so1482543fac.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703735832; x=1704340632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnDgjcXXRrrUQ5Nuc9aEzX4ejqPoR3JYsbDDB3CztFc=;
        b=f8AbI+cUB5QKriss0ztfvwY8kOeIGBxSjK+fOQrw1i/h6O6mBxkEJtkVnYhjVodXjY
         b6YKUXR7ascCYoy3aN2E9LQ7mWTPHmhCYlRzXvBBGrf1pt4qnqI/v1nQcYGuA92QQ7Qm
         KFlqBzzWWZQnwFvKY9w4+HWvynbWE+SDuAQLzhInofTNpoch8xXPTfDpTP0qIf0kcy0D
         KPb0EB5JHr5Cquxv14ODu3zaFxLqfWfmvIOdBrWQKxIWMXpJ3RVvYiSOW5br7FfBywRT
         AB6c3fU0b1Ydm1X5fxzHJoU1ELZYIWPLJaa8QSinG2I5WsOT1A3muOGyC/KGDYua4r9x
         Ycpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703735832; x=1704340632;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnDgjcXXRrrUQ5Nuc9aEzX4ejqPoR3JYsbDDB3CztFc=;
        b=tFU6R6kqoBHAyrniPYhOE0h3lSIPm/yKcUTJYx1WW9sJREWXOJqbUJwy5YnltgB+4k
         1LjxQB0z/I8VsRvp3ooGT+JUy1aEM16aARcj1+pyE2ct0ECHvJEchiPvhzy+fJk3p8vf
         ifMqOevFY7DO6GgdmiTIIhwDNucedmbrOwgHhEn5RmlHCtSwnpqw07VGPXeeFa8rWa64
         3uRsvtKTI0tfTGty++GQkBoNhpNRH7lj0NZwy83eDyxsqyBAOsUYR3N/mk6lsz8RuPow
         1OGwtIcTRUXDle11BuDTWxqU9DMVB0kRYQDPghKeKeoyCwY+fvJudSEpgcBq75s2d0tg
         Zc0w==
X-Gm-Message-State: AOJu0YykEjOPDB9dODXYyzIbfCvtXBqSZ1XOm6khojLBY/mELSrjCJ9z
	JePJ5uOKaZtCp6QelaXWrWkpaAU+EvI=
X-Google-Smtp-Source: AGHT+IE4XaW1FhUkr1AsU8HSKEphWZa/OaJCpZqrRJKsfABKv9OEOT7GFnPmVhr6WVB7t5ZSEjY3Uw==
X-Received: by 2002:a05:6870:40c6:b0:204:42c5:8cb8 with SMTP id l6-20020a05687040c600b0020442c58cb8mr7734084oal.15.1703735831930;
        Wed, 27 Dec 2023 19:57:11 -0800 (PST)
Received: from [192.168.1.89] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d70c5000000b006d7eaaa65a4sm2445449otj.71.2023.12.27.19.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 19:57:11 -0800 (PST)
Message-ID: <ac91d9f3-0651-4c66-9d38-c40281150ac5@gmail.com>
Date: Wed, 27 Dec 2023 22:57:10 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 1/2] configure: avoid un-recommended command
 substitution form
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20231218033056.629260-1-eschwartz93@gmail.com>
 <20231227164610.7cbc38fe@hermes.local>
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <20231227164610.7cbc38fe@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/23 7:46 PM, Stephen Hemminger wrote:
> On Sun, 17 Dec 2023 22:30:52 -0500
> Eli Schwartz <eschwartz93@gmail.com> wrote:
> 
>> The use of backticks to surround commands instead of "$(cmd)" is a
>> legacy of the oldest pre-POSIX shells. It is confusing, unreliable, and
>> hard to read. Its use is not recommended in new programs.
>>
>> See: http://mywiki.wooledge.org/BashFAQ/082
>> ---
> 
> This is needless churn, it works now, and bash is never going
> to drop the syntax.


Per the patch message, the reason to avoid the syntax is because it is
confusing, unreliable, and hard to read.

It was deprecated for good reason, and those reasons are relevant to
people writing shell scripts! Regardless of whether it is removed, it
has several very sharp edges and the modern alternative was designed
specifically because the legacy syntax is bad to use *even in bash*.

(bash has nothing to do with it. But also, again, this is not about bash
because the configure script shebang is *not* /bin/bash.)


-- 
Eli Schwartz


