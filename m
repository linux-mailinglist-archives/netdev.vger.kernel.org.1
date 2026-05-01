Return-Path: <netdev+bounces-283170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIvcNVWc9GloCwIAu9opvQ
	(envelope-from <netdev+bounces-283170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:28:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D057C4AC619
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96F1830060A7
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2183A2560;
	Fri,  1 May 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3ywNExU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F53859E0
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638479; cv=none; b=SunddYsrqLEoF7E2G4PrcnrVtQvG/npGdvOtHgFUhlE65I2+UUKGT2lP+mLe3/TTfofqVoaaOsnPc4S8RYlWRhf37DKuAcuIcimoLmns5DqaFl6cbqafUFOwdAOTLijJhveXltOYeLnnC+xQDN25MeQpJ2QpLVPdUAmddqGmrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638479; c=relaxed/simple;
	bh=5lT6TRvgI8koPXV5OrJFxLzqZFSDbD429ThALkAUV5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cliAWUHICIuClKthxOEacEDehiwoYWGy/B9+yzoyjdRBDD2etuciGSvt7tjJNC/05uOZn6AEdjyA9vK3zCuR33EFUdfRuTjocQANSVq6td08OStq1P2h+6Xqa/K2Quozv7xJW5u4D+upazBjEv5Nw5PzvjKv8+TPM9DuSNSumfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3ywNExU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C625C2BCB4;
	Fri,  1 May 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777638479;
	bh=5lT6TRvgI8koPXV5OrJFxLzqZFSDbD429ThALkAUV5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3ywNExUj2rzEoONYig+O5R/gH4E4ylYWyD1Q4XffE93Bn70bImrpG29F2WbHGP9g
	 k1Q0utKUddFKMo71CQGsHyV5fJqSIJvfer2braPRwRiMO96oeVgFcVfnQ/3KiLUDrd
	 toWkkruv1TnGP2NHecRVAl66yd9/VlybHG7lr/gVFaF3dLOFcbonIAGN4YPAiniOVA
	 B+9nw1HdiDlheCg4wCTyv+nl/F2I5DuTOngZNz/EMlqo2ki8W8E76s3io2tZl/zcFM
	 20rW5X56AY+LnJBVf3OGL4DyA3Plz5bQvbWjpfpzMXUwD21+3afkWDef/DEU5rOZNr
	 DuZLj/wvEx9+g==
Date: Fri, 1 May 2026 13:27:56 +0100
From: Simon Horman <horms@kernel.org>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch, chleroy@kernel.org, qiang.zhao@nxp.com
Subject: Re: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Message-ID: <20260501122756.GB15617@horms.kernel.org>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
X-Rspamd-Queue-Id: D057C4AC619
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
	TAGGED_FROM(0.00)[bounces-283170-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hitachienergy.com:email,horms.kernel.org:mid]

On Wed, Apr 29, 2026 at 01:42:07PM +0200, Holger Brunck wrote:
> Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
> done explicitly. If already unmapped ucc_fast_free will crash.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>

As a fix for code present in net, this warrants a fixes tag
that cites the commit that introduced this bug.
Perhaps this one is appropriate.

Fixes: ca20e191eed0 ("net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove")

Also, as a fix for net it would be best to explicitly target that branch,
like this:

Subject: [PATCH net 1/2] ...

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

