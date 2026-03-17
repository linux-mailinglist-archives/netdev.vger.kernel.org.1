Return-Path: <netdev+bounces-268723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAFxHEaruWlDMAIAu9opvQ
	(envelope-from <netdev+bounces-268723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:28:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAC2B18B5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 730DB302B66B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2633EAE4;
	Tue, 17 Mar 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Z6/mVXEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63315E5DC;
	Tue, 17 Mar 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775680; cv=none; b=mGpM+kE5c+Intqjtt7tJtaPey2gGsoSrkGB+zOx2nP4aAujXiJ/7YtmUMtTjO+91zqBd5bumUp+gIZm+U/0ZZe9BEFlOiXAMe+550UMtBR6XF2hUnXIlmmWAlNmwz4EvMNPMbqW60V0w179KBxzeED9pQuD0ENVzmqX593o4LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775680; c=relaxed/simple;
	bh=L0MGtNF09Byv4FEfebDveuGBacJzpLUZ9kM+uH7TIdA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bJRdp0Tw6B7S3GQmi52mcJ6jFFbv7dJ/MJWURh/GpbTg8i1iIPDB8Xd5OeufNunVyf9mdSsoIdP92Wo+gGEot1vkTExfUeZEPbWyfpgwWU4XN2Mj3CoLlzCY8j3h9er3kjWOsdBVflOIFFNxaQebckiG28dLA8kYmHenlVWR7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Z6/mVXEd; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9654BA1416;
	Tue, 17 Mar 2026 20:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773775675; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MZOLJBj8vyc8zi9ElBTiIxhp4PszNvJM6mynTMhFdog=;
	b=Z6/mVXEdkXM8ztK88i92PcQHEBzML+VEyaVHNswDjgvmkDg0IfrgxWJHZSZ66EKUzfiLsl
	gOZNCiWrJ3/ztfVFlMgoeYB2Gm0ARs5yaF49wy3DlrQbnHZdyBzNmGnrAi7c1pwWrv7hI9
	KZYMjhRl1ub39iDS2jCryIkNEhGoLbl9r0ZLR1acdtxGwYCTzmCEd7g82a4i8xSxcAUXAz
	CBQbDsd87zFsZw6EXdPXWQqYB7mAlczq79usfDZ36RTy2sOvR+37jIcpKKIuvGhDUb5mii
	ojjX+poR5uY/tm43UquOBmxAaZIUpaBvrvAnCyfqyrZaGdsudXhR78ukDiHAyQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 20:27:54 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, mbloch@rooftopnetworks.de, edumazet@google.com,
 linux-kernel@vger.kernel.org, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, opendmb@gmail.com,
 bhargava.marreddy@broadcom.com, netdev@vger.kernel.org, ebiggers@kernel.org,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, florian.fainelli@broadcom.com,
 kuba@kernel.org, arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com
Subject: Re: [net-next,v2,3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <20260317161906.1758581-1-horms@kernel.org>
References: <20260315214914.1555777-4-nb@tipi-net.de>
 <20260317161906.1758581-1-horms@kernel.org>
Message-ID: <dd8cc7a1f13cf02b4d9ae54f7ed07d19@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,rooftopnetworks.de,google.com,vger.kernel.org,broadcom.com,gmail.com,kernel.org,lunn.ch,arndb.de,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:mid]
X-Rspamd-Queue-Id: 79EAC2B18B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.3.2026 17:19, Simon Horman wrote:
> [...]

>> 
>> +static struct sk_buff *bcmgenet_xdp_build_skb(struct bcmgenet_rx_ring 
>> *ring,
>> +					      struct xdp_buff *xdp,
>> +					      struct page *rx_page)
>> +{
>> +	unsigned int metasize;
>> +	struct sk_buff *skb;
>> +
>> +	skb = napi_build_skb(xdp->data_hard_start, PAGE_SIZE);
>> +	if (unlikely(!skb))
>> +		return NULL;
>> +
>> +	skb_mark_for_recycle(skb);
>> +
>> +	metasize = xdp->data - xdp->data_meta;
>> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>> +	__skb_put(skb, xdp->data_end - xdp->data);
>> +
>> +	if (metasize)
>> +		skb_metadata_set(skb, metasize);
>                           ^^^^
> 
> Can this corrupt memory? Looking at bcmgenet_desc_rx(), the xdp_buff is
> initialized with meta_valid=false:
> 
> 	xdp_prepare_buff(&xdp, page_address(rx_page),
> 			 GENET_RX_HEADROOM, pkt_len, false);
> 
> When meta_valid is false, xdp_prepare_buff() sets xdp->data_meta to
> xdp->data + 1 as a sentinel value to indicate no metadata is present.
> 
> In bcmgenet_xdp_build_skb(), the metasize calculation becomes:
> 
> 	metasize = xdp->data - xdp->data_meta
> 	         = xdp->data - (xdp->data + 1)
> 	         = (ptrdiff_t)-1
> 
> When assigned to 'unsigned int metasize', this wraps to UINT_MAX. The
> 'if (metasize)' check passes since UINT_MAX != 0, and
> skb_metadata_set(skb, metasize) truncates UINT_MAX to u8, setting
> skb_shinfo(skb)->meta_len = 255.
> 
> This incorrect meta_len of 255 can cause downstream SKB consumers (TC 
> BPF
> programs, skb_data_move) to read or write 255 bytes before
> skb_mac_header(skb) when accessing the metadata region.
> 
> Other XDP drivers that use skb_metadata_set() (bnxt, mvneta, ixgbe,
> i40e, virtio_net) all pass meta_valid=true to xdp_prepare_buff(), which
> sets data_meta=data, giving metasize=0 and correctly skipping
> skb_metadata_set().
> 
> Should xdp_prepare_buff() be called with meta_valid=true instead of
> false, since bcmgenet_xdp_build_skb() handles XDP metadata?

Will fix this in v3 by passing meta_valid=true, matching what other XDP
drivers do.

Thanks
Nicolai

> [...]

