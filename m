Return-Path: <netdev+bounces-255938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNBDKITVgGmFBwMAu9opvQ
	(envelope-from <netdev+bounces-255938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E0CF256
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA39F300CC8A
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450B37F8C3;
	Mon,  2 Feb 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCXGxi7G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2SZFUFJJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593637FF5B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050757; cv=none; b=FwMd0xG9KpPSZbRvBHlW9tO4CVMmYV1KENSYmvmM/2Z8czFl3RTuEa4GJpkC4Jt8mufTFLjoaHUBlyzzg2G/PP/YwwEhaKFZJLUvfdh6vn3NS027pKrIRP8emkv4rMuwhoDSs5uv2FuuGW3wwj+Zp1o/z0WIxFfcWdwzjFpBRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050757; c=relaxed/simple;
	bh=2rCUUjPQ5Gw2eMK1VPZU67Sv7/uV2Mzy3MdK6iz0PNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hceC+Dd1hLKgGzAGBJlJNz2XGzi9VUVVucHBrbqJdlZ8Li9OWx82P5i9jhJ+18eRa1dQuC3yhkKVXOfXzah0Rb0zhiUUbe4Vq1RmfPMr17c1RqUjdkh2D6BiZU+OOw0shHkBPzsxCcT3A2ngb5Gu8vLgDcSlFrlUbvDGzrflmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCXGxi7G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2SZFUFJJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Feb 2026 17:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770050752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oWvAbJTREsFu30nv38G6OQAZAsf9k53l2zsbZmrJpLc=;
	b=gCXGxi7GfCMjLwyErUeogIPBT5+UtM6LWBwOhz9dAO6pvD9e9q6vbAAdWj8hq5bVZ8wsqd
	aCOnoWN966/tQ9iLiZhOXZhx2nNBUkK0aIqy1wl8DQDhAyQ8rolcE8ih7+3aks/bplonoP
	d8Zz6q/zqH0uef6p4cKWphkn6AFsxym6HvBYJnSZ0LcjbTszdJMU0YWeQb/4TUE4eL6Gyx
	zqZWNHpt+lPWCu5I3oX4d4kePJOI0uXpdBjkmO2rz535cPFYlRDSh7Y8v+Y3fRqxL+4zbe
	IJPgTKNuonvrrHT3IFWpBkZQTkTP9XFX0hRnCw3aLsDqj/9n3KyTzebdx9PROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770050752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oWvAbJTREsFu30nv38G6OQAZAsf9k53l2zsbZmrJpLc=;
	b=2SZFUFJJwsk2VFrHeY0jiVHJ48t1Ye9W5ZUoTya1l4rN8M6QVMTb+RpxUud2WYgxy+2JQi
	7ni5xYNb9vBejADA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <20260202164550.1TDNCEe_@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
 <20260129133217.xNoDm9nn@linutronix.de>
 <aYCK5Dczg_0tbuEA@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYCK5Dczg_0tbuEA@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 258E0CF256
X-Rspamd-Action: no action

On 2026-02-02 12:30:44 [+0100], Felix Maurer wrote:
> On Thu, Jan 29, 2026 at 02:32:17PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-22 15:57:00 [+0100], Felix Maurer wrote:
> > > Add tests where one link has different rates of packet loss or reorders
> > > packets. PRP should still be able to recover from these link faults and
> > > show no packet loss.  However, it is acceptable to receive some level of
> > > duplicate packets. This matches the current specification (IEC
> > > 62439-3:2021) of the duplicate discard algorithm that requires it to be
> > > "designed such that it never rejects a legitimate frame, while occasional
> > > acceptance of a duplicate can be tolerated." The rate of acceptable
> > > duplicates in this test is intentionally high (10%) to make the test
> > > stable, the values I observed in the worst test cases (20% loss) are around
> > > 5% duplicates.
> >
> > Do you know why we have the duplicates? It is because of the high
> > sending rate at which point the blocks are dropped and we can't
> > recognise the duplicate?
> 
> I could not give a definitive answer on this last week, I had to dig a
> bit and think through this. The reason for the duplicates is not a high
> sending rate leading to dropped blocks. Rather, it's the low sending
> rate leading to expiring blocks: in the test, the ping interval is set
> to 10ms. As the blocks expire based on the timestamp of the first
> received sequence number, the 400ms entry expiry gets hit every ca. 40
> frames, at which we basically clear all received sequence number in the
> block by creating a new block. This happens on both nodes (for ping
> requests and replies) ca. 10 times during the test, leading to about 20
> duplicate packets, which is the ca. 5% duplicates I observed in multiple
> runs of this test.
> 
> This means the duplicate rate is highly dependent on the traffic pattern
> and the test manages to hit exactly this situation. I'll add the
> explanation to the message in v3. If similar traffic patterns are hit in
> the real world too often, we could test different block sizes. I just
> did this and the results are as expected:
> - 64 bit blocks: the duplicate rate is about the same because the block
>   still expires once.
> - 32 bit blocks: the duplicate rate drops to around 4% because,
>   including the netem delay in the test, this is roughly the edge
>   between expiring a block and already hitting a new one. But if we keep
>   the bitmap as it is, we waste 50% of memory.
> - 16 bit blocks: duplicate rate is zero because we use new blocks way
>   before the expiry time. But this wastes about 75% memory for each
>   block and the overhead of the timestamp in each block gets quite
>   significant.
> 
> I'd suggest to keep the 128 bit blocks to have a chance to detect
> duplicates at higher data rates for some delay difference (up to about
> 5.5ms with 1Gbit/s). 64 bit blocks would halve the maximum delay
> difference, but probably still strike a good balance between memory
> overhead and duplicate rate. Do you prefer one over the other?

We had false positives with the old algorithm so having now some is not
the end of the world. 128bit blocks are fine I guess. The question is
how far do we want to tune it and everything comes with a price.

If I update bitmap every time there is a valid packet:

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 08f91f10a9347..bb9b13940c35b 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -572,6 +572,7 @@ static int hsr_check_duplicate(struct hsr_frame_info *frame,
 	if (test_and_set_bit(seq_bit, block->seq_nrs[port_type]))
 		goto out_seen;
 
+	block->time = jiffies;
 out_new:
 	spin_unlock_bh(&node->seq_out_lock);
 	return 0;

then I the test
| TEST: test_cut_link - HSRv1                                         [ OK ]
| INFO: Wait for node table entries to be merged.
| INFO: Running ping node1-NUb1aJ -> 100.64.0.2
| INFO: 400 packets transmitted, 400 received, +22 duplicates, 0% packet loss, time 6113ms

turns into

| TEST: test_cut_link - HSRv1                                         [ OK ]
| INFO: Wait for node table entries to be merged.
| INFO: Running ping node1-6i4xNe -> 100.64.0.2
| INFO: 400 packets transmitted, 400 received, 0% packet loss, time 6067ms

which could be considered as an improvement. On the other hand the live
time of the block gets pushed past the HSR_ENTRY_FORGET_TIME so
the first entry survives longer theoretically 127 * (400-1) = ~50 seconds.
In the reboot case the box should be quiet for 500ms at which point the
entry gets removed anyway so the longer "hold time" shouldn't matter.

It sounds like a good idea but I don't want to rush anything ;)

> Thanks,
>    Felix

Sebastian

