Return-Path: <netdev+bounces-260590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGx2LlDVnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:44:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A389189F55
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46278309E902
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AE3A9DAA;
	Tue, 24 Feb 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH7lkZ5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB13A963D
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951033; cv=none; b=a8659zM+FJZEtnrAWmEQbP9TZioX7as2Ax76ye8YQ7PKhoRM4GN5PimvT64cG3EbCqDFGraaKqLOMM0ImPUY8+8MVLZ69cwPTTd2YcEhxm/VYcj4L/Q4hc4TUV69xSMTfLcbDQK+ZF0Wp2oVcg6fOxV/YNKyYelCKBHyIuxAdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951033; c=relaxed/simple;
	bh=ojn0K5o62MY/bnJI5RmPX/5Bh3K2gTILuWl4M16jIxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5O80VcPffIu69jPoLqp5E6X7xpe0ll9mibPgtXkw6gaxQXShEVbDsTUfGVJW51Czr8iNZv1La7gVf4ili36Oy9wiwKZFYSZHCX7Hw5bVM5P8T8FlFktH6uNaLLxDup4ZrQcDvJS0vCgQ6BPOShGLUOoHahqNeMMQ4UwtvUq0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH7lkZ5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FDEC116D0;
	Tue, 24 Feb 2026 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951033;
	bh=ojn0K5o62MY/bnJI5RmPX/5Bh3K2gTILuWl4M16jIxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IH7lkZ5T/91jwfqG2w8Wu1UdgYJcPAo4Vr4e2qubdXgUnOV8ljmyu6yYzXt6VNmvS
	 LEf+z/UkmXKHn2M9ayTHigXCplrHF624ZoDBh7+Ay6fvpG5RXTVLpGZcSVvyiz2Ons
	 cK4lc9CXU0RUwzDPKdAH8q+WPvdqNqpR+LeamTZxSayTuqzMP5DnmX9Zl79ns/UK6J
	 WvTFH/F91b5JBtAp5rfci1Irgdr/660sFhYWuMtbx/XwcnTOaP1/tZ/TecqLibNCNn
	 JINeKworKvOVNuJtBOA4KKMm60Npq3ux4LdjQJ8JmIksoy/Dvjh4OKC1W20kRMEvcE
	 EcTaznNqIjeaQ==
Date: Tue, 24 Feb 2026 16:37:10 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec 0/4] xfrm: misc bugfixes
Message-ID: <aZ3TthfXLt5KncV_@horms.kernel.org>
References: <cover.1771876412.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771876412.git.sd@queasysnail.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260590-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A389189F55
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:05:10AM +0100, Sabrina Dubroca wrote:
> These patches fix a few small bugs in IPsec.
> 
> Sabrina Dubroca (4):
>   xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
>   xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
>   xfrm: call xdo_dev_state_delete during state update
>   esp: fix skb leak with espintcp and async crypto
> 
>  net/ipv4/esp4.c       | 9 ++++++---
>  net/ipv6/esp6.c       | 9 ++++++---
>  net/xfrm/xfrm_state.c | 1 +
>  net/xfrm/xfrm_user.c  | 7 +++++--
>  4 files changed, 18 insertions(+), 8 deletions(-)

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


