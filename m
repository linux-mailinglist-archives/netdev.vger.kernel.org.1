Return-Path: <netdev+bounces-107709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376491C09A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BFF1C202ED
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B141BF305;
	Fri, 28 Jun 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="weuF2p3A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15015886A
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584087; cv=none; b=i+R4WO9pREGU3+9siA3vyoRx46ZfT3RkNkdl7dht6BM8Aug9EfU3awQpCxsj1pbI7i547m26UsYgQYCX+yHHnyvvs+GNnRHE93jdZngpbm6CU9+HdUQXqXAX4sjAjuSJSNsLdaqoYHGOr+KXd69UDqnolRCKfySV0u0WbQv+cN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584087; c=relaxed/simple;
	bh=YrYZ0YECxZULbshtU+6CRzEJlWgp4TpccVySBzYaM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW4YWnEEg7OfF6MWmPYrhy18DhUtDw3QUU9zRQ8SFHHaF2UH0VyEFZ02iwFi8aKvyNpt9Tghz4JpB/J+4ORmrw5P+pGDnWVU9Ur4MXS3wbrq0PtxdZM6a9MYZFHt2J6rl6VX63ux54wFu0zwsbzGZFHO1C/3zd2GvWKr3QqBG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=weuF2p3A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YJLEh/Qt8RkmnwHV88glNWkkO2RuFr9YmOYosi9tpzE=; b=weuF2p3A4hDelQPBhyGbQTQWxY
	UW9a+xMViwKDdnM3fPrjy9mrLG41Edf6nAKxIyEYVz58ahXw+Avp822ibz/YRRItClljIu7RyYpJu
	v2VokAV6TeHaJTjAQnotM0+aN0x8tNZAG4/jfPWPwdlNAw8mqt4+n35jWIkxRlk6AzKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sNCNA-001I2d-3k; Fri, 28 Jun 2024 16:14:44 +0200
Date: Fri, 28 Jun 2024 16:14:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk
Subject: Re: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
Message-ID: <fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
References: <20240628134116.120209-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628134116.120209-1-fujita.tomonori@gmail.com>

On Fri, Jun 28, 2024 at 10:41:16PM +0900, FUJITA Tomonori wrote:
> Call phylink_ethtool_ksettings_get() for get_link_ksettings method and
> ethtool_op_get_link() for get_link method.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  drivers/net/ethernet/tehuti/tn40.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> index 11db9fde11fe..565b72537efa 100644
> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -1571,6 +1571,19 @@ static const struct net_device_ops tn40_netdev_ops = {
>  	.ndo_vlan_rx_kill_vid = tn40_vlan_rx_kill_vid,
>  };
>  
> +static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
> +					   struct ethtool_link_ksettings *cmd)
> +{
> +	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
> +}

Have you tried implementing tn40_ethtool_set_link_ksettings() in the
same way?

This patch is however O.K. as is:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

