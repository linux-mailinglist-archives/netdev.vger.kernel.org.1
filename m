Return-Path: <netdev+bounces-261527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEOqH3qPoGkokwQAu9opvQ
	(envelope-from <netdev+bounces-261527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71E1AD826
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31F2230E6CA4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6C3876B2;
	Thu, 26 Feb 2026 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRL0LbO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5C27F732
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129755; cv=none; b=Anz049DL1mhgXXQK6gvjFpwtWd9Eoi8we4XVZnPSg8yYup7Q2pKtA14/sS5JDlvvBBlwJ2FcnmQA4sd2YVWFSu4DWEPZK05sQOYnRXWAuMqJ4FyRz0tUzplFNQ6fD+4zRghgJtruhCY7mF8xjsS5ef36WHuGVlpr3nJL5CjF6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129755; c=relaxed/simple;
	bh=InGfA/MrbxN5QZm/AqMEn8DbQ6shJCSZ7sTJO2WBjXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYmHXXf3OjoaqCg8ob/AdfbtrviOhUPhy0O6+nLIqP3ea06SsoBUH7PxyiwM74RuodFiSAI+sS9hMfjz4CtjcMQw2HhqIDJ/Hmx65Yl1LeiRvBPvP/tpld1DY4MxS12RB4u1QYJ9WS69rUIP+y8hzTYUVNpkww671v3a4p4IrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRL0LbO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB8C116C6;
	Thu, 26 Feb 2026 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772129755;
	bh=InGfA/MrbxN5QZm/AqMEn8DbQ6shJCSZ7sTJO2WBjXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRL0LbO/9lG0+lmcdHgwB8n1ryhi/Swf63VoLqLAmtI/w6H8cGwgIyWhgf0KGfPTM
	 Dgh/1nYb+xe5Wa07dMTLcfCJQ8fO6mFoG4gKhl1ttbHKEtqUYK/54EyrcS5LjjL6P2
	 7nStkSVBrXSiN4/gYlObnIBhvK52bq0F9xEkvKK5uMNAw0nI3TZR0iCK/DbnWS20yW
	 +JzLSPof5v1i5ehkKrM8pl/by/6hDW2wSvpfJ3QlzcpErT0A38D+Qlc5jaCNSc0KVB
	 x5o7oc6rICnvF/+U0XrsT8XZ7lvD+kPclV9zPP8zIn88A/23vXOwvXGSaVtenfBt/e
	 iFcNWMuTcMB3Q==
Date: Thu, 26 Feb 2026 18:15:51 +0000
From: Simon Horman <horms@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, jserv@ccns.ncku.edu.tw, charlie910417@gmail.com
Subject: Re: [PATCH 1/1] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <aaCN17Xsg9qVM6UX@horms.kernel.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261527-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,ccns.ncku.edu.tw,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: DC71E1AD826
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
> +        if (!ttc_params)
> +                return -ENOMEM;
> +

Please use tabs (8 characters wide) rather than spaces
for indentation throughout this patch.

-- 
pw-bot: changes-requested

