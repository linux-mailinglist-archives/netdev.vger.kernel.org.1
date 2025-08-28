Return-Path: <netdev+bounces-217609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD1B3941F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969C4462271
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854601F55F8;
	Thu, 28 Aug 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VCfzzeIv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA149747F;
	Thu, 28 Aug 2025 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363665; cv=none; b=dSVA+Hp9oWgg6MqksCSFsshNH2uUkXoXWtmJ4sqzxM48TyvJsnnZZxw4YsG0IdKlfv9l+rILfVO03DAUF98KxNXKRB9hWC4mpBxWOShaA6/Dieryj2qN+tQW3UJQS2ns/P5t2DHKDvMsQ668luULtfMMUS7yhaTHi3XJB/EbjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363665; c=relaxed/simple;
	bh=8sbgKSxAhOEK+Z5a/Of1IcGfOcbdGrx8hV/4V6OmYQg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p21gJnn/YYgwmOtmJCnzSmclV2RNM0ms+oOYUtoPujLmWfJwqrxbsGKgJOK+ZCh4iTcZxrkTtkaQQHU2xkzZerorlxlbHA//uz59iiz82a5q+UnRV+LvKbe1Y5vk6qZCGQYe0S87Aeq3V5CplMHlUsCT6ZjXbKUYCWpjvxIpWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VCfzzeIv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756363663; x=1787899663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sbgKSxAhOEK+Z5a/Of1IcGfOcbdGrx8hV/4V6OmYQg=;
  b=VCfzzeIvdtn8Do8UOs75EUOS2IM6tp/+CAJTqpuYt6sIEIiXAALe4DQK
   3YNqFdopwTS7dPSubaa5cHau5PBQW7ZJv1miraQtZkAEojm1H3gu20/ue
   5R2Qd9L/8JfmsdoNkn5RWn+JEHqctAwH0F4YbKjJ4G484kP4qaL2/Kqcr
   GJ0owlYSFTuf8sve28WYBwa4Nc0s8xWQ9pwNBoEQP9MHEnPXD+GjDFg0p
   M7F9hDuMaxdlt/ExpN1UFmUtuLAcJUPLRu/BA+fZR6zoJxuCEyt62fPRK
   OMSn5Ua+dGPmtoxEWio95ZcKnzfPbDVMzQD58niYnYKFbMsr4wop3rUoe
   A==;
X-CSE-ConnectionGUID: qJZKSV6FTHO7/mkDgcwgpg==
X-CSE-MsgGUID: K50yxsCaSJGjkgfAKAve+Q==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="46322859"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 23:47:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 23:47:06 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 27 Aug 2025 23:47:05 -0700
Date: Thu, 28 Aug 2025 08:43:32 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <Parthiban.Veerasooran@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250828064332.n7kqn2rfuuieydnx@DEN-DL-M31836.microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
 <20250826071100.334375-3-horatiu.vultur@microchip.com>
 <20250827174720.7b6406a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250827174720.7b6406a1@kernel.org>

The 08/27/2025 17:47, Jakub Kicinski wrote:
> 
> On Tue, 26 Aug 2025 09:11:00 +0200 Horatiu Vultur wrote:
> > +#define LAN8842_STRAP_REG_PHYADDR_MASK               GENMASK(4, 0)
> 
> > +     addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> > +                                 LAN8842_STRAP_REG);
> > +     addr &= LAN8842_STRAP_REG_PHYADDR_MASK;
> > +     if (addr < 0)
> > +             return addr;
> 
> Did you mean to mask the value after the check if it's negative?

Yep, I wanted to mask after the check. I will fix this in the next
version.

-- 
/Horatiu

