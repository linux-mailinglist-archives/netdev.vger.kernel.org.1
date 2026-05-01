Return-Path: <netdev+bounces-283297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPT2NswY9Wm+IQIAu9opvQ
	(envelope-from <netdev+bounces-283297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF54AFC57
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 23:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB63730252AB
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06A2C21E8;
	Fri,  1 May 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKZ+6XA5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A435E940
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670038; cv=none; b=M23OolS0yy2/TjnBLG+UbXaWjDVYNWcUIbNxB2pJ/Bqo1wClzeJs0ZQ3MBi0VDm17EAI1aOyU6gnixsPDT/CusC7udWPoz2fw+u07tsYtbFqLI+sMoZvoDni2XUSVXxM+n+iWYhecqOv9A7Y3objTMLxU+FDPdZScovhXeLei5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670038; c=relaxed/simple;
	bh=95Sx+bv9rxt4Gdz7nmbDOorSaWI3FHFN25hadY8x7BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9i83OrGjR1y/6XrP+DWXpZhUrGFATbfMnc1/43M9NgdQaDzMjBjlN7SrpUbCwfeMf5OSYlwj0TK+B4ZiLh1FB54grgqbr0EmsE3B/3wzbiNVEqWZu7dBE036voH44n+p0+LuVKJ2WIj1NvWbdV0PyNwH8Jr7gXbBbwGsuBDBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKZ+6XA5; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2d868d014a5so2430462eec.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777670036; x=1778274836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMzZq/UEE8cGhjEjr/oMQyDTO9ytBsSVbsJW31mprl0=;
        b=bKZ+6XA5BMsgrkB4QHcW4kkHrd7YbdiyW8XdhwIrXg+Nz5oVrzK0qgyrOHvJ5e23oM
         MtShMShVpYfenJlEeHRa+8p3nbsZwESvSQhTfFWnmZlSeBDX3/fvRIV5V8yKpp5g9QRv
         v9WvdAxhcC1cywWIivnaWKqoElQVPkbuOBxGHUAeWwxBlgPYOtFO3x7vajg4P3/2ZqMX
         nK5znRSjn0KT3eFiio0N4JHnTOmLjSF27jmPSY3et4c35CWS/z++t6mDBiG3r629pFJY
         nnN9ib5nxDC3fmsaQEuqT21ZqzWrcIIpyQoqSxcHVGGeLl7gor9WkCHLiDbBH9cvE/Q1
         bIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777670036; x=1778274836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMzZq/UEE8cGhjEjr/oMQyDTO9ytBsSVbsJW31mprl0=;
        b=VEVlWgO+6P/1+8jpMMKpo1I+cgvyvWrFTLIjxLtadeeGTD7SejbDFHq85SDojRgYLC
         R1gSHquNwmHUBfJUmClgcmknhbfMf3pMOQD8BXjL9gfJgF0qqHhg4qcegiJftQyc8LG5
         wQL8RgKY5qT6p7NqPuRX7REn7bxazualmy0X2i1vxHkSR/E10dFze5RDGUDGDSjvHmLW
         xNUxUcycFDvQbYr7NBkDPecz7gJO0Yx6EKdKvdKwTw4NX3/nNryu/Gk5zxmZEEhRIDoF
         8NJs5UfAfC0Bh0ZVsJXiP/m6ReF13YG7sUA5rC8dpVMP8/2TR/RJ0h2U978tW019Hhk0
         Sa0w==
X-Gm-Message-State: AOJu0YxjHMkwQCiMpxKO+N687/BtReRHQTGDo/rC20wvqXjLmWYErFOj
	M1DvDXwuvwmXCSw2pax7nGmfYpLe1ahqxgKItPlNB5e/a98kzw/Q0LAO
X-Gm-Gg: AeBDietA3G3D1E2DOEJUGD/cXgGcBIe2x+7qVMhaj/aHlXa84De3O24gem3PvU7QZe0
	8FkAvD4YySAONud6lNiuBGxaFuRWpN+htmruKIaNReUzqsZVQ+TDv0btlCZMmU4frfR/Ia3eCll
	hGVEFcJS1kbiXTieirNxgnibUJ75ktfnTwQmmn7TbQ+lXMlKjopD4rh7TIXSn1sTXo7ofsCOmMU
	jCMImwVHL1T/+jetI3+a0KyOCoyUVJ98E6s8YdL2nuCriTZ/e7UzB8Iwq6OkPDpasLcSBh1TV2k
	p0yoJOFaXBR9zRzuArwKygz1PRkkpNh6wUTkmdayu7mNDheZMlmMOLv4zCrPC50kPmrMWLf4BfP
	8DKdjBu96sOt4SkzaMwcnaqE0528hIzm9WrKGId8VuoD1fy0klBAWyXbRhdDcTgpy5v8unhOHNv
	PoHKTVCvhYtOeg/AkrteJzl4+DQXjZ6bT4b/gu9l9or98Mm0k018WQaOL5KXMAwdDMmFC0kC65R
	LZpGGUUQa7lidpyneD4AQ==
X-Received: by 2002:a05:693c:3005:b0:2ed:e14:7f55 with SMTP id 5a478bee46e88-2efba7a7989mr412676eec.31.1777670035902;
        Fri, 01 May 2026 14:13:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::4a71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d78391sm8030670eec.7.2026.05.01.14.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 14:13:55 -0700 (PDT)
Message-ID: <25780d3d-3d5d-4aaf-9bdc-c21d7051232f@gmail.com>
Date: Fri, 1 May 2026 14:13:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/5] netshaper: Extend netshaper support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, ernis@linux.microsoft.com
References: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
 <20260501081741.0e07ed4f@phoenix.local>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260501081741.0e07ed4f@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 36AF54AFC57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-283297-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]


> This helps the compiler with optimization and static analysis.
> 
> These are all minor issues in an otherwise well-structured patch series.
> The code properly uses designated initializers, validates input with
> appropriate helpers, and follows the error handling patterns correctly.
> 
> With these small fixes, the series would be ready for inclusion.
> 
> Best regards

Thanks for the feedback Stephen and David. I'll address these points in V2.

