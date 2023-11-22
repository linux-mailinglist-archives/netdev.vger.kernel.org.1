Return-Path: <netdev+bounces-49986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890187F433E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC8BB20E10
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FC2111B;
	Wed, 22 Nov 2023 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muX4048R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5A083;
	Wed, 22 Nov 2023 02:08:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507f1c29f25so9032002e87.1;
        Wed, 22 Nov 2023 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700647679; x=1701252479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj6kLcO4H7xVgRAluQPUvuiaRmKUfdS5jqw/65rYvpA=;
        b=muX4048RWQmkhv9stYI5Wtqi4e4mPiR+e6yh/pQtxviYLPsXCkMn26WN0gGNGmlLJy
         NIjnh141QiTrdmXmVXLwGJUng/6hWs5EmxLn38dREzZG4nJkZx/OvFa3pnfxxroVyL4q
         U7mo8jpE8pW8ugaVEoecBRXrkhMAxrXPdnaBttghPFenhHCBoTf2Bu48d/DFHpm0fypp
         Fw725ypy/EYP4FrYwslkyNyrUXwuoHP3yer6yhc94g5fPqI+aPJYCPPXAb+ZZ64JEgAw
         fPqE5aCbt8FvKR/oHKEyh5X9nN1aDJqY4HxMlVTNkgHk9sqvx8sosp3XNes8PvDufwi5
         SJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700647679; x=1701252479;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj6kLcO4H7xVgRAluQPUvuiaRmKUfdS5jqw/65rYvpA=;
        b=XlEWnbG5En6Sawvb8ccWJLDWCa5piAFWzBqmH09jHd1F9ULCLa6tdp9aZ88CLd9tYh
         BPJl3elI5ifSV/Jaw9S/H/MII9vg9TJO0WbWMSPrT7sOvPGo9IN/HnLwTQb72QnpYCUY
         rH3tUxY5hHVS7m0FzRJnV9dxtrp/27cJ7v/uxvFK85YeBMqmemZUzKpdo6YPEa2RYKkU
         GfAwyls9+Tlatz78YlwXttnINLhnMEAqWD2RzFIL0GLlCVXdF5Q753vMCaZeWIS8FHkj
         /+9X7+jvdTZGi0JbeDKS+kHH4jSZh5Fd2nn5NCcUfNEFTQtUCOzphRcFVdKf3dwdkh6D
         DDrg==
X-Gm-Message-State: AOJu0YwBEVA7CWjiYWkH+nWLgvNgy5fDcJE/YZfH58+Ti47CMhijyad2
	5WFy1DmHBwKyvuJ6ji4GpgMhLcRZhjQ=
X-Google-Smtp-Source: AGHT+IFyvbZqYSaG/VBCSNqJ7mAuVYm2S1c+A4TGJ8KK3I/E5RouWfNFcCSfre+U2DLgFSvfTyDkgw==
X-Received: by 2002:a05:6512:4809:b0:50a:a940:2d81 with SMTP id eo9-20020a056512480900b0050aa9402d81mr1251323lfb.68.1700647678713;
        Wed, 22 Nov 2023 02:07:58 -0800 (PST)
Received: from [192.168.1.103] ([178.176.79.58])
        by smtp.gmail.com with ESMTPSA id fb7-20020a056512124700b0050abac6011fsm160848lfb.296.2023.11.22.02.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 02:07:58 -0800 (PST)
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
To: Oliver Neukum <oneukum@suse.com>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 dmitry.bezrukov@aquantia.com, marcinguy@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
References: <20231122095306.15175-1-oneukum@suse.com>
 <2c1a8d3e-fac1-d728-1c8d-509cd21f7b4d@omp.ru>
 <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <5a04ff8e-7044-2d46-ab12-f18f7833b7f5@gmail.com>
Date: Wed, 22 Nov 2023 13:07:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <367cedf8-881b-4b88-8da0-a46a556effda@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 11/22/23 1:04 PM, Oliver Neukum wrote:

[...]
>>> The driver checks for a single package overflowing
>>
>>     Maybe packet?
> 
> No, that would be read as network packet, which
> is precisely what this not not and should not
> be mistaken for.

   But "package" hardly fits either. Is it a USB packet or something else?

>     Regards
>         Oliver

MBR, Sergey

