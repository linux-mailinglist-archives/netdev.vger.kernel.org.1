Return-Path: <netdev+bounces-274402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J54M3AZzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33138514A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7862301E239
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144436DA16;
	Thu,  2 Apr 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="FOOoIjav"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1431F9B8;
	Thu,  2 Apr 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114092; cv=none; b=aPpLc4LcDi/y3UzQsBWn+jUAc1dK/0P74kglhrrQO7KYz0XMt0dQnJ6YD4GP6nrodkTmjYEn+5EiBTG6G0B8XI11Kb+bBo7aC7yEzptPw02bQHP67AI8M4Rr8ukahyNH2nS96kFP2nitnSFAvO7Askrv2bnTu3+B6skAO0sSZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114092; c=relaxed/simple;
	bh=PjRBbHyCDRs5giP5cHIj0UQ85MPBUDBHa3e7t/RsNA8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=kRXmcMh5u7/NNRy2oar3IAu8HEbKwl/pLzENDdtPHv+Edga3WsXepX7We7Kwe4TiCUNReh9Y75VxSWLTafjJznfPtmeuno+Bt4JIj2vzlTeGZNqTK39HouAsyrXepua6OkJDG3+Ejldq4iZAfvkvcFvLsqH2dRqjRXwR3yvhnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=FOOoIjav; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6566d59578=ms@dev.tdt.de>)
	id 1w8CGJ-00ATtn-5K; Thu, 02 Apr 2026 09:14:43 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w8CGI-005hTl-1N; Thu, 02 Apr 2026 09:14:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775114081;
	bh=lmFCqlfBE1fnq5/a2R/XBJFQiWLUI085rhhck3qDYPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FOOoIjavVRyTUPmFdkJZsNNZkzXcVcISOxtTcUf8yaL/OdmWyKG0SjI0SspO2lnmx
	 dHboeRz7Q6g05aU5jJd70wNpMnZWlNT674aythhN0qovbZlLVBmGZX7uaTMdWb8v4k
	 XZJYiGy9A4UGkH3yT+GmODkmrtXp3eWQaX0XaHkvHXlPxVgipAwFjf5ATByzuJl0j1
	 s28NYh6xd7bZNp5LDL8zMC7zObjd0CVJWHkf5HcKff4Bsn2qKqu5QPqN2TFxAl4EJI
	 /HXx6Sz1ZMNaS+C2/k5BG1K8iECOYf0a2orAd6Nuzmh+fUPifMBU3bSD86uQLsXD2y
	 hNxqQ3y+ZEBGA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 807F4240040;
	Thu,  2 Apr 2026 09:14:41 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6C45B240036;
	Thu,  2 Apr 2026 09:14:41 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 0E98423CE4;
	Thu,  2 Apr 2026 09:14:40 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 2 Apr 2026 09:14:40 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	yimingqian591@gmail.com, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [PATCH net v2] net/x25: Fix overflow when accumulating packets
Organization: TDT AG
In-Reply-To: <20260402024855.842920-1-kuba@kernel.org>
References: <20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de>
 <20260402024855.842920-1-kuba@kernel.org>
Message-ID: <8aa013a16fec55cdd7a2ba374bf37437@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1775114082-B3EDD76A-8F68A85E/0/0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-274402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2A33138514A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-02 04:48, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/x25: Fix overflow when accumulating packets
> 
> This commit adds a check to prevent x25_sock.fraglen from overflowing
> during packet accumulation. It also resets the fragment length when
> purging the fragment queue.
> 
>> diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
>> index b981a4828d08..cb84c683d249 100644
>> --- a/net/x25/x25_in.c
>> +++ b/net/x25/x25_in.c
>> @@ -34,6 +34,12 @@ static int x25_queue_rx_frame(struct sock *sk, 
>> struct sk_buff *skb, int more)
>>  	struct sk_buff *skbo, *skbn = skb;
>>  	struct x25_sock *x25 = x25_sk(sk);
>> 
>> +	/* make sure we don't overflow */
>> +	if (x25->fraglen + skb->len > USHRT_MAX) {
>> +		kfree_skb(skb);
>> +		return 1;
>> +	}
> 
> Does this cause the skb to be freed twice?
> 
> When x25_queue_rx_frame() frees the skb and returns 1, the caller
> x25_state3_machine() leaves its local queued variable as 0 and returns 
> 0.
> 
> This 0 value propagates up through x25_process_rx_frame() to callers
> like x25_backlog_rcv() or x25_lapb_receive_frame(). Since the return
> value indicates the packet was not consumed by the protocol stack, 
> these
> upper-level functions will call kfree_skb(skb) again on the already
> freed skb.
> 
> Would it be safer to return 1 without calling kfree_skb(skb) here so
> the callers can handle freeing the unconsumed packet?

This is already fixed / changed in the v4 patch set.

