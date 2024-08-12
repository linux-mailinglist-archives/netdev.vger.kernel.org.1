Return-Path: <netdev+bounces-117843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D476B94F88A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 22:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700CAB213EF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CEC1991D5;
	Mon, 12 Aug 2024 20:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585931991CE;
	Mon, 12 Aug 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495759; cv=none; b=G3j7Q/rrQyXMjBl7n2doV/SGdKor0aMhR8V356nbZQyAxiVLog2stdx9TbJSizefyU+F8UKIgFf030odK3e0fIOZiBG3PmSbrOGSa1lD9T3DD/fHM/t/VUc4ipmj1nCIpbAx99TTFTXHfw6nOj3hMcHydC2Ua6ABzgwT8GbCQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495759; c=relaxed/simple;
	bh=dW9SOqY+cqjrVtEjhErOJJqI719L+mbquzKIzGLFTLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ziuqo1ofgT57SdCbJbR7DUvhw2dWYM+PbD3P1E/K5jI0NoIva8NfVmwWamX3XNGM6LjXbmN8GgA6sjoqihQDVf7QFaImZM4xUlaTgmtmZjSa4KHwEK23tiYRQnHo5tsXVqzGPDS8pdH/4k8FWF6fy32eybF2ftRe0SJy1OvVTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sdbye-000000001Yf-21y7;
	Mon, 12 Aug 2024 20:49:16 +0000
Date: Mon, 12 Aug 2024 21:49:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 3/3] net: ag71xx: use devm for register_netdev
Message-ID: <Zrp1SRpgsDLpTq9R@makrotopia.org>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190700.14270-4-rosenp@gmail.com>

On Mon, Aug 12, 2024 at 12:06:53PM -0700, Rosen Penev wrote:
> Allows completely removing the remove function. Nothing is being done
> manually now.
> 
> Tested on TP-LINK Archer C7v2.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

