Return-Path: <netdev+bounces-61235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61A6822F3C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 15:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A58283BCB
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9BE1A293;
	Wed,  3 Jan 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LqsyvOKV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23F1A27E
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33678156e27so9617156f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704291335; x=1704896135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zjreSabw8CzN94mx8h5dumFRh+tngguL/9HyCovmyjI=;
        b=LqsyvOKVl/1aw680VuFR+JdCxzgEJZPPWI3j+JpgLAKgB4uuKu6V7NK6bPwh9BVXPb
         mdgFdKdIEr4oTkUPNQMMez6B1AF4pKsH3/nhhJ4Sj6apOKjwoNuYpHUyLitZMKIUgEau
         pm7WfPK4DoRYZ44JoIyyxnp9JHE15t/bmkIN3vl5lKE2drQVb3S7vN1389mPyAUwrGt/
         JvUp5ioL3dIa1/Kq8hOES0Fu2Wm1W43mcqkxXugfBAW2qp0KiHrOxssasWunkD92KCTN
         NYsqp51sdkjzXFlPusad3xigSBgLdROaZBe1X0kuU0GPIn1p1Qvp0zkI2ipTVtdVGFvi
         0Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291335; x=1704896135;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjreSabw8CzN94mx8h5dumFRh+tngguL/9HyCovmyjI=;
        b=WT4ZIeqlgNyzSbu9iP+REq9+O2l6NN/B87M4Hgs7sYjbU8rtdWyuCV3554qOsteSaD
         2T+GStkoug73fwqsQ57Ck8paVc4Vf4iVxYpr4ZqISFKJ1bshJ1/e362SfOOKlkZs1W9J
         aBpFs7HCUI9i4HwOyTJdNRPQyTS4DtKZ10ZHozhAzkzmPejYSlLIErHjlVUYnW7tq90a
         RzfvXm4YcSenkRV7sqTB9Ar6NuEMgzgW3i4itMoRCTmAxVeHRgNa49foSJ9G//VlN1X7
         V3wAl4slV8/vy8XPIZeiTFaS7XDxNecZN/xxnAFSUyHBowh+dQvA45qYjruJyIwcnqcH
         wJzw==
X-Gm-Message-State: AOJu0YxZC0nx5OL3rAtGC6YI5ChalqB7fdmjcvtgYHxTsH1vbELSzT32
	BrIcyXIWRSYYeN2XldrCu4qiQmPcy0inRg==
X-Google-Smtp-Source: AGHT+IHO8l3iNW9GGkm9CZvaxpxwPCczB3dfEde23okmnhOsNbhANqgiCdDia+nO7ZcoCnLELfLkxg==
X-Received: by 2002:a5d:4e09:0:b0:337:39e3:47b5 with SMTP id p9-20020a5d4e09000000b0033739e347b5mr3263444wrt.14.1704291335062;
        Wed, 03 Jan 2024 06:15:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:f3f1:7caf:cfec:10bf? ([2a01:e0a:b41:c160:f3f1:7caf:cfec:10bf])
        by smtp.gmail.com with ESMTPSA id c6-20020adfe706000000b0033342338a24sm31013108wrm.6.2024.01.03.06.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 06:15:34 -0800 (PST)
Message-ID: <0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
Date: Wed, 3 Jan 2024 15:15:33 +0100
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
 <20240103094846.2397083-3-nicolas.dichtel@6wind.com>
 <ZZVaVloICZPf8jiK@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZZVaVloICZPf8jiK@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/01/2024 à 14:00, Hangbin Liu a écrit :
> On Wed, Jan 03, 2024 at 10:48:46AM +0100, Nicolas Dichtel wrote:
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
> 
> Hi Nicolas,
> 
> The net-next added new function setup_ns in lib.sh and converted all hard code
> netns setup. I think It may be good to post this patch set to net-next
> to reduce future merge conflicts.
The first patch is for net. I can post the second one to net-next if it eases
the merge.

> 
> Jakub, Paolo, please correct me if we can't post fixes to net-next.
Please, let me know if I should target net-next for the second patch.


Regards,
Nicolas

