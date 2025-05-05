Return-Path: <netdev+bounces-187773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B330AA992D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CC01754D3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8679199FAB;
	Mon,  5 May 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FDB8Tlk+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3719341F;
	Mon,  5 May 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462956; cv=none; b=FBei3VDft5OICD+4NjpWBuHuDS/1NU/ejWQjXpDJaPOfANIAS3QwuU5d4psG0uEi0UkI7K+ukNuScIrFJneE9sxw9ZrzCmd/+YEx/a1p+EJ5M/IjZUDswX/u9NcYpLfex4MlJoiQjb8Gmp0u6G1NiPJQ0+xltdcpn1dd4NMlBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462956; c=relaxed/simple;
	bh=SN3LEvOozy9YYjogVFFZMv66Vs1R7d/I7uPJaAfKHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4sftIUiJ4tdJtv2K5RSBI7lSA5YnCQNQL+zMhTUPsP4syIW0cVWTLKZrrrwOS0m2UEuIlH6eDN4s3AJSJdrL4o17K6jxzsGBxJSLbJHqTL84E3Ig/kyHzvG1ZhqtW7TGMlwEwOZ2s0ms4h20G6Sq7H4BBVaUKccgQoo5DK4SIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FDB8Tlk+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ps5XORoy5MluWSPT6nmEp/fadh/2kzupywrUCthCbkM=; b=FDB8Tlk+ubkAocR0FYvBOlxfN+
	9jJyPMdqMwL9Z+fWyr3PFSn2s4JV+eZ3++bCpzWu0vSAFN42D74SHQfqYMKjfj9gxXLQuLkq7One/
	5+vczXCA6fIOREt+kb5fKZLt6WGaqPQVDPbxWzl7y3QdRz80ujcHUjXJTHZSqZnBQMxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uBynE-00BcB6-4v; Mon, 05 May 2025 18:35:48 +0200
Date: Mon, 5 May 2025 18:35:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: vertexcom: mse102x: Drop invalid cmd
 stats
Message-ID: <fdac2206-86ad-4d07-9aea-ef88820dfc88@lunn.ch>
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-4-wahrenst@gmx.net>

On Mon, May 05, 2025 at 04:24:25PM +0200, Stefan Wahren wrote:
> The SPI implementation on the MSE102x MCU is in software, as a result
> it cannot reply to SPI commands in busy state and increase the invalid
> command counter. So drop the confusing statistics about "invalid" command
> replies.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/vertexcom/mse102x.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
> index 33371438aa17..204ce8bdbaf8 100644
> --- a/drivers/net/ethernet/vertexcom/mse102x.c
> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
> @@ -45,7 +45,6 @@
>  
>  struct mse102x_stats {
>  	u64 xfer_err;
> -	u64 invalid_cmd;
>  	u64 invalid_ctr;
>  	u64 invalid_dft;
>  	u64 invalid_len;
> @@ -56,7 +55,6 @@ struct mse102x_stats {
>  
>  static const char mse102x_gstrings_stats[][ETH_GSTRING_LEN] = {
>  	"SPI transfer errors",
> -	"Invalid command",
>  	"Invalid CTR",
>  	"Invalid DFT",
>  	"Invalid frame length",
> @@ -194,7 +192,6 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *mse, u8 *rxb)
>  	} else if (*cmd != cpu_to_be16(DET_CMD)) {
>  		net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
>  				    __func__, *cmd);
> -		mse->stats.invalid_cmd++;

If the net_dbg_ratelimited() is going to stay, maybe rename the
counter to unexpct_rsp, or similar?

	Andrew

