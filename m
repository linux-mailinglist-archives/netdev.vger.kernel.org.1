Return-Path: <netdev+bounces-283174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OFjODWe9GmfCwIAu9opvQ
	(envelope-from <netdev+bounces-283174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:36:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA04AC701
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E986300608A
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F13A4F59;
	Fri,  1 May 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P24Mo1II"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883883A4F26
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638959; cv=none; b=W6ShaZSZOXsGcIEzMX1XS60TXqQ6raaAHTWytqKX/L2Zwqh0GLxCJn3cFP9AI2reTvxkUY7JJxNK1nrNuQY/TBph0ILpO0byOZgP0OkHX9dzh6qYeFjQGVr8XWvA0PwijK4rc9lgQJhcoVq2AdhNA6igFouRYSAAzPcQ9zEsXco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638959; c=relaxed/simple;
	bh=zs6x/LEwnR68uhk/ijWwQApW1jJL4t87b71Ve+6e4Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpjKQ6fI7NjyJoHZvpry6PxHEllYghbAfqOaNz9o5ta4Xz7m4n1ww8Cws+Q9KsBfzy6hF/ITooobXkZZ+Mlo1uxy+/2P3LtSl3RUExQh0TLR/+6P2pXIi1dXTfk5qpwCN+QmcHTR8WL0GNVNEAAiLKbEOiRG8HeEeJGe7Zj6ZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P24Mo1II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CD0C2BCB4;
	Fri,  1 May 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777638959;
	bh=zs6x/LEwnR68uhk/ijWwQApW1jJL4t87b71Ve+6e4Zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P24Mo1IIqSwDbUdn19Cf3/oy2Ut72ojBWwp/ETMZXT91XiN4IRr1onQu6mCobGA0K
	 BszQ1jEhWnGELgzCquvA+Iqg42LzKc4+zgSMY8dzFSPQ8OF7Uh+Q2iNVVQjSzZq4id
	 dwvxelJYGFxlbPce3b3+628jh6eAetX0gOva1fitNc2iuFGmBO0/EGRFEEfGoNrVQr
	 nSvF/rv/vfCH8mrM7wG4PcV76z8HeTkEuwv4U0gRkC6u3YnD2mCPxPO3hOvuOb82h8
	 AbTAoSMOyKEkgvHq1UhelRZmWeosM1EjYDxyAzWGSXN72XJa2uV3O1AS2KxFvVS9rw
	 bRAuL2nDh5jIQ==
Date: Fri, 1 May 2026 13:35:55 +0100
From: Simon Horman <horms@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com
Subject: Re: [PATCH 2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
Message-ID: <20260501123555.GC15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
 <20260429114208.941011-2-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429114208.941011-2-holger.brunck@hitachienergy.com>
X-Rspamd-Queue-Id: DDFA04AC701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283174-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hitachienergy.com:email,sashiko.dev:url]

On Wed, Apr 29, 2026 at 01:42:08PM +0200, Holger Brunck wrote:
> If the driver is used in a non tdm mode priv->utdm is a NULL pointer.
> Therefore we need to check this pointer first before checking si_regs.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

Hi Holger,

I have the same feedback as for patch 1/2:

As a fix for code present in net, this warrants a fixes tag
that cites the commit that introduced this bug.
Perhaps this one is appropriate.

Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

Also, as a fix for net it would be best to explicitly target that branch,
like this:

Subject: [PATCH net 2/2] ...

I don't think it's necessary to repost to just to address either of the
above.  But for reference more information on the Netdev development
process can be found here:

https://docs.kernel.org/process/maintainer-netdev.html

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, an AI generated review of this patch is available on sashiko.dev.
All the issues flagged there seem to be pre-existing and I do not
believe they should block progress of this patch. But you may want to
look into then in the context of follow-up.

...

