Return-Path: <netdev+bounces-116375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D894A3C7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2232282968
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AF1C9EC6;
	Wed,  7 Aug 2024 09:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8623CE
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021837; cv=none; b=R/d3/qJXlwpte0jfddI4wa2dcuB0pagCgx3fc82s2ahMmWHqpBnwTWKtdz7mK2gAtJwBvoj+LpIh73tA2kDqiFwltRqnj6MiUVbrdVCDJ4uZooWhlWbMQM3zRFR12LaO/upOGKj+CXTALaXgg/Muny2/5anYpAPKZ5B5typYgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021837; c=relaxed/simple;
	bh=0l8Vmzby5rAmaTXV1dW8oKUqfO+hPnaXxfhZiWhrJQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO78P9m+I5BCSs/DQmgWbCrVsVa1a/6i9wIh8K2IPaUm+gK0cG5CvGZuf+nkCO5dKoPfog9UU3UV11UqxsNAQMjglXxX+8g6V+UWPU9usbCnbFtnRhNXYd3Ez+ml8OIWelzdTH/prs8/ooLxRyKD21xnpR7cQcehBfBWBz1a+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcgP-0005uY-38; Wed, 07 Aug 2024 11:10:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcgJ-0059hx-Eb; Wed, 07 Aug 2024 11:10:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbcgJ-006tOe-13;
	Wed, 07 Aug 2024 11:10:07 +0200
Date: Wed, 7 Aug 2024 11:10:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: 'Guanjun' <guanjun@linux.alibaba.com>
Cc: kyle.swenson@est.tech, kory.maincent@bootlin.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: =?utf-8?Q?ps?=
 =?utf-8?Q?e-pd=3A_tps23881=3A_Fix_the_compiler_error_about_implicit_decla?=
 =?utf-8?Q?ration_of_function_=E2=80=98FIELD=5FGET=E2=80=99?=
Message-ID: <ZrM570f3dUxPm-Bm@pengutronix.de>
References: <20240807071538.569784-1-guanjun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807071538.569784-1-guanjun@linux.alibaba.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 07, 2024 at 03:15:38PM +0800, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
> 
> bitfield.h is not explicitly included but it is required for FIELD_GET.
> There will be a compiler error:
>   drivers/net/pse-pd/tps23881.c: In function ‘tps23881_i2c_probe’:
>   drivers/net/pse-pd/tps23881.c:755:6: error: implicit declaration of function ‘FIELD_GET’ [-Werror=implicit-function-declaration]
>     755 |  if (FIELD_GET(TPS23881_REG_DEVID_MASK, ret) != TPS23881_DEVICE_ID) {
>         |      ^~~~~~~~~
>   cc1: some warnings being treated as errors
> 
> Fixes: 89108cb5c285 (net: pse-pd: tps23881: Fix the device ID check)
> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

