Return-Path: <netdev+bounces-254855-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEXOEreMe2mlFQIAu9opvQ
	(envelope-from <netdev+bounces-254855-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:37:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83EB2456
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C1333004C82
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA376331A68;
	Thu, 29 Jan 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaJFS/Sx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC28934F;
	Thu, 29 Jan 2026 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704609; cv=none; b=czAevvwlZhGfOL31z9V3D3+FtjZG98T2xgnywtAY4XSPffQfTA+OVIEovHKW0VVGRajCCVs1tHUOh999eVQ2ibsP4Qo4eDmBgbC6uE/2c5S21ZVRdlE+zJ94zxUkQ7awSdmcDWbywwTmp5ov3KfEu88oTlGu+rDt8EeuhujtUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704609; c=relaxed/simple;
	bh=j7clNA0P0ppadRc+5o2lyO9sIBharxomFEA2q8V3Kf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdap1HCKMYQcQe2Q3UY6Yoz1vZkGeUVjMv1LrC74e/sD0b+dRUUmLKgxLnWuFFHXfaxOI3rdycGK9HQXl/f+g+Tg8eL8ZPYpE9VrziEMoy5amM4xHhFfYmnuREJoh5LKkxnrbWUmZ26lJABoSI5QSXMKuZ/VvPr7wuN+GHry9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaJFS/Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B2C4CEF7;
	Thu, 29 Jan 2026 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704609;
	bh=j7clNA0P0ppadRc+5o2lyO9sIBharxomFEA2q8V3Kf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaJFS/SxgM/RQFV6geLuGYu2xOfZ7Z92aE0/YtqpQ6RikpW9mNeGRZBQK9bCBgfre
	 KJsn+2FJpObVBb4FBoIMMZ8ASL7Ls0nmXljSfsM8QeJpJodpCVhRHNURm7v41vW/hx
	 alpB+NIt+aruDKhm23mggQM4dsDA05Evbtu1i/K/X/FfK8JjUHwSfASDSZSMjhylSc
	 nOLP20HMLPQzxOJv0WghVSmv4ObqqHwU94xpb/2u2EN/wi/aVCZH1OEVck4xtnXDWV
	 0kJbYeNrU6boPlGoMz64wNifZgE3+dveCNSYfdBhJunQIUdhEeeBDeVErb7fP+lnpR
	 P19bhiv8WBbfQ==
Date: Thu, 29 Jan 2026 16:36:44 +0000
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com
Subject: Re: [net-next PATCH v2] octeontx2-pf: cn10k/cn20k: Update count_eot
 in NPA_LF_AURA_BATCH_FREE0
Message-ID: <aXuMnNl3B0rcXeor@horms.kernel.org>
References: <20260128022448.4402-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128022448.4402-1-gakula@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254855-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid,marvell.com:email]
X-Rspamd-Queue-Id: AB83EB2456
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 07:54:48AM +0530, Geetha sowjanya wrote:
> This patch updates the count_eot calculation for CN20K devices. 
> Where the count_eot feild extended to 2 bits, while maintaining
> CN10K compatibility where only bit 0 is used.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> v1-v2: Fix size value based on count_eot

Reviewed-by: Simon Horman <horms@kernel.org>


