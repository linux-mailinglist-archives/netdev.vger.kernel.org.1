Return-Path: <netdev+bounces-301984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yuB8HFk9PWrTzwgAu9opvQ
	(envelope-from <netdev+bounces-301984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:38:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA46C6BA7
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nxJwCI6t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301984-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D133097B04
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0E3DDDCC;
	Thu, 25 Jun 2026 14:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6218DB26;
	Thu, 25 Jun 2026 14:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398197; cv=none; b=HYdwEB7QfLqe/3DnbmAlvfi+wBPrnzCX2Z5MXEdgbAXWOoEvseHQy+OqzZqzGRz0oiPTviU91sI1rcUbhmkoKrYtYdvF4ioMKdLoQy7KzprNaVGJ3638pKRQXYADDYUeZR1YsDfwELOwgiNBsWQqvuWW4lXQtHFPNO5oYjFulB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398197; c=relaxed/simple;
	bh=MutUaWOcy8UStgksZpXCxUL5JTNVq1Aic408mCjLWjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAS2vIMTsfWVdnTXpnbY7kPBhgO303pGKVuvOOPaagp1UlNC46dFXSeUajflGcSAJyeMJqMgj5DdyF5S5AehAqxhA97/b9Es+Wdf+xWbR6LvH7ealv/CB7TsBNQFGVbqsal2C0rVUNLwHBhyjTeyzDsgVX/CnVoX0d3c7bG9qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxJwCI6t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F061F00A3A;
	Thu, 25 Jun 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398196;
	bh=LbSQkfUUlzm5zlB1XH+iM2dbK0d5bmjr1Jd4ex8GGE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nxJwCI6tILxtZLWztXsGB2hXuTRqgwqMtlBNb9SwQfiFgTf4BwK7tkt4/60WcFxhq
	 WgdakcxzOSbmO1pZlz48Hn8c6mLbmbf5jsn3qorIx7dUfoBQsYOSHkQ4t/WckAr//q
	 /MM19xu9Tso+qpPYVDEJwvqTn9R6EWh2B2SN0kZI6RBNmVjrHwFijNIQqjXB0bMesj
	 KC6QtGAldBYE8BAjVx8dDHvsGIOp9N24xCqqMFMMpJjrub7FYm/rASSmESrchXGikh
	 ch3yr3LpxCjtqWw6o6vmJtdz92hDFUBO2Ffk98AleKRl1EIkzsHeAzHVRCUfm+HUda
	 vS5o6WOB4poBg==
Date: Thu, 25 Jun 2026 07:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <tushar.vyavahare@intel.com>,
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test
Message-ID: <20260625073636.449a28c0@kernel.org>
In-Reply-To: <aj0EYNt7Sr1dD96N@boxer>
References: <20260623091008.1046547-1-maciej.fijalkowski@intel.com>
	<20260624193326.295e3711@kernel.org>
	<aj0EYNt7Sr1dD96N@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-301984-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,m:kerneljasonxing@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04AA46C6BA7

On Thu, 25 Jun 2026 12:35:12 +0200 Maciej Fijalkowski wrote:
> On Wed, Jun 24, 2026 at 07:33:26PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Jun 2026 11:10:08 +0200 Maciej Fijalkowski wrote:  
> > > Subject: [PATCH net-next] selftests/xsk: preserve UMEM view in bidi test  
> > 
> > Do you want it in net? Either way - we'll need a rebase  
> 
> I have not checked if this has been -net propagated already, but the rule
> of thumb on bpf side was that all selftests related effort goes to -next.
> Is it different on netdev side?

We prefer -next too, but during the merge window net-next is closed.

What we definitely don't want is a -next patch with a Fixes tag.
So either net or drop the tag, please.

