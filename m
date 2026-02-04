Return-Path: <netdev+bounces-256682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDEPMDwxg2kwjAMAu9opvQ
	(envelope-from <netdev+bounces-256682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:45:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A56FE544D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2200B3028ED4
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28093ECBC4;
	Wed,  4 Feb 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pF2UY7wQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="087y/cKt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3653ECBC5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205478; cv=none; b=DLKjMY05WPnBgmtyvPwCgPfsB6l4720j6594AqtKOoTWq6Uq2zqlGADH44Z72pCt9BueemjWFByfLBItB1Rs9hezyGpqpPufrm+1eJm8OQTvESvk6hLiTXulQ6d39ugdREOOQYS7zvmU4Rc9IofphSRF8o2d6MtiwlUagx3320Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205478; c=relaxed/simple;
	bh=9byFsLQgNFZiHVEwP8ypuafOFX6Ed1mgG0N/hqlf/sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGJOCKLbln2TNx566QW4jWbJp9tDKwRkvATizRhRdG2Oa+PE1dEXqnxYv39kRh6wFsmFN38OeES3mjbUbGVTZ/8Y92Cg8VhIA7zyB1k9SKCN0/cJAtto9B2F6McM17RyQvk59+5WAH+pjtna8nBV0ZVj1ggtxvwJqPy9CuBlUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pF2UY7wQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=087y/cKt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Feb 2026 12:44:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770205477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+WAkjlBkUkvBCb4k3/2MhLw3zAZGCKINg2jB2bEFNc=;
	b=pF2UY7wQ0QZk1t/4ZT+a2hn3bDrmthoZwiihU5LWu3AwATqRS3WnG5IZmZgKihmDkMdQ6i
	ia9w4538g18sLM5R/H3XMAO+7VMLXi7kNptCPKsTJVkkqU0/7vLarUKm3My3z3SLte7q8V
	jlrrL/8pDD0+Ouxwf0a20dOhQV7O94/+FgdmJPwgb8uQ4nT744H0BHnpoEnuOKtolHZS3P
	KHgsvw/cwP0BPKU2GKRfsGLAvBSc58ha7D6P2Ha8nhsbOb3t+jpkEXMF6O1AbDp0e3XhkA
	FsEJ7FJRUhchzrX5p3y4KXBeY3zYlGbXy5RNDhiFIGOgTH4ODpOD3NRYnoakVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770205477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+WAkjlBkUkvBCb4k3/2MhLw3zAZGCKINg2jB2bEFNc=;
	b=087y/cKtlwGK3r/GvTj+8gKoQaikELnVcYRnetpPWCPFRhda5doKsEKTHIcPMKym5Vz+dm
	FqxydocJI3DR2cBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@kernel.org, mingo@kernel.org,
	matttbe@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v3 6/8] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260204114435.X2D6RStR@linutronix.de>
References: <cover.1770041682.git.fmaurer@redhat.com>
 <e7b254bd364d7df42a455a496a2d99f9b2e106df.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7b254bd364d7df42a455a496a2d99f9b2e106df.1770041682.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fr:email]
X-Rspamd-Queue-Id: 1A56FE544D
X-Rspamd-Action: no action

On 2026-02-02 15:19:22 [+0100], Felix Maurer wrote:
> Update the KUnit test for the PRP duplicate discard so that the node
> allocation matches and expectations on the removed fields are removed.
> 
> Reported-by: Yoann Congal <yoann.congal@smile.fr>
> Closes: https://lore.kernel.org/netdev/7d221a07-8358-4c0b-a09c-3b029c052245@smile.fr/
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

