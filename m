Return-Path: <netdev+bounces-292071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFkMO4JZFmo9lgcAu9opvQ
	(envelope-from <netdev+bounces-292071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:40:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 505405DEA13
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 04:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BEFD3013AAE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEC2283C89;
	Wed, 27 May 2026 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCLEH0ZV"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92128634C;
	Wed, 27 May 2026 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849599; cv=none; b=pjAtPZ06hTVcSf1LEnR+SVpXMcGGf+ZGvcdlJ0PCwCPj3jZ7QM0n6P4zGorlUDSOiGMz/+7gCkX1imVdbTLSTe95R1SPyaxy79rZUH55Gm9Ef9gbVqj5nYlvTAHJJtBqXjFDFuCWUPPL3B05JSooxLUMCrbgtAfKuDpD/Xhi2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849599; c=relaxed/simple;
	bh=IxVcgxaiFRhrbxKKNt/n9CTAfyskZGeCxhccEfOgkOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnxIwlotn7vTqHdqVrGCBSsbBsDASWkZj9GxeYqAvOVHAtTaRjjBs2jJAHl/DGovOqEnvQ7vLHS0OXzS6ly+spiYCn2SJAPZnV1HyMiWf6dV2X2J9w0NU/9uBPyp1TgMTuvBRXaL0dKJPjjhuEUcWOyx+d+iKcJohfcOj8gkFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCLEH0ZV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=17OZ+SJ5AtcF0dHm0RawFo9m+tVpv7RAqJytRnY3cN8=; b=XCLEH0ZVNQ6eBKZvQo3vAViF8M
	GU+IsGmQOWY/AM/EqvLA8x+TXS1Cbq3Kz7E2ZiZHHPhN15BBobGE4iLNwChY7TdK7V3/8ay4backk
	wd0TZEHybBzfziLoK33074mPLo+esM2rHwaTKRKgB0ksLRisHtDs/KClSyXBSddQWfWCSqhkkMZ3V
	eGD5VCU3gtyHjnGQdF8SFB4WanDBpLM9yOrLvTjuoYwHsqN+aGTwQAe5GYArSXgZmyONAED50Qa6X
	W/1LAY69lG/60zXasFLKm7QBQXp2tly6ZoWQOIcub4avuVs5iZYEjV4YnPVboQVC8AhBrrlm5ao4S
	whAtF/HA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS4BQ-00000003AxU-1t9k;
	Wed, 27 May 2026 02:39:48 +0000
Message-ID: <72e0f118-5fa5-4ca7-b443-b472e7ba317d@infradead.org>
Date: Tue, 26 May 2026 19:39:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com, linux-doc@vger.kernel.org
References: <20260526160151.2793354-1-kuba@kernel.org>
 <1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
 <20260526153719.7261b7f2@kernel.org> <20260526154001.4a8d30bf@kernel.org>
 <9757813c-dfc2-4979-80da-c3bbf962dc4c@infradead.org>
 <20260526181513.0393ca46@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260526181513.0393ca46@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 505405DEA13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 6:15 PM, Jakub Kicinski wrote:
> On Tue, 26 May 2026 17:51:45 -0700 Randy Dunlap wrote:
>> It's in today's linux-next (20260526), line 1950 of
>> include/linux/netdevice.h:
> 
> linux-next is useful, but we try not to merge broken code, not just
> notice it after the fact. So it'd be great if the fix made its way
> to Linus and therefore propagate to subsystem -next trees, not just
> linux-next.

OK. I don't quite know what you mean by that, but I just checked the
current net-next tree and it's still there at line 1950.

-- 
~Randy


