Return-Path: <netdev+bounces-238875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F174C60ADE
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC504E05CD
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFBF2264BB;
	Sat, 15 Nov 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="urNslFF1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532E2236EE
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763239328; cv=none; b=t/K6UElPxj1GffCtu527DxgCfnggWazIwf+VWsEW/EnFCnxpjds4kA3Blogb//pFsD2iVFDjWzeCqoA1PfNSQpuUjLQcXi+jY+kQc/tOVNXvSsheH8M7QCKCnfokvPycUwOql5y5jriLebwKUZSnHYGIITDh0ZbM+yA+FtFEDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763239328; c=relaxed/simple;
	bh=TEUEDBQ9wvR2rwqjbs/8wmgdveq0gdq76vY6sxmpDNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l41naatI5tVAdECE9apzAIBcgsXM0+DwQHzBU14XNjKdkBnrla5/V4gEs3wxe/YaRiOW9bt2djaqPc7kjqu1PtBs3k0WDgWWkVfFTNBovoyVP0f31Uiv3UZYxxgsTLgXuONZoeIk1v741ghgj8o/Udb7XvSlAGMUMDx9eDX8YjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=urNslFF1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1zaSnpZY2j5WMcRbkVDFCfjcZk9eWGD3qEhdN9TGvx8=; b=urNslFF1iOYY3DrMW/ZDtFs8Go
	l0pnttuOFAcxVN4zZfcbEue1DgttGt2BRSHO7DKx4iwvuG6fypmL2JzopZBckqtZc18rdExn2s0nc
	3Z2gCH1oXHbaJl5qX14rX7A2kqezZhJVZvjk0asjlVT0f52uCyTG56HTj0+3fgzqGii4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKN5n-00E6vA-TD; Sat, 15 Nov 2025 21:41:55 +0100
Date: Sat, 15 Nov 2025 21:41:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Peter Enderborg <peterend@axis.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
Message-ID: <3feaff7a-fcec-49d9-a738-fa2e00439b28@lunn.ch>
References: <20251114135935.2710873-1-peterend@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114135935.2710873-1-peterend@axis.com>

On Fri, Nov 14, 2025 at 02:59:36PM +0100, Peter Enderborg wrote:
> This 0x88C3 is registered to Infineon Technologies Corporate Research ST
> and are used by MaxLinear. Infineon subsidiary Lantiq was acquired
> by Intel. MaxLinear bought IP's from Intel including this network chip.
> Ref https://standards-oui.ieee.org/ethertype/eth.txt
> 
> Signed-off-by: Peter Enderborg <peterend@axis.com>
> ---
>  include/uapi/linux/if_ether.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
> index 2c93b7b731c8..df9d44a11540 100644
> --- a/include/uapi/linux/if_ether.h
> +++ b/include/uapi/linux/if_ether.h
> @@ -92,7 +92,9 @@
>  #define ETH_P_ETHERCAT	0x88A4		/* EtherCAT			*/
>  #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
>  #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
> -#define ETH_P_MXLGSW	0x88C3		/* MaxLinear GSW DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
> +#define ETH_P_MXLGSW	0x88C3		/* Infineon Technologies Corporate Research ST
> +					 * Used by MaxLinear GSW DSA
> +					 */

Is this actually registered with IANA? 

https://www.iana.org/assignments/ieee-802-numbers/ieee-802-numbers.xhtml

Does not list it. Please keep the "NOT AN OFFICIALLY REGISTERED ID" if
it is not.

	Andrew

