Return-Path: <netdev+bounces-43721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DC37D44EF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E011EB20E0C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A653B9;
	Tue, 24 Oct 2023 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0RvEhf/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EF15D4;
	Tue, 24 Oct 2023 01:25:14 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1B110;
	Mon, 23 Oct 2023 18:25:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso2862008b3a.1;
        Mon, 23 Oct 2023 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110712; x=1698715512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iccc72CUWL+tdQoo/lU2s24lxXNfe553vrT60nkWVyQ=;
        b=j0RvEhf/ezBmwv+oxaPDCvBA1UTmHkMb4CnWGVY6BXsOCuUVfXSjmmxkZld6seJnue
         W+ukk5W3IOfNYmYzJNb5GHVtz+ejKII3NI7KByZL8ai5mKVN5PlT+KEIG6XUglpMqyrN
         DNL0ekKYRtVtqml8Lq3idfg5+WGCUVDR+ucaqMVwhJ8EUDEmk8Atq3rcl+U0ruE1m9JX
         REEMhvgnHZu9cUT1wXjgj8dXnAX5JOqw+viVmewFpiE2choM4+r3zl+wtOfX/tg5uCsc
         rnV13TBo9rmviBDbjj291HKhE+7fkbsRwucfgOeuUyimsJD6d0zovXMI5c5Ke8qHLA82
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110712; x=1698715512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iccc72CUWL+tdQoo/lU2s24lxXNfe553vrT60nkWVyQ=;
        b=HOHpJ8/bmtN82QSNZVbM/4PtKrqPUvHn845B9sQjY8gK97iQ3T4ttgVY55RJytScAa
         BFnrUippiiKurcF0mTxDXGqXvt8fGpkz5k8qEZyT6FEeMNqtV3YmUeL5ZgF4tt/Mk6aY
         fueCTsdJWpC6r7H+g/Ss+21DM+tAG7CTvWScmYfokeeDjYZkr19vDk+97Qlx9rFe4DTV
         1cJMfLSrp1dPOEv5BAHxiSk6c/CMZ6MXY9NNz0msb1AQe8LjktVnbsYynYloYD2kmnDk
         tjzuVKA3XMse4AjwmT5XbOjiUzr8bBirgwRNriCdPb2ECJHh6z5W3GgaQ4q6Nve4Hh7G
         eCTA==
X-Gm-Message-State: AOJu0Yzid22Ha7bPxKUoEUssolLiERU0oLN3XugqbZpd6mkOHzayHkuj
	Sf9WfFAA0gNNhs1Wdkx/5GJ8AXWM59U=
X-Google-Smtp-Source: AGHT+IG2mAsmvq3VqKl8vDHOkpG6e+H+tw6ktt9pYQRZCSBiLKM9r3sEo4EzliuxdE1EY93mHqpFuw==
X-Received: by 2002:a05:6a00:2daa:b0:68f:cb69:8e66 with SMTP id fb42-20020a056a002daa00b0068fcb698e66mr14191135pfb.15.1698110712359;
        Mon, 23 Oct 2023 18:25:12 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm6757110pfp.56.2023.10.23.18.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:25:11 -0700 (PDT)
Message-ID: <3332cc4b-8143-48e8-90ba-673ba417a660@gmail.com>
Date: Mon, 23 Oct 2023 18:25:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] r8152: Release firmware if we have an error in
 probe
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>, Jakub Kicinski
 <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: Edward Hill <ecgh@chromium.org>, Laura Nao <laura.nao@collabora.com>,
 Alan Stern <stern@rowland.harvard.edu>, Simon Horman <horms@kernel.org>,
 linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Prashant Malani <pmalani@chromium.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/20/2023 2:06 PM, Douglas Anderson wrote:
> The error handling in rtl8152_probe() is missing a call to release
> firmware. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().
> 
> Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

