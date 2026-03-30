Return-Path: <netdev+bounces-273325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M6pEGDlymloBAYAu9opvQ
	(envelope-from <netdev+bounces-273325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F09361414
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E46D30300D4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A339B4BE;
	Mon, 30 Mar 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="OCXKeTOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D239BFEB;
	Mon, 30 Mar 2026 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904607; cv=none; b=Yi1WtQIVgw8jHshny3YgQjoT0PKRSnGGkdXpmwkhKChMHuAAsTBDqlfR6fQ0tjiVqkVz4v3AkTImSgjOswEkgLpbO6c/KpkUBqzEsT/PB8HrGb3OTjsAMTksg2PJ7EqBExoxkjI/TJUuh5/W6rkE6bpcOnP8ShR8Vo0Q694CsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904607; c=relaxed/simple;
	bh=w1aLGMLQtidwdL+bfN3B1dZ0hayPSe7uJ0nIHApsbv8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NzbPDDtHmtHvwFn8vXx9eqE4/PDhMeplxcNwLSkOhNQux4uudTuxwMi7bKX248CnhGKbuPNNOYl47am+xLJvXXJcoGpCL21e5vs3uDBibXgl6jzLsZvrMPlCMXOaqnBzwmdxipB6Ph6PUrQqZZqj/18qx5lxP/n2hkDoH03q74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=OCXKeTOe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44CA6A56FC;
	Mon, 30 Mar 2026 23:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774904595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5g17+wuSJArzSX6jeFcyrufBHGNDfuvnCEYVcyEwhVc=;
	b=OCXKeTOec/NX2wMTgqgkMqTCA6LgqSX9HbMGzFum4qjiwaErWaygC9nhvIoDbeqITeoDcP
	lTBvTi3LUlq0su43a5qRwNttJ+IjxNhMeDqw3qb9hKYhWl35SPCof194g94ZTC7MOCBE9H
	/VvfIi4PQS13yNvNrIi10L3yk2JB+BJDb/nLbTh4U+EfCoaXEU7UTSxWbMGIUjnawqvNMx
	R+2JeCtYlrjwPkg3YWLujUVORx+jSoO7fwjQ2Uw4xWHK8DH9/ToH+mWGgzTsMy83n+OMPw
	FaDVtnweL6cMsfdkm3Pko2hJwiwagziTL0bdjjiN4yysB2wy3liZmZx/8mK1pQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 23:03:11 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Doug Berger
 <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Bhargava Marreddy
 <bhargava.marreddy@broadcom.com>, Eric Biggers <ebiggers@google.com>, Arnd
 Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: bcmgenet: convert RX path to
 page_pool
In-Reply-To: <aeaa44fc-d7e2-425e-a7f5-703bc8539f82@gmail.com>
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-2-nb@tipi-net.de>
 <aeaa44fc-d7e2-425e-a7f5-703bc8539f82@gmail.com>
Message-ID: <b2278e983ce5e3bbaf90a50722233960@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-273325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,arndb.de];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4F09361414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30.3.2026 20:15, Mohsin Bashir wrote:
>>   		if (priv->crc_fwd_en) {
>> -			skb_trim(skb, len - ETH_FCS_LEN);
>> +			skb_trim(skb, skb->len - ETH_FCS_LEN);
>>   			len -= ETH_FCS_LEN;
> 
> Looks like 'len' update here is unnecessary since we are overwriting it 
> later anyway?

Good catch, the len = skb->len assignment added in this patch makes len 
-= ETH_FCS_LEN dead code since skb_trim already removed the FCS. Will 
fix in v6.

Thanks
Nicolai

> 
>>   		}
>>   +		/* Set up checksum offload */
>> +		if (dev->features & NETIF_F_RXCSUM) {
>> +			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>> +			if (rx_csum) {
>> +				skb->csum = (__force __wsum)ntohs(rx_csum);
>> +				skb->ip_summed = CHECKSUM_COMPLETE;
>> +			}
>> +		}
>> +
>> +		len = skb->len;

