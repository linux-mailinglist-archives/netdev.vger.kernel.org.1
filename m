Return-Path: <netdev+bounces-277935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBTOMDgl3GkANQkAu9opvQ
	(envelope-from <netdev+bounces-277935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 01:05:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D853E65E6
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 01:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70CF3007357
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423F30100D;
	Sun, 12 Apr 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Su+whJvc"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9857082D
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776035112; cv=none; b=qbuklq9mp0aBpw+s4IH0KdmsR3IqfSV5I0naoDwippTjjmSXcQNnVUYL0fHbNPncFt4RF/JDACHnGy26wEJ+lbh47Iw/vLkP3uAtqLYaenXn/XDs3l3ayeP/XSJ2yjJarWagZYjEZzcF1IeNdZDM9Gf/teNtUn+UPHV9caZqNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776035112; c=relaxed/simple;
	bh=/wRYjeZfRPEsY+7mjJ80Nf4ra6EO4rRCZFOFM6L+hM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV5f+cYSxX00HlRmg2ZcmLe/qi1Eo+O30EkCmV7gTNCfdECprAiQzAOY3fr65zQF0X2rBBSbwfeGAC+wMggQqWcneLRWTRmGCDn347QTEUSsNamAYembwElra9WR6gfoK0JHekTtVN9Dyu9Lj51I3+gJYkqU3dWzNrdugeY9AGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Su+whJvc; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Apr 2026 01:04:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776035099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMZXVhxArrX2MIw67lXbdoUVcMjR3WhMg1BwJqh+Ul4=;
	b=Su+whJvcuoBO4DRTsIgcZVrxGj3/j6gLr4HqyRltFJkymmu1LHrwiVdJULuco3b9eXP7IP
	vfDSRyneo/nCdZtId8DpNLcNVR3w3+Rye+hS5OwQGaI196NCxilqehsTFXzr8yu+Ar5W5A
	CprRjXpVoleWFlC2GC6hgvSkGWsYETM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Tim Bird <tim.bird@sony.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <adwlFgKPdW4zDVb_@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
 <20260412141004.22c6686c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412141004.22c6686c@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 20D853E65E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 02:10:04PM -0700, Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 00:57:02 +0200 Thorsten Blum wrote:
> > In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
> > byte less. The NUL terminator is never used and only ->datalen bytes are
> > accessed.
> 
> I can't see where this is used at all.
> Please write better commit messages, there's no way this 1 byte
> is worth the amount of time I wasted trying to review this :/

The point of patch 1/2 is not the removed NUL terminator itself, but to
prepare for patch 2/2, which adds __counted_by() and requires ->datalen
to match the number of elements in ->data.

Currently, that is not the case because ->data includes an extra NUL
despite never being used as a C string. Removing the unused terminator
makes the length match the allocation size and allows adding the
__counted_by() annotation.

I can fold this into the __counted_by() patch if you prefer.

