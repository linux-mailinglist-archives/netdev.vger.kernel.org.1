Return-Path: <netdev+bounces-150219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C959E97EA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08298283B2B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A871A2392;
	Mon,  9 Dec 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3+kMAkn9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B61A23B0
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752564; cv=none; b=SygXkyhXlPDuD98E876bo1vxYFAvmUmyFSC/72T9pmXtNxN2muaBt7xtufQvB2Qb7GtYnu2FBSJFXbxqPvdGEBMDMbmQoAPnbolk1enMLqYrNorKEWOsuhqrbJ6MhsEJU1BX208KUkuLqFYX4/a6gIjQuYFKPJtwOhwA0lY+OFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752564; c=relaxed/simple;
	bh=FuIOPoG2+BZZMbEfINe6+9SCzdyeymvOXCXu3ohDOjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWli8XWh2ZF9gLebtrHKjjzn8LjLb8BW1fu5pUgE/+IsZnXwGVPz2WoHG4dVPnrad/7yEOCyaD/rEkh+FFxqJ5Z0YQ3YPe5CVPofEVGMG5QG0ChZQye6A4cxMwR3pypwjW+WnskmMnHAAFbdICOPtIp76BKgnhw+V2vGSJy4L5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3+kMAkn9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SRJBNIZckzN2KXNrxnqYLNNc05fyPmMRA2fz51FS1N4=; b=3+kMAkn9kc9x9fLT1aoUsntC5z
	Ew1DZH/28dTnMjpljE2lxhPUPhsVXEAgcsRh53/6ffWZwWRwijYpuSaioTrvN2AKgfNWtqHzD8yGp
	h1GKGPkomQlE/QyXK4+ROa2D43p8hkZXmZ7goT0CtJvLE1dcHVKzpm7i7yn7KDmUcji0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKeEx-00FfzI-Hj; Mon, 09 Dec 2024 14:55:59 +0100
Date: Mon, 9 Dec 2024 14:55:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 15/16] net-next/yunsilicon: Add ndo_set_mac_address
Message-ID: <f84ad3c2-ef22-47b6-bc10-b7e8fdfb1ca0@lunn.ch>
References: <20241209071101.3392590-16-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-16-tianx@yunsilicon.com>

On Mon, Dec 09, 2024 at 03:11:00PM +0800, Tian Xin wrote:
> From: Xin Tian <tianx@yunsilicon.com>
> 
> Add ndo_set_mac_address
> 
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> ---
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |   4 +
>  .../net/ethernet/yunsilicon/xsc/net/main.c    |  48 ++++-----
>  .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
>  .../net/ethernet/yunsilicon/xsc/pci/vport.c   | 102 ++++++++++++++++++
>  4 files changed, 130 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
> 
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> index 979e3b150..8da471f02 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> +++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
> @@ -613,6 +613,10 @@ void xsc_core_frag_buf_free(struct xsc_core_device *xdev, struct xsc_frag_buf *b
>  int xsc_register_interface(struct xsc_interface *intf);
>  void xsc_unregister_interface(struct xsc_interface *intf);
>  
> +u8 xsc_core_query_vport_state(struct xsc_core_device *dev, u16 vport);
> +int xsc_core_modify_nic_vport_mac_address(struct xsc_core_device *dev,
> +					  u16 vport, u8 *addr, bool perm_mac);
> +
>  static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
>  {
>  	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> index a3b557cc5..1861b10a8 100644
> --- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> +++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
> @@ -1349,37 +1349,13 @@ static void xsc_eth_sw_deinit(struct xsc_adapter *adapter)
>  	return xsc_eth_close_channels(adapter);
>  }
>  
> -static int _xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod,
> -				  u16 vport, void *out, int outlen)
> -{
> -	struct xsc_query_vport_state_in in;
> -
> -	memset(&in, 0, sizeof(in));
> -	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
> -	in.vport_number = cpu_to_be16(vport);
> -	if (vport)
> -		in.other_vport = 1;
> -
> -	return xsc_cmd_exec(dev, &in, sizeof(in), out, outlen);
> -}
> -
> -static u8 xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod, u16 vport)
> -{
> -	struct xsc_query_vport_state_out out;
> -
> -	memset(&out, 0, sizeof(out));
> -	_xsc_query_vport_state(dev, opmod, vport, &out, sizeof(out));
> -
> -	return out.state;
> -}
> -

More code which appears to of been added in the wrong place to start
with, and now gets moved.

	Andrew

