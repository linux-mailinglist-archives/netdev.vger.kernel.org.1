Return-Path: <netdev+bounces-159671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A379A1656E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 03:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6CE1887E1D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9D91BC20;
	Mon, 20 Jan 2025 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MuqiZ1H9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A77DA67;
	Mon, 20 Jan 2025 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737340777; cv=none; b=oDggCifYVSx/l1Yn6g3rkxLv7hhydwlwmXKD4p3U6YrL19kOBHB1h7KCZ2/siHQRAwH5enEpaUyRjVyOhVF1uK6eiqmVS4R5RCwg2DUXhA5hXd87dzUZBK/u3steGr5ZleFwAzbT57iZQ9m/QXEzqoHGkuOTNZ3DnpKKG8YBWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737340777; c=relaxed/simple;
	bh=xgh/sgoLZub6NYdxB+Q1kf4ERM0Ong2UIryGmVWjFcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFsyIpVVWwW3eMZdzEUR34yVTFoz2UJdWPYL1pDbTlYCr0SZXTNu/Qx64YBlhalafhfOyVEjpgzhIejr25qQPNdYZcCoAmHM25GRyR7Mq2N0PmJCGkDcsd2MAOfIiosS+lTkrM0KYpNb/iNgO4ezShJdng21ZZC1Fftv4oqaOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MuqiZ1H9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OYcUHU0LxUMVrY7U7H2NKNNOolff0sPd5I3rEOmwrts=; b=MuqiZ1H906owYEkEta5auTEITL
	TD3IFlF1OF9CNWpaFa0C4fDb/eMshIXaSvykKEpfvUxapCdFI6oUUL6gixPexw2BTmqZTOps2fyD0
	Xt4ihJ6Y+8JjI0A2/7OpV6a+85u3EAH7IioOUZDniGrjXvuBtSisgrThacLP5wMvKz0I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tZhh8-006DHF-BM; Mon, 20 Jan 2025 03:39:18 +0100
Date: Mon, 20 Jan 2025 03:39:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Message-ID: <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
 <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>

On Mon, Jan 20, 2025 at 01:49:12PM +1300, Aryan Srivastava wrote:
> Currently the DSA framework will HW offload any bridge port if there is
> a driver available to support HW offloading. This may not always be the
> preferred case. In cases where it is preferred that all traffic still
> hit the CPU, do software bridging instead.
> 
> To prevent HW bridging (and potential CPU bypass), make the DSA
> framework aware of the devlink port function attr, bridge_offload, and
> add a matching field to the port struct. Add get/set functions to
> configure the field, and use this field to condition HW config for
> offloading a bridge port.

This is not a very convincing description. What is your real use case
for not offloading?

> 
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> ---
>  include/net/dsa.h |  1 +
>  net/dsa/devlink.c | 27 ++++++++++++++++++++++++++-
>  net/dsa/dsa.c     |  1 +
>  net/dsa/port.c    |  3 ++-
>  4 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index a0a9481c52c2..9ee2d7ccfff8 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -291,6 +291,7 @@ struct dsa_port {
>  
>  	struct device_node	*dn;
>  	unsigned int		ageing_time;
> +	bool bridge_offloading;

Indentation is not consistent here.

net-next is closed for the merge window. 

    Andrew

---
pw-bot: cr

