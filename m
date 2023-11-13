Return-Path: <netdev+bounces-47299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17B7E9810
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7691C20325
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAD1156D9;
	Mon, 13 Nov 2023 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MIUheSmK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9D16423
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:52:38 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA824D79
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:52:36 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso629327366b.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865555; x=1700470355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=no0g8tCe9M/ACnWMS4hSD43FezMf7B1awhK8Bk++Q5s=;
        b=MIUheSmKlivygXomBU6ibeUvSMt4hOZqKoTzpfEYurYGfP6mMcwv1vcSyZiqXZphMD
         hwVlJUe6XXOiEk1S/14yyb2c+NQhVY5l9uiZAueb2VlRfubYNWXFrrjBrpSDc4lNxxne
         jTf1GCc8Mk1KHCmO2pU9YUESXmXVoY1g1tg2Sye/Xw2ZGBo85Td8E0L9ZtsHwdaJ54K5
         oPxRUUfmmqzMg8z/NQDohBedf5h93tN0ea/L1Ahwepg20AfhOxx7vNOvx2BR098tmi68
         K+zTFr9/mQ2wGWjk/ISlnWTcEyDT6TJezuMbD2Ijc0/u+C2e+4uywMH4bXjbkuQ0Hk6R
         DNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865555; x=1700470355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no0g8tCe9M/ACnWMS4hSD43FezMf7B1awhK8Bk++Q5s=;
        b=G2vY+Py+D1SjyxgXDcCXe3gyXR1+f+/A5fMusw/akMsT9Da7bWnvPIPwReDsoGyqsw
         vCicYlDg6DXmf+90PuyG8fUGTYr9ZX9rNj1t+qDzHulNYggU/vqU1IK9hYKqjOvEMccG
         aVnG4WUl5Rfyqv6RMJCi1KWAkw+7kp4dQOrZPMjFANM5t5GFDx9Ikegltrh0/AhCbsgE
         4+VGVqRv+cb4MDm8fvl/yiRiTbAiiMgi9c1iWlgTLWK51bX6Nvqn77d6AvYM1c7+IxfP
         wRhCJa8aWiKe5Vg5/S4Ei97/fvaP3fRYGuJxXLMo0K9BfXnl7JjyfDR1PxQehwUPq/SH
         3aCQ==
X-Gm-Message-State: AOJu0YweL6bimaK7s17d/a3XU+U95BY65RNRFtA82bMgYSy7mOrCAJ3J
	vSyknqr1ZWijq8qzn6nmaK+oPg==
X-Google-Smtp-Source: AGHT+IFsly8j4gBEEmGzx7jG20mZD6SJi1vnR92p+ITKjkDMTySIEFv6aW3V8EYHTehBCdLwDahuDg==
X-Received: by 2002:a17:906:855:b0:9ae:82b4:e309 with SMTP id f21-20020a170906085500b009ae82b4e309mr4374711ejd.0.1699865555335;
        Mon, 13 Nov 2023 00:52:35 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b0098ec690e6d7sm3677361ejb.73.2023.11.13.00.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:52:34 -0800 (PST)
Message-ID: <ec3ce84a-8203-b33d-008d-0a49eeb11bba@blackwall.org>
Date: Mon, 13 Nov 2023 10:52:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 2/8] net: Move {l,t,d}stats allocation to core and
 convert veth & vrf
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-3-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> Move {l,t,d}stats allocation to the core and let netdevs pick the stats
> type they need. That way the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc) - all happening in the core.
> 
> Co-developed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>   drivers/net/veth.c        | 16 ++-----------
>   drivers/net/vrf.c         | 14 +++---------
>   include/linux/netdevice.h |  8 +++++++
>   net/core/dev.c            | 47 ++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 59 insertions(+), 26 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


