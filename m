Return-Path: <netdev+bounces-238688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F0C5DA64
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32F033607B8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11532B9B9;
	Fri, 14 Nov 2025 14:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DA326D76
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130495; cv=none; b=giM5pc0dPcFxaIV+6px73b4Fnk17jsG0Qu3HxYpM7I2jrIVeB+SrxaKJlDo7A1Xqt3X5w3EDfUKZiPXtdzkgrHiuQQ93Az8Me5lFCd0bHlQ31awafD+b8vhkOje1qBGgoVX02PzNvKExK3/VvfsS5OcqF1DNj1JR3M0TeveyB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130495; c=relaxed/simple;
	bh=5NYO8c/labYquofE4JgMA3Bw2DbW4rxzSW2Y+fx6w2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgdUu95rzezac1hokhmeCmyf2i4z6GhKVJxR8UCBBClY7PZQRVzdTsG6t5xhSljnJnNHZ5lvpsnyXBte1ABA60WSlUSZW5aTe8s9T0F1R0E3+zA0gJ5gc0fTshanTFkdGWMmiH8wpZTWgt2OckZgoCQ7fdn1/Ueb1Ek/R1usV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vJuRK-000000003Zo-2Iyw;
	Fri, 14 Nov 2025 14:06:14 +0000
Date: Fri, 14 Nov 2025 14:06:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Peter Enderborg <peterend@axis.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH for net-next] if_ether.h: Clarify ethertype validity for
 gsw1xx dsa
Message-ID: <aRc3U29wVvZEG0zv@makrotopia.org>
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

Thank you!

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

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
>  #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
>  #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
>  #define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
> -- 
> 2.34.1
> 

