Return-Path: <netdev+bounces-272549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOoUNMN6xmnwKgUAu9opvQ
	(envelope-from <netdev+bounces-272549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:40:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D1344568
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6B0301DB9B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C02021CC5B;
	Fri, 27 Mar 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Yu4TmWo1"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1A21B9DA;
	Fri, 27 Mar 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614910; cv=none; b=h8v35rQoRL4L/wNplmrOBC/wS5aKo3DPc2xVb5dvp7QoI/vdXs6cszqT3N36xNKxLgJxPlEvdaKi+pKUqyhgCscBLAzGp8mlK9hHKUfGD+5FYtMvow8O/WnjTwJja+sEhcIz8H/wyQFt6C68/qbqJ3TaNTFyOCfTgexhT1B1rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614910; c=relaxed/simple;
	bh=X3kyuRjg7v+xLbz6US3MZDcLvz17mxsXqmt5e/m8kbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPI+Mp3JT8+5fn9ieJ482/NqduiGzUWFHt+J7AZtdyrOr1klP2//3NR+F8tlxGYldwzqK/xIWRUAyZXFEz2cm+r3d86iOGrz/6PTLg2edziqtzD/GOmATGah7oJ2cQslSEce1aQqGOuZZSM+V8FHVxRQYcL7DFAYztGg7lP87nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Yu4TmWo1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774614908; x=1806150908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X3kyuRjg7v+xLbz6US3MZDcLvz17mxsXqmt5e/m8kbM=;
  b=Yu4TmWo1oxcMsMTUAk/K9+XptmbxvWAr+VVv8A2As1/b1JPXFSNseJXq
   rdD3S+Ojj9FHl0fu82CSVvIpMksYxwyrr7bs3IYYbcVnY9tM4XsAyzJyV
   OTAglF62XUBd/vFfS/YQtquJeEDju3oZHF4Paz7M8+zwvG7qXSNKlIMX5
   l8v41/nJG1y+iPovCMKgcaJhdCbiujAU259Tn7V48RssqMVOERZFzeC+l
   qVVL65LJSu26auoXCxzIpK9fdOianQsNKHlhzwjfbubOEsce4cJSNwUNz
   1pxK/08cYCVnV66xGvaeWLthdQWGybjT9ICLUpJ4QnUFTA4OAidsX8IWG
   Q==;
X-CSE-ConnectionGUID: tFGc9Y2OSSqwHrCtZH+5dg==
X-CSE-MsgGUID: bEduLCXNQ2CHYc669s0JdA==
X-IronPort-AV: E=Sophos;i="6.23,144,1770620400"; 
   d="scan'208";a="286683013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 05:35:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 27 Mar 2026 05:34:35 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 27 Mar 2026 05:34:34 -0700
Date: Fri, 27 Mar 2026 05:34:32 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] Add support for PIC64-HPSC/HX MDIO
 controller
Message-ID: <acZ5WDz5qVxBDj3e@bby-cbu-swbuild03.eng.microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
 <20260326203309.7154152d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326203309.7154152d@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-272549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Queue-Id: 3C0D1344568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:33:09PM -0700, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 15:02:52 -0700 Charles Perry wrote:
> >  .../net/microchip,pic64hpsc-mdio.yaml         |  68 +++++++
> >  drivers/net/mdio/Kconfig                      |   7 +
> >  drivers/net/mdio/Makefile                     |   1 +
> >  drivers/net/mdio/mdio-pic64hpsc.c             | 192 ++++++++++++++++++
> 
> Speaking under correction from PHY maintainers but I think we need 
> a MAINTAINERS entry that will cover Microchip MDIO, or at least the
> files you're adding. Important read:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

Sure, I think this should go under "RISC-V MICROCHIP SUPPORT" or maybe a
new "MICROCHIP PIC64-HPSC/HX DRIVER" entry if the former was meant only for
Polarfire SoC.

I'll add something in v3.

Thanks,
Charles

> -- 
> pw-bot: cr

