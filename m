Return-Path: <netdev+bounces-246313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE803CE93E5
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C33F5300206D
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885ED2C21D8;
	Tue, 30 Dec 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jSIagAW4"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326082C033C;
	Tue, 30 Dec 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087762; cv=none; b=ou6yxAIqsU5UCP+C3vo7K8bWvomPNKLT7ztprN+W8PpCdDVaQojjvYMvDH+uZeD6jPhAvVFXbPALit+Optpy/W6lOxi7oj734LT/N1OeFY9rZWL+Y6M1SC9JIGQasfijXIyzSTrQHIfaXKDHniB9FT7VCs0GFW6Ojl1TLLrDCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087762; c=relaxed/simple;
	bh=XmqKIy9cnklve1BV71QOG3wfHWFkj4jPxiUdfwlPgPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2oZfX5py8aLGVLhwReQGzk+y96LuVfeC0qPSI97xd1qbLyrbkKqKN881+/VKpuAapoiZYhzJvHV3kRy8iwdrKsvHLbx8VB9gV2EkZ3i89fZ+vyIIhC2IaLzvbiWAFoP/CA9mptgiN6CF1jK+Dg8DxX5hXkRCBKtf+7ZX/zBinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jSIagAW4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767087744; x=1767692544; i=markus.elfring@web.de;
	bh=GSOjd40VlSlbou9mKAeILtRlZtg68k4M7wE/MNX/JyE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jSIagAW4ZukCNkfYb2KA6wXczmmwZWVFFU2aauF3TggWnBJRoBoidZ9WvsenbJEt
	 ghaYvejLesmv/YpkhGPPq1EwN//uVK4byGs1GUTjcM9Hnr5vYTT7DIo8IrnZhe+d9
	 PkeYQ1unfZ0n8Scr+HQA6iSY97Zv5UQhR7cIJDV0O3aw1IRxPY41C6jD1coE2B+ZC
	 9H6FBYFGlSTG5SUOtQwADUJ4/RJhuTvwtWg3lk7fBAL4TTbW66ANYQzrt1Wpzkn/E
	 AOGlKl7mstIsoxRI9PjIM3+HiM9KLEjHsiyi2lB9leX8tBOYhcuas1vLhTyg9+xr9
	 gKHqmGqWKaw7sjlEMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1vxHu92sLN-00vuk2; Tue, 30
 Dec 2025 10:42:24 +0100
Message-ID: <a79bed83-8a43-4ed8-94d4-542b7285835e@web.de>
Date: Tue, 30 Dec 2025 10:42:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
To: Jianhao Xu <jianhao.xu@seu.edu.cn>, Zilin Guan <zilin@seu.edu.cn>,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Paolo Abeni
 <pabeni@redhat.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>
References: <2835cc53-326d-41d4-9ca5-1558c0ccbbaa@web.de>
 <20251230092532.1145752-1-zilin@seu.edu.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251230092532.1145752-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KYu3y2aFGD3vMkvPGPThL0Lgr4n7pFDelEFMtz562Ja7o8wgh52
 vZ8+AdNcWjzB7XCr2z2fCPC2zPO5s+dAAdh+KXjO12QxoJro2HH0L93Jnp1p9bzW+2qs6jt
 RE7bIMjkqnkRFuAOiw0UYsJG9+TuFkjWkLXIrxf6sDvOm0CVDDtP4vTHZiFi8ofV6qWOyj6
 4ajmKcvvlTJUIcVlBuO2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9qTOH6/4xto=;aLy0C3ki1CRw3hcPrmU+Dz4mH3M
 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

>> =E2=80=A6
>>> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
>>> @@ -456,6 +456,7 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
>>>  	struct sk_buff_head *free_list;
>>>  	union mux_msg mux_msg;
>>>  	struct sk_buff *skb;
>>> +	int i;
>> =E2=80=A6
>>
>> May this variable be defined in the loop header instead?
=E2=80=A6
> Thanks for the suggestion.
>=20
> I would prefer to keep the declaration at the top of the block

Do you tend to interpret such information still as the beginning
of the function implementation?


>                                                                to mainta=
in=20
> consistency with the existing coding style of this function and to keep=
=20
> the patch focused strictly on the fix.

Would the mentioned variable be relevant only for an additional if branch?

Regards,
Markus

