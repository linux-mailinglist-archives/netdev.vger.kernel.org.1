Return-Path: <netdev+bounces-286194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED6BF/Zh/2n45wAAu9opvQ
	(envelope-from <netdev+bounces-286194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 18:33:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF575007E7
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 18:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69CD83012E9E
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379C2BDC0B;
	Sat,  9 May 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Kf+PtUmv"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924C01DC9B5;
	Sat,  9 May 2026 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778344326; cv=none; b=fwkfuy1S76cAaXFrKddPtysPXEAdrn7ogzsNlkBN2ngp52AuiYfLnrWmmwQgZ7wYcYTOKVsFgEjqkOleNEt83y3W2xpeVEaE4UmabO6A8AeK/g3kSvFg7+oimpGFLwmN5h4oe7BuJCktI7i4GdSUSo6R9uVyliF2Ln0qoC5Qv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778344326; c=relaxed/simple;
	bh=lJfTTLqRrHS11c6qVKBKuk20IZ8zLgvDKFkWOXnMZgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XgZr2GXkLRuns6oIsVkpgjBGzkeBbEokhbZ0YdoX1yfZGx/2kyvqSZyDuGDvWruH4H5GHJkUpfjgYMfFYpRtVEIzxi+8FDf9/0k+M020SD/15VCymKwR5iWf3vbb+hQyGlaraxiSA/hFrcOyWk6Z4ZBRNnp62CAAztyYLAq9LVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Kf+PtUmv; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778344311;
	bh=lJfTTLqRrHS11c6qVKBKuk20IZ8zLgvDKFkWOXnMZgY=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Kf+PtUmv+D3Izdr5IiKuHXql9AaU4iysVk9qisJP89eMy5/vZS6XxycB3foTj2ExZ
	 LwyT3/OdQISIE6UOvyPfqbh92DdQTK5MBIKz5obM2dD5ohvhlKDPHbr6OMABUQZuts
	 dTFJfG3aso8s4UWM2MVoJW5kHW/ggveEY+hazBnw=
Received: from [IPV6:2a01:599:c0b:1cde:a2d7:fa0f:588e:7b7b] (tmo-069-114.customers.d1-online.com [80.187.69.114])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 649GVlnI008310
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 9 May 2026 18:31:48 +0200 (CEST)
Message-ID: <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
Date: Sat, 9 May 2026 18:31:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BCF575007E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286194-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/8/26 17:10, Simon Schippers wrote:
> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
>  {
>  	void *ptr;
>  
> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
>  		tun_ptr_free(ptr);
>  
>  	skb_queue_purge(&tfile->sk.sk_write_queue);

Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
operates on a tfile that is being torn down. Its queue_index is no
longer valid. After the swap in __tun_detach(), it points to the
netdev subqueue of a different tfile.
--> We should not wake there.

I will swap tun_ring_consume() with ptr_ring_consume() again and
submit a v12 :)


