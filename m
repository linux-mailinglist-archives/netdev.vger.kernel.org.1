Return-Path: <netdev+bounces-259073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBWuKxiLlGnTFQIAu9opvQ
	(envelope-from <netdev+bounces-259073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:36:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2CF14D9EF
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFAA3019827
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352833509F;
	Tue, 17 Feb 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9hYjGdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05Wgg74O"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4A36923F
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342614; cv=none; b=JNLEc5dyyzy3zzdHnCO0wwKf8YQ6sC2q5k1t6bMj4LYdxab3ow6Bmts98f1cOogmq1OyplGbxQ7gdSNloC2EHpFHQfrHx1AI+p3QrHfwrbu0jKlCHp7Bn/Rn9GvvqcyevPXy5Au1RmqlxI/Y6gxWlYLmSJkXi1IbgcwJerNOeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342614; c=relaxed/simple;
	bh=CUGPqxftphH1B2oNAPSzfpqmx09sO4Dkf5L6AOrA8gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te8my8pUxheh8YFMuUClI41LJk17vHlsw8cla1NeUXI0EK1Mk2MijJlCWf/zxh2BIX+aG4ATmWS5bPSVaZTN2mStcTuO3btR21jwkYiblONEP1VwhwRBRBX93MYvKUKqxKVQr+HcC2Rnl3tKeAsRlK4l4/zsaxZqxFtm32sLTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9hYjGdR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05Wgg74O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 16:36:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771342611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6rxBWCbGVE2uNOdzdIFGI2cWHxiqCTDkKQY/fKY0oQ=;
	b=j9hYjGdRMcwAfxgxNqZdH381dJjk5t3P1y+qmwxIaSE4hE7DhIsiVXQpbNgkAACdxhTon/
	njOp0OKy/XAoXkYZKcrZNNMVaSP8kGNnv6VUA9z7xhHRtKGs+VX72oB6Xw0Aeo5nrzWF5g
	vfvcLw1G78zyhvMorNxkdPGck1ZAJQZ2vLABPQVLnTHDjwgi1De98okC5aYgrO5/Il7XdV
	pVlQANhJorTYkxEA2pzDPj58xAc+mfkwq2p2kbQV32yuj2Z3t7fQq1ApnzBPvhd4ABoG+f
	nXzhDLfxR2i/zXGRPr34D71uU9ZcMyzuV5phva6cJM4WgbdISdxFDv/M8Ma/oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771342611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6rxBWCbGVE2uNOdzdIFGI2cWHxiqCTDkKQY/fKY0oQ=;
	b=05Wgg74OkmPnpduDxUdMqZTFzyZq4I6ebYSUW/YWCgJ/0OUbeV1kn7wBdTs3Oo2Sii651L
	nHhyTBk7VPItLfDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260217153650.MQtAZ8Jz@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259073-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F2CF14D9EF
X-Rspamd-Action: no action

On 2026-02-04 12:30:47 [-0500], Willem de Bruijn wrote:
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -605,6 +605,7 @@ struct skb_shared_info {
> >  	};
> >  	unsigned int	gso_type;
> >  	u32		tskey;
> > +	u32		hsr_ptp;
> 
> skb_shared_info cannot easily be expanded.
> 
> This is too specific a use-case to warrant fields in every packet.
> 
> I'm not super familiar with High-availability Seamless Redundancy
> (HSR). Perhaps you can use either an skb_extension. Or the skb->cb[]
> field if this data is only needed within the HSR protocol logic, so
> can be assured to not be overwritten by other users of the control
> block.

Okay, will look into this.

Sebastian

