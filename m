Return-Path: <netdev+bounces-244152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34304CB0A3E
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E949D30054BB
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3A329E5D;
	Tue,  9 Dec 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ8CgyTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35051329C53;
	Tue,  9 Dec 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765299019; cv=none; b=dQ/t4vkiMHQh8CBe67ptWE87MMgMKZFePxKdOjXj3B9qYgAVjSrWfyVdR3rGBxaUQF+Zhp0BYOtark+7CgQvJcdnr8pJSUBQeDLjbwoicWXIFG1PBMz23rXI4E06FwoNktzzX9k0MkAqKFxsZbwuZN3GUhvuTJvYmhMZioG8Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765299019; c=relaxed/simple;
	bh=FXbATIidoIQBrMNeNYA9cIMy7SPm70snkyPynqDeIXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmwG8k12J+IZs6Po5y1cXsKwlHytDII5zrd41WdiRGG4TdTcQQdeRV7ynuSJ/VXlcdspoW0oetatRXLByVUFpjEi2yILM6H7jLshb66LIRy0QHfg0Tyksm6GkdIbCHDtiXsHklAwpzgd5cnImwRnz3KhtjZ6/NBeFkDu+aw43jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ8CgyTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DC3C4CEF5;
	Tue,  9 Dec 2025 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765299018;
	bh=FXbATIidoIQBrMNeNYA9cIMy7SPm70snkyPynqDeIXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJ8CgyTFU+dN6AcxQERLX/twQd6Eliiwq1uUH9bV/4QNMJx0nB28WSFc6wXxGVpa7
	 Rj2ktTmv1/3Wkzet8rbmYFK9JXFtMkrOBA2OgEIPbEx35Lfmcv+DhQykNecrCP5cXd
	 jFc3mpsZoNi06mwghh+RW0zzaBxFmmX5MHiXFuaE4VtzD2kiL4MYmgv1QhK9MRd9Vp
	 AFz77EhSfzTTPgA1CCsaSIY5cXryVi5isamOqkb6e/YVg884GsTS5XPN6TdYcHLed+
	 aSY7jP1IgiwGXNHNQ/cf/8Q+jAULA+4XSJwIKdhEerDw5ExdJ5EKLz5KxAbY+W43x4
	 NKgZcS+8jfa/Q==
Date: Tue, 9 Dec 2025 16:50:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hns3: add VLAN id validation before using
Message-ID: <aThTRWe3iHB7HQAZ@horms.kernel.org>
References: <20251209133825.3577343-1-shaojijie@huawei.com>
 <20251209133825.3577343-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209133825.3577343-4-shaojijie@huawei.com>

On Tue, Dec 09, 2025 at 09:38:25PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, the VLAN id may be used without validation when
> receive a VLAN configuration mailbox from VF. It may cause
> out-of-bounds memory access once the VLAN id is bigger than
> 4095.
> 
> Fixes: fe4144d47eef ("net: hns3: sync VLAN filter entries when kill VLAN ID failed")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Hi Jijie,

Can you clarify that the (only) oob access is to vlan_del_fail_bmap?

If so, I agree with this change and that the problem was introduced in
the cited commit. But I think it would be worth mentioning vlan_del_fail_bmap
in the commit message.


...

