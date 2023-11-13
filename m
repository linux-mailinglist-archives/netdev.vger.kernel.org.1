Return-Path: <netdev+bounces-47298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6927E980C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F79B2085C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346816423;
	Mon, 13 Nov 2023 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RsIWNSus"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548715AE1
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 08:51:12 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDD10F5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:51:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507c5249d55so6390562e87.3
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1699865469; x=1700470269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gGf34EKT6JLZCyiN+3THFbmV5b3yhyscElV56Zri1A=;
        b=RsIWNSusz+TGLGv8PC5EhKX7NhzP4HypiXsFsYYELqOYV5oIZLJ1W/lRYbIsJuO1ZU
         eFmWOd0FbEBwv49/5kh/dDYjTGmpgn5twpZpB/mT9N8VmqwPep+sHI5pW4NkvcL+BNaG
         PNApMnxtpBR6sO1o4YNAm8+54s0npyHcPluEJBtjq9chuP563/D5D/hDFv7h9uXkxKPs
         FKYpebMJxmsmSQuQlYEMoQPpA0DbDfCKAA5VC/4n7m2fTxeoGSiA+7FnJdMdcw4zE3cW
         qLdK4yHTy2VtE+QI4w30eJKTnC6NRDGXtV6OHgfoA4vwvElHtymId+jl5UYnUKulm2IS
         LTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699865469; x=1700470269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gGf34EKT6JLZCyiN+3THFbmV5b3yhyscElV56Zri1A=;
        b=DJiZ9eU/28NHcpg6qH0xJ0ABec3mQI81DabS9pklYaeksomE8vPUDuyQHCrjSUqRjM
         YO+rF/DSVp1MQ3IepiWNolFfkMp5U4TqtwjnJuTh2EiQZ5S5ODVeJOWUJm9L0Bn3CKQy
         OJ2llUGvhykYp7yYG7fgWGq5t1b9Uhg2xJaoMdsMDP9TkJyrRZta8tgPUKU07J685/Zl
         xyUnrVLHkN9fJuA+feExAHJxBTsK9K3aZbr4BsxSAl0XsM6ZkT+Xxb/V10pwj30/iR9B
         toik9cTEXW833mKgYZIoQFlmXuDT+qB/MAdq7jyTiaLLuo5wTPo/nQYW/c85ZAG/PLSI
         QUiw==
X-Gm-Message-State: AOJu0YydEXrRhZFjq8wxWcAIU7k4shZCFJgI29qI0Gg3M8xxhszQPaV7
	UAHt+qo3QH0DIe7vymqfZ4Fiqg==
X-Google-Smtp-Source: AGHT+IGy+HR0xLv3OIn35GWcq8oNkFL7eVYqeEFDFMOjcwObFfS2j1Kdqo4/T+YlyL88IW+zg8R5kg==
X-Received: by 2002:a05:6512:3e28:b0:500:7a23:720b with SMTP id i40-20020a0565123e2800b005007a23720bmr5485968lfv.55.1699865468599;
        Mon, 13 Nov 2023 00:51:08 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709064c4a00b009a19701e7b5sm3701810ejw.96.2023.11.13.00.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 00:51:08 -0800 (PST)
Message-ID: <8d437b3b-b410-5572-0570-e0baa962f344@blackwall.org>
Date: Mon, 13 Nov 2023 10:51:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf v2 1/8] net, vrf: Move dstats structure to core
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: kuba@kernel.org, sdf@google.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, David Ahern <dsahern@kernel.org>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-2-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231112203009.26073-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/23 22:30, Daniel Borkmann wrote:
> Just move struct pcpu_dstats out of the vrf into the core, and streamline
> the field names slightly, so they better align with the {t,l}stats ones.
> 
> No functional change otherwise. A conversion of the u64s to u64_stats_t
> could be done at a separate point in future. This move is needed as we are
> moving the {t,l,d}stats allocation/freeing to the core.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> ---
>   drivers/net/vrf.c         | 24 +++++++-----------------
>   include/linux/netdevice.h | 10 ++++++++++
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


