Return-Path: <netdev+bounces-286215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E4TKAec/2mZ8QAAu9opvQ
	(envelope-from <netdev+bounces-286215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:41:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45582501633
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 22:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6426300381D
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D635A3A9;
	Sat,  9 May 2026 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0/fcOC0x"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737213635E;
	Sat,  9 May 2026 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778359299; cv=none; b=B/g6ne/LB7E2Y9geBCoIQ3PeNgPDvZpRNQiIiXGl/9z5+oRNyZgtY5Qm5o6BkJuKYj8E7LmxfDOciLzaJ4y0RKEsoivoyOdEbug9wHPxUCoOiIZ/eqWBwxlMKYBlsh/oxig6/0L33+3erUflyhXBK4jYQW+pAJJNY9gUDK4n614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778359299; c=relaxed/simple;
	bh=IvbiowIyJzp/HWMWybhmqyEgvwDPaciIa/5gxI4tNzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWA598KG6fcJJlSw4ojHyl9nNm+i3C/PMdRI0eto+rsLdufs3sQRsq7syZE+MnXbbG9fMqI7w8Cfm6BHe69tJ4nfvDgyl94oV/QCHgG6RnFw5gSHK3Lzj+H3JTvnMo5PWAS9r6589Yn8y+0E/QTmdl+XEnnSzfJo/s5U6MUiF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0/fcOC0x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8Ll9UzEIFrA/Y2cg4MLqHpnXwj68nPuPZz+mPcUm9t4=; b=0/fcOC0xnzptOC8GRNsT8GfFML
	TkDvmgtlcMrnt76s8JV2j92mXn4OBEmAzTBIO8YZ0S1UuQPWwf4cb/yyRVt0fjaGJjySBHFqFlWB8
	cUhjdhVm9N8HC8IZfwIizFSSFN1KQPeXU8mStMitD3pp+z9r+WPZUouA0UM7fu1l0oi7I6IEUnbPn
	+stFVqmhBKWbRscWdfWMk94qnObTT9GlsTAQCJTQlptE+u7ifOPWCDKqvg+djKBRfdUwjd56fZD0q
	7VsGmcVvUs8nYipfnyBE09xWL2LVI6qhTneI6OZ+M/Yc7aFuKKsbNwKxDQtZzzjz+MmLuEjGwEXk6
	YzDJOwdg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLoUJ-00000009dBh-1fcW;
	Sat, 09 May 2026 20:41:27 +0000
Message-ID: <5cc6c7e2-f870-47fd-8fcc-0e4c2b978f2e@infradead.org>
Date: Sat, 9 May 2026 13:41:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Adrien Reynard <reynard.adrien.08@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
 <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
 <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
 <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
 <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3b4357a7-f70d-41b0-a75d-c30f9fb7dd98@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 45582501633
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286215-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/9/26 12:39 PM, Andrew Lunn wrote:
>>> Can we get the tool changed to add a warning, something like:
>>>
>>>   WARNING: This tool uses very simple pattern matching to look for
>>>   repeated words. It does not understand the complexity of English,
>>>   and will often result in false positive reports. Please assume it is
>>>   wrong until proven otherwise.
>>
>> There was no commit log and no cover letter AFAIK.
>> Do we know what tool was used?
>>
>> Adrien, how did you discover these repeated words?
>>
>> (If it's my script from 2021, I'll gladly update it.)

Adrien is not using my script -- they developed their own script.

> Thinking about it some more, i think the warning might actually need
> to be different.
> 
> If this tool has been around since 2021, all the real problems have
> been solved, leaving only the false positives. So the warning probably
> needs to be much stronger, saying that it probably only reports false
> positives, unless the code is new.

Makes some sense.


> Maybe we also want to extend the tool to have a list all the known
> false positives?

I'm not crazy about that one. And we have no evidence that I am aware
of that my script is causing any of these patches.


-- 
~Randy


