Return-Path: <netdev+bounces-247385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB5CF9278
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED95D3081135
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3629344057;
	Tue,  6 Jan 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6Co8myn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40E338934;
	Tue,  6 Jan 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714088; cv=none; b=LKvRgcXElNHFLJA83W1/xu+FO2zDftEaw28JwJxaoWhytzUTS4gOr2FTskj6WtplD4NJjLEhNIEPiu8UySuxAHxnQJXscdgtRAaDBU9dOTQgwgxlFcCIcb2fNzgNjqQH4QESxbeCvzU88hgdivcO8ouIRHURNtPtOzqE19wSLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714088; c=relaxed/simple;
	bh=CdGPyshttLxD8DJV4/BFY6cgwNfR89oa6k4OFQmSBJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZysX/Lw15nCwkZMGjyriycAnM4HSDQ3mV9tKmxQ5WmhC7hEFLE24UF76mRoHdkxUYJOPOfl3LThChhTwhxY9jbCfg75OVuoi/p+dcNZf0Zq1Vpga6p2PQiCRgxpl7urPkx/BHbIcnHo44tTwtIhMBeUBR/WL94eq7F/CNjllZQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6Co8myn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D3CC19423;
	Tue,  6 Jan 2026 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767714087;
	bh=CdGPyshttLxD8DJV4/BFY6cgwNfR89oa6k4OFQmSBJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6Co8myneDJoUYQZmxuzgRigdzBbhvhT8LXQknjWbTLFU1fX8bB/SKcz4Y7qCiXFz
	 wIDipJUDVrePZaOFDgp+lsFivJhvB2Bk7pM5ieb5wmIsdrJ2ADCjpFUZ+OQ/IrjNQE
	 qOITJ/3MhFGwo+8zjoHPh5Sl2GUA/pqXtalwVx9c0rohfhKMkC2z80gzPBLsl1XdU7
	 P8OjM52B2f3+TPARq7Y1ZROfV8qwhkm0J9IlvewulyvSeZmsoKpKbXn/I1Ur4NQ7gI
	 FyZBKzLfOddxtOtWuavyVMzgvJ7bYnCAVm3/AhbDBQIlrbLMJtOawyL8U45gs7sKRX
	 pjEkJnoBeEhSA==
Date: Tue, 6 Jan 2026 15:41:23 +0000
From: Simon Horman <horms@kernel.org>
To: Yicong Hui <yiconghui@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH net] net: Fix typo of "software" in driver comments
Message-ID: <aV0tI5nFOd_yQirr@horms.kernel.org>
References: <20251225034353.140374-1-yiconghui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225034353.140374-1-yiconghui@gmail.com>

On Thu, Dec 25, 2025 at 03:43:53AM +0000, Yicong Hui wrote:
> Fix misspelling of "software" as "softare" and "sotware" in code comments
> 
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_hw.h | 2 +-
>  drivers/net/ethernet/micrel/ks8842.c      | 2 +-
>  drivers/net/xen-netback/hash.c            | 2 +-

Hi Yicong Hui,

Thanks for your patch.

According to codespell, both the benet and ks8842 drivers also have other
spelling mistakes. So I think it would make sense to make a patch set,
with per-driver, or perhaps per-directory, patches that fix all spelling
errors in each driver (or directory).

Also, I'd lean towards this being for net-next rather than net
as I don't think these changes are use-visible.

	Subject: [PATCH net-next v2 0/3] ...

Thanks!

