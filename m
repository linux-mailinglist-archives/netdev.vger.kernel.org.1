Return-Path: <netdev+bounces-281304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJGICcw172kw+AAAu9opvQ
	(envelope-from <netdev+bounces-281304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:09:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E54709E3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32799307F9C9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1863B47F9;
	Mon, 27 Apr 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="o34wvNlV"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CAB358378;
	Mon, 27 Apr 2026 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284091; cv=none; b=TW1m+sr+vqtaP+cDY2gXTbtxGvbclVVQe7sGisvKW+EDoV83rRUXnJHTfo7yRMXuGhPs7Wb0inRQJnELixPqyELvax05dLGkU8iSOdZWWwYab+UrBhOHfrxGdSMrC82A6WvyK4fQSb/wmk5zcS6sG0pevPUw4yPeo+YmYO3sz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284091; c=relaxed/simple;
	bh=atbEGFmeDSSdktHKnGJMRG/KmbT+1bnX/jq+DUetKC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK3Cepqzkfidg6qQoq1iEIJchl882hND5qrhyeYDu7gI21bQNJ5xE3hctSbQYlikktLYdnMM+Eqr66/+aXCLFWOqbT366MRUrQH35BNR5eYsiaztXPfPDXkXbRqCOVK5cxMWtBopUGAqmfRDWBzKaH6dJYlOiUQNiA9/yf2HfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o34wvNlV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RBUKs+AUojAOYNRxGOXMvbj4xCArWDXdG0JasNB01rE=; b=o34wvNlVkC9lGQz8ZIYV7wCJPC
	UjI3IuIHZD5XLdNZG63zX7PlfSrcCpAXFG8iXElTN/odIybNH7A9Bd6VXRW9B7ZPLLH2AbxVUg/C5
	k/Pah3s/6NhxiWn0cCH10+yy9Nu/BWQwI2bh0U1ZEpRb7B8CW9/BjXo6uvxDvsiDSZvCyAYkWAku9
	Kgj8nq4lhqWC9NphB1LFB1qdQElvEcR4nRK+otAlseAky/inICLGNpP/VPgicjgvuFplX1qz3yrf9
	Ppbezdl3Q8SR+Uu4ZNSS5OsD9fSd88qNdqteHLjjuEtJtJsymXLZpPYvYqOZpWQ8Aysew9y35Wrzj
	pZ8sY1lw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHIlv-005Osq-0l;
	Mon, 27 Apr 2026 10:00:59 +0000
Date: Mon, 27 Apr 2026 03:00:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
	gustavold@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net 1/3] netconsole: return count instead of strnlen(buf,
 count) from store callbacks
Message-ID: <ae8zD24sBNtZnYtJ@gmail.com>
References: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
 <20260423-netconsole_ai_fixes-v1-1-92b8b7de9a2c@debian.org>
 <20260426084640.GN900403@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426084640.GN900403@horms.kernel.org>
X-Debian-User: leitao
X-Rspamd-Queue-Id: B71E54709E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281304-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Simon,

On Sun, Apr 26, 2026 at 09:46:40AM +0100, Simon Horman wrote:
> On Thu, Apr 23, 2026 at 02:41:15AM -0700, Breno Leitao wrote:
> > Several configfs store callbacks in netconsole end with:
> >
> > 	ret = strnlen(buf, count);
> >
> > This under-reports the number of bytes consumed when the input
> > contains an embedded NUL within count, telling the VFS that fewer
> > bytes were written than userspace actually handed in. A conformant
> > partial-write loop would then retry the trailing bytes against a
> > callback that has already accepted them.
> >
> > Every other configfs driver in the tree returns count directly from
> > its store callbacks once parsing has succeeded, including
> > drivers/nvme/target/configfs.c, drivers/gpio/gpio-sim.c,
> > drivers/most/configfs.c, drivers/block/null_blk/main.c,
> > drivers/pci/endpoint/pci-ep-cfs.c, and the rest of the configfs
> > users. netconsole was the outlier (along with
> > drivers/infiniband/core/cma_configfs.c, which has the same latent
> > issue).
> >
> > Align netconsole with the rest of the configfs ecosystem: return
> > count once the parser/validator has accepted the input. The numeric
> > and boolean parsers (kstrtobool, kstrtou16, mac_pton,
> > netpoll_parse_ip_addr) have already validated the meaningful prefix;
> > any trailing bytes are padding and should simply be reported as
> > consumed.
> >
> > Fixes: 0bcc1816188e ("[NET] netconsole: Support dynamic reconfiguration using configfs")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> FTR: Sashiko has provided an AI generated review of this patch.
> Like it's review of patch 3/3 - which I forwarded separately -
> it flags that trim_newline() may perform an OOB access
> if passed an empty string. But this is not correct because
> trim_newline() correctly handles this case.

You're absolutely right. This has been addressed in the patch that recently
landed in Linus' tree.

It appears Sashiko ran its analysis on a tree predating that fix.

https://github.com/torvalds/linux/commit/7079c8c13f2d33992bc846240517d88f4ab07781

Thanks for the review,
--breno

