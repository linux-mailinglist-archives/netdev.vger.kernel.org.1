Return-Path: <netdev+bounces-283678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gm3qMK+x92mrlAIAu9opvQ
	(envelope-from <netdev+bounces-283678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 22:35:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352A34B7559
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 22:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0723005AC6
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B832143F;
	Sun,  3 May 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/weAF/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066023C8AE;
	Sun,  3 May 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840556; cv=none; b=C/KctHu5LMN0/Lli98YU+XlCIQEp2RhB11ZbdZTLlW3fkKSz5ZZIFcx6dHR4j74J2R9SyX3bloYmU+T3XKxLRm7+0jRH7w91K98VRpYOerCctj9CRd4VxzKzqIoYZQYLU0GWpPx45r9ob/dDqaru2lhFF4cF48Qc6cDNOH/YSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840556; c=relaxed/simple;
	bh=q3wfZQ/XcD5PpDh1LiT/06XWdBI/wnc/pCixI5mlEdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kztafdr7d1y/oyrJ9bImfjhpAysaJE+QGvaLtd5LpuVWSoIVOd7RqYN5/+zJByfivQQlnQH6D140QC4qbqvuspt6y9huEUzU2d9L5FXaGL9EiqkiMnnJmySD41iW4R3g9h0sMnc5GX5AkWFtQrHcfTFdfYVoun5TqExjUXh55EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/weAF/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5911AC2BCB4;
	Sun,  3 May 2026 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777840556;
	bh=q3wfZQ/XcD5PpDh1LiT/06XWdBI/wnc/pCixI5mlEdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/weAF/ocJjz0BVt6DJPTWTLU/OAWLr2wyIOENO9Se82IF9o77fdryfsSMDegckwB
	 O4ugGJCaWc5IcddoCGzs6mseKR8CePJeOjKYpMuy2lP7sFwQA1VmaStAIAwVLHVMJz
	 F/TB6tfBelA0pCm6wIsDepnX17kvzAHf9ClmF09G2cTfImyS4HXCjo+9eXZBvt7tid
	 uSFm7fDWeeUXn69yUoppz+6gfu+9lHi9d2ex9rT8kb6Dfx00pGr7gEBTL8dryDDtIe
	 EWj4aW2wOPgLIW5dABABLgga01dapCvdcgnVeOBxbZm51e8jjcL1OtJI7I8/rTsI6V
	 qjSGPsgMldJAA==
Date: Sun, 3 May 2026 22:35:51 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update address for Michael Grzeschik
Message-ID: <afexp-hcrSrchinN@pengutronix.de>
References: <20260426-maintainer-v1-1-d74d2f4343f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260426-maintainer-v1-1-d74d2f4343f7@kernel.org>
X-Rspamd-Queue-Id: 352A34B7559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283678-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Adding netdev to Cc:

On Sun, Apr 26, 2026 at 12:20:59AM +0200, Michael Grzeschik wrote:
> Since I am moving from Pengutronix update my email address for the
> ARCNET subsystems to point to my kernel.org address.
> 
> Also update .mailmap.
> 
> Acked-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Michael Grzeschik <mgr@kernel.org>
> ---
>  .mailmap    | 2 ++
>  MAINTAINERS | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 34acd34bbf9bf..7b01246851705 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -579,6 +579,8 @@ Mayuresh Janorkar <mayur@ti.com>
>  Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
>  Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
>  Michael Buesch <m@bues.ch>
> +Michal Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
> +Michal Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
>  Michael Riesch <michael.riesch@collabora.com> <michael.riesch@wolfvision.net>
>  Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
>  Michel Dänzer <michel@tungstengraphics.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd163..48b601d36b846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2058,7 +2058,7 @@ F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
>  F:	drivers/gpu/drm/tiny/arcpgu.c
>  
>  ARCNET NETWORK LAYER
> -M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
> +M:	Michael Grzeschik <mgr@kernel.org>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/arcnet/
> 
> ---
> base-commit: 897d54018cc9aa97fd1529ca08a53b429d05a566
> change-id: 20260426-maintainer-eecd046c4a87
> 
> Best regards,
> -- 
> Michael Grzeschik <mgr@kernel.org>

