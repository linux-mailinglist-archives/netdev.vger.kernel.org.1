Return-Path: <netdev+bounces-75698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F986AF30
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BFF281D03
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC013BBC4;
	Wed, 28 Feb 2024 12:28:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144D3BBDB
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123324; cv=none; b=P55rZn4ni8BXEVEc5nxF89f6fhQ+xdd+wz8y9bchlSWJmu83ZqAllysKAjO7q6Rio87A9TFvDgj6YTbW5ue8uDPqB8Nz29k3g9gA3wEA9DxgEX0Q9afb9cC1lm7JL0j9DsiDD2Gg2XuupioelptEi6G5MgmtT2GI06wqOMomEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123324; c=relaxed/simple;
	bh=VqomBaJsbCrDWx32dDWhbU0egir/gv6ZNYqtFyQritQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU0IX8kfs7jj58az0vvmu0HoCFQbUeem9OQyZ44ABKsGOjHAXPExhdWRbB+Bxle/zD0i7vipiXJ5ur5y4tAMhi0M8LryNfb6iq7k7xnqmYtXdOWK7XKgeS+kqYkKC09Rjkg0WI7QgHHAPqQkC5plxpeXl7oBrotwnBr7ZSqVSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfJ2z-0007e4-Up; Wed, 28 Feb 2024 13:28:29 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfJ2x-003OF0-Lu; Wed, 28 Feb 2024 13:28:27 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfJ2x-00C5Dx-1t;
	Wed, 28 Feb 2024 13:28:27 +0100
Date: Wed, 28 Feb 2024 13:28:27 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	nathan.sullivan@ni.com, Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] igb: extend PTP timestamp adjustments to i211
Message-ID: <Zd8m6wpondUopnFm@pengutronix.de>
References: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
 <Zd7-9BJM_6B44nTI@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd7-9BJM_6B44nTI@nanopsycho>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Feb 28, 2024 at 10:37:56AM +0100, Jiri Pirko wrote:
> Tue, Feb 27, 2024 at 07:49:41PM CET, anthony.l.nguyen@intel.com wrote:
> >From: Oleksij Rempel <o.rempel@pengutronix.de>
> >
> >The i211 requires the same PTP timestamp adjustments as the i210,
> >according to its datasheet. To ensure consistent timestamping across
> >different platforms, this change extends the existing adjustments to
> >include the i211.
> >
> >The adjustment result are tested and comparable for i210 and i211 based
> >systems.
> >
> >Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")
> 
> IIUC, you are just extending the timestamp adjusting to another HW, not
> actually fixing any error, don't you? In that case, I don't see why not
> to rather target net-next and avoid "Fixes" tag. Or do I misunderstand
> this?

From my perspective, it was an error, since two nearly identical systems
with only one difference (one used i210 other i211) showed different PTP
measurements. So, it would be nice if distributions would include this
fix. On other hand, I'm ok with what ever maintainer would decide how
to handle this patch.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

