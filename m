Return-Path: <netdev+bounces-281900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC3eInnR8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DC487C7F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83C373040A47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622D423A7F;
	Tue, 28 Apr 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="iXsur50J"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B01423149;
	Tue, 28 Apr 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384512; cv=none; b=c5sJjqwg8ytGfEMr9O34nbvGlQI4lu6C5/gOp57IQ3ECYSQd0O8zegN0iusebz/mAJfoMD1PNOR/3ENea5VjfII060UWiB+Fx0ScyHHwetAH7yNYDvILFJnR4/jfZ22NTnNJowubzQMWVXy5yZimZqD70w5qIHnOL5F3ytV2U+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384512; c=relaxed/simple;
	bh=/TBA7XiARwiAQSZx68MCDTSAaKoKqBvl4YcHodvi+v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfroAfol7365cusELovMGGdCRUlK+7+OPs6nQ00NIuhx0WodmH0IYb72icTzNPDMQYaYgaYQZ+56eqLWDqOJqTVISUgx5mG+eXhzdFNsMJ/SzRZGiGw/5i+izRJhJOHtVkB/6CcLS0lnNNvb5Yc2llB9V5OIiZAhoYUoh4qV5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=iXsur50J; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 327C2114D84;
	Tue, 28 Apr 2026 15:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777384507;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EGvD5wcsJVw3RfY6mBOHDdejysfuQE2W+/6cq0RYXq8=;
	b=iXsur50JWRiqSHyUyxIPuSKrJ6Nrt8Y0TxzAvJya9ulCRzxh8ixa8p1h1y8FDkSPPwzvNu
	0gNrIml6FqPdLEsN0XWOL1jEPKbQ/NOn8KuOB7C8510WTKxUyOBUZvnVJbV2EXaCrEnxhk
	pWR9iWQzQy6X8KYUJliWPw7XgN//yXlxBKcyDsBlm1U2Q4dczQHJPdDxdcOvRgpKhG6XMr
	nvfdMYn+v/SwYClJPFKjobx5KqzYs4IFZ8iHx2MqIt8M5ZPnzJRn9tas0vOrfw/rlKFZQS
	q77ap1CN9Xxm/rhrqqspk2KCeRUkS66Kldkuaobkhz0BcU66NGZk7IKVqJVpwQ==
Message-ID: <ba6f9b8e-f4e1-4368-0829-526cf9d6da9f@nabladev.com>
Date: Tue, 28 Apr 2026 15:54:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20260425031339.3318-1-hs@nabladev.com>
 <fcb880c0-40d3-4613-af73-f1cdd1764975@redhat.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <fcb880c0-40d3-4613-af73-f1cdd1764975@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 621DC487C7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281900-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hs@nabladev.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello Paolo,

On 28.04.26 15:50, Paolo Abeni wrote:
> On 4/25/26 5:13 AM, Heiko Schocher wrote:
>> Table 7-121 in datasheet says we have to set register 0xc6
>> to value 0x10 before CLK_O_SEL can be modified. No more infos
>> about this field found in datasheet. With this fix, setting
>> of CLK_O_SEL field in IO_MUX_CFG register worked through dts
>> property "ti,clk-output-sel" on a DP83869HMRGZR.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> 
> Note that a required fixes tag is missing here:
> 
> Fixes: 01db923e8377 ("net: phy: dp83869: Add TI dp83869 phy")

Should I resend a v2 patch with this tag added ?

Thanks!

bye,
Heiko
> 
> /P
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

