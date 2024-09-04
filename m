Return-Path: <netdev+bounces-125260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651696C83B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A913F1C227D2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDD1386A7;
	Wed,  4 Sep 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGT1/+dd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83A84A35
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481048; cv=none; b=mlNQ4JLgwsrBZKgabeb2BK4Xy8pOifUnv/FVsKQc4KAh4fNkuzmfdZZLYGPbR8VnOQQ8Mz7z6IunNAf6Z7ED9QQz3xjRjX6kfTNBS+T8wuHPTD9MWMokFUKQ3CNEALpHy2nzanP88RR1MkO1LtZQGSCVRL2/rXQV5O5dM66iXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481048; c=relaxed/simple;
	bh=DsMFYbvCrM/r9LeX4YUcNDTlxeqLSpgD2MxiUrT5chY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcmW1yt7jOZHt2e4K9oLtDy7C40cFsoIi2yJSbnC3TeWbden/XsOYR+hGx8EK2MWBnX022sp/PBnesnuqzC3ZQkn7WEg3CZTLrS5Xu48J2w3gmvmEEJft9DHgLaTSs79HwHKiNVrh5tvXlJscJhYh5SH+6BtDcp15xGAQSiCeto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGT1/+dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C64C4CEC2;
	Wed,  4 Sep 2024 20:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481047;
	bh=DsMFYbvCrM/r9LeX4YUcNDTlxeqLSpgD2MxiUrT5chY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGT1/+ddV2Hm71eO4kuD5usvD6Vwkt/uCKqx8IU9VxS3METl3/tTCgga/tVynCZHj
	 otI5ouirk7pT1oyx+zL8VE9ltD1LhqmKpuPlaJZaWPKx/R4GZOCifmxfYV9xhPcahK
	 zk1LGHAMkbqqDxGjnZL6nW9hWejdBVmJX/ZQayXkUrCYb7hBnLs8hKZDQaCsW3dw0e
	 T626ut/k3R0hc3aZj+B2xZycccEvaW2sgkuK4nhYgvjAWLBRcF4v06GgWIjbTPwxMO
	 kHXBL2R2fiBxVvThRoLNNnCTPmNzPgMXlMc8zOFiCkZSqXuV1ZIW2yBghjIlBYeeSo
	 EeUKhFkpz1gKA==
Date: Wed, 4 Sep 2024 21:17:24 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: fix ptp ocp driver maintainers address
Message-ID: <20240904201724.GE1722938@kernel.org>
References: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904131855.559078-1-vadim.fedorenko@linux.dev>

On Wed, Sep 04, 2024 at 01:18:55PM +0000, Vadim Fedorenko wrote:
> While checking the latest series for ptp_ocp driver I realised that
> MAINTAINERS file has wrong item about email on linux.dev domain.
> 
> Fixes: 795fd9342c62 ("ptp_ocp: adjust MAINTAINERS and mailmap")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Hi Vadim,

Should an entry also be added to .mailmap ?

...

