Return-Path: <netdev+bounces-285861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ENbKS30/WlxlAAAu9opvQ
	(envelope-from <netdev+bounces-285861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62F4F7C18
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85C230C8A33
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B593F0A86;
	Fri,  8 May 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQpSxrCR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ECF3F0757;
	Fri,  8 May 2026 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250404; cv=none; b=IRbgNusrMY3LxNe8e52P8ucHx3YW7KmZeghVvZJUOofZZv8nUYJfJ+xjPpMCCD3m/BUd8LyG4YQqnzTZkFywNOu9cH8eA+kzlqpp9ZoAFpe9piR+BayxNyhXSREGvPVHOYkBwyxPOEx5jpbbYFLc7caTWowYvqrmIssjAmEIWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250404; c=relaxed/simple;
	bh=ZiN/EMgSDxuZs/BBhHBaRIIV4dNVOUbLJZU0Kmmg47k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVBsxHaa2bGiQUAnV6v5WF83WDwcZwdZrkBZ8r0sm+SXNykYbaOeU+IwHL6zbSt//M20XnDFOznFBscj1L3pptyxzry7rIMzPv6v4mZlCUlAOodDIajkGXqPJoeBdj7eI413Cn5OiQMrcjY61fWcaa12cxZWyXeaBLeB6fHmsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQpSxrCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C65C2BCB0;
	Fri,  8 May 2026 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778250404;
	bh=ZiN/EMgSDxuZs/BBhHBaRIIV4dNVOUbLJZU0Kmmg47k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQpSxrCRYG35baUcJLL8n3SXZsTYcmz30I4/Mfc+xnMtmR9TIV40Hx3P5VvxdFvgX
	 ZeQwZ97nz+Yn6DIv31JZRFEQ3pQxajGDvQ9aHZemb2Ef4vLdp0kB22jq0+0uAA8dM/
	 ysGOttieaAiiwvLH0KRVNWcE5RCrhONbKQoRN9XHPHj0m7r08IMsxdLBncoCYh2qe4
	 hGAC/kOebTq3VQRyjo5bVynAjummKKFQF809hhwy+FBBvkY/w+esf/1zx5wml749q8
	 o+i0REg1U5fKNaKxp9LJ6Mn1JZ1NGq1D9wdFF4pBNWWtZX/eAe/Xn434Y2Nw04lwdU
	 vJhnOgW+bmCZA==
Date: Fri, 8 May 2026 15:26:39 +0100
From: Simon Horman <horms@kernel.org>
To: aleksander.lobakin@intel.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kohei@enjuk.jp, jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 4/5] ice: implement Rx
 queue management ops
Message-ID: <20260508142639.GO15617@horms.kernel.org>
References: <20260505152923.1040589-5-aleksander.lobakin@intel.com>
 <20260508140758.1200568-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508140758.1200568-3-horms@kernel.org>
X-Rspamd-Queue-Id: 0C62F4F7C18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285861-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,linux.dev:url,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:08:00PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Sorry, the line above should have referenced
https://netdev-ai.bots.linux.dev/sashiko/

There is also a review of this patch available on https://sashiko.dev
Which I plan to forward separately.

...

