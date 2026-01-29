Return-Path: <netdev+bounces-254779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B6aOq5Pe2n9DgIAu9opvQ
	(envelope-from <netdev+bounces-254779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:16:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60948AFFDF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C639C3021D0A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7E388858;
	Thu, 29 Jan 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WnGVkV5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BA388847
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688913; cv=none; b=kur40Fl9gxjOljldQ8WOjftkpWA6rys0EC+8CdoaHdfym/RSaC0nAg1hNndfHk9cvkDXSI+oAx1PFbFRTbE2FHVUoLRmNmzdF8bQBn1hhVceBqMtTSlKDBUxWw7glauisyA0NhNzLTbGpwNa2yE6DqfDOCudrgi9HRMJzlxtdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688913; c=relaxed/simple;
	bh=BKL6mXkuNwuIgjX6tk/CceCioRD11L/7svOaSUf//pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re0IH7pFLtPI0cko2/LykZhBb34aJq1MYPJs3STvktqZ7gBph49I/3tGmQoURL45TBhW1ink0JRw6geiHszDh0bCjxz0jzOuXdic0zlYB1M7Gaqoz41d3e7xAqp+SM5s68ocWMtH+vst3gpLbi0i5jHIjFYoxNcB/uTnexxF+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WnGVkV5K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so12206155e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769688908; x=1770293708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jplzhxwdBCQSyKwsI7cF2uGXEBppFP2DS506Q5npTks=;
        b=WnGVkV5Kv9rx8hO+l21tSt9csQmWvavZ2l0tcSQ+eNHbjgkyPO1CU6M5Nenaw+zjrN
         G/S+Z3eet3mHlgGQJjIS3c4wHpg0WnAlaFXv043WQiCDt2MSai/oObcBk7xEOtFjaVMp
         3VqAFGs+Fda4imh/uh5eOWUV8fpHsh+egh3RdRJwqBh2aU6hE4Lk1YwB7dc/Jk0QW/lw
         lDH0wKylULizq++8WvsWBkWNR7ow1sJSizpjZ6YeRGXuR4vRWd+wGLtcmzPm5NevUCVk
         GA53ErKhNaKdaBzdF3okWtVR/pXvyX2TceoMBmNibTd+/olBHLeJNCxbQRtN8VjOVphL
         0PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688908; x=1770293708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jplzhxwdBCQSyKwsI7cF2uGXEBppFP2DS506Q5npTks=;
        b=ihhmWiAugyHHK88YyEV50Wsz4EdHM/7GGmdRMRCaJt3D9Dew3iMBfztXC7x43BocMt
         r8HpTZHJDQi1HihqkasderUilWk6dlsEz74br0z0cL37YmIHBiF3OfTw5dUKOHddiNi6
         X9xZccde9I67u4FNtsKYeD90WB4TUNF6soeQ2nZMoxJRlRKE1hIBBAplDNhTtfD2Bz7g
         QB6UN1mrb26qI/k0wXmoFdTeyJhREgMj2CC5jYRah/dL8DCQNR6hH32hc0EVUfeHueML
         hNd6YVuRfmaovAaDQSFoAR3XJA81mqBBBnpgD2VPVeolxSnPnI04B/5x7YcFevyg7922
         iLAg==
X-Gm-Message-State: AOJu0Yz9OkznGrRiDZUdYDJ03r8J0hPdyGbkAFsivoaq6qTtBDM7MmHz
	ByhUQg6VyfwrDn732eOjK1Vow3BWTxYxiBNx4DjCDQDqTqAgrBr1XGHlbMikr2yAD74=
X-Gm-Gg: AZuq6aIRQNQBrts4DubOb8yjdiR72T1ZiZaTxzB7WWY2oUX4t1nf3wNpOecSTCeWBwb
	GvDLR+n0UgWGaL6YCppLFb9oDzfNCcbFa8oHq4VLDNd1zMFkpWx0AutpjRMOkWZN+J21XulJoDw
	skl0tir5ryxhKRvT0hYzngmxZgW8RpOo6AcKHoYopWwj5B9EG4QT06raQqar6mVU15YxWLw8Wda
	hNyOU0ELZ2HdoBA3Oil2kZTRw+6Ep0m0ZAalQacnxpbjsA36MX23CkTTC8/5uBR2oy1EbXxErG+
	PJ4NPInMFrE7Andk4UbNnRjIjt5xxLfzJconpbISqkFNGtn3abCgrYw+3PwAQRU26kjT3LhnHk1
	k5/+uirppmeoztUpWh/GHX/CqFG6iZkgeVTDq7qjPMDCqtNGtBznjbwRbPYIbrWIGzEIUaW4nDS
	9TqAkUMZFzbvxYIC+nleXu9TRyGyBKQA==
X-Received: by 2002:a05:600c:8b26:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48069c164d8mr118526325e9.7.1769688908106;
        Thu, 29 Jan 2026 04:15:08 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d4b5ecsm2960765e9.2.2026.01.29.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 04:15:07 -0800 (PST)
Date: Thu, 29 Jan 2026 13:15:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Petr Oros <poros@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] dpll: expose fractional frequency offset in ppt
Message-ID: <sxjsuxqsgx2etc2t3hd4v7wpffdoe6e5epacktdobwynyv7bru@ra37na5aqxyx>
References: <20260126162253.27890-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162253.27890-1-ivecera@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,linux.dev,intel.com,microchip.com,nvidia.com,lunn.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 60948AFFDF
X-Rspamd-Action: no action

Mon, Jan 26, 2026 at 05:22:51PM +0100, ivecera@redhat.com wrote:
>Currently, the dpll subsystem exports the fractional frequency offset
>(FFO) in parts per million (ppm). This granularity is insufficient for
>high-precision synchronization scenarios which often require parts per
>trillion (ppt) resolution.
>
>Add a new netlink attribute DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT
>to expose the FFO in ppt.
>
>Update the dpll netlink core to expect the driver-provided FFO value
>to be in ppt. To maintain backward compatibility with existing userspace
>tools, populate the legacy DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET
>attribute by dividing the new ppt value by 1,000,000.
>
>Update the zl3073x and mlx5 drivers to provide the FFO value in ppt:
>- zl3073x: adjust the fixed-point calculation to produce ppt (10^12)
>  instead of ppm (10^6).
>- mlx5: scale the existing ppm value by 1,000,000.
>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

