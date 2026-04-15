Return-Path: <netdev+bounces-278758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILsGNWG32nSUgAAu9opvQ
	(envelope-from <netdev+bounces-278758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:38:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE140456F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C3F3006959
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7653280CFB;
	Wed, 15 Apr 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZkcaRN1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E5271450;
	Wed, 15 Apr 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256448; cv=none; b=lfXj6dnXR2v5uMISQifHBPyqhlMGU5/89FkJZeT27FPDaljBoH43A5nkSrsVm2XZF8QvPQrBjciGt0f/VzF4sh4ZTXO8Y7qjvGg/uCeXlgSvpZqPJeqb4zrEiryVyFW3QPY+cyFCoSdCnWCpyNFKA4+6SSvuv9igyckbkXDJ6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256448; c=relaxed/simple;
	bh=a9Gf7H+lgjWN0OnQp577qpRWzrmfzcyTB9ajpG5uvxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGrU/rxra8pnQqaKNWXtTh/jic44I5vhiWaN5ZTXOz7Jr66TlKR5qXkDndIhFv3G5RHvIcaGSC/fI+dBvWuJ3Q+3bDMaPsbxplIJ+HLjbNKb0VgPJJIAy7zxf7mH4cy5Q9fE2cfVJU/Hp+Zj0HwWzky5soUutKJFKtc89F/jLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZkcaRN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FC5C19424;
	Wed, 15 Apr 2026 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776256448;
	bh=a9Gf7H+lgjWN0OnQp577qpRWzrmfzcyTB9ajpG5uvxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZkcaRN1qktYVjUp7R2zWGucNqmN9L9E1KcqWPqW63hCY7ltSXZrOTTfCgN/IWNbo
	 RTl8A9qlfASeP19gaVtrSJDRWcD5JmFMNRaUrg7X59ld/vfTHdgUJa7+qDOgDgwGhN
	 PnsKOykDaPU+49HaNcPr12yICE5l8Y+Vsyzn15RvGKgtJ4TJZP1Bu9mHIiEAJ/gIm5
	 mYIMt0mH4GnW6ykVFDCw00wHEnehz/ONot8d4aQ85GSYvikqVwRVs7GvriRF6UqwRg
	 Q8hPH1k25r2LFu1de25q7VT20+G1Ktp6uZyejt26lKtrko5e5Tshg4lbWg0UKJj0YZ
	 gQa6r7xEtbvyg==
Date: Wed, 15 Apr 2026 13:34:03 +0100
From: Simon Horman <horms@kernel.org>
To: veritas501 <hxzene@gmail.com>
Cc: chia-yu.chang@nokia-bell-labs.com, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net/sched: sch_dualpi2: fix NULL pointer dereference in
 dualpi2_change()
Message-ID: <20260415123403.GF772670@horms.kernel.org>
References: <20260413075740.1@hxzene.gmail.com>
 <20260414183132.GC772670@horms.kernel.org>
 <20260414183601.GD772670@horms.kernel.org>
 <20260414160000.1@hxzene.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414160000.1@hxzene.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278758-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFDE140456F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:31:58AM +0800, veritas501 wrote:
> From: "Kito Xu (veritas501)" <hxzene@gmail.com>
> 
> Hi Simon,
> 
> Thanks for the review and for pointing out the alternative patch
> from Chia-Yu. I agree that the more comprehensive fix is the better
> choice for this code path.
> 
> Since I independently discovered and reported this issue, would it
> be possible to add a Reported-by tag to Chia-Yu's patch?
> 
>     Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>

That sounds reasonable to me.
But it might be best to bring up in a response to Chia-Yu's patch.
(I can't make it happen myself.)

> 
> Either way, thanks for handling this!
> 
> Best regards,
> Kito

