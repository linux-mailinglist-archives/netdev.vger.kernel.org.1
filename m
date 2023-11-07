Return-Path: <netdev+bounces-46359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6B7E359F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B5DB20B02
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2B8C15E;
	Tue,  7 Nov 2023 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWQAU+LU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84717C3
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 07:15:52 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C4120
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 23:15:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32daeed7771so2703017f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 23:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699341349; x=1699946149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRzm56T7EUgRkqNvrdAiWVMpijVnh8MmrmIatfAwqkk=;
        b=XWQAU+LUQjc0kt1/oAAVPOQBqsUzmfdYqTRYBskXLkatyZ/jfkyGyGaAWbpsAhbvge
         n38d3uduJVNnQWBJ1SG78bfcfrgA7CunaLGbMU2QjNM0b54kdV01qXOQT0U/sWDZvlL8
         VU9gI8CeQGkJEVPdAdDoD9U/daSaD4bdnwxe5vk437YUrSfi9UYYFRwamUjBat1Fk5Ry
         VyPVYnmkHd+lS6nANfmQNI5ZJtpPtlZr+eUKJaZCdcYL20kNV6fRBg4xPw/sdS9V/twY
         KueEaQFUXImTKtOzhun5gO0x/gpcGyh/A/fmJRr4XKxLAEQNWMf756N4LPA3NJIL3Lg2
         FvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699341349; x=1699946149;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRzm56T7EUgRkqNvrdAiWVMpijVnh8MmrmIatfAwqkk=;
        b=Eb8QepT/u789JQ5fP0v8ftkCFWMBkUUaZwRsDQWRzhZ371u2UNkqVs48zIKdjn0bs2
         KBbMjXvnhy24946kJkPocODnEXoXbcgAysU1xtm0v865o9bqb/lGGU7xSef0MVNgB++S
         ZUOe78bXu7byQHksUPVhTmajpNIJru+PiqrlHLhQFf1amYHvLfD0yYywwRINqUAzNBzb
         gnjgTR4N/cIKS2YLpAUr9YdHl6TIPqgf5BvPvBxKuj7UxzEJqmHlx8Q/QiS/390iiNMO
         D5VZ7VEhCQ5Y6Rm1XQHzK3Zsvc9/A1BCvMwbxA0zESBZzK5lnbN4cWXAgX0kVLes3V7X
         JiFQ==
X-Gm-Message-State: AOJu0Yz6hmFeL+rRD1qsYcHCiDbOEZBwMocn1jhvvcUfO0MzmncH1cch
	MCxekMaO0hZWwdSz9quOIHQwlamE8b8=
X-Google-Smtp-Source: AGHT+IH0l+/C0x2rBbGh7zU/Zli8cAqaLFKLL0xV2Z8WTczWUbF6oewwL7IGuT1jLrgTHXMQKupDDA==
X-Received: by 2002:a05:6000:4020:b0:32f:acb1:ba9b with SMTP id cp32-20020a056000402000b0032facb1ba9bmr12115578wrb.22.1699341348719;
        Mon, 06 Nov 2023 23:15:48 -0800 (PST)
Received: from ?IPV6:2a01:c22:6f6b:1c00:45f5:1cd8:f090:5720? (dynamic-2a01-0c22-6f6b-1c00-45f5-1cd8-f090-5720.c22.pool.telefonica.de. [2a01:c22:6f6b:1c00:45f5:1cd8:f090:5720])
        by smtp.googlemail.com with ESMTPSA id b18-20020a5d6352000000b0032f933556b8sm1496783wrw.7.2023.11.06.23.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 23:15:48 -0800 (PST)
Message-ID: <5ff51bab-52ea-4f9a-a1ba-31b26d21a8a4@gmail.com>
Date: Tue, 7 Nov 2023 08:15:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: fix network lost after resume on DASH
 systems
Content-Language: en-US
To: ChunHao Lin <hau@realtek.com>
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com
References: <20231106151124.9175-1-hau@realtek.com>
 <20231106151124.9175-3-hau@realtek.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231106151124.9175-3-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.11.2023 16:11, ChunHao Lin wrote:
> Device that support DASH may be reseted or powered off during suspend.
> So driver needs to handle DASH during system suspend and resume. Or
> DASH firmware will influence device behavior and causes network lost.
> 
> Fixes: b646d90053f8 ("r8169: magic.")
> Signed-off-by: ChunHao Lin <hau@realtek.com>

Also here: cc stable
With this:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>





