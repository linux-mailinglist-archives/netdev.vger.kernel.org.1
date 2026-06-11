Return-Path: <netdev+bounces-298274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3/WBsv6Kmrp0QMAu9opvQ
	(envelope-from <netdev+bounces-298274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:13:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6B6745C7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=SSnD4lhF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298274-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60B31310682C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111748BD5F;
	Thu, 11 Jun 2026 18:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751F40803F;
	Thu, 11 Jun 2026 18:13:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201590; cv=none; b=jw+z34DCyFXYxzyTLvB3ET0ajoLGy9ALY3MpoNzlyqSZQY9ajGrgidSPNtbTEs58mZlQc1XFxxI88ulM2NVhoDaA0WYpWHkGMnYOrIuOo0NEmju+DeLf16CvK3PhTuJoagYKrIKupzNrQ7hxNnzVqq7MICpn5va6uID6sQTKnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201590; c=relaxed/simple;
	bh=3I4xoxP+p54s1cGQssQ85yGoc0iciTPk+xpmG//tbqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqp1da7RoJ6uBVplzhJf65D1EtSP0FFEHScEuJ+evQyAPmwZt6ZVWqkzqzrbVy5vSCwN6X2udyiz2kyA1qv5EGCMdp+Rg4ABULB/b5ZkxTZBMhJemJ1xkyX1Y0KZArJPR6PHu7a3GRdhdcmtKlP+7uoypN4U4SAUM1X+7BDc52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SSnD4lhF; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GLBFDngNHJBFn0sLaJMmuhhTTkvE395p0MoxIu7Plic=; b=SSnD4lhFMe6i3Nwm0mlklSlGM8
	tRQhmUiRi9N3gsxQi6IQtk62ldxUXJ+m+0w4t/4t4PFN4dQfIcDIiLcZ7xBE8pnErUa2WCE/p5Eu2
	07NCvL3b+4PRDRkaA1FX1ScyG1f7+lQH1B5B3YNAl4q0tC0NJLJPr7uYYPbAKM8L/Vs+/zQMS5KcJ
	0XyW0aLUVJsM+cAPLiZ+cjvxjoj6IFFtTWbwXqXW0b+bp8E/B/QZsQQNM2/G2rWMqBaQw6z4IVDvg
	4yzJ1TZyiQ2hmBF+Bqogzt2DOfep92mBDmciuDIz6gdtoUNtO+6ZOqf3xt07OljCOkBgOjwrno4W5
	qdz61aNw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjtr-00000009sNP-0BMw;
	Thu, 11 Jun 2026 18:13:07 +0000
Message-ID: <a44db021-3a63-42dc-b1da-7bb2dff089e8@infradead.org>
Date: Thu, 11 Jun 2026 11:13:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] docs: net: tls-offload: document
 tls_dev_del, tls_dev_resync, and rekey
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 skhan@linuxfoundation.org
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-3-kuba@kernel.org> <ainR5GAK8LaHJYMP@krikkit>
 <20260611101817.18964bd9@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260611101817.18964bd9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-298274-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEB6B6745C7



On 6/11/26 10:18 AM, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 23:06:44 +0200 Sabrina Dubroca wrote:
>>> +The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
>>> +to synchronize the TCP stream with the record boundaries:
>>> +
>>> +.. code-block:: c
>>> +
>>> +	int (*tls_dev_resync)(struct net_device *netdev,
>>> +			      struct sock *sk, u32 seq, u8 *rcd_sn,
>>> +			      enum tls_offload_ctx_dir direction);
>>> +
>>> +See the `Resync handling`_ section for details.  
>>
>> Hmm, this callback is not mentioned at all in the "Resync handling"
>> section. I think it'd be good to add at least a quick note there about
>> how/when it's invoked, and what the arguments mean (at least the two
>> types of sequence numbers, since the rest is identical to the other
>> driver CBs).
> 
> Something like this, you mean?
> 
> --- a/Documentation/networking/tls-offload.rst
> +++ b/Documentation/networking/tls-offload.rst
> @@ -278,9 +278,9 @@ sequence number (as it will be updated from a different context).
>    bool tls_offload_tx_resync_pending(struct sock *sk)
>  
>  Next time ``ktls`` pushes a record it will first send its TCP sequence number
> -and TLS record number to the driver. Stack will also make sure that
> -the new record will start on a segment boundary (like it does when
> -the connection is initially added).
> +and TLS record number to the driver via the ``tls_dev_resync`` callback.
> +Stack will also make sure that the new record will start on a segment boundary

Preferably "The stack ..."

> +(like it does when the connection is initially added).
>  
>  RX
>  --


-- 
~Randy


