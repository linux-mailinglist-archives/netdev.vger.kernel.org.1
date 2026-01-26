Return-Path: <netdev+bounces-253498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKhKHRJ3d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:15:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14575895D9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 794F2300680C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988283385BE;
	Mon, 26 Jan 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHvCZB5a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AO20Ue4n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB722E3F0
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436942; cv=none; b=o+R4yDn3apSDknZ1wzVecDBv6mYEfCyqpK0R07Eb+uHmmFuUTLTn5K9SxxdHBEjZLxOTEgS0gKo8Fks/g4nYYir4bSHr4BTqqyjICU6KVyjbAW8yrzhr2wliWUknyKJO/CJaJQtcnd9ln3prsaPtSlbjrwk/XvxU08tS6R+WDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436942; c=relaxed/simple;
	bh=zUktEHGKHLE9TJGXL5YM3vc2cOgc6sc1SgttBbIkLpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3qBnCJduBXH0XDINAMB6TqfgBmw8fUDpLYH23JILcZM5gXyQmyxYXuwkQBLmYtKMU6QIEKNMAL31+jebrT9tQxCuNTUKIFWFGRI5tlDtTedhwfjo1PhpzpcCsIc8zl5CYMYMsQTYGbU+u46yLEwyuzluh2rm5t0oR+SPzvdoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHvCZB5a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AO20Ue4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769436940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ba6scG27hyC+OOv6pXy5I21jJl9wm99+WT3gp+Bu9c=;
	b=ZHvCZB5aHSoxz9KcOLnT3s0VASj1t2FzH2mMZitUH4Xyb6avp93Q5rk6u6pTgAWVAR4V/J
	/9mW6vu/eytSTg2goQD/ZPfCmTPcIrCRd8Ryl6VlcldfhnT3TtgDthM/0btxKeZiQNEUs7
	H3MOVl3gKdqLpNPEMGHQd8np8vR+3RA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-m2hNu9TxMq6O_Q2rtG7qnw-1; Mon, 26 Jan 2026 09:15:38 -0500
X-MC-Unique: m2hNu9TxMq6O_Q2rtG7qnw-1
X-Mimecast-MFC-AGG-ID: m2hNu9TxMq6O_Q2rtG7qnw_1769436938
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b81081aso4428160f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769436937; x=1770041737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ba6scG27hyC+OOv6pXy5I21jJl9wm99+WT3gp+Bu9c=;
        b=AO20Ue4njo3SRsO4304QsS1vR7SdoNCpHEARyWaOsdE7MFW/ki+SvWHz0fbKwIkxtv
         GjJdbhYIBCzb59+CW+JqqiR6QJfgykUxlgYnHkqohA7SWm5jztm7Dx2OtVEFcQhKDD8l
         H7Mm3T8vDENCEdypA949HvCJ6X72bUdGy8vDP5oeQ0J+FPs1WvGzWKtZyt0B/MtDG94d
         IFVW+JMeV8GcgAyGY93e8JCJrxcfMWKeqLKn2GtmtazyNGx5qMh/hI5xflUNUH75eykc
         pxn1J5uoCVy9waQBZ58/EuskWDdesvvZ3vT5GQChhtbDpTGqUEQ0yqDbrWfM1nKUA5Q6
         /wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769436937; x=1770041737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ba6scG27hyC+OOv6pXy5I21jJl9wm99+WT3gp+Bu9c=;
        b=w0iWBFEvz5/gemz0BBCnlGyJTKZHRm8bjOGlqM4nRa0NAxva2VDjFuIfWOr2OO3rcW
         vyY3H2fgFUt44J7YcXjJyna/Asq3Wxj4YKv5bvUy9YUPC4oLplJSuQX6fs6nD65wElI8
         AeVrtuFG9MA4ayC4JTLtziD/3RjZXYE41b9LAplo5uQ7gyPwjgjM09HlPD1C4WX/S2mw
         xIvmThBNFiG8lFAc4Xe7Huyof6vNnb6ncQhRZ+JrrwPrKGyDckX4CA5++SezXZNXHMjw
         o8LB0J+NMv/1XQ3JDrBR5MezQr3o1iQX24SXfhAwhIaatw6HoxMLGbejbkXljjVCMhR8
         OGdg==
X-Gm-Message-State: AOJu0Yze7Dr9M3tP34NtEltT7eY4uhZaZPPMtksejH0aRsYm0rLdgXg9
	IrP1aojHStzzCqv0K25TnEMnBA83MOuJsVEBihGGIW+oEcWOVaM4rJsW3qqEBZkAKPWjVwynLGZ
	okyQWTj35R5BKIR+O8ijIdy0sDPblg3czuQ/ouM5Zykz+iodcDvWrfzixJA==
X-Gm-Gg: AZuq6aIT0gk78UYqeZfnL2HjJ6vxmh8l5sONv0aJryVsjCjJcpDqdXvZZTeAYnW6F9H
	cdSgox0wnEjMtbF/JjPcePXry+3GEwBh2TV2WBKv4ZAa3kDhfoqK6pMNePXUxy2vXHhVxNABt77
	FQXHYi5rq03LdKDTrXzEP914zK5rPoeQTeR+sf18+zAT0g0eSaXz8HNHhEOrvBF9f0Cak4Gc8GR
	PIbU2qAlvqfqWO/4ll+980Nasuuyx/e/jncQ7FOIvrNqQCkmhsq5r0phNhX1yhCwG09E/6iCV1W
	1hLhBjxwaeRMQF350qU9CoQZB/wH6ahWFcqs/k2nmFksOw57znLBwoZ1/ucYkFbn1/bis98PIN3
	W8rpU/A57wZQ=
X-Received: by 2002:a05:6000:3109:b0:435:a464:f468 with SMTP id ffacd0b85a97d-435ca1b0a8amr7518695f8f.47.1769436937432;
        Mon, 26 Jan 2026 06:15:37 -0800 (PST)
X-Received: by 2002:a05:6000:3109:b0:435:a464:f468 with SMTP id ffacd0b85a97d-435ca1b0a8amr7518659f8f.47.1769436936993;
        Mon, 26 Jan 2026 06:15:36 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a6fsm30748182f8f.16.2026.01.26.06.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 06:15:36 -0800 (PST)
Message-ID: <18ed7727-b68e-4611-b9cb-6884408835ef@redhat.com>
Date: Mon, 26 Jan 2026 15:15:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 00/10] geneve: introduce double tunnel GSO/GRO
 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me,
 petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com
References: <cover.1769011015.git.pabeni@redhat.com>
 <20260123113334.1dea13d3@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260123113334.1dea13d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	TAGGED_FROM(0.00)[bounces-253498-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14575895D9
X-Rspamd-Action: no action

On 1/23/26 8:33 PM, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 17:11:26 +0100 Paolo Abeni wrote:
>> This is the [belated] incarnation of topic discussed in the last Neconf
>> [1].
> 
> In case you find yourself with spare cycles or an intern -- adding a
> test case to tools/testing/selftests/drivers/net/hw/tso.py could save
> us some driver surprises?

I'll try to have a look and/or offload it so someone else. I have a
vague suspect that the additional setup will require some rework - hence
the offload one would be the preferred option.

/P


