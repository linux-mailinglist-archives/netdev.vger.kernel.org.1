Return-Path: <netdev+bounces-261270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGAdFoIboGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:08:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D721A3FC3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D68B93086DC1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E73A0B1C;
	Thu, 26 Feb 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZsuW3xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2133A1E8B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100319; cv=none; b=gVxBdOuo+KA4RG8ClOErDnTTNzWum+tzHsJRj538my1TY6HI2SdOnWu5/wtcHQjNHcrrwdAG0rtC2MOaHvbXnWN4715M6VpfRlUVZz6+07sTJnZ070b2jsLwfug1WivHMbUfCnJVmx7lSN+LBKJVTNUPt9OFswF0JX9POHx4eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100319; c=relaxed/simple;
	bh=il5BobYPO13HOqKz/MlB9UiuKZcEcL1hHpkOQGFX1kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDetx46r2E9zrtp7unqeorZreYcbXvH8bm0QbX3+ABWUow1EtnJdy9XpTnItlI3sqSnZly5s/XBQAkSjTrdH+vmwqYIAxtMUv1hAhcBtsaZiOrobwc+e8AgWGEBTzK0go8K8QH4JQAkTpsWy5osQiY/0jw7RMVz/xKgQw/FflYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZsuW3xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF165C19423;
	Thu, 26 Feb 2026 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100318;
	bh=il5BobYPO13HOqKz/MlB9UiuKZcEcL1hHpkOQGFX1kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZsuW3xdcaAFnbzRWJ2pJKCT16LHWPOBz0L4Q4CF34qqBXg1pvEK2fuyC9C9Jz0/N
	 GDT565/+MXQ7kh0oR7ZgmFeDRcFSM5F4IZuA/WfeSAe7Kaueot4iE72RS4oSTltclP
	 40oowlkBgHml4nggBU0cEMY3Jfi4LEcxGNtibEDFSXJO27viB1ruvHK69SJyOTa1lO
	 jTdfOm/9nUwfDE0siomd63p8eX8Io6pJL3IDK5KJJRUPCuq9CO5r/DTD7QjKAVcRM0
	 aTDFO/ff0TYcdmSGV5qpMQGiafkJIPyo3rqoxqP82QHslA6iX/r3c+YL3BMf8O+bHr
	 hxWrXh8w9A6dw==
Date: Thu, 26 Feb 2026 12:05:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, jserv@ccns.ncku.edu.tw, charlie910417@gmail.com
Subject: Re: [PATCH 1/1] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <20260226100514.GH12611@unreal>
References: <20260226092857.1583984-1-yphbchou0911@gmail.com>
 <20260226092857.1583984-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226092857.1583984-2-yphbchou0911@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261270-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,ccns.ncku.edu.tw,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9D721A3FC3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 05:28:55PM +0800, Cheng-Yang Chou wrote:
> The ttc_params structure is too large to be allocated on the stack,
> triggering warnings for exceeding the 1024-byte frame size limit.
> Consuming excessive stack space risks causing stack overflows.
> 
> Allocate the structure dynamically to maintain safe stack boundaries.
> 
> Signed-off-by: Po-Ying Chiu <charlie910417@gmail.com>
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++----
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 15 ++++++++++---
>  .../mellanox/mlx5/core/lag/port_sel.c         | 22 ++++++++++++++-----
>  3 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> index 6eec88fa6d10..8e3862f5b563 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> @@ -966,27 +966,34 @@ static int mlx5e_create_rep_ttc_table(struct mlx5e_priv *priv)
>  {
>  	struct mlx5e_rep_priv *rpriv = priv->ppriv;
>  	struct mlx5_eswitch_rep *rep = rpriv->rep;
> -	struct ttc_params ttc_params = {};
> +	struct ttc_params *ttc_params;
>  	int err;
>  
> +	ttc_params = kzalloc(sizeof(*ttc_params), GFP_KERNEL);

It needs to be kzalloc_obj(*ttc_params).
https://lore.kernel.org/linux-rdma/20260226071913.GD12611@unreal/T/#u

Thanks

