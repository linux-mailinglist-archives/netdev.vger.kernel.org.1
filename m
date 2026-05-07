Return-Path: <netdev+bounces-285228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGEELvpo/Gn0PgAAu9opvQ
	(envelope-from <netdev+bounces-285228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:27:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB344E6C52
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2F053008E11
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB73B4E97;
	Thu,  7 May 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNwokZ1h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527A6DCE1;
	Thu,  7 May 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149621; cv=none; b=PA6JXCoYSLiac67imz15508FCr3hq+kLQ13hrLn5b39LLqEPXrc/VBTC9tpIQDnOcMFjnYeC4Ih0/pdqf/qvZp0aT9UxjV08MYbdNdHZm+PwnutKjZ4yySXU0uZd235F9Wy5Yb7HTVwC/trcAbcKnBJU0ulzkqPahnAco5Nm+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149621; c=relaxed/simple;
	bh=Qu4E2DzDoxojdEWz4vf7u2rXOgAClLiFxZt/vQe15H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+tPiHzad9PYTDyxtI9WONNGBQuaTDvwc7weZsSj/U9vhPITwEUrp6db41fRQ1cortaW/o09+dtRolR2Ekj4iDv9Egy9XTaMAw+FQp0moVfnZdwL6N8bpPb54j5MBEemkSkB/XpFsGSDEqHY9x+qruOrGiDPB1p0LDCWlG4dDdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNwokZ1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41586C2BCB2;
	Thu,  7 May 2026 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778149621;
	bh=Qu4E2DzDoxojdEWz4vf7u2rXOgAClLiFxZt/vQe15H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNwokZ1hZ3nQ8BbxBdGldJkDmVX+VxYitriqMIroOU2KBfaNF0/eglHu0jrjpk3+m
	 kQHBsDok81b3LOjXeBevYgFYPxw/XdCSFykKiYtijgNIXE7ejF4pHVJAtSaaSRjIRw
	 wGoX+oK2HumyehY1p7mdyIeCSPqDtYpSCr7uHOiP65uA7JUkGPtE/EDgJ5Sf/x7MAL
	 3xqg9is50xc//FxKsyuRDVIobs/cUDYqEwWNR/ab/jPyqxD7sqb9pRwt05ePn9+WwA
	 Idnefkkn4a++OIg2/xY5iNywFbrlucn1ZF5gVtZ+a33VWx0MWVhTSZdQxQvaAdK8Ao
	 hfCCHOwQfGOTA==
Date: Thu, 7 May 2026 11:26:57 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 0/4] octeontx2: CN20K NPA Halo context support
Message-ID: <20260507102657.GI15617@horms.kernel.org>
References: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1777879921-15542-1-git-send-email-sbhatta@marvell.com>
X-Rspamd-Queue-Id: 2FB344E6C52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285228-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 01:01:57PM +0530, Subbaraya Sundeep wrote:
> This series adds NPA Halo support for CN20K in the octeontx2 AF and
> PF drivers. On CN20K, NPA supports a unified "Halo" context that combines
> aura and pool contexts in a single structure. This is a simplification
> in hardware so that there is no need to initialize both Aura and Pool
> contexts for queues. Separate Aura and Pool contexts are needed say if
> we have to point many Auras to a single pool but we always use 1:1 Aura
> and Pool map in Octeontx2 netdev driver. Hence for CN20K use Halo
> context for netdevs.
> 
> The series:
> 
>   1) Adds Halo context type, mbox handling, and halo_bmap tracking in AF.
>   2) Adds NPA DPC (diagnostic/performance counters) 32 counters with
>      per-LF permit registers, mbox alloc/free, and teardown handling.
>   3) Adds debugfs for Halo (halo_ctx file and NPA context display/write
>      for HALO ctype).
>   4) Switches the CN20K PF driver to use the unified Halo context and
>      allocates a DPC counter for the NPA LF.

Hi Subbaraya,

There are AI generated reviews of this patchset available at both
https://netdev-ai.bots.linux.dev/sashiko/ and https://sashiko.dev

I would appreciate it if you could look over them, as there
do seem to be issues relevant to the progress of this ptach-set.

