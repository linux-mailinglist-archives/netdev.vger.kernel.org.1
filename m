Return-Path: <netdev+bounces-61286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0438F823111
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D68D1F20F1D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6D1B297;
	Wed,  3 Jan 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Qpc7HOQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4241B295
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d560818b8so78711845e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 08:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704298635; x=1704903435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P4HeiWEfj03zP8RF+fFdjEB2mpj6CmAbAnHQ4IQrNL8=;
        b=Qpc7HOQxZmGVTTZ1qp8AZ1+KNl9fTkdJhLCxuuiU9usFklQXW96sUa7BRP9KrGAdG2
         dEF8E2zn8qMvibVkkYDJoJyfnn26NKWU08OTd0wSOzD3ztsFD2TD4OP8zhyDPSZeaAu8
         dRJeAYwxwG/aGf5WSl3YUaXa0ejpnHPMyVeEGKcf9AK2i4wy0ZBCkhVqlxI0Z0DyFWdL
         TcdtNBhs79rhNouRcKTxMrI3MlaVyRUSyZQXrqb9mOgZeNOuMHOAhyOPp2ibikxQIN8c
         gVn2q7ndok58VnKViRoIdPnaMIiRrVnG1dhH2QCNjXBBzb2Ft8nXxpYIP83qrYpabCLz
         ZAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704298635; x=1704903435;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4HeiWEfj03zP8RF+fFdjEB2mpj6CmAbAnHQ4IQrNL8=;
        b=gybEBIbTxdZQETEMsWeOprBmaQtbpF1JnNChv7Idek4PUJ3b0bWlM6dutVeuER8EDN
         wEUP9eGVBiYQI9pU4E9uMM8srkH1oBsSZrwwadyERJV70HvJuMmf/zrY3FRpRtrd93gV
         iE1f8zU9vxe9PutsFfuq7S2dRErsZXVNKaK9K8rEowHzOS76vjYQ38yvEqZ3+HSCbtsN
         9wEN9a+y0qt9jMcaXYhbsIN/i7qM5SE+qVHy/HZDwSFO3jER4iv09yNLNR/ljuibX3Gp
         c0HsWroClUq3wMGZn5xR8qQBifduLz/uWTMA9SvLqpiokq3+Xf5UnYDl4TzbqEL2aS8A
         /WsQ==
X-Gm-Message-State: AOJu0YyS9qTnjAJbeemSVpFItNdOcLsVghDNUZjUvKYm3Vh1DFz4LLIv
	/Zwr8sV6O/BFFIMR9gm+x48aucmsIwqpvYhnuMP6HzM7v4g=
X-Google-Smtp-Source: AGHT+IGDuOaFnXXZAnFz6q6y/9feotP7Rhf84rUExQb5vzihLuGiE7smJ0Vrjj8bMhSG8IE/N27DUg==
X-Received: by 2002:a1c:7c0f:0:b0:40d:5c0e:a679 with SMTP id x15-20020a1c7c0f000000b0040d5c0ea679mr6342251wmc.138.1704298635006;
        Wed, 03 Jan 2024 08:17:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:f3f1:7caf:cfec:10bf? ([2a01:e0a:b41:c160:f3f1:7caf:cfec:10bf])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c314a00b0040d7d6280c2sm2808957wmo.7.2024.01.03.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 08:17:14 -0800 (PST)
Message-ID: <0cc0cfc3-14d3-43d9-8fa8-b2b76b1ca14e@6wind.com>
Date: Wed, 3 Jan 2024 17:17:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Phil Sutter <phil@nwl.cc>
Cc: netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
 <2b3084da-ab85-412d-a0e8-3e50903937df@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <2b3084da-ab85-412d-a0e8-3e50903937df@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/01/2024 à 16:42, David Ahern a écrit :
> On 1/3/24 2:48 AM, Nicolas Dichtel wrote:
>> @@ -1239,6 +1240,44 @@ kci_test_address_proto()
>>  	return $ret
>>  }
>>  
>> +kci_test_enslave_bonding()
>> +{
>> +	local testns="testns"
>> +	local bond="bond123"
>> +	local dummy="dummy123"
>> +	local ret=0
>> +
>> +	run_cmd ip netns add "$testns"
>> +	if [ $? -ne 0 ]; then
>> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
>> +		return $ksft_skip
>> +	fi
>> +
>> +	# test native tunnel
>> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr
>> +	run_cmd ip -netns $testns link add dev $dummy type dummy
>> +	run_cmd ip -netns $testns link set dev $dummy up
>> +	run_cmd ip -netns $testns link set dev $dummy master $bond down
>> +	if [ $ret -ne 0 ]; then
>> +		end_test "FAIL: enslave an up interface in a bonding"
> 
> interface is up, being put as a port on a bond and taken down at the
> same time. That does not match this error message.
The idea was "the command used to enslave an up interface fails".
What about: "FAIL: set down and enslave an up interface in a bonding"

> 
> 
> Thanks for adding test cases. Besides the error message:
> 
> Reviewed-by: David Ahern <dsahern@kernel.org
Thank you,
Nicolas

