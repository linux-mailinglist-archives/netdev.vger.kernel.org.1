Return-Path: <netdev+bounces-286035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCFYBkpp/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:52:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C434FC815
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CA88300B29F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381A39F187;
	Fri,  8 May 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BZ65DI4W"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB23A3803;
	Fri,  8 May 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280773; cv=none; b=T2PaP1qxoO0LRy3wpvg+hKkn1cy8EVqBSrBgy4FZaCKeBi0sDtg1oUYWryE0BAb2bvhpQw/iXDOsPUeNdwf83+WI6DzpYcnXTambiUSPAJIajPQOuDhVFbnOzKkUpp8q6nLiVrfYFSxKkkVzowc1Y9Xism2TNsfH9QhPNoSvImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280773; c=relaxed/simple;
	bh=s20kqENNCFxqHsADchApmHPC8MzLlEGRdfpMf4PZYOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqvtgBva9oPa8mvyzR68KNUH3ax9xhyQz+9dHRiR8IpG6/pPUQreBImnoL6iZwDFpsaTZP/bKjSPrXPz0KjAt7bnPn1PSqIqy/rO/qpBE95XeJrnqBXHr+/9dWzzrZDk3Nubyzw/XvEEs5zMdqsCzp5pzqDFZe6pGS0hcmhDfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BZ65DI4W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=658ccoulNtX3cPhVXXZRudsliBqtDdGK7HxCbW6pxgA=; b=BZ65DI4WTcWke3r/UU48lt1x01
	BgSKvShjFFs3wvDmN/5KQbJdnMt6sN85x9h3YYmLlIMFgnQJOlILOu/NpBz49JQmZGhmYhJYiVYx8
	v+kkaM6lKHkemrEPXkuOX2rWjQc2osyA/EN0mdFIazaCTdX8vqJOwf6g58A9YLn9CNZOblAtetcMK
	SFS71CB3A6w0ofLuGfKYSZVxXnxM6zWyI0QncjAnVVZhUTCeFT5DrR/kTpUgXVHBhNoBdIIVx867L
	DgQ5v+xbC5F6xTWKbL6kIpsaj16uARiej9xLqxqZAIYdhrcIcDcXZVb6iZuKvmnx+/52+ZUVzwxKX
	HKAo9sug==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLU3k-00000007g6u-0dPG;
	Fri, 08 May 2026 22:52:40 +0000
Message-ID: <27c61395-f04f-420c-9a84-7e27773f2027@infradead.org>
Date: Fri, 8 May 2026 15:52:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>,
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <3c6cde1a-9ce0-4d63-ba89-820c596cff3e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 23C434FC815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286035-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action



On 5/8/26 3:41 PM, Andrew Lunn wrote:
> On Fri, May 08, 2026 at 11:23:43AM -0600, Shuah Khan wrote:
>> On 5/8/26 10:38, Adrien Reynard wrote:
>>
>> Missing commit log
>>
>>> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
>>> ---
>>>   Documentation/dev-tools/kasan.rst                   | 2 +-
>>>   Documentation/networking/switchdev.rst              | 2 +-
>>>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>>> index 4968b2aa60c8..3a8bd40ad905 100644
>>> --- a/Documentation/dev-tools/kasan.rst
>>> +++ b/Documentation/dev-tools/kasan.rst
>>> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>>>   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>>>   will not be enabled. In this case, all KASAN boot parameters are ignored.
>>> -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
>>> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
>>
>> This is correct the way it is - no need to change this. "results in in-kernel"
>>
>>>   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>>>   support MTE (but supports TBI).
>>> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
>>> index 2966b7122f05..948bce44ca9b 100644
>>> --- a/Documentation/networking/switchdev.rst
>>> +++ b/Documentation/networking/switchdev.rst
>>> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>>>   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>>>   bond will see its upper master change.  If that bond is moved into a bridge,
>>>   the bond's upper master will change.  And so on.  The driver will track such
>>> -movements to know what position a port is in in the overall topology by
>>> +movements to know what position a port is in the overall topology by
>>
>> This looks fine.
> 
> Fine as in the change is correct, or fine in that the original is
> correct and the change is wrong?
> 
> Because the change is wrong, there should be two in's here. Please
> search the archive for an explanation why.
> 
> This is the second time in a week i've had to deal with "improvements"
> like this actually breaking stuff. Which also shows that the submitter
> did not search to see if somebody has tried to fix this once already,
> and failed.
> 
> Can we get the tool changed to add a warning, something like:
> 
>   WARNING: This tool uses very simple pattern matching to look for
>   repeated words. It does not understand the complexity of English,
>   and will often result in false positive reports. Please assume it is
>   wrong until proven otherwise.

There was no commit log and no cover letter AFAIK.
Do we know what tool was used?

Adrien, how did you discover these repeated words?

(If it's my script from 2021, I'll gladly update it.)

-- 
~Randy


