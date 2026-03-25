Return-Path: <netdev+bounces-271658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOFTEhUUxGmfwAQAu9opvQ
	(envelope-from <netdev+bounces-271658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:57:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1343297CD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 378DE31AAC12
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812B3E2744;
	Wed, 25 Mar 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L38QAl9I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91713CC9F8;
	Wed, 25 Mar 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456973; cv=none; b=owvo6Z9XyXWEBIwgAdsmKkfvb2GdIAzH6p1rvs/9kbJBUAr0qOR+uZc8O6J3EyXs8Kivq2WUqqOdiMp3D718tjWyxlYAA3Cg15+SJ8rH2qd/UUY0zAPRlq9iFhQV3PQv6vDWJSkikGjXpwqcWn9rcGixkDy3yluIG0jhBsngStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456973; c=relaxed/simple;
	bh=ftAS/2TjN/TRbBu6BzWLARyDup41kIcRxGAHYWEUato=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHF8C1+Hv7CqX6CtA3QsssDKc1bkBCcZiSz7o/KH4Anxb3Q2kG2J+ud8BzSVIvwngLZAIlb5QJOMpfA4s9s59iOjzPqoDOrwJfY15DG8s2fNgnnPprO/E7lMfXRV6Gxwh2qiVLYfutrRCV+nDYDmGKY5nAUedWlJ2n99a1ZpzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L38QAl9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887D5C4CEF7;
	Wed, 25 Mar 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456972;
	bh=ftAS/2TjN/TRbBu6BzWLARyDup41kIcRxGAHYWEUato=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L38QAl9I5o4+juGu4PvFQoEga45702tv0N53YB1Azh3rPCsy49koOpniP9GltrnnF
	 mvNr/chm1v115BTjaJf46BtE9+v4g/dzkACODErjFDIJV3M8mhb1J2Wey9y1qTmGen
	 ZZ0++U/eHY5y7n32ZdrrE6HpcGntgle2jG7haDFB/qM/Kn7Dz1/CtatbTpfxsJOpL0
	 Be3vr6isBTcDJv5/5Fb8jZ/u4XI1f3DSrYXhNkrdrbb5Clf1MS9Iv4SfBsfSuGFvCT
	 7bnEjIld2kzv0u0A5Upnf8Dh9hWV5vZob/MLF4zZ9D3Dbg0tzrdlJBolV8QxbsBMjA
	 JOrX69yGkZayw==
Date: Wed, 25 Mar 2026 16:42:46 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com, dtatulea@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH v7 net-next 5/5] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <20260325164246.GF111839@horms.kernel.org>
References: <20260323035110.3908741-1-rkannoth@marvell.com>
 <20260323035110.3908741-6-rkannoth@marvell.com>
 <20260324163621.GC111839@horms.kernel.org>
 <acNTFn5pjllT6C2G@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acNTFn5pjllT6C2G@rkannoth-OptiPlex-7090>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271658-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: BA1343297CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:44:30AM +0530, Ratheesh Kannoth wrote:
> On 2026-03-24 at 22:06:21, Simon Horman (horms@kernel.org) wrote:

...

> > Perhaps it applies to the existing code as well. But I think
> > the new code to handle parsing images read from the file system
> > could benefit from bounds checking. Basically passing in the length
> > of the firmware image as an argument and ensuring that data beyond
> > that length isn't accessed.
> This is already done in both arms of the code.
> 
>  		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>  			dev_warn(rvu->dev,
> 				 "Profile size mismatch on KPU%i parsing.\n",
> 				 "profile size mismatch on kpu%i parsing.\n",
>  				 kpu + 1);
>  			return -EINVAL;
> 
> >

Sorry, somehow I missed that.

