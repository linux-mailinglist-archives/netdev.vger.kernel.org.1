Return-Path: <netdev+bounces-60393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE681EFD6
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 16:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446BB28261E
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9FF4596A;
	Wed, 27 Dec 2023 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="seFe0ogu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE445023
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5554e43adc0so914772a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1703691904; x=1704296704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdjJv1uuqltdQ3TMTpUu/ZbNucAajnnY0rLtv/lCBKs=;
        b=seFe0oguCUcZbheHM0CEzJAmE7gtrErwr2+KxBP9wqqoCeFv1/IvrOZkD+wnU+HSPh
         5L065v+Y4NNnE0RW0dzyLrmO8NbtgviiF3FV7Fe3GEoSED+GVTzIyakOuTn+7dGEgbMX
         4KJCRJo1IvocENmrtay5oyhPCq2A52dhquDhlI8SNJQw7/vfdhyDt93YcabXIM5sLFx6
         WQEyVMhsMnVUz38lcIlG0l8p4hmuo/snNd8ql5QHA6oOOgr+R8kek+rYdtTm4YO0NAOj
         X2t9O44yQmbnwzkdCOLl48Wb35MWrhaXJdokIzd+zGiw/wLhQdlLQgYiaKDZ2yvjJCJm
         jacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703691904; x=1704296704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdjJv1uuqltdQ3TMTpUu/ZbNucAajnnY0rLtv/lCBKs=;
        b=D/qHvMaS/jO5pgtDMZsaiwcUKKpRweKbEi3UtTyGbyN4tlVXM+zX+GeQ/bmQ9drRch
         gEXfNamaQMHw5sPav3xy8rfg1zrZts65GXY/+PhLIIFxRPOHZMP0Mrj26y4/nFgrFwd8
         0VGQtvo5q0xwK7TworFc5gwbZy5ooQy2B2UUUANewguDMsNfmBs167JlqLi9w/s0/xlt
         oeK63eXcgmJcaqrlFJPOygTsBQJkrAvSg24gzpzE2nvRrHize0KdbOEO3B3ClNH6KTbS
         SPi30TA3zBxvyIysje6OFHVTgf1lU8AasjpkCW7xX1WveQvljlh6shnViTjup7/qxfX0
         dNgg==
X-Gm-Message-State: AOJu0YxGt6Dynrphz3uRkW4wMSZWR/47KQWaq3aOb5gExcs397pqiKCJ
	wwe002qr0HqUEFCyu2pBM6iLN+iLKvt6UQ==
X-Google-Smtp-Source: AGHT+IGl3DcIk07cA7u/sbhKpP54AakxOf8FwMob6hgaz/DqOvKnBu/LWQxqw2GCWOStLHSZFRFtqw==
X-Received: by 2002:a17:907:6d17:b0:a23:35e9:579 with SMTP id sa23-20020a1709076d1700b00a2335e90579mr5886105ejc.33.1703691904141;
        Wed, 27 Dec 2023 07:45:04 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906a29300b00a26988c8772sm6624161ejz.214.2023.12.27.07.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 07:45:03 -0800 (PST)
Message-ID: <d7d084a9-16bf-41ef-8767-5291b15398bd@blackwall.org>
Date: Wed, 27 Dec 2023 17:45:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] bridge: mdb: Add flush support
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, petrm@nvidia.com
References: <20231226153013.3262346-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231226153013.3262346-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 17:30, Ido Schimmel wrote:
> Implement MDB flush functionality, allowing user space to flush MDB
> entries from the kernel according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  bridge/mdb.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++-
>  man/man8/bridge.8 |  67 +++++++++++++++++++++++
>  2 files changed, 203 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



