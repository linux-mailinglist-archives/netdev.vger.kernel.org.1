Return-Path: <netdev+bounces-47244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED37E925F
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210A9B207EA
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C7171D0;
	Sun, 12 Nov 2023 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="szZ9wewA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0166D171BF
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 19:49:05 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7E136
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 11:49:03 -0800 (PST)
X-KPN-MessageId: 834f6a6f-8194-11ee-a95f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 834f6a6f-8194-11ee-a95f-005056abbe64;
	Sun, 12 Nov 2023 20:48:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=3jd54rheqa3eyCP/arjGA7QcvJs2dFziSLShsjjiCn0=;
	b=szZ9wewAu/jn4WymPNmz5KhWN5dD7D6nCmyQtUPE7+NbXbZZNNP2ChVzqZ2vigsFFr8Wk7AuAaVe6
	 UoHOwCkvQR62Ba1SOGF6vuEZHqf1MQc3AKwTOgG8NyOF9Hym3QYXuYzcrnyueaabfvjNK8MJpxGLVM
	 Ic4mnmvFCMmZXASY=
X-KPN-MID: 33|edFCny9RkDwt84PKJ10p5PLS1ThlEhUJmyCl4LcRGgsEdlFuVZvBSFLwLwR8Y2J
 ordB/I56xvu7HmaE5PM0DwAxNnwyKaXd3wdoONCtHxxA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|HuyiPhNq/BbYdYU7oXnOTPNRbMlJUPgf3hC28I7qSIoRBXMJNlm3CEgvnRtmXbE
 ZkqBrATfcccrf3JVGsuvTug==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 86b0c680-8194-11ee-b971-005056abf0db;
	Sun, 12 Nov 2023 20:49:02 +0100 (CET)
Date: Sun, 12 Nov 2023 20:49:00 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org,
	Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next 1/8] iptfs: config: add
 CONFIG_XFRM_IPTFS
Message-ID: <ZVEsLPhykZId7Opz@Antony2201.local>
References: <20231110113719.3055788-1-chopps@chopps.org>
 <20231110113719.3055788-2-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110113719.3055788-2-chopps@chopps.org>

On Fri, Nov 10, 2023 at 06:37:12AM -0500, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/Kconfig  | 9 +++++++++
>  net/xfrm/Makefile | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index 3adf31a83a79..d07852069e68 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -134,6 +134,15 @@ config NET_KEY_MIGRATE
>  
>  	  If unsure, say N.
>  
> +config XFRM_IPTFS
> +	bool "IPsec IPTFS (RFC 9347) encapsulation support"

RFC use "IP-TFS"?  in the text use consistanly. 


> +	depends on XFRM
> +	help
> +	  Information on the IPTFS encapsulation can be found
> +          in RFC 9347.

Add details what is actually supported when enabling this options. RFC 9347 
has several combinations. Are all combinations supported?

> +
> +          If unsure, say N.
> +
>  config XFRM_ESPINTCP
>  	bool
>  
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..9b870a3274a7 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -20,4 +20,5 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
> -- 
> 2.42.0
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

