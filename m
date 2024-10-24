Return-Path: <netdev+bounces-138486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9C9ADD85
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2B4B21A33
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA518A956;
	Thu, 24 Oct 2024 07:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DDC16DEB5
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754767; cv=none; b=OzWpE2TQJGy73+3hbgm4cAhKeDegswPnYG97fIG55PHAClMiMGGLY9sg1g78BVpJOBLHSO8Yi1uaamMD7Jle+0bJKUWNGgpoiHcSejYcMR4gMYuRxlxpZjtocWCExft8WaRPExHuEH4BXcY29sStMeCW8S7bJLu+2zVrqoZQo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754767; c=relaxed/simple;
	bh=R9deXjWHBVLcV8fFK0A52eottkXW1MLRhMTopuyXxc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Mi9n7tfNsW48CcjtfplRh/s1SFWYRmHg9pbazWy1YdIWjkI04igTgwerfMLQzCFg9PiWNVWk1W2Um7iUTkSgPCMLYqgc2tZgxrT+Cetv5DrK8g3Nv6hFFzjFfs+H/98UcIwOOOd2HpgSSnv5WWpTuWrXl3a4TX/B8/3S9tFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t3sEI-0002Kx-7h; Thu, 24 Oct 2024 09:25:58 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t3sEC-000A3M-0f;
	Thu, 24 Oct 2024 09:25:52 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t3sEC-00B6Ja-0L;
	Thu, 24 Oct 2024 09:25:52 +0200
Date: Thu, 24 Oct 2024 09:25:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net,
	kory.maincent@bootlin.com, horms@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [PATCH net 2/2] net: pse-pd: Add missing of_node_get() before
 of_find_node_by_name()
Message-ID: <Zxn2gHDHRhqnyFFx@pengutronix.de>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-3-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024015909.58654-3-zhangzekun11@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Oct 24, 2024 at 09:59:09AM +0800, Zhang Zekun wrote:
> of_find_node_by_name() will decrease the refount of the device_node.
> So, get the device_node before passing to it.
> 
> Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

