Return-Path: <netdev+bounces-284140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MvTYGRhB+WlP7QIAu9opvQ
	(envelope-from <netdev+bounces-284140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF74C5971
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 03:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48A80300A31D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 01:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E74314B9A;
	Tue,  5 May 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXjdjIIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570A3033FB;
	Tue,  5 May 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942806; cv=none; b=lnyqb9Zng3g5oBI6lg11ZqfMyQ8HPqM8PuNFzJS999fIoWW91qzgvtJl2xQnC8FbCmGRKLriaqtZqt4hH2z9VQzk/Vp2FFMQzxkwHhM45UNuv48kt9i4+RksU5OHD4ulYbuhjtmfT6oKvicSfRjlM2a6M3/ljW4w+qGBPGSq9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942806; c=relaxed/simple;
	bh=g6tcTCmX72/mt6i3cGWc4ykAaU8y/PHQF8yCU1Xwytw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms9bPMdUaQH1XPGW+H1UH0SodXRgugrgXhjyZTv/eS76UlbE+cXqutuYpVVdb+cJEtRQ/Z251w1JkBwqeJyhgcNfH/utUpkCc9zixmh64WkUus00iqLMOrOD4m5iyeXCA3jh9oXuMzQYuH0JpvUc1HKjkFBwBbmsIFkzgT1PbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXjdjIIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C5DC2BCB8;
	Tue,  5 May 2026 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942805;
	bh=g6tcTCmX72/mt6i3cGWc4ykAaU8y/PHQF8yCU1Xwytw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BXjdjIIYhgHwE1BxltQQPlyBOw//sBtjYskv93QjKguAFSExJWH2k0/aJHyq3fUv0
	 1AC10Mp/I9u4wOev+5/zWKtFw6ZufSvKNDqjURRP4NMMn9etk9/wEdNTFkTdeoLAEf
	 JoYHtGGA8OY8XCTegy1w/mEnxtp8+tfwO0hH26V02vPuy6icDmRd1mOobbiUxBwf+t
	 k4vRGZusC80IqenIatgryFfiN/LL+SxjDXdUPnrfV3bUM6B/pvPrCoQung8G0UtMmA
	 AjNvKuFJGLtcx0gesYA/G1NeKhO5BONTK8uxyGNGbTIeAgkCyqFbwTp7cR2LgOt8pM
	 fWO2neD/AOoSw==
Date: Mon, 4 May 2026 18:00:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin Karsten <mkarsten@uwaterloo.ca>, Gal
 Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Joe Damato
 <joe@dama.to>, Frederik Deweerdt <fdeweerdt@fastly.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <20260504180004.7b9955eb@kernel.org>
In-Reply-To: <4onzzvtgdyj5k4himhtv4dsga4dnunk4ppjyqgam6us44biear@7vvozjz2ywrr>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
	<20260428175134.1197036-3-dtatulea@nvidia.com>
	<20260428173844.1354aabe@kernel.org>
	<36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
	<87o6j2hslk.fsf@all.your.base.are.belong.to.us>
	<bq662gcnuk3yltgzg4q5w672xsbsdf3abqrej2mrg6rl74ts2v@5uv5a35jrlp7>
	<4onzzvtgdyj5k4himhtv4dsga4dnunk4ppjyqgam6us44biear@7vvozjz2ywrr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2CF74C5971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, 4 May 2026 11:30:47 +0000 Dragos Tatulea wrote:
> > > That would also follow the scheme in napi_schedule_done(). (Note that
> > > swapping arm/clear does mean that we can get a wasted-timer outcome.)
> > >  
> > If it is wasted is fine. I figured that this could end up with a timer
> > scheduled after the napi deletion:
> > 
> > 1. busy_poll_stop(): clears SCHED bit.
> > 2. napi_disable() runs past SCHED wait, cancels timer and caller
> >    deletes napi mem.
> > 3. busy_poll_stop(): napi->timer is armed but napi is freed memory
> >    by now.
> > 
> > What am I missing here?
> >  
> Gentle ping. Once I understand how/why the above is incorrect I can
> update the patch and send it.

Eh, I didn't respond cause I got depressed. Look around for the pattern
you are calling incorrect in existing code and you'll figure out why...

