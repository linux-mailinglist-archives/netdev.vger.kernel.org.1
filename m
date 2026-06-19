Return-Path: <netdev+bounces-300650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xnwmKAwCNWq/lwYAu9opvQ
	(envelope-from <netdev+bounces-300650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDB6A4B24
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:47:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=liUthXPe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300650-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300650-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E91083011A7B
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA6633CE9A;
	Fri, 19 Jun 2026 08:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBD283C93;
	Fri, 19 Jun 2026 08:46:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858772; cv=none; b=K7fVPC0bVAs07NlXpS50Suq0qwwEazJLmtbYd+nwJYw5oXNqE2UOulF/vYVJeqSIxt7sHL/jkGb350eR6f8jK+Dyp/QfpBz+5XnfMk3KYGyb7Qhl9u+oawnJ3aMvRdJPACb1MimYhrXCQFaP0l6rUyiouU86tfaUik7NqJh8+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858772; c=relaxed/simple;
	bh=KY1C47P+ZXHfNpSp+CFuixpqLfghr1Idy5h/B6LXxGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGwCiHG2p/1WpJFtgQn4Wk3R+oN0NBxHoMJVorYWMCGqQff1ToUye5JsMvK6rvif+1YofeYmtayqMegUjqIR5dLxA5AuB+sBHWE+OSNSwcAGEaULu17SZSKJSkyxXTDH8UffwIdozgQKaCE4Zac+fnZ4K0p0RgXR7Afayu/JKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liUthXPe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E411F000E9;
	Fri, 19 Jun 2026 08:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858771;
	bh=Q3jUDrpfpTl+7emDvowW0x2rQb/5MzXpy1kl2YHYIoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liUthXPeGpnysTDtwuQHY2k6+Mk+U/6R+yJCmxpAGg/kHa9LUl2mclaIA5FNK0Gi/
	 zXfDBwRce4qBfJ2sZOrbvUD3bLPrjNAbbW8iGh2w+93UifSMSRcrunVzNKaWrp+CBS
	 Jpac10a2yRO3lFDX9AzakdObbI2z8Qbe0+69yCo28CjvEYuau32vy/dvi1bkYNIOvk
	 5H9uXx+BFEiXvVOVcMcWqBNmq93T3Hhy+rwI+XOqk1fVp0pdmYJ8zrsVJdjeonsAO8
	 MU9NpiFnIBl6Zaq+xMNJ16+rASvOVmNQtHOJ6VZC+aQYZ0FD4qg4x6A5S8zCEMsoTO
	 iYgj89T+9u5/g==
Date: Fri, 19 Jun 2026 09:46:06 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, rkannoth@marvell.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v3] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260619084606.GS827683@horms.kernel.org>
References: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-300650-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02DDB6A4B24

On Wed, Jun 17, 2026 at 09:10:53PM +0530, Subbaraya Sundeep wrote:
> NIX maximum number of LFs can be set via devlink command
> but that can be done before assigning any LFs to a PF/VF.
> The condition used to check whether any LFs are assigned is
> incorrect. This patch fixes that condition.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3 changes:
> 	None, updated changelog
> v2 changes:
> 	Fixed AI review by updating error message
> 	Updated comment to mention modifying NIXLFs has to be done prior
> 	to attaching NIXLFs to any PFs/VFs.

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

