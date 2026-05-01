Return-Path: <netdev+bounces-283242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCGTDKHb9GmfFQIAu9opvQ
	(envelope-from <netdev+bounces-283242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:58:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB334AE3CD
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EACC30048CD
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0A413244;
	Fri,  1 May 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL6gWa8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED13F9F5F
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654679; cv=none; b=OLC99XqWYX5aPn740IwKj2avKdAo4rr0x0tbEgEHnd+7iP2dQt1rXdOk/VKbH4Gu4GyHGGv1dC1BXNyRDY2qCByP+cseXe4i6Lg1F+rJzg9vJ3dK9JL4m21qgPR1Yaz7Pgu6vLRfErKiakllrhkfkri2sJTiqcWRYmerCsEcwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654679; c=relaxed/simple;
	bh=2Vpbu7v3Whe9J7UOJHXV3VefJcMd3caY/exLVyZ2xsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2X6XJq6dfGiNc+OBHxSnKK+hBZdjcAFA+uwICuWgiutKUrbzra3IUxbShO1H3+3Nar8jjUiT4ydtzu7z7GXyJHoO4f66RRPApMRD922t/v2vzsgHcev4dRMwmSsrQlhtZ7ekEOnzGJgGugpuWqEoiJR7qcewwPKDyMGNs+qi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL6gWa8g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad21f437eeso13758405ad.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654676; x=1778259476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83opU+NQIEZVqyfuSAebQ2q200xoGLe1uIeO8FeKtHM=;
        b=EL6gWa8gOUiU90X/k/pHZNAlyBRzre+kXJBdEE5Oj9G2RiSyZqYCmAWqbkdYRd86AF
         ZbYh23Iz3hfdP7zRH4qOG/C3eAq7m6SAHeIRtC2gIfTjqsHPx118C1sZ0xCMnHG4fBf1
         RgMalZk9UJLNjgJh84WICFFG8hFdPduyc1RmT45HI4AJUveyIFbKC0gE1yqEZI1u8Q9i
         W5OJ/EH7pKpkycM/5R9nE20F+Kvmoe5is1TEqPfnQQmuK8O/dZDoVhjLa66yX5cGcaux
         BtWqI+8psAqZjfpYHcwzLk43hFW7Fv28bfmTEobZpQRpiM6XaC9vwOutN7EP+0WFHNg2
         Gz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654676; x=1778259476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83opU+NQIEZVqyfuSAebQ2q200xoGLe1uIeO8FeKtHM=;
        b=eFH+mOW8v95oyrxlp8ZY8YRVrFknbD1lOUDUVceroQcLYVzhJl7oRXKc6HbBZF5cJy
         SuI1UWA2VgnDInPzi1vauDmEQhIOeMd5NEYswVdt2U9o5erKvFz9V9scrIs+i3rEE6NL
         uMbqSCS64r4/qdyga/9MOh5BqJ+G2NVC380vPm1PTLUXKPEFTgjF8QvwVmnpeZLR/QBE
         ofVFPCv6FKNwKn1t/0XozonGjStXNujthIbtE3wciqXtwBgPnLKulM4AoYLuTe8PHkkW
         /KxZFkopxLc41kuiOWOiZpIu6S+YlZntGGQ1fjR1UKRnQbSP3OKlbcwduqxoRNR8jekk
         l7Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8ewBrWwbPUnFiUjhF7Zq5ETf3IBINq/q/lMnyBK/NpyG0Ne2JtyBh1zOGpLm25/FaDrJ2Yl2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZuws0ysACuNwjQfnxlc12RRsPinTMSfwbVHJ15G26gZ8vHrF
	9CHa7xYCXg6rrdUIfZmQ+HmiYjipTC7v8P6/mqUKQPSmP01dVvFxLa1d
X-Gm-Gg: AeBDievY1RNA28E92QQ3Wd0hL3fCoHQ8XGH9fM0GXuHl2X5IweCPWk+hKx9dB52GItR
	e0ymIt+M493peD5Hej1DnEo2Np2QIvCXR+uIJytjIQg6SZ1pLKJWtCVSuvIa9M4ZUKuJrGlLwKu
	0pDYdjN8VG1B59O8D8gym2COlwBDDPgt2eunzJplsYyhDffHtoKgL+98acYLbT2PL/rv+jPiOoh
	YGsyTkWFOVDVutHhLTdYU2cxB3zHQKr2AYOXP0SCbOyyUX6C38GA9SGZaC/dxt2ABIkEo2/o6nG
	eflydGr66fvf6M8orO+UowRMIXkrXxxa0gH9rFIBxhWCB6BPalLZxRxacZvBREG9TPz8ifal1pS
	iXB88hfRaHMtzdPCCZ4seIUJoezY+OcDeTXMiwuXBvnA5Z1kWhKXIq9n2YopCxBZl8FPIOan2Ww
	auAxuv+KOQRYbaK0YDLdaIZu5DkRZqrMyicANQEDi64psZ+d1P7PA1uw==
X-Received: by 2002:a17:902:fc84:b0:2b4:5e85:efc with SMTP id d9443c01a7336-2b9f1de926dmr2284075ad.18.1777654675560;
        Fri, 01 May 2026 09:57:55 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa91671sm27987615ad.13.2026.05.01.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:57:55 -0700 (PDT)
Date: Sat, 2 May 2026 01:57:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
Message-ID: <afTbj8GszS-uZNS-@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
 <20260501155806.222592-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155806.222592-3-horms@kernel.org>
X-Rspamd-Queue-Id: AAB334AE3CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283242-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 04:58:08PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
> 
> This commit updates the DATA and RESPONSE packet handlers in rxrpc to copy
> the skb into a linear one if there are paged fragments present. This ensures
> the security handler operates on a fully linear skb during decryption.
> 
> > diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> > index fdd683261226..6c924ef55208 100644
> > --- a/net/rxrpc/call_event.c
> > +++ b/net/rxrpc/call_event.c
> > @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
> >  
> >  			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> >  			    sp->hdr.securityIndex != 0 &&
> > -			    skb_cloned(skb)) {
> > +			    (skb_cloned(skb) || skb->data_len)) {
> >  				/* Unshare the packet so that it can be
> >  				 * modified by in-place decryption.
> >  				 */
> 
> Since modern NIC drivers commonly use page pools where packet payloads are
> placed in page fragments, skb->data_len will be greater than zero for almost
> all standard incoming packets.
> 
> By taking this path, the code calls skb_copy() right after this check.
> Will this force a full packet copy for nearly all incoming RxRPC DATA
> packets, bypassing zero-copy receive paths and causing a large performance
> regression?
> 
> Additionally, skb_copy() fully linearizes the packet by allocating a single
> contiguous buffer for the entire packet size. For RxRPC Jumbo packets or UDP
> GRO-aggregated packets (which can reach up to ~64KB), this requires an
> order-4 page allocation.
> 
> Could relying on an order-4 GFP_ATOMIC allocation cause reliable OOM
> failures and packet drops on fragmented systems?
> 
> If the goal is to ensure the skb is writable for in-place decryption, would
> it be safer to use skb_cow_data() instead of forcing a full contiguous
> linearization?
> 
> Simon says:
> 
> I note that this patch included
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> And that the suggestion in the last paragraph above would
> reintroduce back to the problem addressed by d0d5c0cd1e71.

Yes. applying the ai's suggestion would reintroduce the bug fixed
by d0d5c0cd1e71.

The performance concern regarding skb_copy() is, however, valid.
That said, I cannot think of a way to keep the zero-copy path while
still handling in-place decryption properly. Suggestions welcome.


Best regards,
Hyunwoo Kim

