Return-Path: <netdev+bounces-268211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPPFDsAxuGmvaAEAu9opvQ
	(envelope-from <netdev+bounces-268211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D995D29D7E2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0A830F0D6D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C83B2FD7;
	Mon, 16 Mar 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="I0gsVnV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE73A1D07
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678699; cv=none; b=gZBJDVrgv+nCu4VkfUDZUgCpMiKPKrHjwTmu+/wkb8kqbd7KL9QOTNJcHJhL4cFQe5ByQGuUcEK4mh1TY9qkNcHjW5JSlIxFdGWHG6niL8PzUL3YsUndvU0yv36b0Swxwsq5lvDdZyk7JDTf/eCNRR5AQV5sN4K5ZEUXZi1wlrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678699; c=relaxed/simple;
	bh=weUvuiugfWiI0Sg/ND1RsnpboRhIU5iRpS1NkIweLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj/rZBJKGGSDEex32emJDRjzvk2Lrp3MOIzKVw5sLlxQetzL7tEPFHNrJPufDWW8FRrMEf3325lDqMGvdYhcDxfkEPcEGpM6WZmYr2fG2BIEGiEljIhdSkIxhQ3ZKda6gw0ztb1gYymdkcTagrq6RU/p6EB8zgGY1i6muRos9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=I0gsVnV8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c73bc3dd25fso1826596a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773678697; x=1774283497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYHkrP1b0p79WeAJVelEfbeQEyFeubJRPvMAd91XCok=;
        b=I0gsVnV8rgg7XDdBRr2scbCmFbB86Q1l/+aMhZLeX+ovVsAzo6DKGjMFKliHcGUldh
         6o4jE61/Q4apP/AvP7dezSS4nN8ZcVzGYBLxcpkA0R83I70tQQpEe1t35Ol5u3FxgvwG
         JMLmL2DiRjHxUjipqF/+HPP3tMdku4MFTXwgB/sJTJxgk2DkdB4ttlWxAysLt1tVh6T8
         H3yBZWD4GOGtoAeCZgSsW2D1aA8d/8exrPvHqVTdl+of4lKuWft1LgKIKDMQmcUuGnY2
         mVwe4saU9kfWyLajcvqDwNVwKjQUs/plMyixjuWtxkcdPZ2OFl8VYA4QAdGoVhnfM1ju
         jXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678697; x=1774283497;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYHkrP1b0p79WeAJVelEfbeQEyFeubJRPvMAd91XCok=;
        b=GjQPLNCn0uyFgBZx5sNuq+057UxrwIcHsYs064Xu9F6EDS6ebMNb0ef5Ktr32hQIq+
         AMJXdbONZ/2ON8TeskbUwU6CL/ehdbIBUe+pdm463lrKoe1LYi+nsjzoEkb75TEVkvu/
         JSbT3U+HAg/O5L0UlkPpVl5zsEm2TZ+iC+OvcdFa2aYWRuexTaIr+Kn/ex1k88BulFuX
         d5bSyZF1oV2m9DGa+QD2Q4XPssnXMPUWkFHrCkZYPhxARD82OjdqJIpxCMj302TpYxxF
         YvHia+BJY2SfDZJNJW54118xH+J/B8xB31ImQ+tBOASGnsLb+ReQSlN6VX8P4+NDesr9
         4n/w==
X-Forwarded-Encrypted: i=1; AJvYcCVBB9JesolI8YKNk4Lca8p1Je+Ol05+0tHq0BTZUKXA6NuuYwQHjpD20q8f1+gRHBMX89pk5FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGVkncm2OkWOnEWflrcbH4lTQP7AZJ4rEC0MbaJ/WkfO1zzbs3
	WgAEm+Gtiv+jnvRzJG7NbonTELpFo8ieQibtbIaPgl8lDd/3Q/Ronullbw/crj6vncY=
X-Gm-Gg: ATEYQzy0gHzNufolGzuDzy0FkoFJbaWNmVp03raGL4QJfJUz/QkRE4wNrBrVn9wEgst
	TLsgw6nsb35xOPirI2xTdIs9atxJe7l0Jd80Cexy6Cm1u/WHozuloWc9r3nYquhU0NmCxYY+tOu
	Ieu1L+igNpb2BAzWeWTNKhvjOarycAhl4wvt3gEmih4rTfPykgBZm79qE57fSsKS6rpWyvwp4jn
	zxzTVybyVPxGJwlgsrX/hYIJX2BsWwrgDTyLK3gZ8jY9JlcFPFn9S6QKif+qPCqX7H+h0q0hdOC
	Y4vtvdLYHWTO0eJnMrCR91CvER3Xbl44LtJdrOAxEVXDOF91zP3veYR7XbJligyI5BXSCcLZDui
	Zv5UUJ32P/aTGkrYirEcT9TVWR3AeuDryIyk7GzaXMaWkp8RTN0y+H4h8JWWzgC9rxsYhgWpBnK
	CU6hCk
X-Received: by 2002:a17:903:41ce:b0:2b0:5968:a6d5 with SMTP id d9443c01a7336-2b05968aa46mr35648275ad.18.1773678697057;
        Mon, 16 Mar 2026 09:31:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8453cdsm107729715ad.84.2026.03.16.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:31:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:31:35 -0700
From: Joe Damato <joe@dama.to>
To: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
Cc: rrameshbabu@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs/mlx5: Fix typo subfuction
Message-ID: <abgwZ0ye440CPdVw@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ryohei Kinugawa <ryohei.kinugawa@gmail.com>, rrameshbabu@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-268211-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:email]
X-Rspamd-Queue-Id: D995D29D7E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:56:14AM +0900, Ryohei Kinugawa wrote:
> 'subfuction' should be 'subfunction'
> 
> Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
> ---
>  .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> index 34e911480108..d549b43e00fa 100644
> --- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> +++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> @@ -120,7 +120,7 @@ Enabling the driver and kconfig options
>  
>  **CONFIG_MLX5_SF_MANAGER=(y/n)**
>  
> -|    Build support for subfuction port in the NIC. A Mellanox subfunction
> +|    Build support for subfunction port in the NIC. A Mellanox subfunction
>  |    port is managed through devlink.  A subfunction supports RDMA, netdevice
>  |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
>  |    SRIOV support.

It looks like "subfunction" is mispelled in the section directly above:

  "Subfunctons are more light weight than PCI SRIOV VFs."

Maybe fix that one too and resubmit the patch? If you do that, you can feel
free to add my tag:

Reviewed-by: Joe Damato <joe@dama.to>

