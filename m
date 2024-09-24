Return-Path: <netdev+bounces-129516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47EA9843EE
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB3D287D90
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721719E82A;
	Tue, 24 Sep 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dqM8Tq1u"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88B19D886;
	Tue, 24 Sep 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174678; cv=none; b=UD/gsNU/ooFkJHH6ar56JAwXK4pPdziNL09Rc3Hw5O7O/j5031S7aSR6gNZb92dgTLJZL471g+y7B6dc3mBsj9hmknZpWYbpX8HukIYWvnOtIdjCX8Bp0idmtvKFchT0esdXu+7nLZEyA6KnXznAIENV5H6Hkj7FV7oQ2alAMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174678; c=relaxed/simple;
	bh=ADSIUCCjjcb2OIUtOAndet+U1NHJFFj9wfQ+Cn4WBsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+o+hn7THyV863HefHy4dNFjZ9HQGo8nHfr4Oo0130ZpzHdLEEcFlYXifuwFVOU7tNsxgg0ySnrqEkxpYyc/YxZUM9MjnQ+zfCUaZOdWtskoBfvhKsOSt5dw5nqPfJ1VzmySLQYFQc36YEwo4cvdMYnltXQSWEPG0nMbIKn3luU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dqM8Tq1u; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727174677; x=1758710677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ADSIUCCjjcb2OIUtOAndet+U1NHJFFj9wfQ+Cn4WBsI=;
  b=dqM8Tq1uqWgwAR1ZcSVN6DNN9cnLiMCTG2nBZd/QPHJGFrXiB4LP+pc0
   KF6Hh0QMsZ4iWDv0BtGFsztjo2LWdSyjwlfmFHQKVbFNuZqQfD3h5uklM
   3hhRTIpmQn/Omxjzlay4SXnHL61vpi6vA27MQxMbkpTVxhi1oZPCKSCLu
   LTYNVkzvdyFCBpuRwYCO6eSJxbChdBA1V7lPEl9gxFEjP9Jc4EOu++u5u
   zOQY6AgkyF2jZVDDhmU3paLV2wTSb1eOyqpfEemOutZZgsEkq9sHPdChp
   40KgcABVTAfSYDHPjmcNWeFU3mqdbCcAODCYuP1Jd7S1zqu50fYTSUWRU
   A==;
X-CSE-ConnectionGUID: S9IVD7eVSNKmiRVsjE9LDA==
X-CSE-MsgGUID: uGZHp0hCRNaA9YGPnbeqSA==
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="32165508"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2024 03:44:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 24 Sep 2024 03:44:05 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 24 Sep 2024 03:44:03 -0700
Date: Tue, 24 Sep 2024 10:44:02 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Jens
 Emil Schulz =?utf-8?Q?=C3=98stergaard?="
	<jensemil.schulzostergaard@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: microchip: Make FDMA config symbol invisible
Message-ID: <20240924104402.ab73u2ayks2h7amz@DEN-DL-M70577>
References: <8e2bcd8899c417a962b7ee3f75b29f35b25d7933.1727171879.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e2bcd8899c417a962b7ee3f75b29f35b25d7933.1727171879.git.geert+renesas@glider.be>

> There is no need to ask the user about enabling Microchip FDMA
> functionality, as all drivers that use it select the FDMA symbol.
> Hence make the symbol invisible, unless when compile-testing.
> 
> Fixes: 30e48a75df9c6ead ("net: microchip: add FDMA library")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

