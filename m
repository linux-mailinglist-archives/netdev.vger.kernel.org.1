Return-Path: <netdev+bounces-91037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7308B117F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081BC28489A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7E16D4EC;
	Wed, 24 Apr 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aUC0vyJy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42916C855
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981299; cv=none; b=ePlSvUYV4mmhpeu9YTwPR0H5bjAjdOMsDrApjS9u/uI/MuTzgVnvY08himhr3UA5uv+hhxUUBUQAhDHW05Jjnz2MItI+9lNuMCGf/KuC083mMOU2V/Sw7aXr5oMe5LL9rTxZQAf8ol35ESMe/nZ29iEjD4KySj1p0ij7euhBMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981299; c=relaxed/simple;
	bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9ZJtys8TCRgxQeDYVQ3NXOXjiWJHqIETUNRYhLMTLjMCDyLxmFkLdF2D30czNiYEdMyXP9C6AYzoV962JSa2tYlCu3z46ZeMD5TNTom3DR9M7c2NKM4Z1T3t/ZoHXYS4oCY7ruuiTtrX0BPodCDhGxxSOKq2/smq+Neo78062Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aUC0vyJy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713981298; x=1745517298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWkXdDAPfkJpiKcltcBrQt7q1vz7/sgfqjDtuw5QtOk=;
  b=aUC0vyJyZd1xA8c56s+tYL0OkutTpH/Ltcfv7MAROeZQz56JQCut5EXb
   Jvz+V7IQ15t4Q1zTvO1MQewtBt1Ijjw+h0Ax3SMcbom/K3Kp6bgYcqhvS
   SQVodLXZH6SKggBmTf1TZ3svXYptYUHPtkFYH1zkkAxtM81/6m8YVyryd
   tmsq4D1+k01NUbwrOoGBlH/H35NPXdyxLDKKCquloqcbb5z3qQUT9Z8x/
   zbh9AAc18Lz3S0yZ6UT3p6nViCUnK1dFhrzo5Koclpg3SK0T0gJ6SaXNj
   lJADTF++45iopu1o0wjPzURSI+D26CNBaAP3/dwvMhh1T4koa5MwGAk2b
   Q==;
X-CSE-ConnectionGUID: FpmaB6VhSvy5NDYsJ5z9/A==
X-CSE-MsgGUID: r13xNPKPSqGULT+5EqXAzw==
X-IronPort-AV: E=Sophos;i="6.07,226,1708412400"; 
   d="scan'208";a="189808107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 10:54:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:54:29 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 10:54:27 -0700
Date: Wed, 24 Apr 2024 17:54:26 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"Richard Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/4] net: lan743x: Correct spelling in
 comments
Message-ID: <20240424175426.2hgdljb5hahptyt4@DEN-DL-M70577>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
 <20240424-lan743x-confirm-v2-1-f0480542e39f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-lan743x-confirm-v2-1-f0480542e39f@kernel.org>

> Correct spelling in comments, as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

