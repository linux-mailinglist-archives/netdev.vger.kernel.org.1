Return-Path: <netdev+bounces-256324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OwgGAILgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:49:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B567FDACAE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68028308DAB5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C19394481;
	Tue,  3 Feb 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhI9Q245";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="63+Wz9yq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E5393DD2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130148; cv=none; b=HZJd2xarEOuHtPuvCBYkIPAlIOmFHrNpl7oKEtA0oKMfE1yJQMiW6Y5A70cHFjkplaeW0OpjyNgYFxqqQr651F6P2pv/1WUtKdDy+fSmBODUS6JqSny9I0gGmIchEnqGElyIxlN13VxysGwJpNL+eZjCwnuTuYk09SHyUNO7F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130148; c=relaxed/simple;
	bh=ZP5/z287tsXmpn7kDb4nzRa5n56zkOAr+S55eYggzJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzdRxBdtCZPH+zmVESJvGoA5gVDUJyvaPUO6mUquxcPjs9ULWJfylu4UwILoO6qj6U+U5C/ygdM4VEg8U41OiCbxvVEiehKR+nDUrfLB18kmKd9WFmKIJEHQ/VUWJ9ctJmDE02PGW4oQD5kiXNGDKtuJUT3BEiWiOsF0JqL26ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhI9Q245; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=63+Wz9yq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 15:49:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770130145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HabIfHSGhqKfFMi4gVBPIyt5UQ6Yj9bfjp1I8GtxH9g=;
	b=MhI9Q245JThbRrlR3N6EbEfkHCfzHWVWXRJsos3caKQnLMYN+BLD5yLsKR49Vqssy0e4EM
	GBdU0GuxTzzrDhV9EbQmiWSdQpn6hz7QcECNAryCEZ6A/Hofm7Jk7cUcN9FhYs3BGIPula
	CVJZXqYlM3JOPgNkzNytaH47qvWKxOmm/wWzZdWoZf5d/3hnZblrxshOi0IF6DQwEAKWIb
	HPViAGZzXp9Ct5fhz2AZ73rqSBoPzX42DvQBltfzN4t36iR/q+lBJsCJfNtCwzO7MEXFE4
	1x4+emDf3MjjnjPg4A3dnGVN6EG0SpjNshoGUT3ZjIKBxRXVptBkSn99vutWXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770130145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HabIfHSGhqKfFMi4gVBPIyt5UQ6Yj9bfjp1I8GtxH9g=;
	b=63+Wz9yqppnxDEinNWFKps23A4xapJOQNWazatIAwh4aXe2Whne5+KxoKUslZ7izR9hZ/J
	X9uHL+JhYUoXJ7Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <20260203144903.ifAQ9Yh4@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
 <20260129133217.xNoDm9nn@linutronix.de>
 <aYCK5Dczg_0tbuEA@thinkpad>
 <20260202164550.1TDNCEe_@linutronix.de>
 <aYHlhKiSh8YrXjT1@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHlhKiSh8YrXjT1@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256324-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: B567FDACAE
X-Rspamd-Action: no action

On 2026-02-03 13:09:40 [+0100], Felix Maurer wrote:
> I agree, the reboot case is safe because of the 500ms quiet period. But
> I kinda fear a situation where a node sends a lot of packets (making
> it's sequence number wrap within the 400ms), but only a small fraction

wrap? A lot of packets means you force-recycle the oldest block. This
doesn't have an impact on timing.

> of that to us, so that we don't clear blocks because of a full buffer.

Why does this make a difference? Are you describing it from PRP
perspective? From HSR point of view, each node sees all frames. If you
have HW support for de-duplication then you don't see duplicates.

> That could make a block live pretty long, when we hit it multiple times,
> which could in turn lead to valid, new frames being dropped. I'd say

The block covers up to 128 frames and you have 64 blocks. This covers
8192 incremental seq-numbers and every block gets recycled 8 times until
the seq-number overflow.

I think you are afraid if a node sends 65536 packets in less than 400ms
and the receiving node observes only a fraction of it (less than 8192)
so it does not expire blocks by force. This may indeed lead to dropping
"new" packets.
But this should be only a PRP problem or also a HSR problem if the used
sequence number has "random" increments.

> it's a somewhat artificial scenario, but not impossible in reality
> (especially considering that I'd expect a good chunk of the traffic in
> HSR and PRP networks being periodic, which may lead to reliably hitting
> the same blocks over and over).
> 
> Thanks,
>    Felix

Sebastian

