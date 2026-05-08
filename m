Return-Path: <netdev+bounces-285950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA7tNPUi/mmunAAAu9opvQ
	(envelope-from <netdev+bounces-285950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:52:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8A4FA3C5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E175030B1119
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E141B37D;
	Fri,  8 May 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zuYsXKrB"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786E332EC1;
	Fri,  8 May 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262260; cv=none; b=Bcw66SKTn0QnheRpnhPH8c2RPWmkVD9TcHRt7Y5YtgDtwRYWsWzdo6jJKyJDKYK0KWqgYddiwbFT85pl/NBOCs1QilqEcM1VoWEolWgujEE731xVVPZPWSQvVx9TTj+JKjWwJvAUlqosOPbtvlnsOfr7Wp9LaPMRZZfAxD6IK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262260; c=relaxed/simple;
	bh=vWBbf3JinArC7hIZtuRm76eG4Ogp1fNM34BXC2qJUoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CZji/2PFG8jSmM3QVwhxIio/MQoaTW3xo/cP6XAbjwvwpsK919zjBThMrDRSuAebdo0dtr1xz8s5sqHkOs1yYVdcUq818tfKMiMxUcxsGbKvv3oj69jFL6/Py5pKqpd16Fu6N3TOXTJDBqoEOyBsOXHqCP4lC9AzMUWgzB7NfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zuYsXKrB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=fa/e34xs+vWwC/zpkG0Qp4UvPM0UzqYtHRg0W2k7uTo=; b=zuYsXKrByCw7L0zVLyvYfMEkAH
	i5TqP3X44ObLDxGPgXhQwzrFz/tQlroxqLvqdN1GWUsEAfXSF13OtI0GFy9QLKBvghXNMFfO/URHH
	S7eUmCu75/clOgqVhlmlVRvzhGnS5dHHoDz9Qk+EZpzUGlIlBP4FdNunjvD4Fq7hxoafOBAvZLquF
	v2G9ZuYwQAo6/FJazbEv5UToxyUzSE9p7M1LKvKiU0oRMBzfPOWuITDPV6TWASg2fdGjYIDTuElq8
	p3/djUgKtSzwOeKL1FSY6acGPzao662sbYJorlLdXupPudIVHChJ++pPwkjDGkjUiPHBE7USh/G11
	fBZz2Nkg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPFD-00000007B7a-273Y;
	Fri, 08 May 2026 17:44:11 +0000
Message-ID: <7bb54e36-44cf-4816-b66d-a18534ea05c8@infradead.org>
Date: Fri, 8 May 2026 10:44:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Shuah Khan <skhan@linuxfoundation.org>,
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 30A8A4FA3C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285950-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/8/26 10:23 AM, Shuah Khan wrote:
> On 5/8/26 10:38, Adrien Reynard wrote:
> 
> Missing commit log
> 
>> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
>> ---
>>   Documentation/dev-tools/kasan.rst                   | 2 +-
>>   Documentation/networking/switchdev.rst              | 2 +-
>>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
>> index 4968b2aa60c8..3a8bd40ad905 100644
>> --- a/Documentation/dev-tools/kasan.rst
>> +++ b/Documentation/dev-tools/kasan.rst
>> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>>   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>>   will not be enabled. In this case, all KASAN boot parameters are ignored.
>>   -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
>> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
> 
> This is correct the way it is - no need to change this. "results in in-kernel"

ack.

>>   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>>   support MTE (but supports TBI).
>>   diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
>> index 2966b7122f05..948bce44ca9b 100644
>> --- a/Documentation/networking/switchdev.rst
>> +++ b/Documentation/networking/switchdev.rst
>> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>>   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>>   bond will see its upper master change.  If that bond is moved into a bridge,
>>   the bond's upper master will change.  And so on.  The driver will track such
>> -movements to know what position a port is in in the overall topology by
>> +movements to know what position a port is in the overall topology by
> 
> This looks fine.

Change not needed.

>>   registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>>     L2 Forwarding Offload
>> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> index c37e8e594d12..7b08738c30aa 100644
>> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>>     Developing always goes hand in hand with debugging. First of all,
>>   you can always run UML under gdb and there will be a whole section
>> -later on on how to do that. That, however, is not the only way to
>> +later on how to do that. That, however, is not the only way to
> 
> This change is not needed. If at all add a comma after "later" to make
> a distinction between the use two back to back "on"s
> 
>  "later on,"

We disagree. :)
This change LGTM.

-- 
~Randy


