Return-Path: <netdev+bounces-208094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F5B09CAE
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5CE1882DE1
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C24267B92;
	Fri, 18 Jul 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arqT0TdH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60046267B9B;
	Fri, 18 Jul 2025 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824154; cv=none; b=VOhkuw5PITQErqxdOngEFMsVfhW7yM8b+zYAfDNaxfVAsTFb81kJjgIwtquEYSmEaScSaVWJKTfO/+mzydWqaNWGcPAL5f3+yr37BcZiWHKE5D6UG18BHNnXC+zn2VSHDYvEGS46PZEqPpqp8zqnBW4mvJMTC8hXdxiGNT6adqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824154; c=relaxed/simple;
	bh=QkFe2+JwyTLcWjFbzAYDT7Cu5exwo4dOChGw4Nhy0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8FGoChPmgPOiSjZMNBAEhoJvhIUhkbSmY096ciFymPB4zLZ5B1nAxz3hJKzEW+Bd7jUdtIMTWVZ/3/FQm+rpEYKtzddgnz7ORhtJlcUrmHAdyCBCSOKtVDirwJ5P/oMWnjZQaCmTL0ITrnqHZSJlnLQQCDFAkuT/oF5R2JscDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arqT0TdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457ABC4CEED;
	Fri, 18 Jul 2025 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752824153;
	bh=QkFe2+JwyTLcWjFbzAYDT7Cu5exwo4dOChGw4Nhy0Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arqT0TdHUIeaJ4ur/xaN+8/XQusOWMjEDizwU4JAFqDutjjvgaomxKZ1nl0UgYl6l
	 sHY6dM0TyV3383s75PaYSzcDOxNR4tYvQSvSGCS6Yz1n6TbINhF/kAm170SXOjiObp
	 O31O5LFQOPGFiUrm56tMQmPvObc7GyPdiMa9SC/paXwWW+EytPc1mcziqlB1LGxgmu
	 ZZSBbkipFVdOXyvZSa8ErlTg9VIDYz7SbjAWXXdak1uoFJ5LNNesFV9hQFGWPg0fnW
	 Haq/rL25VsnRnkwwr1qknfw0J/a+FvZJEA/m2LpTWfZgr0JYeLzA1xzn20jubzQNhK
	 cHfENdz4dRkFw==
Date: Fri, 18 Jul 2025 08:35:49 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, razor@blackwall.org,
	idosch@nvidia.com, petrm@nvidia.com, menglong8.dong@gmail.com,
	daniel@iogearbox.net, martin.lau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/4] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
Message-ID: <20250718073549.GH27043@horms.kernel.org>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
 <20250717115412.11424-3-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115412.11424-3-richardbgobert@gmail.com>

On Thu, Jul 17, 2025 at 01:54:10PM +0200, Richard Gobert wrote:

...

> @@ -4596,7 +4615,9 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put_u8(skb, IFLA_VXLAN_REMCSUM_RX,
>  		       !!(vxlan->cfg.flags & VXLAN_F_REMCSUM_RX)) ||
>  	    nla_put_u8(skb, IFLA_VXLAN_LOCALBYPASS,
> -		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)))
> +		       !!(vxlan->cfg.flags & VXLAN_F_LOCALBYPASS)) ||
> +		nla_put_u8(skb, IFLA_VXLAN_LOCALBIND,
> +			   !!(vxlan->cfg.flags & VXLAN_F_LOCALBIND)))

nit: the indentation of the above two lines seems inconsistent with those
     above them - I think it should be a tab and four spaces, rather than
     two tabs.

>  		goto nla_put_failure;
>  
>  	if (nla_put(skb, IFLA_VXLAN_PORT_RANGE, sizeof(ports), &ports))

...

