Return-Path: <netdev+bounces-239641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB080C6ABBB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2C7052C129
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97D36B047;
	Tue, 18 Nov 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lh/WXSW3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9383368275;
	Tue, 18 Nov 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484608; cv=none; b=Gdap1eC4SaH5+6nYsHYgzE6s6MFAwMu0i0ecpoyPs4I4Psu7gvG6h0lQMLENM0i1UEkjwUyvcAMBS9GRsJdPqdp050D5g1/UvCNXTuldMTFowGeCRIbLMNt2Nf08ljO8v5+jZ5OS+VLyLXvgO0kk99kVieQu+mn0X23fRqmDZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484608; c=relaxed/simple;
	bh=Gz7C0zxUsuhxrC3g7BpdaXUBXOAX3bQB2zZJVmH2GzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTvJYpKS+JZMvid/ptEnGSR4p45w1RsTlbdbf9LuThUGlY/Q7bBgeYChweG9O1ZyfA6yzG5a8DL1G4Pe7+C3vG9/QoxrMB9g0RZ7NDyNmq08ivoUBX4tVuLUoHYxVT56tu3CJvylknTwYMbxAWsMjMLtQalvmlzobgl1qf14sIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lh/WXSW3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lGt66pGi8dt8iogorYeJbKaQNvOXL5mgOjSYNAZEHq8=; b=lh/WXSW3qZAsc4V5+gvZWY4g8Q
	sZtFG9V0gg+vsr2BGFXdM2CfYy0CQp3Xpc+WZHF3EepGQmPKV2SgCmsQhDD+J8UGwHMlDK0KDF6Is
	9YTJ5T7LzXGrhA3RtndhPpxQziLQF6z+dPVtjIExbGdm5PYSQlfYLkxPSV84PRZwkqXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLOtv-00ENKw-DZ; Tue, 18 Nov 2025 17:49:55 +0100
Date: Tue, 18 Nov 2025 17:49:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: yt921x: Fix MIB attribute table
Message-ID: <89a401dd-b6a9-4b1b-b323-10d713646e5d@lunn.ch>
References: <20251118091237.2208994-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118091237.2208994-1-mmyangfl@gmail.com>

On Tue, Nov 18, 2025 at 05:12:33PM +0800, David Yang wrote:
> There are holes in the MIB field I didn't notice, leading to wrong
> statistics after stress tests.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 944988e29127..97fc6085f4d0 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -56,13 +56,13 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
>  
>  	MIB_DESC(1, 0x30, NULL),	/* RxPktSz1024To1518 */
>  	MIB_DESC(1, 0x34, NULL),	/* RxPktSz1519ToMax */
> -	MIB_DESC(2, 0x38, NULL),	/* RxGoodBytes */
> -	/* 0x3c */
> +	/* 0x38 unused */
> +	MIB_DESC(2, 0x3c, NULL),	/* RxGoodBytes */

How is this described in the datasheet? Maybe add #defines for each
location? At could mean you don't need the comment, since the #define
documents what it is.

> @@ -705,7 +705,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			res = yt921x_reg_read(priv, reg + 4, &val1);
>  			if (res)
>  				break;
> -			val = ((u64)val0 << 32) | val1;
> +			val = ((u64)val1 << 32) | val0;

And that is a different thing, has nothing to do with holes. This
should be mentioned in the commit message.

    Andrew

---
pw-bot: cr

