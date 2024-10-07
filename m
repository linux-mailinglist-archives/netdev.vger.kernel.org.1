Return-Path: <netdev+bounces-132744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C653992F72
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE541C22AF2
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3041D9688;
	Mon,  7 Oct 2024 14:31:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9921D9661
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311460; cv=none; b=R6k3DBC+qQbEKT2ygB9nSkTuroESHNEJaCKKLFSxADskXf6doS8QTE4sLXKrCx7x+PobDGaKtm0dG70nJ+GyY3iNnXMKqwT4tYzm1R6/ZNfT1r2j73yejGemZgEm0ZR7W1JAqZO2ipPYBBzDon9320BnPPfN3n2RpfCmBDO2Ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311460; c=relaxed/simple;
	bh=Nd9+R+kP6/ZMEZeCsskVjMGZ4XQKjXVqgxsSyXWh8k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVuv9gTqbvdV1apmcAmrhyHLoQx7Rrf9LCeOjDF0qbHldi82rDJCs/3A2BVXlvvxBBt7l2N9ZvMALcIXm4nymr3vgUewTt7PXfTOEvdJomRWDTvsaxbcGVHAFs0u+EqOg96rvT6UelJb+tS65VKeUYrxW4STGaSiTrEJXH2gNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1sxol7-000153-L8; Mon, 07 Oct 2024 16:30:49 +0200
Message-ID: <13350842-4d40-480a-b33d-3f223fca6c63@pengutronix.de>
Date: Mon, 7 Oct 2024 16:30:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] improve multicast join group performance
To: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson <sean.anderson@seco.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 07/10/2024 16.17, Jonas Rebmann wrote:
> This series seeks to improve performance on updating igmp group
> memberships such as with IP_ADD_MEMBERSHIP or MCAST_JOIN_SOURCE_GROUP.

Sorry, I forgot: This should have been tagged for net-next. Will be 
fixed in v2.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

