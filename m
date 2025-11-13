Return-Path: <netdev+bounces-238460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88479C58FC2
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F374C3661FE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B6345CC5;
	Thu, 13 Nov 2025 16:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300922F83B5
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052504; cv=none; b=p1nijXuZbuQwI7iYOfY/mpm4CDhhkLimWAnf6IXcsgkqFmNqiLd0UG/pgQnp5wR40FInlgDdLIX8hPlcsAhUfUW+FAFBjtSNvC8sbRSg94SvVoOtsJSRuxqJcDoiJzY40JZMMIK/Yi1692OBizZCeb/izsNMQwoJUPxCQs48Mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052504; c=relaxed/simple;
	bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fA2pW8Q9KQYa20bDXyHECNEFdZ4+vnmujsHtypFib8HR0zCdhKGZdDqlplO7HMZgwCz0XiB2leyo/6ArkdxiZcNgDZHJoV5Wl0UEsxervfPK4rQa0Ca1ZW2T5z1RZ1B0ic3F4B3zj0HG+4dokH8Rj1mCus5/vpy5T+qNdHLhGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-44fa4808c15so160514b6e.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052502; x=1763657302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sum4+JVeXPfizys9pdpiHbOuRRQLqk+dWSvyWk6OJtU=;
        b=Cnp/gwXOfVvZmsWLyuaE1WmlyI2GjHFvVi/Tl6EPKHy2rxbA5rU0a+u0e4WoX26qWP
         OnykSNXgCn9Hw7ltv8K3Nor5sq3ycQQ86W1jfSgbTn+CI2CO0niYE5zw4dMRR76ovxRV
         4Ng2I0wOIuy17PrkuPcRWVj2bAYcXJPKPY6UM24BTVNVR8HBrySUbwtF078eq8rZgyZ4
         5xmThqWx2Ud4qP7LYiJUtQ0qLUHyrxx6pkShMeU7mHk4Z8f+ykvqm7RDwiBRYyMw98av
         YIcvhqkjk6+XR7IBLPGf0kviVKBWQUBvEpoPruh0GtGeVMz/GI7h+EgXwlaI7vI95oPy
         N6sQ==
X-Gm-Message-State: AOJu0YwGR2ukQKS5pihLxzEz6c53bC1ptOwg8xjYEJBV+ZCC2d2u9jse
	QxKf9MuQytOOVr/YDoggVXCqxHFTZrrW3A8pMjxz1gUcq2CClkxFOzj0
X-Gm-Gg: ASbGncvhXoWswppT1Ae787DS3rrWKXJY3T53KzWt7taECVo7UkF9+jW+bolygthgUqn
	CIgy3mjc/1FCeEATLwOjitOdsgp6TVSoQuJgI5YlFjX8bVzjbyLQkaXNGeZUAUNEv0S3RmYYjre
	OEc0WjU1mAdmEMiH7q/B4Nhlee6dhInXQA8aUhjvrnGsRr5HwasOq0MKBjii178GAIgegEKzjhm
	/6rscvyRy10jOLhjL50ruEwOLCXC5rQh/JviZRmztBxbuJWQ2SUZ+x1qy8dUmiX2n9e7Aj4yrI8
	h9GhA8KMEjHHC0GtbikeIMG9Nhr2yCXDRoPbMSxjWstY5msWkjcyOPqRGKPI9XysdlUf3w0z+gI
	CZ07LyH2Th1pfVhr/Vl9yFeSzfLQXc1C0glWKqZ/Je/1Evf+V7cqkYFy9z0aXedmUn5D0DHxp0x
	/kbLFEc4dwvO3mfg==
X-Google-Smtp-Source: AGHT+IG9TDGsXXH71ZlSYsT4b04gTMVdrIDzUOCAbUC+AwdHftVnv0Uodlv7OFGiel08iPesDyqhlA==
X-Received: by 2002:a05:6808:228b:b0:44f:e7bd:274b with SMTP id 5614622812f47-450745acef7mr3902165b6e.55.1763052502220;
        Thu, 13 Nov 2025 08:48:22 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4508a2e4af5sm1261843b6e.0.2025.11.13.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:48:21 -0800 (PST)
Date: Thu, 13 Nov 2025 08:48:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] net: mlx: migrate to new get_rx_ring_count ethtool
 API
Message-ID: <lto3b6lf2ic6ajph74ljo2ibpmoltkgpswfbvcprx5pr3iqfoi@67u4olbyq4km>
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>

On Thu, Nov 13, 2025 at 08:46:02AM -0800, Breno Leitao wrote:
> This series migrates the mlx4 and mlx5 drivers to use the new
> .get_rx_ring_count() callback introduced in commit 84eaf4359c36 ("net:
> ethtool: add get_rx_ring_count callback to optimize RX ring queries").

This is "net-next" material. I will update and resend with the proper
"net-next" tag.

