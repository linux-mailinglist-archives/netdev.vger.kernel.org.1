Return-Path: <netdev+bounces-61876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DD82525C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F451F25742
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BA286B5;
	Fri,  5 Jan 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Yw7yCwmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E6250F4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33723ad790cso1132775f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704451741; x=1705056541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tlC4ZuUnj+RdifBxtkmCVpfFmYxPbtB+oy++4rULk2s=;
        b=Yw7yCwmQbGLF7FLhimgyS09q27nvjhzN/EBIKgdL2PTxgsYisO7S0F0cKgXCZfrGpK
         IdoKhW7r4g5ZKYCPaWioF9f5QiplquoleRo8QApsEpo3KQnGc3faNXwdwP5/tsJgGYbN
         hzDQl33rp8Sj3hLlElLuaOAmFWgBXxUcqGRf13BkUB3uyQ97G3xGQG8T4htW37XFA0bU
         4jLq/x2meRueLqxMgdEqsGYOVXHC6MWnpg+1KdSCCLujt6DuYAg+JLVCLroGayfzaiLX
         5oGbSRCQKRZ+XyH6MDJ/vUpAATSnA74uZW14aHeZhCLbeXVc59mKwETpzQCi8yDakIJz
         oZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704451741; x=1705056541;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlC4ZuUnj+RdifBxtkmCVpfFmYxPbtB+oy++4rULk2s=;
        b=S6vC0/c5bojF/ArxK2KBk+7/Z4MLxXESrcmXNmuPnvNIrLDjCZD7nNeeRxDiEj3sLv
         /9m1itQH6gyILOhLCn2L9NaK13j6uhQZ0mxn+p1nYY329YoSoKP0WHo5Gmg3HV+n7X8v
         DvcnVwOB9Os1WP6IbYzBznRrxn34nkiXazTZzBmIc5tFZw6iEbV+suTNhK1N2LIYbNDL
         DvcJnBmyLsO6kJT+1tNF+p5aMsrV8Vmj1V3KZnPN7uvcEGkww5boitDFst6X3vEjogXU
         pUbUKziRTyPdPst0RoX0qIsuPy5xIWbcuetLMpJgT/8GnJxlcmz5BlNxIp3/mNgCsJ94
         CS2A==
X-Gm-Message-State: AOJu0YwUiAwNiL1q1nMG6NKO7U8aKMqnDanx9L5I9EFXcYuCsK0SAHZ3
	xxiDnhstPp3d21ScMoNh/OcvivdxlOdGQw==
X-Google-Smtp-Source: AGHT+IGnMyI2CaJ1DdQhO2eUFu5ouUQNg8qA3YFljmscugwWggiF/uPVuxsRPFPvqce6KDDYnpofEQ==
X-Received: by 2002:adf:a48d:0:b0:336:64c0:a1fa with SMTP id g13-20020adfa48d000000b0033664c0a1famr787866wrb.78.1704451740889;
        Fri, 05 Jan 2024 02:49:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:144d:d8d:d728:b78b? ([2a01:e0a:b41:c160:144d:d8d:d728:b78b])
        by smtp.gmail.com with ESMTPSA id r16-20020a056000015000b003373ef060d5sm1142061wrx.113.2024.01.05.02.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:49:00 -0800 (PST)
Message-ID: <7fe06d6c-0e4a-41e3-a111-71084972d023@6wind.com>
Date: Fri, 5 Jan 2024 11:48:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v3 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-3-nicolas.dichtel@6wind.com>
 <ZZdow05irUiN1c8x@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZZdow05irUiN1c8x@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/01/2024 à 03:26, Hangbin Liu a écrit :
> On Thu, Jan 04, 2024 at 05:43:00PM +0100, Nicolas Dichtel wrote:
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
> If you are going to target the patch to net-next. Please update it in the
> subject. And use `setup_ns` when create new netns.
As said in the v2 thread, I will send a follow-up once net gets merged into
net-next.


Regards,
Nicolas

