Return-Path: <netdev+bounces-49177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61C7F10B1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366292802A8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B646118;
	Mon, 20 Nov 2023 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oyz9Wlzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA8F7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:45:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fd0059a967so193567366b.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700477108; x=1701081908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEGM8ev0APvf3tLYEQebZXb/D0A2uaiSExo0/kQhZG0=;
        b=Oyz9WlzdoI5o5V//eW3QSSkJIoSQVQv3wIWFk0JciwpsRs5MtA5nDb+B6vcKrveMhP
         7OFPE61Ts4DGx1fa30J5i6aDFuojZUpnccEF40/zFDkfZ6fJoYamVe9Tqygqety0jZhk
         mH993JNh/gWmTOEH36F5mqtq6ff7IY0dJvmbX6uZ0UtLOY2AzHrxRKzw1LEbMK4+mVdU
         re5IzyhZSyoIkgSODIlCFIRE4C/j1KTMsxSe4GybQJ760mpd5e8/TIRQljDoubhSZBI0
         I+gpeScraINRWIiBSv0ct6w5iBFkgnBUpujv5bmFwsZ0rmKxQ2+tHg2cuDwGSj97OfTS
         BG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477108; x=1701081908;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEGM8ev0APvf3tLYEQebZXb/D0A2uaiSExo0/kQhZG0=;
        b=LtdeRrXWad9VPGGmNOcl3iuHoLMPLi8p0Xq0lBfp0JI3/4gESTcLNpmaQ9gCzCgW9e
         ImaG5eHm2QrPTorg0s0/tspHOJmu57btEVfF8zLhOYvEIBITrDoqlsuPPLRNV8XXkgda
         hz8hPqV9hFJn4Q5BmcLghWMTnLu11hH5zFxuo/ALLB5A2w4Py5DrUImb4KYcWNLmPoiS
         7aJI2cBwEu/wHL8xQulC2ROCjrRPUMabrefMPKSfKvT6oJhqRskQDpD+d7WutxFgbsf0
         +G0+nr0fWHEm7tRqQgl4mlXtpWzgcM5RTV7P+6Ix/u2oYd4Eb6WjQOi6wUXEi7K+v9MD
         zLBQ==
X-Gm-Message-State: AOJu0YwTKLlvUd91FhO6yeTwo3CKEFVP7BI9ADNlsU3eZHjwZsOsq9jU
	u/7QU5WAB5vB2V0jKlxZ94hp9gMzhOndmYpaiDU=
X-Google-Smtp-Source: AGHT+IEjP8sPK0UFipMOi0e2LIEYHnmhsDWqIRUN1UJ/6btEhdrsFuvC8BQ0XgQUHicCUPuUNIHwYw==
X-Received: by 2002:a17:906:259:b0:9ee:85ed:3196 with SMTP id 25-20020a170906025900b009ee85ed3196mr1455343ejl.0.1700477107696;
        Mon, 20 Nov 2023 02:45:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id lz10-20020a170906fb0a00b009737b8d47b6sm3732334ejb.203.2023.11.20.02.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:45:07 -0800 (PST)
Message-ID: <d82e5a5f-1bbc-455e-b6a7-c636b23591f7@linaro.org>
Date: Mon, 20 Nov 2023 11:45:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is
 running
Content-Language: en-US
To: Nguyen Dinh Phi <phind.uet@gmail.com>, bongsu.jeon@samsung.com
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com"
 <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
References: <20231119164705.1991375-1-phind.uet@gmail.com>
 <CGME20231119164714epcas2p2c0480d014abc4f0f780c714a445881ca@epcms2p4>
 <20231120044706epcms2p48c4579db14cc4f3274031036caac4718@epcms2p4>
 <bafc3707-8eae-4d63-bc64-8d415d32c4b9@linaro.org>
 <20d93e83-66c0-28d9-4426-a0d4c098f303@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20d93e83-66c0-28d9-4426-a0d4c098f303@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2023 11:39, Nguyen Dinh Phi wrote:
>>>>           mutex_lock(&vdev->mtx);
>>>>           kfree_skb(vdev->send_buff);
>>>>           vdev->send_buff = NULL;
>>>> +        vdev->running = false;
>>>>           mutex_unlock(&vdev->mtx);
>>>>   
>>>>           return 0;
>>>> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>>>>           struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>>>>   
>>>>           mutex_lock(&vdev->mtx);
>>>> -        if (vdev->send_buff) {
>>>> +        if (vdev->send_buff || !vdev->running) {
>>>
>>> Dear Krzysztof,
>>>
>>> I agree this defensive code.
>>> But i think NFC submodule has to avoid this situation.(calling send function of closed nci_dev)
>>> Could you check this?
>>
>> This code looks not effective. At this point vdev->send_buff is always
>> false, so the additional check would not bring any value.
>>
>> I don't see this fixing anything. Syzbot also does not seem to agree.
>>
>> Nguyen, please test your patches against syzbot *before* sending them.
>> If you claim this fixes the report, please provide me the link to syzbot
>> test results confirming it is fixed.
>>
>> I looked at syzbot dashboard and do not see this issue fixed with this
>> patch.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> I've submitted it to syzbot, it is the test request that created at 
> [2023/11/20 09:39] in dashboard link 
> https://syzkaller.appspot.com/bug?extid=6eb09d75211863f15e3e

...and I see there two errors.

I don't know, maybe I miss something obvious (our brains like to do it
sometimes), but please explain me how this could fix anything?

Best regards,
Krzysztof


