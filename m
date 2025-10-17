Return-Path: <netdev+bounces-230359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5875BE6FA4
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43E3545FA9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0757823BD06;
	Fri, 17 Oct 2025 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kmC517HF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D323AB98;
	Fri, 17 Oct 2025 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686883; cv=none; b=LgS6qoklrQQ8tzul+D76xnPlGXKrvqFB2HQTTar9O+IUwZzWMNtbN+qhxzXFwumFrW7j7XI1ObSsHXYyA022OXfQ29YBslD9El9zsPzhrazjdwOOrtX5jE8WUxiPh0LazxLYuU3pCPGrDQ9aeUaqtsJH/otOzz7nl0Cd1UNHzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686883; c=relaxed/simple;
	bh=k28j/cY0o1c6CApdJrdkT4hyekVTeYH1pZD3ZM9FMIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axZF2Yjt8MOBWS4hws+VXAs/rMe96/TgL/QYESOnIPYFz07PA1bVhzMsSqsvKC2CfEU57LhU0UP7Lh3y3iR1KjA1zcCJ3XRc0TSvSTMNjln6hECQ51n2I/+lgu9R0wTZwhRRMOA8X7CPlm2HHOmpCg6PjfepIW4u3HO+H5DmPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kmC517HF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8BBEF4E40B36;
	Fri, 17 Oct 2025 07:41:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5957F606DB;
	Fri, 17 Oct 2025 07:41:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 803E4102F2334;
	Fri, 17 Oct 2025 09:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760686879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VX7GP8oohyF3dyuDoiAgWrPjx6bOSi6RJBB6J06GFiM=;
	b=kmC517HFbZScjlehfud3oDP6g69BdC06DjtToA75prfaAXeD7Xq3ruUWPChEEVj69xkJrU
	YrNFh8qGDLHLmVvvE1+pBv8RlwORovJxDINA92uG8LHtpjAaapa9JM5v2IghkCihLGS2f6
	lLYG8j/RBKOcXHShHwwvz2hrm9RdQhLeGaViG1mP6kQ7Eh5on4JwTll8QnNYlLu4GkRkjO
	Y8ywR2LBeBg4KETkN838vRz2s4cQTbC3qmELbTq5WD+bhx1oFkRmiv43JmzlBlwHVXYUS2
	Kq79u8ah2ozEIeDRcV8lSdEpEN6G9eeUA8GKx8RA8OIL0eYR6w/41Dqboxcojg==
Message-ID: <0adaf9b2-2cfa-4d32-a8fd-1aef53bb2a78@bootlin.com>
Date: Fri, 17 Oct 2025 09:41:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] phy: mscc: Fix PTP for VSC8574 and VSC8572
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com,
 vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
 christophe.jaillet@wanadoo.fr, rosenp@gmail.com, steen.hegelund@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
 <20251017064819.3048793-3-horatiu.vultur@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251017064819.3048793-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Horatiu,

On 17/10/2025 08:48, Horatiu Vultur wrote:
> The PTP initialization is two-step. First part are the function
> vsc8584_ptp_probe_once() and vsc8584_ptp_probe() at probe time which
> initialize the locks, queues, creates the PTP device. The second part is
> the function vsc8584_ptp_init() at config_init() time which initialize
> PTP in the HW.
> 
> For VSC8574 and VSC8572, the PTP initialization is incomplete. It is
> missing the first part but it makes the second part. Meaning that the
> ptp_clock_register() is never called.
> 
> There is no crash without the first part when enabling PTP but this is
> unexpected because some PHys have PTP functionality exposed by the
> driver and some don't even though they share the same PTP clock PTP.
> 
> Fixes: 774626fa440e ("net: phy: mscc: Add PTP support for 2 more VSC PHYs")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>


