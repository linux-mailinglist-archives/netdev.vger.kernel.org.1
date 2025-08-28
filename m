Return-Path: <netdev+bounces-217610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC69B39429
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA5D686545
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD62459E1;
	Thu, 28 Aug 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wL8E6AuZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2121FF21;
	Thu, 28 Aug 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363715; cv=none; b=UD48ADkzyu09rl3Fb7f+QH2x7nAKBUiKh3MyjqOzuizktB2w1DrC8kuNdmW15gQCZ7IOc6OjebqEefR968Rh0nBpBiYR4VKRSguxHPvhO+4TSYLKWNk7K2ttsYGRMgiDJUaH6fVjhjHp2OQRcugaWVNt8/lqMVLlJzMoU1qwXSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363715; c=relaxed/simple;
	bh=CEiwmOvESDt0kwun6t4Wjr0ZICxmx56qsTVdSxeLxrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw7NueTSUryXwYXjMNqtfJXX9NnT/TDFu852yPUxJnc84Yg6u0jfvy91R163A5UXVnlznQ8zuINkyNXN1SFEaBrzc5n6Ozt8VMCb/VfrDqUBWu4tDhsPTZxJQlmr58DEukWxGNMt827r1MasZXrk8uxqY5740PPsJm935EqPuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wL8E6AuZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756363714; x=1787899714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEiwmOvESDt0kwun6t4Wjr0ZICxmx56qsTVdSxeLxrg=;
  b=wL8E6AuZe7KZCHD6g59d4RUu/6VJyT/iaXkA7q+oPcI+D00z2stQJ24U
   dXQcajd+40A/l/ksxecNjXPZZOZAIYKmS/swgtwqGuScRph4e7DzGBhWh
   OZYLdKmk7CsMfXgg+gmDmYQXy0lpmJwK+KLPDJzKmZUSuVChmB9rqsxrG
   mJccWrmDItGNQST5BrPNqeOG1D6UVtoyr9P4OODIEBpxxUUEbfJbFpaQn
   xYrwbRjPstFlt5X8b+/Xt2UtLhJY7b+1cw8AlI5aM6EZWhlsaDpsX1TkA
   dXZr9V3Gt8fT1ELfStw3u++4fogrHJI7kqmOV1STFj6+45W2NgJkqCEGA
   w==;
X-CSE-ConnectionGUID: Ap3Gr9DtTeyIkfMn4bDuFA==
X-CSE-MsgGUID: xVDJ0o7ESFanTmFi7GILRA==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="45746335"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 23:48:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 23:48:04 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 27 Aug 2025 23:48:04 -0700
Date: Thu, 28 Aug 2025 08:44:30 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <Parthiban.Veerasooran@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: phy: micrel: Introduce function
 __lan8814_ptp_probe_once
Message-ID: <20250828064430.gjim26k742rncwxp@DEN-DL-M31836.microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
 <20250826071100.334375-2-horatiu.vultur@microchip.com>
 <20250827174935.042bb768@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250827174935.042bb768@kernel.org>

The 08/27/2025 17:49, Jakub Kicinski wrote:
> 
> On Tue, 26 Aug 2025 09:10:59 +0200 Horatiu Vultur wrote:
> > -static int lan8814_ptp_probe_once(struct phy_device *phydev)
> > +static int __lan8814_ptp_probe_once(struct phy_device *phydev, char *pin_name,
> > +                                 size_t gpios)
> 
> nit: size_t for gpios seems excessive, n_pins is an int. I'm guessing
> you chose it based on kmalloc_array() arg type but, yeah, not sure it
> makes sense within this context..

Yes, that is why I have chosen size_t. But I will update it in the next
version.


-- 
/Horatiu

