Return-Path: <netdev+bounces-60438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDD81F47E
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 04:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E15D1C21B0A
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B81106;
	Thu, 28 Dec 2023 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AliLY3+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BF3C0B
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dc07ce2a30so472365a34.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 19:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703735636; x=1704340436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vug8/uppdmBGpWeuyV2BxNNVwAX2ay5weQBiWbkRAiA=;
        b=AliLY3+fUP2tn6beOYvPb/9o+kq2U5NInsoCCrF/QPqiFjcKMsGTFXUFeRg7MqohWw
         dh7QMD9fw0SpRND2H5x+5BtW0N0HIgdg/u3iLEkWmE58Ch0f9WlSCPelcMjAzZrotwkx
         qGuapd9G1YWz7F1SJptKOX/CHO48a9vj/P3XxmMuv59c0rF0JQhxd2Dp4bjoSl7rnEKF
         M4VuVS4bNaALKnQetr7vJYZNlf0dkAgs/aV1ryncD7sKE5ggw0znzjmfYPQvLXOcYXPN
         vxmFGw5Ex61TSNwddw4hesAjDMz4l/JNeGcg75+24sBFYorQ8YRmTqlJTvEnEpO0a3/o
         m6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703735636; x=1704340436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vug8/uppdmBGpWeuyV2BxNNVwAX2ay5weQBiWbkRAiA=;
        b=wfkSXNsyziRO7unKnb56NdxnL10B8digYkANqk0pLtHnUV1eCadAKhnmZv8RULLHDn
         HOApy3Zsp0Z37C8tOplgDM1KwOfdU9GvvTDbCDrgjzE2QSqWJUXXUNaHxCCfOHWEc5o/
         UWNaaRkBeWDA3IkpxKRuQhCRaqlv33ztqByQaqmf+WCb8nyQxOyS66Mzfhjji/VJ3kwc
         rvvsAMynsOWs6eCTM/xqVz87k401M1fVaQUOezhgBRzq+GSxyPMzlAsOoTQHHjd207KY
         UJ37O2/R1xvN2THkVPWQl+87VCgQr2f9iju5Z4/UwU/6eStCawpTLwoZOVCG2VCzoDCQ
         4USQ==
X-Gm-Message-State: AOJu0Ywng+3MV4XYopunLuWINmyGuP0ELf3NRZxH/Sk1x2KEJWKhBsms
	sWowMvrF7bFKq7JYELm9RArVREniMfk=
X-Google-Smtp-Source: AGHT+IG+YotjpP9/ahTWlUYk9EUqcTk1Aqr+QUqzUtCnCoSr5AMQAzKcYnzfnIrv2ypgInhfDQIpGw==
X-Received: by 2002:a05:6830:2b08:b0:6db:9d14:706a with SMTP id l8-20020a0568302b0800b006db9d14706amr6559753otv.63.1703735636420;
        Wed, 27 Dec 2023 19:53:56 -0800 (PST)
Received: from [192.168.1.89] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id l35-20020a0568302b2300b006d9a339773csm256352otv.27.2023.12.27.19.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 19:53:55 -0800 (PST)
Message-ID: <bdb424b0-2d11-4f6d-994d-b2b959098faf@gmail.com>
Date: Wed, 27 Dec 2023 22:53:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 2/2] configure: use the portable printf to
 suppress newlines in messages
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20231218033056.629260-1-eschwartz93@gmail.com>
 <20231218033056.629260-2-eschwartz93@gmail.com>
 <20231227164645.765f7891@hermes.local>
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <20231227164645.765f7891@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/23 7:46 PM, Stephen Hemminger wrote:
> On Sun, 17 Dec 2023 22:30:53 -0500
> Eli Schwartz <eschwartz93@gmail.com> wrote:
> 
>> Per https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
>> the "echo" utility is un-recommended and its behavior is non-portable
>> and unpredictable. It *should* be marked as obsolescent, but was not,
>> due solely "because of its extremely widespread use in historical
>> applications".
>>
>> POSIX doesn't require the -n option, and although its behavior is
>> reliable in `#!/bin/bash` scripts, this configure script uses
>> `#!/bin/sh` and cannot rely on echo -n.
>>
>> The use of printf even without newline suppression or backslash
>> character sequences is nicer for consistency, since there are a variety
>> of ways it can go wrong with echo including "echoing the value of a
>> shell or environment variable".
>>
>> See:
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
>> https://cfajohnson.com/shell/cus-faq.html#Q0b
>> ---
> 
> This is needless churn, it works now, and bash is never going
> to remove the echo command. The script only has to work on Linux.


I think you've misunderstood something. It does not work now, because of
the reason stated in the patch message.

Whether bash does or does not remove the echo command is irrelevant.
Bash is NOT the only linux /bin/sh shell, and "it only has to work on
Linux" is NOT a valid reason to write code that is designed to work with
/bin/bash, but uses a shebang of /bin/sh.

Would you prefer to change the shebang to #!/bin/bash instead?


> Plus, the patch is missing signed-off-by.


I'm more than happy to send in an updated patch. :)


-- 
Eli Schwartz


