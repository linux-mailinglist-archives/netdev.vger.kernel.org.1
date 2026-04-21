Return-Path: <netdev+bounces-280198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOHvCtew52lZ/QEAu9opvQ
	(envelope-from <netdev+bounces-280198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:16:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2AD43DCF2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BEC130457E0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E419004A;
	Tue, 21 Apr 2026 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBvNcvHM"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA12D97B7;
	Tue, 21 Apr 2026 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791560; cv=none; b=c5IG0zpSod0LyXI4H7wLPTVvTTXtOg02J5oh9ZY1gVJrrqQqyGOBC9zdnJWm0Yz9jcVkL1oooEklYkhxhkvX69/hP6xlTU0tRkUMKQNV3SHLFFSjDvyH3wev8KAfoHe3umFrnxXtCf3fRRHpgfkJvZsP2IUXb5Fip0pDSR2hmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791560; c=relaxed/simple;
	bh=lDD4mFtiF/g0xmUz0hEvR2E8FUHSWbKgZE2MMcfcfCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jusFATpY2xue46mricCIHZRSXzaT0mLpqkGaxF6AVrjEqdJXmyB3+6d/e+kkAaP0X+AIzz4otJhHq44CzSYQj19+3Z1l90sQTsq/3mrsIBd5zjy5uTD6+gV8VhVuWLA97i4YTbnP1UFBzZEsHqybfW9a79XEU2Cdl3iz7L/ax2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JBvNcvHM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=pa+7dmAkJk0TY/M9oJPj1j6Upqwk6hNaxUKb3SseGGs=; b=JBvNcvHMBmwOLL6H5J4RUJMLsD
	c5btm4ojoUy/gCDRfEpaRsYdJjTzMmmkPK6Ojjk0K8Yk6ZsdhLIciZU4MVDnS6R4gUfGMzlfJYvXo
	oFXuR496GLhQ4q/Qr5m3SByT/aQWdlk1Taud04KOiEZb6bBnqnXTJ1qxkIW56rBwewL5JRgK6RpZ9
	1cOZiTjQUh6NYLGjjNo+HDM9smdO7MCGtNA9/96/O0NycPL0JXGOm1woabQBI0JUbDvU4pULmm739
	2iIJ+CGvopGJxBvLXQT9qNwnsgPhhki1L+ZermLETx2qaxBmudliZIoBGG1I7wK2M/i5MK98plsEO
	xSQBbeGw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFEeJ-00000008xF0-2Tza;
	Tue, 21 Apr 2026 17:12:35 +0000
Message-ID: <57045171-b306-4277-8f9e-77a96ce31423@infradead.org>
Date: Tue, 21 Apr 2026 10:12:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, marcel@holtmann.org, mchehab+huawei@kernel.org,
 jani.nikula@intel.com, gregkh@linuxfoundation.org, demarchi@kernel.org,
 justonli@chromium.org, ivecera@redhat.com, jonathan.cameron@huawei.com,
 kees@kernel.org, marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
 nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
 linmq006@gmail.com, linux-doc@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <20260421022108.1299678-1-kuba@kernel.org>
 <CABBYNZ+yCH2hxbS32o6eDT7BDMLZd3YpjUZ=sfiw=z9XjMT6OQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABBYNZ+yCH2hxbS32o6eDT7BDMLZd3YpjUZ=sfiw=z9XjMT6OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280198-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,holtmann.org,intel.com,chromium.org,huawei.com,suse.com,gmail.com,cse.iitm.ac.in];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2AD43DCF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/21/26 6:55 AM, Luiz Augusto von Dentz wrote:
> Hi Jakub,
> 
> On Mon, Apr 20, 2026 at 10:21 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
>> from the kernel tree.
>>
>>
> 
> Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Please don't send 1.7 MB emails for an Ack.

See https://people.kernel.org/tglx/,
especially "Trim replies".

-- 
~Randy


