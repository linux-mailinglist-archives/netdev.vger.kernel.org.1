Return-Path: <netdev+bounces-146461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606FF9D38BE
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE25283D21
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7C15B135;
	Wed, 20 Nov 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z/UoO0WB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994633C5;
	Wed, 20 Nov 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099929; cv=none; b=NTVCpjoxU9DRpSTg7vlJf/qOPXi6sLOzchQc7Bzsheam2E4PSDn+Q/oLNbvgXX0q9HhZPavd6b8f/TF1RFfyPdfeF83T39TP5MpZ/eGaiwFH7rLCzADsIBi0pDL3qA8p5YMuhhc0IODLINeHdoozoDEBn/l3tG34+1s5SUyKJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099929; c=relaxed/simple;
	bh=DQRkqPQ7KKWFWhiQ+UDyS/VSm50G31LKA/NUgqhkKDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA1logQ12XC4jv4ih7mhzUmOpNjuD6ycMHszk1BYC/IoEYJ8UUWJcfwyEE4rzZ3RxkGJCxdsJ2jJIUSUsme5m3pK3fX04eaHwFPqH3HIOJsLtckJVnBFnRAQ+xCpUTsywYSJ6rdsLUbEP7qBfg+KX1cYkhSwVa22rUoA/5xVeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z/UoO0WB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732099928; x=1763635928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQRkqPQ7KKWFWhiQ+UDyS/VSm50G31LKA/NUgqhkKDs=;
  b=z/UoO0WBqqOCKnG5+QHH4bIlNSqtgFF6S3eOJ4NaUainFGI5iyjLQuj1
   AkpcDtvU5HdZrqrCVBTPHCfHfDM49I2LfZtzgMDl/iXDxZJkE35Y1k3AE
   6bQVYQ21mq7jEOz9Ftw3rVUyPa9rhBzV8NoFsUNCeyJv86megNiwOtXKo
   FVrVOAh0r9V/I9dpEPv1UiQoas41UIrkmp8qIXT9fdMGNsCbpe6/MG0mM
   qqNqkDSem9OwowLeNyETYMc9DgVFJTU9megqHQsoK9xzpCraLRZja8knY
   DG8TJklE6NMETBvq/j1rrGIE1KX27dsLEWiOF+gIJ/dcIB8ZLQCCgd54X
   Q==;
X-CSE-ConnectionGUID: JrZ1f6mESWimvMFQPOoHiw==
X-CSE-MsgGUID: XgJw+zkXQ5Sthtr9YnRH0g==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="265717816"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 03:52:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 03:52:05 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Nov 2024 03:52:02 -0700
Date: Wed, 20 Nov 2024 10:52:02 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table
 terminators in kunit tests
Message-ID: <20241120105202.cvmhyfzvaz6bdkfd@DEN-DL-M70577>
References: <20241119213202.2884639-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241119213202.2884639-1-linux@roeck-us.net>

Hi Guenter,

> Comments in the code state that "A typegroup table ends with an all-zero
> terminator". Add the missing terminators.
> 
> Some of the typegroups did have a terminator of ".offset = 0, .width = 0,
> .value = 0,". Replace those terminators with "{ }" (no trailing ',') for
> consistency and to excplicitly state "this is a terminator".
> 
> Fixes: 67d637516fa9 ("net: microchip: sparx5: Adding KUNIT test for the VCAP API")
> Cc: Steen Hegelund <steen.hegelund@microchip.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> resend: forgot to copy netdev@.

You are missing the target tree in the subject - in this case it should be
'net'

Apart from that, I think the fix looks correct. In the drivers utilizing the VCAP
API, all the typegroups are "{ }" terminated - also with no trailing ','.

Thanks for fixing this!

/Daniel

Reviewed-by: Daniel Machon <daniel.machon@microchip.com> 

