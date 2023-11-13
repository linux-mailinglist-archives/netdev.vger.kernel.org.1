Return-Path: <netdev+bounces-47300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F87E9813
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6607280A6E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE401643A;
	Mon, 13 Nov 2023 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EsYtshdw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94215AF6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:53:08 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6167110CB
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:53:07 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso632290066b.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865586; x=1700470386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ejOWmOBn/EOEFM4yt9O1w/nAr2D/0wXF8vyj3nup10=;
        b=EsYtshdwOE7m7ApccIqGu3LiNgL82v9Ne098AaXixHJHc2GF7TrlPgQuMJz9kaFyzD
         e9xd2sTFAldZvwL9Ws6IT0CDlW8Ozanu8DdkxlkNqHhPg/uvaXLnmFG6akpDPewjOiAP
         XxqxqbakagymWN4NG6l6JbCplPuigSY7qfYJmhsO130fRhgD7Aie06T9/SNeJ9GOo0CY
         MTx9yeMkZvl+dttTXzZa5aLxRN8pHcg7ZUCq5V1AVCayWI73hG+CU0p0DqV05aKZ1nDh
         qmBDQlixyIWhJPhffw2hSitimYaGxsvlMqQNZt0TGQ1KXeOALOioItNeOxSeAZglASPc
         OwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865586; x=1700470386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ejOWmOBn/EOEFM4yt9O1w/nAr2D/0wXF8vyj3nup10=;
        b=MCO9e2fjaiyp6DzDaWtwqwSbc1waklJLFiNadV9uISoSbnyfoj7KAdtrq8V4rsrNKC
         yw6OA7g7A5+EqlGGz43lSgwsDn4UkISn5lPNkkSbq07sJlgVaCaV6qXneNkFm/THOfiT
         lomlQAbRToLpKjS69GS3D7ewZXBoCuM2R/b2xlp/YZd5V+kmDdphOkDg3d1yHGbqtKvA
         q6MRFng5nu/GOxbiNJ66yCYrizxKXrck58A9IMEHrPExrxRAxNL1k1Nu6ISN1dcGj3g9
         cZ9yM+Znpfti5Aq8Q7sksIDoVnacdsJt7riIWqFDANG3T1TBdiIPtNvM4oH4c86DPki6
         89Vw==
X-Gm-Message-State: AOJu0Yycp8AGS+/fsnVRzBA0l+r7uzKnQNAqn9IqlXw9TdOxjptGyEPA
	6rX9Orcg3VohtSKzC6xQ0e95Ig==
X-Google-Smtp-Source: AGHT+IE2Ct+1BZCfp7ZXU8tc+nM3TA8DhkFMVYX+9D7vOeAC+b5zmKSHro6mTJ3rFwzPTUUodzSITQ==
X-Received: by 2002:a17:906:1315:b0:9be:2991:81fb with SMTP id w21-20020a170906131500b009be299181fbmr4223792ejb.36.1699865585747;
        Mon, 13 Nov 2023 00:53:05 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906070a00b009a168ab6ee2sm3636453ejb.164.2023.11.13.00.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:53:05 -0800 (PST)
Message-ID: <3436cf40-cfb2-029e-9a97-4bcf00b24d1f@blackwall.org>
Date: Mon, 13 Nov 2023 10:53:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 4/8] veth: Use tstats per-CPU traffic counters
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Peilin Ye <peilin.ye@bytedance.com>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-5-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> Currently veth devices use the lstats per-CPU traffic counters, which only
> cover TX traffic. veth_get_stats64() actually populates RX stats of a veth
> device from its peer's TX counters, based on the assumption that a veth
> device can _only_ receive packets from its peer, which is no longer true:
> 
> For example, recent CNIs (like Cilium) can use the bpf_redirect_peer() BPF
> helper to redirect traffic from NIC's tc ingress to veth's tc ingress (in
> a different netns), skipping veth's peer device. Unfortunately, this kind
> of traffic isn't currently accounted for in veth's RX stats.
> 
> In preparation for the fix, use tstats (instead of lstats) to maintain
> both RX and TX counters for each veth device. We'll use RX counters for
> bpf_redirect_peer() traffic, and keep using TX counters for the usual
> "peer-to-peer" traffic. In veth_get_stats64(), calculate RX stats by
> _adding_ RX count to peer's TX count, in order to cover both kinds of
> traffic.
> 
> veth_stats_rx() might need a name change (perhaps to "veth_stats_xdp()")
> for less confusion, but let's leave it to another patch to keep the fix
> minimal.
> 
> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   drivers/net/veth.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



