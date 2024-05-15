Return-Path: <netdev+bounces-96599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FED8C699B
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D922825F1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1C15574D;
	Wed, 15 May 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG1JAc5X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6162A02
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786687; cv=none; b=mLX6aWB6+CL5zF+rbW60cy+kPL35I2CT0DMvLpy/0TF/SN7KnNZ0azq9So0xDtSFgWj2qg6JVM7/DxZAjRV4mYDk9g91hBcRyUYsznMPXuA4U4uUeqkXItCIS1bJU3bC0AFzUNlcRPw+FHy4iHWotN7M1yHvEBmcCOiGxMS2RlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786687; c=relaxed/simple;
	bh=Dqdq8kCCShqQZUG0983dcBrTGziOnRdSUphm/+wFrnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyiinRH42Ifgfux9bxPGUE5Af37CkWGVAMpWlxThuvotz2XMe2cJ/iDXkHSnYPZSwbEqZIJd4VG5KVAvxhLXrBVLe6sPmqZq2CVpKPDTxQxksR+FuY62TeFImVGOttg7EYC1dSDvNz4Rx7DjnVtGAGaf/eM0hWueNCbk/GQvy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG1JAc5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E01C116B1;
	Wed, 15 May 2024 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715786686;
	bh=Dqdq8kCCShqQZUG0983dcBrTGziOnRdSUphm/+wFrnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG1JAc5XCQGOdHgjklK4JQC5qZxMhUl6u8b80yrB713PoW5+BFAV4M9DVGxYpWrii
	 vFDpuOCE7wJC+ITJfZtacrviGVDUQYeQgJFGr3KmSdq2yymeP1OFbBc5CjQUDXt9a4
	 p/G1LtlfYwRMtbA51YQ95vUkuvfrHabF4gUCaWHa/GbGNz0zFb5HgFy+utIAF9Xjyb
	 KRKwnym1jjYjGGEXbfvQSiLFHWHLFDhBR8+mXS4i3C3YbHjYWf0RbyQw5fOnoqQLH9
	 nQ4MbdzztuamKvAvD8G8FWlIs/IrrVBavsGjWqJFvFosuw20zu1ulUsMOkymEcU/eW
	 XfE5CUAnoIgmQ==
Date: Wed, 15 May 2024 16:24:43 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 4/6] net: libwx: Add msg task func
Message-ID: <20240515152443.GN154012@kernel.org>
References: <20240515100830.32920-1-mengyuanlou@net-swift.com>
 <50864E85C9DB3EB1+20240515100830.32920-5-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50864E85C9DB3EB1+20240515100830.32920-5-mengyuanlou@net-swift.com>

On Wed, May 15, 2024 at 05:50:07PM +0800, Mengyuan Lou wrote:
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c

...

> +static inline void wx_ping_vf(struct wx *wx, int vf)
> +{
> +	u32 ping;
> +
> +	ping = WX_PF_CONTROL_MSG;
> +	if (wx->vfinfo[vf].clear_to_send)
> +		ping |= WX_VT_MSGTYPE_CTS;
> +	wx_write_mbx_pf(wx, &ping, 1, vf);
> +}

Please avoid using the static keyword for functions in .c files,
unless there is a demonstrable reason to do so. Generally the
compiler can figure out when best to inline functions.

Also, wx_ping_vf does not seem to be used until PATCH 6/6.
If so, it would be best to add it as part of that patch.

> +
> +/**
> + * wx_set_vf_rx_tx - Set VF rx tx
> + * @wx: Pointer to wx struct
> + * @vf: VF identifier
> + *
> + * Set or reset correct transmit and receive for vf
> + **/

...

