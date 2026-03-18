Return-Path: <netdev+bounces-269180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP6mDewGu2mNeQIAu9opvQ
	(envelope-from <netdev+bounces-269180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BC2C262C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA150302DF6A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8B93F87E3;
	Wed, 18 Mar 2026 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="DkWczbrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B682D4B40
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864674; cv=none; b=GsaDzsS0Zjj6QKYvVLk0pCF3u2lcv2DvH6LZb7oKveD2pAbR+x42vgvBk1wTlj0a1uXXao2h5u1n9gbMGCeUICMHmzqdzfa3B3a9HfHM8Gip3muD3tjGL1yFGTEhjTDe0FNw9gkov+rG/4oFYktzuoQoRznrsGIGJ12Wfyk5pLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864674; c=relaxed/simple;
	bh=7V+tpJcHPHKkKArRby9B/AEvv+A6I5U8x69esMrCnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLhZNqHUGisYKq9Fs+4oRpbKj2EaGBkqYLF7uKX5UBJldhlUUBAQmxxxpZcBrVOpz37tO/oqhsVX+bvavhaMbL4cWTZtLxq2c77sOQZsZqMM6WxLzA3Q/ZQqpZ9AE2EuqjnFkFUXnfyYEgHu9/McODS5U6S4SN24PmpQyQuZ13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=DkWczbrN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82418b0178cso200564b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773864672; x=1774469472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcrjf6o6BBsskimuOBs0/X8mHwc2XWl98zNiH3etscg=;
        b=DkWczbrNIQVEjlE5M+pjSo5y5lJ+by1T8j93RepF68fSx2hJNsN3z/LP14spf2xTxD
         GjHNvBYIMtS9I1INUMEa9oAH70XyhYqcm42elsdox7gMSJoDGd57sSjTB5mSan9qvCsV
         eFlvtmd5JdQXQs1kjwSyZQPsYqDcKk4aFGRq7Dg4FgPkLrQBkMQ35JwbJbhSV8s2I33p
         ndebk4WsWZ/wndb1k/sYfJTDKIYBd//H3X325h17nxGmnatVLHabxX2djDTegEdlLaOq
         jvApSI+LinleIAO+nE8hXcutT4HnR+QMWsgbX152KBdlxgJt5fhGeLLe9LsBOYOLnIdH
         05zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864672; x=1774469472;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcrjf6o6BBsskimuOBs0/X8mHwc2XWl98zNiH3etscg=;
        b=UDqOlcleyW7tdTPcx2XNn7TTwWT7BkYTQhaANSU+AfmFxL5zwFOU55BP4GfTkFNhHY
         p2HPQpexSNIdAtT7K1JtjsINEu/XaegerYgo3Z+3xTdZlLoCcZ79R9Th7Q6U0RmjZb7j
         4h6rD3dn/2k40ODhvC0+1BhBQaD7R6NoZKmfXVolBEujxriJbUHo3Gf6wRuWKzt4MRz1
         A3Vu0wyRrVS544SQVPomgv7C05svCqN76BSLvPPu9M17oTbupKbdszeF1p8A8WUpDkZW
         r1j8Q0ieMHUse15dnGO6HUEgWCKLif/AB0ZdaChHSvFERxhRQ7stqO3KdBEMH0XB6+69
         wG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXC+BnkaR2WSnT/Y1DEdDmFRQkQPuLEdicPOuoX/sZkk+IugwkDc7uSafhE3oO258UhUV9tpYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuMYoXYeq6zHvBzlK95+aiTFYFIj7Tu1jC53MyjqkwnjkkasK
	ljENVPGAc69wknsQNXHU8gLmXlsBNwVPxRwFt4SiW5fKJkKZSrkmeNh7F2G+3+rGnr8=
X-Gm-Gg: ATEYQzwFRVU74FzRrdNBCMWOYURwgp0KTNg7IF0yHpHfGBHuTe2SNsTtCxjyD7U93tK
	fLu7ORUCdFBhzCQOl2/BWxnBUVzTLCTV7uo4VJVHlFdvJ6NXxO9kBM2vNG2HUCDoQXHbupMP1pX
	XX7Gm0ovedo5jj8cxtwEtH3Euag0g3d6E43hJxb9xdEwdSSy8mx95+ugfEVvACv+m3/WBJQcvhp
	qx+aLbKIe22IgqYZNOQUX5y5HYo4hnUdKAZIUibd76xqGsldPlRMN6qJOS9Uir53X498vMved6C
	i8sL9wWYGbwfLr+oxnSBww7r+fjXVYSB8e8Tbsh7yl3C4CqLbaCkBmD0vFnxpnDGFtepbXoG2l/
	YEHMz+YhrQgTEBbRIqlzIXw99RvVqNV01xQgYc/IN9G7WngUHa0Bxx2kjx2DpLnj0+FPaF3y+yY
	NfWXU=
X-Received: by 2002:a05:6a00:2183:b0:829:9c9c:1720 with SMTP id d2e1a72fcca58-82a6ae70a0dmr4132616b3a.38.1773864672197;
        Wed, 18 Mar 2026 13:11:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1869sm4227445b3a.40.2026.03.18.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:11:11 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:11:11 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] net/mlx5e: Add hds-thresh query support via
 ethtool
Message-ID: <absG34VIYtLLTF+X@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <20260317104934.16124-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317104934.16124-1-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269180-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A66BC2C262C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:49:34PM +0200, Tariq Toukan wrote:
> From: Nimrod Oren <noren@nvidia.com>
> 
> Add support for reporting HDS (Header-Data Split) threshold via
> ethtool. When applicable, mlx5 hardware splits packets of all sizes with
> no configurable threshold, so report both hds-thresh and hds-thresh-max
> as 0 (i.e. always split regardless of size).
> 
> Signed-off-by: Nimrod Oren <noren@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 4a8dc85d5924..bb61e2179078 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -371,6 +371,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  	param->tx_max_pending = 1 << MLX5E_PARAMS_MAXIMUM_LOG_SQ_SIZE;
>  	param->rx_pending     = 1 << priv->channels.params.log_rq_mtu_frames;
>  	param->tx_pending     = 1 << priv->channels.params.log_sq_size;
> +
> +	kernel_param->hds_thresh = 0;

I think this is populated by the core before the call to get_ringparam and it
looks like it is defaulted to 0, so I think this assignment is unnecessary.

But everything else seems fine, so:

Reviewed-by: Joe Damato <joe@dama.to>

