Return-Path: <netdev+bounces-45431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476267DCF36
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F63281183
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C33D279;
	Tue, 31 Oct 2023 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gGlQULeW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE901DFC8
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:30:06 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19736DA
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:30:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso44355731fa.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698762600; x=1699367400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQd6ocLhz7maRA1sv4oi7Wny7pND/vG9Z60ZXy7HS80=;
        b=gGlQULeWmSaiUQmcnlFHE6f7ni6BpJvW9wzUu/s9gMGGIaQ09jxtEHH5t5YkWJ34I5
         rNr/GQnm5GrfZVWBOgR7z2BL7FMSOCiMm+Vt6IXFTh7SH4ylvgFRYN9ghq1046OZJ1Ur
         CGXg0MZYKO5y/EVB3wCW9GjsAKN8Nr5GjKTCWOugvBKKK8TVQKp25sJcZroJOz8eEs1I
         zeABnK0wzLf1SZ2edwNkpaRQPLstkKQJCaSCs+h/jGwM/aXVvwfeYVLKwhiXrXNVg9qO
         bZOrKfVyzwNOyBWdtukHEscmgldskv+hculBP6SXTnAHmoq+SiqMMdZdSYVBXOdcuwGf
         AE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698762600; x=1699367400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQd6ocLhz7maRA1sv4oi7Wny7pND/vG9Z60ZXy7HS80=;
        b=uj9Y/4Paz2iJvFRgu50lK0I6CwxxEpJcqbckBKtsKim6Fqm+jeyv+MlA3oGpyOB0Vm
         klRdVLnFj2vA6WDAA4poyo2/GC8iNiL34AtfCnN35gTHcjYy7ug/EObYealKB5RERVLn
         EqnK0gU80FUPGwKkOst0eSa5Fv4G81z7iei0hUGPu7pp8NaVn1yAPV/t5qZsIiL2bQCo
         j/bOYJVFT7TRxvsu7BbPx504/APObrurVCew+mbAs/DqlrOhxXBDA3UtcIP4po24OjS6
         FpUAXtUSj9QBpmSSiHnK+2CJYhNhtKY8CXn9xSn0pvAxjAPfSW/TRo8BE31XO/rDggos
         WMGA==
X-Gm-Message-State: AOJu0YxeU6MPtTvei5GRNRUSnKbriiI9VsrEGEBfhYd00wUP2QWmHHz8
	sDv78xTps9dNEnbF5/BkqnUbuQ==
X-Google-Smtp-Source: AGHT+IF73nF6Onj2aQD0oGDoDaFFF6cqs6ya8ozBi9yR1sVSRuY38+GIjSGbEAXI734zjPkXAvZKJg==
X-Received: by 2002:a05:651c:1310:b0:2c5:98b:8bdb with SMTP id u16-20020a05651c131000b002c5098b8bdbmr8044745lja.49.1698762600069;
        Tue, 31 Oct 2023 07:30:00 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b004060f0a0fd5sm1943759wmq.13.2023.10.31.07.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 07:29:59 -0700 (PDT)
Message-ID: <f5823dfb-4ba7-f32c-d8a3-9b8b7cdb7c5d@blackwall.org>
Date: Tue, 31 Oct 2023 16:29:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next] bridge: mdb: Add get support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, mlxsw@nvidia.com
References: <20231030154654.1202094-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231030154654.1202094-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/23 17:46, Ido Schimmel wrote:
> Implement MDB get functionality, allowing user space to query a single
> MDB entry from the kernel instead of dumping all the entries. Example
> usage:
> 
>   # bridge mdb add dev br0 port swp1 grp 239.1.1.1 vid 10
>   # bridge mdb add dev br0 port swp2 grp 239.1.1.1 vid 10
>   # bridge mdb add dev br0 port swp2 grp 239.1.1.5 vid 10
>   # bridge mdb get dev br0 grp 239.1.1.1 vid 10
>   dev br0 port swp1 grp 239.1.1.1 temp vid 10
>   dev br0 port swp2 grp 239.1.1.1 temp vid 10
>   # bridge -j -p mdb get dev br0 grp 239.1.1.1 vid 10
>   [ {
>           "index": 10,
>           "dev": "br0",
>           "port": "swp1",
>           "grp": "239.1.1.1",
>           "state": "temp",
>           "flags": [ ],
>           "vid": 10
>       },{
>           "index": 10,
>           "dev": "br0",
>           "port": "swp2",
>           "grp": "239.1.1.1",
>           "state": "temp",
>           "flags": [ ],
>           "vid": 10
>       } ]
>   # bridge mdb get dev br0 grp 239.1.1.1 vid 20
>   Error: bridge: MDB entry not found.
>   # bridge mdb get dev br0 grp 239.1.1.2 vid 10
>   Error: bridge: MDB entry not found.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   bridge/mdb.c      | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
>   man/man8/bridge.8 | 35 +++++++++++++++++
>   2 files changed, 133 insertions(+), 1 deletion(-)
> 

The patch looks good. One side question below.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

[snip]
> @@ -865,6 +960,8 @@ int do_mdb(int argc, char **argv)
>   		    matches(*argv, "lst") == 0 ||
>   		    matches(*argv, "list") == 0)
>   			return mdb_show(argc-1, argv+1);
> +		if (matches(*argv, "get") == 0)
> +			return mdb_get(argc-1, argv+1);

I can't recall if it was agreed to add only strcmp even if the rest uses 
matches()?



