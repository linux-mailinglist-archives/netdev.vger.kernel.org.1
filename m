Return-Path: <netdev+bounces-152993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB49F689E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0231016C741
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E51BEF61;
	Wed, 18 Dec 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tc+rc7tu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90F1B0417;
	Wed, 18 Dec 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532451; cv=none; b=M7VIa/uktAnG5NdLA7DbLOCij2EKGJwBDA1SO/+/8KOfklNMQljeNKJcIqzMd0raL/6Rs8eD/aioh1V+CNqWW6tkxvypG9kwju5eIUof4do7z4hlveCR8KAp2JWWOFb025gPP7NSh0pAgGcz2LkqhmmqhNYgrfg5doKaVDJEnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532451; c=relaxed/simple;
	bh=x+ouAiKcuBQkZ/37Owdf/1ycla1yjKbXs8ztdlKCfj8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiH5XizN5dVU88gntvZC+NB0EYLPuMSa3ooeCuVZ0OUgy0wGyZ62XLYos13uRcDDXRX+zP/CKVpPzwKFfYuLB0bQL66iuPuRZ3ugWC/DUGuUd/qKYxQ67fSUYp/pP3Rb7oH0bG3symJ+ZuUaXMfn1603aV+Je+s8K/AC7bR9fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tc+rc7tu; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734532450; x=1766068450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x+ouAiKcuBQkZ/37Owdf/1ycla1yjKbXs8ztdlKCfj8=;
  b=Tc+rc7tu3cgqJDPzG3mXuGVfhR9h7+m9x2mUXGkvEzdIokAKvDNB+qp6
   Rak/JXKlKGcTeJbcl2CfHKBjNduXYoC9g/z2EhBmLLBfDr+IcRqGiQn1C
   ke84Dzi1FS2bPaYHJSXHmZIoHlUAumXAbwsifDfISR5QZ2i0ehDufq2Ok
   OZ4BaYbYZXOPowKOjr60r4FDbO9r8RVQ3AcrXI4TL/iCHLBlSdnCCUbq4
   o2FULmXgh7+5mFHQkuTOwTzkBMkk12h4p6mjpdga+vRenAVqRxzLSjAC1
   /jakCMpRsT/V2Mfnma2VaPRAvBeTWOH6BOJGYcz0B1BbCKmhf+BHSnH9q
   g==;
X-CSE-ConnectionGUID: 7sKZ6qhWRXCBO0C3T4e5BA==
X-CSE-MsgGUID: FGgQ9ZKBQfCEZLpy9D4ImA==
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="266920911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2024 07:34:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Dec 2024 07:33:57 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 18 Dec 2024 07:33:54 -0700
Date: Wed, 18 Dec 2024 14:33:54 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
Subject: Re: [PATCH net-next v4 0/9] net: lan969x: add RGMII support
Message-ID: <20241218143354.eh6iinemupxncblj@DEN-DL-M70577>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>

I would like to defer the pontential removal of sparx5_port_verify_speed()
function to a separate series (see comments on patch 6/9).  Any chance for a
maintainer to give the OK for that? I would like to give this series another
spin before net-next closes. No changes in next version - except adding TB and
RB tags.

/Daniel 

