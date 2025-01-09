Return-Path: <netdev+bounces-156699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA230A07878
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA1162ACA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1864216E39;
	Thu,  9 Jan 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Che44zev"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EC63B9;
	Thu,  9 Jan 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431431; cv=none; b=s3mZBjygj2zmlMPo4oALbSXPZGvuAZK1fCGzkGFubexT0Xix+c0cctu7ETTXXqW2YAFjVOAE+qGlec5WLxhARgMnI1wiSKvGsof8BjBUzfGGAeKGFbiH9a77Gt5PYN7keJJQ+rRxX+cTMFwznOAJ0VecHlkZZFK6qNvmgJDg2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431431; c=relaxed/simple;
	bh=frG7Bz/fRGsOTpQgjpmnfVfY1qxDgStiMxjpVrkA5e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lew2uqjoma9aksFIKenP9m2NxFFTmjLzZvGDBxSL5jJjAyarC9PaGn8JPk2AdKlNFxW6W2fIvBV/zW8a7PkNbZq6jq3VAwOt/n/HZ1cTKhiwmFuCG5c6llXFi5TJs2wr39/tEu1A7tkSbaUuxGRzEECIei5q3xow2NVKkrP7+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Che44zev; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=un05v2lMozpOmyFU5fXAvOVhZLm1XdKua0Ebxw1UExI=; b=Ch
	e44zevZ8y6RqEiK3ho/nFd/yoVpe3bElgnYrtCKxs86DlgqHgrhkAgVbOw4AEcR2TW9HTHRWSR47N
	7oyQyv1q3IR3PObOc77n0bsk+AG+Nowe+3PA5vhLzBWsAYh2HxlUTkO9hMK9WYRvMtg9X1fiyB1g8
	QBcIcRQyMMhc/JY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVt8N-002uJy-5o; Thu, 09 Jan 2025 15:03:39 +0100
Date: Thu, 9 Jan 2025 15:03:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeking@red54.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, wellslutw@gmail.com
Subject: Re: [net PATCH v2] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Message-ID: <acab12d4-418f-4a94-aca4-705bab8e4a90@lunn.ch>
References: <20250108100905.799e6112@kernel.org>
 <tencent_E1D1FEF51C599BFD053CC7B4FBFEFC057A0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_E1D1FEF51C599BFD053CC7B4FBFEFC057A0A@qq.com>

On Thu, Jan 09, 2025 at 02:05:52AM +0000, Yeking@Red54.com wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> ndo_do_ioctl is no longer called by the device ioctl handler,
> so use ndo_eth_ioctl instead. (found by code inspection)

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

There are a couple of things which would of been nice to add, but the
patch can be accepted anyway.

One is a bit more details in the commit message about when
ndo_do_ioctl is actually used, just to help make it clearer why the
code is wrong and the patch is correct. You could of quoted
a76053707dbf:

    Most users of ndo_do_ioctl are ethernet drivers that implement
    the MII commands SIOCGMIIPHY/SIOCGMIIREG/SIOCSMIIREG, or hardware
    timestamping with SIOCSHWTSTAMP/SIOCGHWTSTAMP.
    
    Separate these from the few drivers that use ndo_do_ioctl to
    implement SIOCBOND, SIOCBR and SIOCWANDEV commands.

Also, if i find a bug like this, i often wounder if there are more
instances of the same bug somewhere else. I did a quick grep and it
does seem to be the only case. If you did the same check, it would be
nice to mention this in the commit message, maybe below the --- marker
so it does not become part of the permanent history in git.

    Andrew

