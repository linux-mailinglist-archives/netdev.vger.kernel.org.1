Return-Path: <netdev+bounces-270101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJOQIc7SvWktCgMAu9opvQ
	(envelope-from <netdev+bounces-270101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:05:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18F2E2340
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D89F3024A43
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40C3876DD;
	Fri, 20 Mar 2026 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="yNB+Ssgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951E37F007
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047947; cv=none; b=ccLdiOeIEoRPURccTio5hM2Z/sFrZKYTIHNz431x8HEGxAOhoL7Rd0wJsvM/xhlR8DDgO7BL2j7QKjhiyNieewBq4+1iwjGnhiwrxG48tn2/DG3YZmM4/7zi3oUsMjnOj7ZD/eWU0DS6QOZ5K2ZyXarRK2J9O+66eZ1UnO5OKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047947; c=relaxed/simple;
	bh=FIAh290YQLzscCgK3QRlfs3qcGanHE3RzenIPMODm7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu7Qd5Y/YlXB7HwHp2XEGzGFf8bKOFpi+Ulr0NAbLFrDpFENiz46jH2RTXAAhYnKfPklsM3XtZCYgbWS2aUTLFwmJYUvbZRpbSuvHGK19gZoAIJGM4IwDcDG0xHb/kYJZhK2QV0lL5D0dLVe1abupWanP9G8JtoqYxOGg2t17ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=yNB+Ssgd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so818129a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774047945; x=1774652745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhc4N9jlJHnN9buMBRq2NE8bw7QGAFCXpHJparJXDnE=;
        b=yNB+SsgdILnUsbEes0sFov/IqCPyO7nsAGWXH1PH51+mwfjC39ov+fjGSWNS7nBAqO
         6rpJFxVt1deYKTE+e4kVcy4xBo+iN5uMbvJ0AX7XOL3nmAO+UdwoPt+8QdAP2Zp6Btpa
         YQHEsqnfV0Af6K4oihBLM1fSf8I1xh6yjHW4ifaCC4P78wpMXGFGPYS/KwO+XxO7YTOy
         V5M0/HoRTFl7fsNQZuNoEjPH9c7ozMQcw1IokiwVSt0BcxPnux2RhxbzrInK7W/qtKPA
         7v2MtzHOaOS7mzIoA2Tixp29bzKETZz+h5ulW0KObr31xLW2FscUSpQYmby2bsKKwVKC
         5iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774047945; x=1774652745;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mhc4N9jlJHnN9buMBRq2NE8bw7QGAFCXpHJparJXDnE=;
        b=FmqOD9UE7MUjcp3+y6k2uhGhwpB2Dq/EZ2wWB9HL6Uk/b0qbc8NDfJBKgSLrfuBhPK
         ONXklDJW4MdNsnq0AT2Dyp1LM5YAYWzx5jgxq+3w07YuAQMFhhMp2CRNKicXBqf+xvJ7
         1MKEWnVcUG+Z+FmX/7FTaaITQIHTPlLRnZQvCeNq6BXudUfRnn+H5gF6D5xmOy7nsVyB
         yZulxWeazFRJNpbH+7C6uDmGwPUMSOL2ti9cLh4W6vBro5aIhvXPT87d1nHtHS8uPgLK
         MnqZnmfsyLQhmK741cVAAeHFBj+4wPTzOtt7o6H0FAy4zd+fxjyPM67uiEFfTeg7r/vL
         6B7w==
X-Forwarded-Encrypted: i=1; AJvYcCVuTMbX023EPhAe3ymXwRjYaEjGjVemc/AMjeGadM/67dGk+fjvwYeEmSI+5QB4wQgic9Cqi5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1VjWjriyBegqSd56tR192vHLLvLs5EmPAxaaghDV86grZjJe
	VyJ7sJ1Z/+SYb9Qrf+14s7mPkhFXlraNbxr2QGGZEM4cGTX4N4y/lm6RORZu86H0y54=
X-Gm-Gg: ATEYQzwC0NKg0X9jrN37C16x4UIxCCX4z70E+ldk9Czku72W78DKK8WDgKW5bEUDkxl
	O70qRNqnumOCirnIBVdXmE4A2cmRULHigpNOce9/M56CjetOsZXJKPmecsXQ3VaSyVLZtOG81Mk
	hPj4MYNopAP2o4PyfSx2ySKY3EGPaBOkrumKIW0lAQYlxYV3K2fU+AUIY8q7bQnDPuxZokj7Hon
	0naDPU/X/Kul5VZM8/1ZuERIxRO5d1eg6EPVbFoKZ8NO6+SzWKoTA2RzTs6KHPWQAQd2hR/7dmd
	H7BP8kO6gMwyeLCEQ/H47jWNO/9DDlYwhqjxeI3fimrX6LkjYX6v3oXT0aBC27NU+RvbZ8EtlLK
	90kD6kTTcqosD6AF4Teztd9VBhGxmj+znRPn/XjdVpTFIT6wUlFLAvE5IUVrYc0ozbEinrIAMJb
	wErplM4L4NCL/TwA==
X-Received: by 2002:a17:90b:3c0d:b0:359:9014:99e7 with SMTP id 98e67ed59e1d1-35bd2d68359mr3803559a91.29.1774047945558;
        Fri, 20 Mar 2026 16:05:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bf2sm2816680a91.11.2026.03.20.16.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:05:45 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:05:44 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: Re: [PATCH mlx5-next 1/2] mlx5: Remove redundant iseg base
Message-ID: <ab3SyIfv/0FrMPM5@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
 <20260319122211.27384-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319122211.27384-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,dama.to:email]
X-Rspamd-Queue-Id: DF18F2E2340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:22:10PM +0200, Tariq Toukan wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> iseg_base and base_addr both point to BAR0, making iseg_base redundant.
> Remove iseg_base and rely on base_addr instead, reducing the size of
> struct mlx5_core_dev.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c                       | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/main.c          | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 3 +--
>  include/linux/mlx5/driver.h                             | 1 -
>  4 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

