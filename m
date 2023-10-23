Return-Path: <netdev+bounces-43352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631187D2AF2
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9802813A4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5979FF;
	Mon, 23 Oct 2023 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ve0zNz5Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA536EC5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:12:26 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BCD6B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:12:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1c66876aso431239066b.2
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698045141; x=1698649941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tDpgNYJBZWfpDGAZyLDDwSjicDHKCRY45Gtgt4Snt7Y=;
        b=ve0zNz5Q8R4r8Wkpn2WN+1QSLg9K9NDUPZP4MFDHzjWDCNb6ZZmMkYbL5xme7XVWwb
         KIrfHeGNfk/CSkvQWTleJDabnsiiUeId7zgCXGgiXa2YSuaCACY0eCk+sMDJ+UbNLHGW
         Jq+ZeLpxdeamBeggJvAGKlANdpSnfpONqaKM/G9Yl4UgWXcKu0EWj7huIsNlTczWvEyA
         ZIV/DtZw2arA3Ojr4BAygILzIa4FIhltWVdXgX8tt0pV7pM7kmwr1tkRpbDdGzoaFOrf
         GdeK4cn4FoCnJBQdQYfgnDLfOJYMfsDj7AdsRtNPfcUQUDS0aN3pQ6lhT58hUdHVPdim
         u1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045141; x=1698649941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDpgNYJBZWfpDGAZyLDDwSjicDHKCRY45Gtgt4Snt7Y=;
        b=awj4rXtgWRb7Pk8rxVym+mPhGKE0pqXWd8Ghwz/TzSEpf+b49o5FPaU8ltz5T8NsgG
         LmM79bu6+qinHCM/9krBWmoO6A3Dji7xdvVBhf4vVhc4W8/Z28jBp+OVvX4mgvo/nYD7
         5jMl9Yr170WmEXfkHbnaNb5b2ZmHgREvrm9rcq6lEBa9lFW7/78udNNV/cMbyrqQ3euq
         IDQN3+aefls4HkNw6VwANUetCf3Lp2vjMmNjp6LjTIVRBzF5g0BrpWj3Re6xlXD+ZPUZ
         /ze3iz8A31aOvdXK+21L1CAN/Lu78e94l29J2UhF4sBuXwscD/4grIANH+7vNcFXt2Uu
         bamA==
X-Gm-Message-State: AOJu0Ywv9gtbLow5AUhjI/tjqz+SeiI2sOvb4iPVwBEF3Vpw8Un3uexW
	+qab0iYZpXb9B17qHJmmggesUQ==
X-Google-Smtp-Source: AGHT+IFNEqdPmZMghAIy7qjWE2pPnFeO4o0LaZi8rPbo2VteX3nMu1nl4MGz2o+B+svnGR5EbZ9hJw==
X-Received: by 2002:a17:907:86a6:b0:9bf:388e:8e93 with SMTP id qa38-20020a17090786a600b009bf388e8e93mr7195167ejc.0.1698045141185;
        Mon, 23 Oct 2023 00:12:21 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906225000b0098921e1b064sm6158861ejr.181.2023.10.23.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:12:20 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:12:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Ahern <dsahern@kernel.org>
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests:net change ifconfig with ip command
Message-ID: <ZTYc04N9VK7EarHY@nanopsycho>
References: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
 <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde654ce-e4b6-449c-94a9-eeaad1eed6b7@kernel.org>

Sun, Oct 22, 2023 at 07:50:52PM CEST, dsahern@kernel.org wrote:
>On 10/22/23 5:31 AM, Swarup Laxman Kotiaklapudi wrote:
>> diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
>> index 116bfeab72fa..3ab9beb4462c 100755
>> --- a/tools/testing/selftests/net/route_localnet.sh
>> +++ b/tools/testing/selftests/net/route_localnet.sh
>> @@ -18,8 +18,10 @@ setup() {
>>      ip route del 127.0.0.0/8 dev lo table local
>>      ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
>>  
>> -    ifconfig veth0 127.25.3.4/24 up
>> -    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
>> +    ip a add 127.25.3.4/24 dev veth0
>
>ip addr add ...

Why not "address" then? :)
What's wrong with "a"?


>
>> +    ip link set dev veth0 up
>> +    ip netns exec "${PEER_NS}" ip a add 127.25.3.14/24 dev veth1
>
>ip addr add ...
>
>> +    ip netns exec "${PEER_NS}" ip link set dev veth1 up
>>  
>>      ip route flush cache
>>      ip netns exec "${PEER_NS}" ip route flush cache
>
>

