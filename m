Return-Path: <netdev+bounces-285080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBeLAtDT+2lxFAAAu9opvQ
	(envelope-from <netdev+bounces-285080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:50:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD854E19CE
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 01:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95C64301828C
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023430C608;
	Wed,  6 May 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CquGxZwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18522F388
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111436; cv=none; b=JKn1oQ+WDSXOp3cKBARExcI0bLDfjUZcHFNBjARE1jNyd3o/AQ7hb85lD5YsKFI63NH3J1f6H9LaaKdvxbkZyN/YLTdAKOkaqyTk2YJY5QI2f891QpO1mpZGx0BnO+fYuisHZvUivpeEf/8qnCPeTPWnbYkPQb/TT63k3gsXPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111436; c=relaxed/simple;
	bh=ssnhLB84IN7OCc4RXBEREznEfHRaLz/WCqYk9Y9UF+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnK1SKtwyDYXfRz64kCmQShYlZvscRiSZSSQsqkOeVc1hGayF5JY+YWkm16wxCHGnH5IBHeHcp4+n5vKDQAuaISg1SBx2dE3o2IAjC/q30Edg1MRPZhjyrTFnKHLUM5w0WRwXKyEOS2JyHGz5xUuBYw7pJ5tYvxYLUQhqJLJSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CquGxZwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DF2C2BCB0;
	Wed,  6 May 2026 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778111436;
	bh=ssnhLB84IN7OCc4RXBEREznEfHRaLz/WCqYk9Y9UF+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CquGxZweRvYVlg6omYzutaaxH/slvzFvKkBoQSgck9VFw9WKrNkz2veLKiNNrQxme
	 WYrNat7JxNyeOuQ0+HHlmpRm+96kVr/IzyHt/n1lzEPKhR7s3Z69x/oeVC6BOeFO/P
	 vJvUBVOL6QOuXH1jD9n1iSOqBByF9xtsgBNg2mRIQsCRUsmGWv+pbL29cx4OA6nv7g
	 nZdSZr5XCov3N1PfxIJXtl6u4HsZV8zCvbQ/srcXX8zWyOqgPSUR8XGnjp5kd9ztuL
	 z8NuzhapnbI5R1G/R4nQCv5RcBbBY4rnQU0naaZzdorqY7m7vyUNT/BYTqabov5b8f
	 wGYL6XMRLQq0w==
Date: Wed, 6 May 2026 16:50:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull request (net): ipsec 2026-05-05
Message-ID: <20260506165035.61964333@kernel.org>
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8AD854E19CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285080-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 5 May 2026 15:22:56 +0200 Steffen Klassert wrote:
> 5. Harden __xfrm_state_delete() against repeated or inconsistent unhashing
>    of state list nodes by keying the removal on actual list membership and
>    using delete-and-init helpers. From Michal Kosiorek.

Sashiko seems to have extra comments for this but I suspect follow up
is the way to go there.

