Return-Path: <netdev+bounces-13144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F3773A728
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA021C2116A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72732200C4;
	Thu, 22 Jun 2023 17:24:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F21F16A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A05C433C8;
	Thu, 22 Jun 2023 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687454681;
	bh=peGmVPowJipNJQIy5eFE+8/1j762NisvMXMysKsQirg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=emNWI80aveU4MMQYLu6bh6YNOJ4RvcibldjrVm0aKqk9j74umkrktA0nPRt2EowtG
	 8QzaZY7gOma7IqFVcaeJZRBecy/9ob8gBGP3c6HvbRjphwnLxLpoERZNf17hlpp1nE
	 U3TmgjbFDbXNTwBBKIGNeqZ9vp7ESqPh6I3USotgddg+nnRYKHhAHRYGykOENWwVii
	 KBKjGgAISKesc+vJv1mCHWqGlOG5TsrnSQ5Q4AAzSBaLI0VK4jeKgLudWwCk+n3lm3
	 pKxonCtumBoGl7Lj5yUHLeFif8+5ysme83P6/KsI1/fC7ywRvmRx4K2dj/lH2lhib4
	 2GoIC2GDi+z0w==
Date: Thu, 22 Jun 2023 10:24:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <20230622102440.60d18020@kernel.org>
In-Reply-To: <20230621191302.1405623-2-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
	<20230621191302.1405623-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 21:12:58 +0200 Pawel Dembicki wrote:
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 30b1f0a36566..1552a9ca06ff 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -15,6 +15,7 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u8				forward_map[8];
>  };

kdoc missing here:

> drivers/net/dsa/vitesse-vsc73xx.h:20: warning: Function parameter or member 'forward_map' not described in 'vsc73xx'
-- 
pw-bot: cr

