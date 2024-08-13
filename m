Return-Path: <netdev+bounces-118126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76728950A11
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213321F22FDB
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B16A1A0B05;
	Tue, 13 Aug 2024 16:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE543168C20;
	Tue, 13 Aug 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566334; cv=none; b=S01Q6WHmxFkf4ptg3lENFNY3gTZ4yu/xyVoePkzCT6G3ygwOAR6WhXw9/KVV31tezIWYesoGArZxoaUbnuN3mq8zx7LPNMc2DcAOQ2E0oU8r0D14OFwGPzB7g/FZ7zP/ZWASxKzJHbM9Jqvfrnsv3Do+xb8WRgXfuDO91epb1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566334; c=relaxed/simple;
	bh=s4+lnu5hdM2McYsYFItOtd1MUrvx99HOpg7qojDxEgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctk7DKfm6gkT7MSTF/m00qOqZOB92QN3EFvzlS2ilMCHa4zJyRnFAmb9CvfZ+/ry2fEB1JzPPhm7JeaBvT+OL/7xemETROLZGQyI7xkJuoLAlqx7p7s4Y4lVpAvPvxqA7KddYvS+rHIhOgJt12Ws9pZ3xC6AWbtRr5+GWA2SN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa086b077so517330566b.0;
        Tue, 13 Aug 2024 09:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566331; x=1724171131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NoZCSaoOttYGFP4/rYe/XKjJjPS0m2JdIDQ6t2cpfA=;
        b=r+ZNt/NKg6A6M4cUzMX79DyFlJGHlWf6Hb9PJliLasf/LszeJfnjJqXVEeo5XJrIjC
         RbP/I/o6EcY4o+EIW2xmuU/m/MZ+0v2d4mkLzcCD7I3hJ2gFuqkSOahX6NxFD9OuctFh
         f7iCoKwjRhaHXEEcSuL7sdmSuq6hqT7L+7MRvavErakmLgVe3DhjyQS9TmdqM6P3tcnR
         +tKDgkIygqo5FnuGG43jEBEhAfroQTzqOlVa2elv57EqAjvHt8X4X4EgY600JgRPT8Tn
         py2ilLMlg7nIWmom67Hbx5gviaoBfZhwME/jdwslKREnCsXTD7SXVOmNCFFYWxtDYtte
         oC9g==
X-Forwarded-Encrypted: i=1; AJvYcCVw9R+yDBWmTTSLq1BIfYCYggJnWgb4NRWaGLsbUEDM53/KABkhrgrxJnQyU/IswtMjnc2W0bkNndgFCGqbBQ1YFRclj2nWOKImaM+pkSZLHTC5QwzvryZBmCH1vkaqidWCb6hB
X-Gm-Message-State: AOJu0YyxoFpkPN28sFTpJMbQ9yt9nO0SiEaEwvDyg9bsm/XyF/DjdxQm
	vl3QA6HWVoToZ32zQGbljxcdf3cZh2Z+BX6AE/AP1k79VtqQUwrGSFhyaA==
X-Google-Smtp-Source: AGHT+IFkpR0IkCYUU+T11+NYu6VUySRtWZV3ow4RwBvn3WjywCNSuBqDVsW3Qc8BvnDESX+CuMTY+w==
X-Received: by 2002:a17:907:1c26:b0:a6f:6126:18aa with SMTP id a640c23a62f3a-a80ed2d5a41mr280573866b.67.1723566330595;
        Tue, 13 Aug 2024 09:25:30 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414f04csm80637366b.166.2024.08.13.09.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:25:30 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:25:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: thunder_bgx: Fix netdev structure allocation
Message-ID: <ZruI940YZCETGNGq@gmail.com>
References: <20240812141322.1742918-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812141322.1742918-1-maz@kernel.org>

Hello Marc,

On Mon, Aug 12, 2024 at 03:13:22PM +0100, Marc Zyngier wrote:
> Commit 94833addfaba ("net: thunderx: Unembed netdev structure") had
> a go at dynamically allocating the netdev structures for the thunderx_bgx
> driver.  This change results in my ThunderX box catching fire (to be fair,
> it is what it does best).

Should I be proud of it? :-)

> The issues with this change are that:
> 
> - bgx_lmac_enable() is called *after* bgx_acpi_register_phy() and
>   bgx_init_of_phy(), both expecting netdev to be a valid pointer.
> 
> - bgx_init_of_phy() populates the MAC addresses for *all* LMACs
>   attached to a given BGX instance, and thus needs netdev for each of
>   them to have been allocated.
> 
> There is a few things to be said about how the driver mixes LMAC and
> BGX states which leads to this sorry state, but that's beside the point.
> 
> To address this, go back to a situation where all netdev structures
> are allocated before the driver starts relying on them, and move the
> freeing of these structures to driver removal. Someone brave enough
> can always go and restructure the driver if they want.
> 
> Fixes: 94833addfaba ("net: thunderx: Unembed netdev structure")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for taming my fiery commit.

