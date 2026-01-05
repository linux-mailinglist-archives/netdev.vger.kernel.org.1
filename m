Return-Path: <netdev+bounces-247193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEBCF5923
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6647E306B745
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6CF26F2AF;
	Mon,  5 Jan 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wqVECP1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2722E406
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646373; cv=none; b=AYvItlGT8EC/bfuEgm+W45L9mswqIPtLbVpmVnZrV6mAu8j8eqKRh+/OM/nx37gzZ/r6GCPsb2s02HYA7/keUOpsEbs0DydjslEtFlqaPAXJtrqbTVI9EDz1mVJSTcU0itEFt+3ShGN5Vs5m3FOSTmWZADX/0aS3HcjaSwX1G18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646373; c=relaxed/simple;
	bh=iyKn8rvUpe9Ixbpns20EJkjgG9Hb4qzmINql41dCdHk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TS1+jhtRBPmECr0vo9MyKpaNH8YKq9YENMWFvVBKMQ3jWtEXGLu4Zm/Y+OMpr4HNKgJL4Qj4uWm6mlfIaV0L2yUjQxvTF8fOD/KzpW2yiVCi22XU5NY6EjeKOUFBtfuGH3S+FWXghVxmlBoqGRFmb7EEhXzwu4fC08H7gjIM9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wqVECP1z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so219732a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 12:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767646371; x=1768251171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCb9sY5eWHfFp7S6NJ1pwNDBiIDe2ARMH+uqafrlkAM=;
        b=wqVECP1zLwx1ClSGb6SWkevTDdWXCVBDZRSGoOw21dFiToGXMmwwODtQqANvGj3GB9
         IR/Tl4nfPEWMFaqOfyW6UJJ71PfBQYL9lIz51nj309F+SQRNilo/w42HBOgQ6sG9ac/H
         qJiAjBV1PkASwpkLiSLR6wCdKpzQQ/JPZwXIeN1VM+lhoUYtiboz7pAA68hLgAUazoq0
         XiJg0ahoTxyzTIAGnfUYus1NjrUS2X0jerzFNVymNd+FIlWfcO4AWP/JceUfEHcT4RBq
         xhCA0pBtsVszQxxkUJnVREoAfZ4O60IUdzMpsCqmDpC3qFxCoDPUHaS5+0OJ5hifKnVL
         RJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767646371; x=1768251171;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCb9sY5eWHfFp7S6NJ1pwNDBiIDe2ARMH+uqafrlkAM=;
        b=on/YsOngPYmm0/7EUUTHg3eRMe8zgkeXq+mpjU1uoBIyRa4l4+xWbzAbQe6f2AZgC4
         ApaMZiPsv2QWJsI2hoVqzh0M6giI9i/lk7NEsfUEFhLWpsfPQPjOODM5jkdmoqmvX/8B
         ys/HmEdt+wv4S0wC7VwZ5h6H1Kge78K8bn03RA6Pr1w1vYvOO2bz/uhfDO0LIun/cK4Z
         m2HFySU3HlCwFOMsEoLsT7ylCZBF23/+ak8baOs0ynZcM13yP1qMvnoQ0tovrdkLUV03
         9K4NbvGW7fKtG8CLK2nCot4BPpzGPVnJGa/YJFrAn+8EyggIWC6DBbaApap6WpIZC4SB
         lRCw==
X-Forwarded-Encrypted: i=1; AJvYcCXrzy6O+IOwIA2CYtNDGPsIkTOMD5i6qyOS7t29XpLvU+L5W5OApS1O4r/sfAPdiYMOJhmIK/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqK2DFeUVC6qAQCfmcOafvLx2ly3UeJmrzz1R88J/mu20v2ydS
	2iBgo/qtnyRW/X7PpLzhoOaTYOysHvChqnynnkJdkmUKpS5oAexQ1BbqgScaHbStZA==
X-Gm-Gg: AY/fxX6rQrKPv3uTkiOaEFYQkCUkNlYk5IehjBLUOVPTQNLSuunJuG4+TPXfSLzO1NM
	Ud6RD5fT9qQkd/wAEoYixHZczItoGKKcb3MhYObOihGGQSUcEnI4JQe1Pu9fJ+3w4UYD5muYRjq
	A5AiuOzv/yP1/IxK0eFTbQq1NqEehiRm3TIM33LW18sBjqsagjuo5g1it5ueumwiJhGV1lCEk7y
	onSM8naysklG67xgcSJbM7iANHKGMygzPMOR5h+0utFgy1nPlF8lX6OMDJn7vnnsa9t/n2B0qkY
	g004K8gDsRLN53LmrULhx5fuWQ3C9itr65mNMD76xmVrt9UbKauqM8EALXjfiYLBxtSUXy+aXfa
	9vpPm1Lsua83hZF67o4uMW6vpuzHF+CFca69+Gjwlcfr0TWd1ADZBl1cnP8uWxUUYHxnjrsuLXb
	kk/w1ftDSLnYafRtvZJmHqqr6MUI/CtCy0
X-Google-Smtp-Source: AGHT+IE+dMTxe1WIhbpzEtzhArfLn62auaFBdv1wnjaBHeXTlYeyhZ+F8ywFN+X/W2GeTbPrTXKvZg==
X-Received: by 2002:a05:7300:bc0b:b0:2b0:514a:a8cf with SMTP id 5a478bee46e88-2b16f880888mr462930eec.17.1767646370718;
        Mon, 05 Jan 2026 12:52:50 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::2000? ([2804:14d:5c54:4efb::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a6386sm371481eec.14.2026.01.05.12.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 12:52:50 -0800 (PST)
Message-ID: <04a4cfc3-ca15-49cf-89c1-17a4bc374caa@mojatatu.com>
Date: Mon, 5 Jan 2026 17:52:45 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next v5 6/6] selftests/tc-testing: add selftests for
 cake_mq qdisc
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
 <20260105-mq-cake-sub-qdisc-v5-6-8a99b9db05e6@redhat.com>
Content-Language: en-US
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-6-8a99b9db05e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/01/2026 09:50, Toke HÃ¸iland-JÃ¸rgensen wrote:
> From: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> [...]
> Test 18e0: Fail to install CAKE_MQ on single queue device
>  [...]
> +    {
> +        "id": "18e0",
> +        "name": "Fail to install CAKE_MQ on single queue device",
> +        "category": [
> +            "qdisc",
> +            "cake_mq"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 1\" > /sys/bus/netdevsim/new_device"
> +        ],
> +        "cmdUnderTest": "$TC qdisc add dev $ETH handle 1: root cake_mq",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $ETH",
> +        "matchPattern": "qdisc (cake_mq 1: root|cake 0: parent 1:[1-4]) bandwidth unlimited diffserv3 triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0 ",
> +        "matchCount": "0",
> +        "teardown": []

Hi!

This test is missing the device deletion on the teardown stage.

cheers,
Victor

