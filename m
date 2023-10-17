Return-Path: <netdev+bounces-41792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D47CBE70
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12981C209A4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7E73D974;
	Tue, 17 Oct 2023 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tOb6p5+N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780238FA0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:06:11 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE093
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:06:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5183306f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533568; x=1698138368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qA7yQpTMUNBHSQCogbhz+FKzV5+XqR4AHXCW8qRlHDA=;
        b=tOb6p5+NKtdEs0tR/2JxVqEbAHvSdyR9xcVVu3SX7SkUH2X2GD7VKGlBgtDiI/HXzq
         hEMKqLa2daXs4V3bNT/kdnCRVewBi2WTc5wpzOSw7+dEEJM3eTaVkgZ0w8l5aWwW+kdn
         mms9lbPOejn2jWNdrSgSmu1kIvPBXVIBzI0B16NRrkbfyzGPFS4VAb4burwB/OVJMytg
         7fm3+2UfrLaLHMSGUmmzXT//OT2i4kaIcSjLJVBG2lXQ1IAYPDErWC82ZzwBfw8J/u3q
         oF3d+Enw6+isZmqVQks7C02I6CS/9QbiSTc3aoAY/rV5SLpoi114zlF1vyiKQ+ertzYO
         HQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533568; x=1698138368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA7yQpTMUNBHSQCogbhz+FKzV5+XqR4AHXCW8qRlHDA=;
        b=wuJAzPEsbmeZAgNSkdzjMb2J434kwd0zE5mBtqdrFzcg1xF4FsXEJPbWUwfp1gfAnu
         QrJ1LTRC6e7LacMsDdz+5jLKTCzGsx2PPTMAwgTB1n5lg0MLBdpbsi00eKXqRwb+AqHb
         w5N/xBHwXPoeV+Up9qe4e8T/X7NeeRSvdwU0eyMsfCXg0qgc/SNW8hBGd/25/bs4/6Yr
         fFKU7Y1DHi4Cl/uEiWcAdv6zGRzQmXOt91b85MJs0vS6upRD9oZo+PbK+3HJoOD0stcZ
         mn1QALYN42ZTqYoWpx+lNHaQoBwSp3jsHZhgUVFUu1kNEXNrryf8pLUBw/2xFqC/3VJY
         jItw==
X-Gm-Message-State: AOJu0Yymi1s84rVdvh14oVi4Fd6qDec0sBD3vK24EQmuHfqmkiRgEfYA
	MBBrt1kO7FgZOoH4YqQTcBy5Xl7B4QWn5QI1He2ZYefKjnE=
X-Google-Smtp-Source: AGHT+IGmIebJbkbjOBEPa5EIHmOhIa+mOXQR5GJ8J4ulCwPgttY9t9PBuAEc6T1teTGiWBAjWm8CaA==
X-Received: by 2002:adf:ffc3:0:b0:32d:a469:a1b with SMTP id x3-20020adfffc3000000b0032da4690a1bmr1589243wrs.62.1697533568192;
        Tue, 17 Oct 2023 02:06:08 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id j17-20020adfb311000000b0032d9382e6e0sm1223085wrd.45.2023.10.17.02.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:06:07 -0700 (PDT)
Message-ID: <7549f41b-2a31-238a-655e-4de2f01d1ea4@blackwall.org>
Date: Tue, 17 Oct 2023 12:06:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 04/13] bridge: mcast: Rename MDB entry get
 function
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-5-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-5-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> The current name is going to conflict with the upcoming net device
> operation for the MDB get operation.
> 
> Rename the function to br_mdb_entry_skb_get(). No functional changes
> intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_device.c    |  2 +-
>   net/bridge/br_input.c     |  2 +-
>   net/bridge/br_multicast.c |  5 +++--
>   net/bridge/br_private.h   | 10 ++++++----
>   4 files changed, 11 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



