Return-Path: <netdev+bounces-52437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634397FEBD1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C8E1C20D30
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6436AF5;
	Thu, 30 Nov 2023 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FcAgEYQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FB8F
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:26:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b18dbf148so644116a12.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701336418; x=1701941218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmA/HYMrDk71qC2ZO7rQ5U0brK94y3tBM8HrbpJttyo=;
        b=FcAgEYQjoehOZRh3HJODGxUVy8dsxir0jjCwMGzQrGOJDAgf9xepR5H8orSBW/IqTZ
         Zb3PbiSIVk/JgsTEJtdDn3kVmV7AYgMGMG+g1XE4hluFLkbPXoxn66oiqaePLOXHSc4Y
         k0ad2U7gvyasBxCULgq8gnwzGhiMVdT44JSqn8Dsmjgz2aGp+XCaet16b632XfNmwvm7
         +Jol2SUGsf/w0GCYqxSElCux3mk7oWT2pIGKpJwg8Zt1cxFfOcodbmWeji16zuaF7171
         nbU6Mv8y3pbRc1shorW0vDgTuD94fwmWySNiXNBWloDWaSTy+2KD/oDq7B9hYrZ5p1jf
         ybNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336418; x=1701941218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmA/HYMrDk71qC2ZO7rQ5U0brK94y3tBM8HrbpJttyo=;
        b=nBNr0B+9qekHZIoYOFNslxOfOZAU7Jr7dIbKd9j3ByEsXHsKC9zpjZ6LDxYZrg/RlL
         WISxvyf7c7qzKTEbFIbpFMqg4IxUfM0ij4WMeSd+90EMkbge0WAO9Pmm2UkbgghaeoY3
         W8HPK/jVxsHeGYQ4FWiktqde/wcABRMHZ1Kic5m3PTQt4dWt03SChMJrw6Wrx89/lwtQ
         6y2pTPV8o4llv0dD++VzL/seMWTNg1PfYjLkaddmoR0W5HEBCLcruGgPWAmninZjYDQH
         GUtoQGLdeccpa6WWK1Fgo/mnh0EJUC5HccYpkFebzdfYcuFsDZvlYxf4uI+VVTbsznPo
         QeoA==
X-Gm-Message-State: AOJu0Yzq8ZHSnn6GQMiRQV4KWiQIbbkoIKnWZt/XXZwxkrn9DPUTqcJO
	WvsTtUBKLHkl5fxWIizvqw4Y4A==
X-Google-Smtp-Source: AGHT+IFKfAqqM3TxKmVd40nrTNjxnPg+yr0ddKjKa60ImvKDFw0ILmLDqKGKJwMu3KeMdgpUFs0xug==
X-Received: by 2002:a05:6402:5141:b0:54b:1cdc:ce23 with SMTP id n1-20020a056402514100b0054b1cdcce23mr11657650edd.31.1701336418055;
        Thu, 30 Nov 2023 01:26:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id d15-20020a05640208cf00b00543b2d6f88asm364252edz.15.2023.11.30.01.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:26:57 -0800 (PST)
Message-ID: <8be2ac60-ca17-45fa-8666-6bf6dbbe7441@linaro.org>
Date: Thu, 30 Nov 2023 10:26:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: fix fortify warning
Content-Language: en-US
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: netdev@vger.kernel.org
References: <20231129170352.6050-1-dmantipov@yandex.ru>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231129170352.6050-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/11/2023 18:03, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231129 (experimental) and
> CONFIG_FORTIFY_SOURCE=y, I've noticed the following:
> 
> In file included from ./include/linux/string.h:295,
>                  from ./include/linux/bitmap.h:12,
>                  from ./include/linux/cpumask.h:12,
>                  from ./arch/x86/include/asm/paravirt.h:17,
>                  from ./arch/x86/include/asm/irqflags.h:60,
>                  from ./include/linux/irqflags.h:17,
>                  from ./include/linux/rcupdate.h:26,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/ratelimit.h:6,
>                  from ./include/linux/dev_printk.h:16,
>                  from ./include/linux/device.h:15,

Not that relevant...

>                  from drivers/nfc/pn533/pn533.c:9:
> In function 'fortify_memcpy_chk',
>     inlined from 'pn533_target_found_felica' at drivers/nfc/pn533/pn533.c:781:2:
> ./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'
> declared with attribute warning: detected read beyond size of field (2nd parameter);

This is unreadable. Please trim the logs to relevant parts preserving
formatting.

> maybe use struct_group()? [-Wattribute-warning]
>   588 |                         __read_overflow2_field(q_size_field, size);
> 
> Here the fortification logic interprets call to 'memcpy()' as an attempt
> to copy an amount of data which exceeds the size of the specified field
> (9 bytes from 1-byte 'opcode') and thus issues an overread warning -
> which is silenced by using the convenient 'struct_group()' quirk.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The subject PATCH should be with net-next, so it will be recognized by
net-dev patchwork.

Best regards,
Krzysztof


