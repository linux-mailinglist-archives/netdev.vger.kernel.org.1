Return-Path: <netdev+bounces-273272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFu1GpeqymkG/AUAu9opvQ
	(envelope-from <netdev+bounces-273272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0A35F155
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 387953004400
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC163BD64B;
	Mon, 30 Mar 2026 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kZRQALIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB6227CCE0
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889616; cv=none; b=paTYrvGp3Bbx78+dcRjEQlHSZZlMv6+FnBNSstPdI7NMWUbEaosdU78e7pHANAzfElam/Oc49fGDmMwMac7SLyQuy/pktOZlZLjpScByQV0TYllFTlXAbI63kpURIPkfHx858f1pWTuDjYj0HTGUE8L9gaZMxC09f0VKYAwvbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889616; c=relaxed/simple;
	bh=ZbLN6tiDZAtL9QunsGUH8Hnlgt4gphbqagiH7nSCUCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDn29IDgSkmc9N5UJgrIJsIMUdqmcVh5UBIcs8AyYJa1uTI47Z6yKKFb23UK7NbwEL9TnzRtxxO3h+A9HWiy0JWiGHIw9vTlX9tdo+aFUVXSazhoT8XHN/D34tHoAHNcwz9/7/0HWthytFdbSXwS+685sA3HVz0FoVT+wuDH/rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kZRQALIc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab232cc803so22392035ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774889615; x=1775494415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsPHeBxmNzNHe7NLwlikS/LmdLqYQXVEehPrQIj9X+8=;
        b=kZRQALIcD1rzNdukz6+QyLBzGWid/mfo57RwriiYKfJxbv6dSUrT2XmxfF4CdhmS6y
         ZJ4qMu/Bo638avMzKi1vDkPi5B+QDgdm9vuzDEisLSjnX3z0/NPS7s8yBr9ptqmhYgOp
         jBv9ghbsZtquEAum9q3tWYmzjY6K4KZ9dl3eSg2YmHjCY3ZyMa+BJJaMjG26L+n7DD1y
         NAplg5DPFAT2WU4a6x62J+Ynsq36J6gFVRL+KL1ozhfcQV0Xbt/so6d3pcl5xPxtcuY3
         g1nMFTwxU8KzXZptzdFekGD6BsIRrWu7MU2GMGou4DejVZkpVoYgpN0dQWSSsgLgdp4/
         o0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889615; x=1775494415;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsPHeBxmNzNHe7NLwlikS/LmdLqYQXVEehPrQIj9X+8=;
        b=oB8w9qaydU9BKkHfdycBXYfEZ2/PMi1vW0DdqnCWhKTTwvAR1jtcLO1tZiW3vPiLLi
         oBaALPqaJ2ByTh78J/sOe3r/1Dg1tZ+NxmX8utL2IoFvp9/y7GgnAqKWI1a26bJHpBOs
         DzhFtC5B0wt7Tu6dY4qvx+yDRRlaFVBz655H21+HseU6pCWfjRn/sJ9srY7YyztOxg/p
         btWKlnXoZfay3bnYpV7E3GmD2v4hvWWN6h8nosBMbi5E/zHKj4W6uL10x76aK/4jp6Sp
         vOuGzjvXtjQmxRKm4Lab9l5b6RxskDmeIOlzygBMuhJVFAzW8+5C9dBuamSI3IO8vIuW
         Jj/g==
X-Gm-Message-State: AOJu0Ywqhfm+Fa50CpXoBJwqbHc925FYFXNe2qp9UTKhk51GbOQQXArw
	EmDPcoPvLQieRzLFuigrYer7sO8WrAma5FAO5UWVpqZKg+SGIlqXqLmQHl4wqCLBPys=
X-Gm-Gg: ATEYQzxlUK4rDSeJQykDhV2eHsCCC3NkEbUhf9iEpyxB0V13gfKMP+pG9n+XAM6IlZC
	Q2axm4r+BHT4TG/dKjud7jIQlahmrn41B/CtmHY1S8PEEh0GPHKp8YiVvLyG6eUFB/3K1yIGzZH
	+1lpaL53jENj3kUgUQCMwk8NWm1Cdm8hqqdez43ggMP+q159TZoU+CK45HZOS0z/a28zFdxUD44
	mzf8gacxegHu99RhlVoaaaRuSrKyOuB1VrCcVBSJVSP9hBEB9jCTTX70ngA26hbhI/hn6TVwbww
	bt4DIWXwp1a1XwrLip75Uesn8nkYrUxNygfRHND/g/Wz2IMzTI1domcTsJWYkXOhky7RRPXROXl
	FQZTq3ccWsHQ+i4dcnLeDsnHu5eD2f75tiUBn7DUEo6HxANliEt4Ro4DB4fbYPOOHgLnaYqlmPI
	ESxn9R
X-Received: by 2002:a17:903:46c4:b0:2b2:5840:808e with SMTP id d9443c01a7336-2b25840867dmr27494265ad.10.1774889614687;
        Mon, 30 Mar 2026 09:53:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b25ca51aefsm10131965ad.16.2026.03.30.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:53:34 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:53:33 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v6 08/12] net: bnxt: Implement software USO
Message-ID: <acqqjfzDK04j2APz@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-9-joe@dama.to>
 <20260329152016.27646fab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329152016.27646fab@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-273272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DF0A35F155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:20:16PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:27 -0700 Joe Damato wrote:
> > +	/* Upper bound on the number of descriptors needed.
> > +	 *
> > +	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
> > +	 * at most num_segs + nr_frags (each frag boundary crossing adds at
> > +	 * most 1 extra BD).
> > +	 */
> > +	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
> > +
> > +	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
> > +		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> > +				   bp->tx_wake_thresh);
> > +		return NETDEV_TX_BUSY;
> > +	}
> > +
> > +	slots = BNXT_SW_USO_MAX_SEGS - (txr->tx_inline_prod - txr->tx_inline_cons);
> > +
> > +	if (unlikely(slots < num_segs)) {
> > +		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> 
> This looks sus, try_stop() will evaluate the bnxt_tx_avail(bp, txr)
> and leave the ring running.

Yea, I think the slot check can actually be removed entirely. Each segment
consumes 1 inline slot and at least 3 BDs. BNXT_SW_USO_MAX_SEGS is 64 and the
ring's minimum size is 2 * BNXT_SW_USO_MAX_DESCS (420).

Using 64 slots would consume at least 192 BDs, so the check above would fire
first.

I think as long as the ring size is constrained by the code in fix_features
and set_ringparam then this if block can be removed.

> > +				   bp->tx_wake_thresh);
> 
> Is tx_wake_thresh larger than the max USO even for smallest ring size?

Yes, it is.

Maybe its worth adding a comment in the code somewhere to make
this more clear? Not sure where would be an appropriate place, but maybe
bnxt_init_tx_rings?

