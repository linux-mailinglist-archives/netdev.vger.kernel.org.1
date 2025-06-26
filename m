Return-Path: <netdev+bounces-201468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C88AE985B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA0C3B073E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BD28FFD0;
	Thu, 26 Jun 2025 08:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F6218AB0
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926726; cv=none; b=doTMwmETUz1z4sYcBvfrvvUpWw1qHYcypiqN99CZg2aT3TAeyxQPaP4zlDSMo+7S+iQBo0XTc04PZuQ/QSQRb4uz27EgvORdqwzdka3r+UW2cJBF0lTZWpJtRaQVG3lmlJf57cLRwcW5WNUPSdsDSIfBCzijQks0jyTQ38kUeiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926726; c=relaxed/simple;
	bh=uP/rFDx8e9z3sNXc4VRTDpBmgU3yeg67Y/han+fosNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhkU8/31LEUV2rROH6Q3ELz0oRXviSvTKjmrREhwtYubRrttUrXIKgTtSegaKSa4kEMrkQKlw4vctloTNb99wccWfogsNvpwV+/t9C6yCBIpan3WQ/1OyJdfAXGRBv/h+dSpT696JMTYhPp3pVp+PbOu5j2WbyPwHlL1kkPyTFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uUi1Y-0000AH-3U; Thu, 26 Jun 2025 10:32:00 +0200
Message-ID: <f2647407-3de0-4afd-bc79-5b58e13f10aa@pengutronix.de>
Date: Thu, 26 Jun 2025 10:33:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: allow disable coalescing
To: Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
 <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <d60808b3-eb20-40ab-b952-d9cd8d8d68a7@lunn.ch>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <d60808b3-eb20-40ab-b952-d9cd8d8d68a7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Andrew,

On 2025-06-26 10:12, Andrew Lunn wrote:
> On Thu, Jun 26, 2025 at 02:36:37AM +0000, Wei Fang wrote:
>>>
>>> -       /* Must be greater than zero to avoid unpredictable behavior */
>>> -       if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
>>> -           !fep->tx_time_itr || !fep->tx_pkts_itr)
>>> -               return;
> 
> Hi Wei
> 
> When i see a comment like this being removed, i wounder if there is
> any danger of side effects? Do you know what is being done here is
> actually safe, for all the different versions of the FEC which support
> coalescence?

For reference, this comment is taken in plain from section 11.6.4.1.16.3
in the i.MX 8M Plus Applications Processor Reference Manual (and is the
same for the 6UL).

I was also worried about this so I made sure that in any case where
either of those is zero, the coalescing enable bit (FEC_ITR_EN) is
explicitly disabled.

fec_enet_itr_coal_set is only ever called if FEC_QUIRK_HAS_COALESCE is
set and for those models, we expect disabling coalescing via FEC_ITR_EN
-- and consequently also setting the parameters to zero -- to be
unproblematic. This is also the reset default.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

