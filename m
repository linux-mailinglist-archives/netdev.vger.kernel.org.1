Return-Path: <netdev+bounces-96804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505308C7E98
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F78281DE0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06521799B;
	Thu, 16 May 2024 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BZeedQll"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A24A11;
	Thu, 16 May 2024 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715899912; cv=none; b=D1fFLih+yyvax4G98o+6MiwKsdT1qyME8I1xUFk0ojl6hFMQIYRRJzmO5t++FlbPP7UwzK6xbxx9RxAymfQtJxEgyOuFHLLZmGfA6zFjXxPmNCOjZFoKKSn3yeQnRRnuyQFG/g3sQUciSeXjdNV5a2S/6+oeMNQxEIgGF4b3AjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715899912; c=relaxed/simple;
	bh=L7KhBLLyRFGTOe2L8CfKk/G01adXlvkwHXxoKyKvHqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNO70RETm/lUjuN/DzPDkZ/H0RL/NMuc6BFaeeE102nB9n9A7GOx3cKYlmi7iGnXi6ZTf61d+0oPZx0tb4DuACAnUdYnyoMwIf+7lVAWAVnyby/tKFVliMp9KQ0Uan5P8lVfTaEPnRk0lJ2MbMTDdK+1p49P1+u8mLHBKhja+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BZeedQll; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ervmNo5biR+yzACnIdOD1iqbJR0q4reGPzHLBT50d6U=; b=BZeedQllwqeJtWefMp2XLpr1ZV
	AYRIKZofAv8GgFgu0x9TAqjmSWWvWcJivA839poaN03gAEhGFWgYWsEZprq1l6VVsIrOR7qT/njIm
	nr3stVho4FU+3xJHlBex8TUt3k5snuQuxjpFfAs2fTcNOJahtLqRe20Ga1TApIujH0Xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7jwg-00FXIE-G6; Fri, 17 May 2024 00:51:30 +0200
Date: Fri, 17 May 2024 00:51:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
	glaubitz@physik.fu-berlin.de, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lkp@intel.com, netdev@vger.kernel.org,
	nico@fluxnic.net, pabeni@redhat.com
Subject: Re: [PATCH v3] net: smc91x: Fix pointer types
Message-ID: <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
 <20240516223004.350368-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516223004.350368-2-thorsten.blum@toblux.com>

On Fri, May 17, 2024 at 12:30:05AM +0200, Thorsten Blum wrote:
> Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
> to align with the parameter types of readw() and writew() to fix the
> following warnings reported by kernel test robot:
> 
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes in v2:
> - Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
>  essentially the same, but using lp->base results in a smaller diff
> - Remove whitespace only changes as suggested by Andrew Lunn
> - Preserve Acked-by: Nicolas Pitre tag (please let me know if you
>  somehow disagree with the changes in v2 or v3)
> 
> Changes in v3:
> - Revert changing the macros as this is unnecessary. Neither the types
>   nor the __iomem attributes get lost across macro boundaries
> - Preserve Reviewed-by: Andrew Lunn tag (please let me know if you
>   somehow disagree with the changes in v3)

This fixes the warning, but we still have the macro accessing things
not passed to them. If you are going to brother to fix the warnings,
it would also be good to fix the bad practice. Please make a patchset
to do this.

It would also be good if you read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

