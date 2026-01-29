Return-Path: <netdev+bounces-254514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UESCG8q+emnw+AEAu9opvQ
	(envelope-from <netdev+bounces-254514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:58:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA87AAF44
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DD9B300D6A1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35674330B30;
	Thu, 29 Jan 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npa9BVAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622A33BBC8
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651836; cv=none; b=QX+OP+/XABJk6Zq7jmZEp3A+uPIVI85sZdw0LQVInrFNW0CbaFYDfkcJA2L4rP042TZHfDRIIaO4eSL/ulnDwTVaUB2k+amhJhOdMCBtJYxTQ8sfOchJGu++1jVxTMNib2Cpasb6aaepHgYJiFNmsZ/kVuPC2+k4r9TjeADvY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651836; c=relaxed/simple;
	bh=rzEJ36Hq0hzmVArMcVO/ak7vCFXqJMUCW5NjfaXT5+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRyRrmPwRRNFkGUtLkfnRH9AXZHBPgWskpD5d47sOwV+cv25QyTjalR8P9eD3UiPIDRwUuc56ibHzRsNL49CWzLwmsmK9AuvoSw5PNEyw3Kgqcj+O1LuIYrbjHORR/GM/GBHpLD96k74Vz889RY6ZRvI0Rk3ZLtxp5NSQXrjuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npa9BVAG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1248d27f2b9so672987c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769651826; x=1770256626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PA8gr+YKpeMZlbtexD0GnfzavDOVqcWassYAa2Q9AU=;
        b=npa9BVAGuXhaDjSjI2zpw6vY9T4uejwsVsYKpbE6HMRI1/PMwMrUC+7u/JPLiNhb+w
         6hbybL50KEf0BapPaOM0Dr9syYqGqsWxUuvM/xFQ81dRXlavPVBefbfc0RTb0BukVA7R
         xzZZK7aPUggTGd3hwdwJVn/sCR7CnQRr8zhfG/wDzwhrcVqP3SJoDvx3dXB7f8wl5fn/
         4RYduMW2OusIyFM7qHM8GdLZUC9MnEVsTVMC1Q4yndNo5UKtZz/rVhdcqNFP47EcU2JZ
         0ZyjxEonJClGTwjNM/NtFylucCPVZVTrnDrIoDhkPS4QMgd4+2iJ/HueDn7piiZJ9wwG
         ldqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769651826; x=1770256626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PA8gr+YKpeMZlbtexD0GnfzavDOVqcWassYAa2Q9AU=;
        b=sHE3xsY/ynMvAacBHvz9saBEe76ceYHUrYkuOUPo0GLAFtEk19rPzQ63qwOtJMEV7J
         U0GtFl01WScyspPjpk7PjOn0eZLPw9cfyRWHAQKywy71nXt402lOfAkc/G2xm0D4n0Ac
         y9h9FPKpOuJM8tKGHhl1DSJ4P5pdW4HDXy6uH6Jkldr6aIgVOShPujUnidx8YcQFGYjP
         EYwKsRO1UwCG9xFHoSy8CdwHqDssWyFDe6apuPZMjvRppMO530eWEeGPkhHiBW0WnHc7
         ln+jOZMB+zeKrqaFUVJw85V709ROalfiHQyeusyLv9AUf2ayoZ7m2AzIUpRNCgJyZxX7
         gKmw==
X-Forwarded-Encrypted: i=1; AJvYcCUJqHh6hkDkjeeofbDGOfmCatWYIG2A0IEmmyLAc29WN0BCH8uzSHxoxolCByuKAdUAXMAyYHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQumEIiOfNIf+FHMTfYt1xx2Wt/HVGvJrsFJlMnaVk6jCS+57D
	iZUhGNSAMD0bIQpqid4dbE13aVLIeGbYqP/GvLg5niwQOCIXnHbOLMkV
X-Gm-Gg: AZuq6aJqRRuTn/wCuE4URNybIaLmXhx82j9NjBtSAw5rgTnI4vQLHPRrJZmr/Y1xCZA
	XnDIS3XAGBAYBDeWTl7ZnbW12C0RYJ0Cm2cphO9ROHQnw1tfoxHD2XAQ0I44xUKiyAot5Lo76iW
	qMAZLzIZaZ85TRd1PRGbHfwQEjlGgTeJBhZCPII4049HDOD9QTWasycMavGa+2b8+ZX2lvzoSts
	5YpOjl0jvrM5FbLnkSxGqcKmb8tfdY0doYBbvYmghCRA/biVYOtpUYzMR8GbrIVM52qxNTbZFaw
	c+QVibpaAMHNM/B36XMEuLmFFFOcli/Tl0/VCRjmObAFq2rAHEXkhNo4dmCY5CRdnU35yeA7nV2
	x2zA8T9CFDbFI7KOOz092Hg6mB+C05B8GAT7q91/yeB677zGpY/KsjW8kti3yGyAMWr6sjjeFWL
	WEaFyM2RhT237L3/7zH68fCm2c3FU5HPzeFmxABTTWpfvmUA==
X-Received: by 2002:a05:7022:b8f:b0:11a:51a8:ec9 with SMTP id a92af1059eb24-124a00bd920mr3704741c88.29.1769651826013;
        Wed, 28 Jan 2026 17:57:06 -0800 (PST)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm5670014c88.0.2026.01.28.17.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 17:57:05 -0800 (PST)
Message-ID: <48f1c033-4a0a-4b17-aae0-9c712748b2ed@gmail.com>
Date: Wed, 28 Jan 2026 18:01:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 =?UTF-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
 <3ed93cd3-677c-4d0c-a3a6-25c3d47a4ef2@kernel.org>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <3ed93cd3-677c-4d0c-a3a6-25c3d47a4ef2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BA87AAF44
X-Rspamd-Action: no action

On 1/28/26 02:05, Krzysztof Kozlowski wrote:
> On 23/01/2026 11:47, Bo Gan wrote:
>> Hi Krzysztof,
>>
>> On 1/23/26 02:07, Krzysztof Kozlowski wrote:
>>> On 23/01/2026 08:39, Bo Gan wrote:
>>>>> I assume the address of the interface is fixed. So you can just key
>>>>> off that to distinguish the two instances.
>>>>>
>>>>> Since this is an internal property, not a board property, it is not
>>>>> clear it actually belongs on DT.
>>>>>
>>>>>        Andrew
>>>>
>>>> IMO, they should be in DT to provide maximum flexibility. The SoC .dtsi
>>>
>>> This is not the purpose of DT. Please rather use arguments in terms of
>>> DT rules (see docs, presentations).
>>>
>> Any examples? links? Thank you for your patience.
> 
> Really, doing simple search for it is your homework, not our task. You
> need to try harder if you want to prove that you are not wasting our time.
> 
> Documentation/devicetree/bindings
> 
> Or any elinux resources or any recent talks of mine.
> 
> Best regards,
> Krzysztof

You brought up the "use arguments in terms of DT rules" approach. and all I
ask is just some pointers to make sure I'm not misinterpreting. No offense,
but The way you slamming people w/ "not doing their homework" is truly not
constructive.

Bo

