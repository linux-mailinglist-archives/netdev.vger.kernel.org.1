Return-Path: <netdev+bounces-279571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dEBiGBaK5GkmWgEAu9opvQ
	(envelope-from <netdev+bounces-279571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:53:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B75114235A6
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D28A73015869
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85762DCF61;
	Sun, 19 Apr 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hdm/DIl0"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7111FB1
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776585232; cv=none; b=XQfNZb+HoHgfjIpxt5a3/cSuJ3kywzMtuECXjbWh6qN6yzo2jfz6OTnN25nGToLCm8fcfH3O8Rn/1EUzMpypzjH5TkB4yNGPN0vRkl1EL4t3e+7u8IKj+OVupQPtVpFU4+tVKojdyrzNTo1TMPhbAeG1sDjQMMjnKKvtyl1s2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776585232; c=relaxed/simple;
	bh=E51XdivgXYIY5zPsosfCq0DsVtrQFYIvPrKAyxTDIaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmM/ThVVy8ifmBrFulMpEMS4lrlO970cNfTvJ2Njtpj9UjcQfg6SAcDbegYH1llUbP3CRSJ7lu11gyrnJxEB4soR00ptKCyGxdHxC6GEEx8Xjw+d6dpxGdEZIAF1SWRhLTifK8tkDTfE8gyqe3pdbx0bi/94cVfz6nkLb8e/JmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hdm/DIl0; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50806e49-c3a1-4188-bd73-85e0ad688ebf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776585228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NhmQ0fyExbe9oLesQZIQSK20oXCEDZCPnnUDMZ+R6I=;
	b=Hdm/DIl0gB9Oer2IyAnav8h+Vby2J4nL5q9duVVTyEkdn3H5bQKJauSZx8H3LP+MZamlaP
	CKz3uNB41o5rzASzHusSe7xMxBFr8FVJmFTQHL7QNRZ4BJReHFl8iF57eRa9p9nIGblJ+r
	D3HfeQqFGqYR6hgHrehJ+r903uwHw6o=
Date: Sun, 19 Apr 2026 15:53:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v6 2/2] pppoe: drop PFC frames
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-ppp@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hataegu0826@gmail.com,
 horms@kernel.org, kees@kernel.org, kuniyu@google.com, bigeasy@linutronix.de,
 gnault@redhat.com, ericwouds@gmail.com, semen.protsenko@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@ozlabs.org,
 jaco@uls.co.za, carlsonj@workingcode.com, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com
References: <20260415022456.141758-2-qingfang.deng@linux.dev>
 <20260418191145.213625-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <20260418191145.213625-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279571-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,linutronix.de,linaro.org,ozlabs.org,uls.co.za,workingcode.com,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B75114235A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 4/19/2026 3:11 AM, Jakub Kicinski wrote:
> [ ... ]
>> @@ -434,6 +434,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>>   	if (skb->len < len)
>>   		goto drop;
>>   
>> +	/* skb->data points to the PPP protocol header after skb_pull_rcsum.
>> +	 * Drop PFC frames.
>> +	 */
>> +	if (ppp_skb_is_compressed_proto(skb))
> 
> Does this code safely access the PPP protocol byte?
> 
> After pulling the PPPoE header, skb->data points to the inner payload.
> However, the new ppp_skb_is_compressed_proto() helper unconditionally
> dereferences skb->data[0].
> 
> If a crafted PPPoE packet is received with an inner length of 0 and no
> Ethernet padding, the linear buffer might end exactly after the PPPoE header.
> In that scenario, this would read past the allocated linear buffer.
> 
> Even if the inner length is greater than 0, could the payload reside entirely
> in non-linear paged fragments, causing an out-of-bounds read?
> 
> Would it be safer to verify the packet has at least 1 byte and use
> pskb_may_pull() to ensure the protocol byte is in the linear region before
> inspecting it, perhaps after the pskb_trim_rcsum() call?
I already updated the pskb_may_pull() above, from struct pppoe_hdr (6) 
to PPPOE_SES_HLEN (8), to ensure that.

Regards,
Qingfang

