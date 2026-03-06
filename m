Return-Path: <netdev+bounces-264620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C/LIAc4qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:12:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E063521A810
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 220333030EA0
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367130FF1D;
	Fri,  6 Mar 2026 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fun91ThJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE82405E7;
	Fri,  6 Mar 2026 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763043; cv=none; b=HfCyPmdHifyH+NRPT+8FsjtmFTXpEHTQKu3C5dDCp5SfOwpM66QGovTeQPCqYQ0VMIwAxyt1MbRvwvpBaTTgLX+eHTbFE8wmBEinhR0LYmzLtGNPCXp5HVU1BKWRREzl44Ck2ptcrl6Ad/jczbQZI1QOHxw9mWjNUnJZn+YH8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763043; c=relaxed/simple;
	bh=1MFxJ2K+IYapKg6PdLiC2E9Y7SwI7dgMomEDxvSSZKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1RcwHV1UbaG0KvD19HLpQ3NWo/LTZQ3JZI4Vquou0+RQmXbsCzmh5PuA5Cp4h/0uBSCuN5z5Xxeb+GUi2x38vgPvZSAarTQqGq1FSoGqwpchdslgmcQM7qmxrcPLevh6Nfbe9hMAR9NNJ493IU0u3Iw0l/CzCPPn34Az9q6z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fun91ThJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424DAC116C6;
	Fri,  6 Mar 2026 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772763043;
	bh=1MFxJ2K+IYapKg6PdLiC2E9Y7SwI7dgMomEDxvSSZKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fun91ThJa5dbmMbXlfHc7C5NSxrfM5b2uiGA734gU0qPjFj2FYXJHsKnAMvL1zdG6
	 8VItc0TES/KiElaFkT3Fz9Rey4SCeiq/42LYkPFFHVhThjmSEFUgPTZlb3i05ekwKr
	 agB9WqCod/WVsh7nBF3aaW2h8dNkdy0ab4cKl9r5b36aT+ppInM0nwqUuwN8qDVBTK
	 TCT9nGE5uBEmc69bpxcr1aWm0bXoqC2hSx9iQRRTdZlwgemTokQN0LdGWXgYMxqzQA
	 Qjk7gjnOwIBRPmq3DJNoSZIoWG83pl3T2Lppnxset78W0pEyjtUERpciNIwdOgt1Dd
	 RoZgWQFLLjLKA==
Date: Thu, 5 Mar 2026 18:10:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 02/16] net: Implement
 netdev_nl_queue_create_doit
Message-ID: <20260305181041.7ed26e4e@kernel.org>
In-Reply-To: <5065f783-9378-4965-8266-e494cdee46d2@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-3-daniel@iogearbox.net>
	<20260131154523.5e495380@kernel.org>
	<5065f783-9378-4965-8266-e494cdee46d2@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E063521A810
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264620-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 05:38:06 +0100 Daniel Borkmann wrote:
> >> +	rxq_lease = __netif_get_rx_queue(dev_lease, queue_id_lease);
> >> +	rxq = __netif_get_rx_queue(dev, dev->real_num_rx_queues - 1);
> >> +
> >> +	if (rxq->lease && rxq->lease->dev != dev_lease) {  
> > 
> > IIUC the simplification of having all leases from one devices is still
> > a netkit thing? I mean - there's nothing in the core that depends on
> > this, just the cleanup / notifier handling in netkit? If that's the
> > case let's move this check into netkit.
> > 
> > Sorry if you moved this here because I asked to move as much as
> > possible into the core.  
> Imho it was a good suggestion to move it here and I would prefer to leave
> this in the core, and only really move it into a per-driver constraint
> once we see a driver wanting to support such setting. Otherwise we would
> propagate AF_XDP support on the device where some queues have support but
> others don't.

Alright, let's add a comment explaining the status and plan then?

