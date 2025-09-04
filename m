Return-Path: <netdev+bounces-219833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D1B434D7
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754FA1C82128
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616332BE02D;
	Thu,  4 Sep 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ppg+lKZn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F42BE635;
	Thu,  4 Sep 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972776; cv=none; b=dbA/cLV2bF8bgGb0XNncwqYLyba4rMrLXXJseNC+tXEAkLJk/sU/NXaamvBMAnzpCD7QHwJ5U1dwyMUfByVhgsNz3Ay3gIjxa/rOD8vIP9a/+keUVvdWWugqtqB1Ox0cFbWCyAepbpfoiCjrfD8wKh2DQ0scELZ64qtWkh+0VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972776; c=relaxed/simple;
	bh=OLHGYL2VYkLqPI5tT25FMVUxYYK7trdummRfW3EuY1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSOA20C+7c5rCytqaSnUwIKyMTopwaVDxoB8QW9BbeIwgtXoe2ke3KsWQUU8Oj9l29enFeBR7EAvqaSxu7WQYOR+e5Q3b84Hhlvqx96zOXqcTBIXM8FLcQoO/hFxi6C6ym5sP30l2HQurXdvUHMLwWbHX7SeGmnxShJciAjhIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ppg+lKZn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756972774; x=1788508774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLHGYL2VYkLqPI5tT25FMVUxYYK7trdummRfW3EuY1M=;
  b=ppg+lKZnxkJUVJS4J3Co7vB6s3yqP136TBKdZb+kvZ6BqnNmcB+5xa36
   prPAXlbANqL4eC34D+QRC9S0LJKR7yyOunE0lWdCr0UjMCvns5J07OA19
   ZlayqlaOnOZIyM5Afi0x/fijrat0S38BNkIFX/iYgllttA18fo3d/8Yhy
   YdJJ7/3HYJ5pcT/jJJWTkftwZ0ctAeIwq2tVxs9oDwAwv1y1OHWsQ4nmC
   Oe/fBruTDDp+kqHNqXShm7RCHVU9CBCUGTzBYzb/Q5iILSoje0dDDO6SW
   9pYrMeds613TX709xd8wVvlNoLRVx5Pb3Kgieg09FZvRSLacI6BJvvIbM
   Q==;
X-CSE-ConnectionGUID: WO2Pu+71Q/qFJxgIkpaNTw==
X-CSE-MsgGUID: AwdDj6oFQDuhD9MN31fgtg==
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="51778964"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2025 00:59:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 4 Sep 2025 00:59:13 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 4 Sep 2025 00:59:12 -0700
Date: Thu, 4 Sep 2025 09:55:31 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>,
	<vladimir.oltean@nxp.com>, <viro@zeniv.linux.org.uk>,
	<quentin.schulz@bootlin.com>, <atenart@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] phy: mscc: Stop taking ts_lock for tx_queue and
 use its own lock
Message-ID: <20250904075531.gcovqmarfan4vx7w@DEN-DL-M31836.microchip.com>
References: <20250902121259.3257536-1-horatiu.vultur@microchip.com>
 <20250903170558.73054e68@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250903170558.73054e68@kernel.org>

The 09/03/2025 17:05, Jakub Kicinski wrote:

Hi Jakub,

> 
> On Tue, 2 Sep 2025 14:12:59 +0200 Horatiu Vultur wrote:
> > -     len = skb_queue_len(&ptp->tx_queue);
> > +     len = skb_queue_len_lockless(&ptp->tx_queue);
> >       if (len < 1)
> >               return;
> >
> >       while (len--) {
> > -             skb = __skb_dequeue(&ptp->tx_queue);
> > +             skb = skb_dequeue(&ptp->tx_queue);
> >               if (!skb)
> >                       return;
> 
> Isn't checking len completely unnecessary? skb_dequeue() will return
> null if the list is empty, which you are already handling.

I don't think so, because if the skb doesn't match the sig then the skb
is added back to the tx_queue.

/* Valid signature but does not match the one of the
 * packet in the FIFO right now, reschedule it for later
 * packets.
 */
skb_queue_tail(&ptp->tx_queue, skb);


Then if we change to check until skb_dequeue returns NULL we might be in
an infinite loop.

> --
> pw-bot: cr

-- 
/Horatiu

