Return-Path: <netdev+bounces-134921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD8C99B900
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2AB1C20C58
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2732812D75C;
	Sun, 13 Oct 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eaWZcIsW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D6804;
	Sun, 13 Oct 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728813339; cv=none; b=SBvKtdsaeWJu9Sdslw050ABjZATxGslHBGGtA3j8GpgeqkLnmeGzyep1MFVtO2dzKoT/W6C1QOSCo+YEEIw/nNtgDo9ZTlucCrgucn2cMj1kfim18ZpB1qNiRQOxtWOv5s1W4T65ZrtNjtMFUhHY8aAU1E8Za2VXX3Tof67LhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728813339; c=relaxed/simple;
	bh=Sdvtap7awea3/B15o0w4Yr+EA3pVzLdSs150XFjvMPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjtW8E7loDTUuAp0S0qicJFMD7OyO+6BcUP8M2wQBSlWtE9yYjJdh6LR0OmPFToWy88210oCCMY0ZmmOwZgYeo/eH7OgF7O56lFpejMjxiJb7t5VpgFQuE6riV1EAmtrALFfjeOugGK5gQBuvd3RtihFuDTXPPu7HcbBuVhfANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eaWZcIsW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728813337; x=1760349337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sdvtap7awea3/B15o0w4Yr+EA3pVzLdSs150XFjvMPg=;
  b=eaWZcIsW8Zoc8BZ5e3kNG6GIsYneDpKRfJB8c4f787rVDBVqphRF/9WV
   Zk6DNM1F5YI+0+fPYkd/H8f0siygrgIxqJNtuOEMenWkqL77TA870d/gV
   Qtope1rnoU9SZ1qs6OJ1KnIPJvt63RL1U2WY+AhSBsYoIwFbeEWBleAbq
   i2t8sHgU3OVKoeHcKZXpXBL2C/zXurOG3Tn7oJQTy095dlWFNYRAPdqq2
   UEe/JsUliiM2nUe0cTR6x8yeCR5g0xZNVOOrcLINU2tDkaWwLYip3DToy
   vEd2A5hdHaaN1LA9xwE43ZkiUAAbieGNyzFPmjjcBI0cQouyt1jHiVy6c
   Q==;
X-CSE-ConnectionGUID: Zz34lMM4SwaKw3TRrI31yw==
X-CSE-MsgGUID: j3LUpdOHQwC7UlircV7euw==
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="32751372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2024 02:55:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 13 Oct 2024 02:55:02 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 13 Oct 2024 02:54:59 -0700
Date: Sun, 13 Oct 2024 09:54:59 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
CC: Jinjie Ruan <ruanjinjie@huawei.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: microchip: vcap api: Fix memory leaks in
 vcap_api_encode_rule_test()
Message-ID: <20241013095459.kah7oxlax5qio2nw@DEN-DL-M70577>
References: <20241010130231.3151896-1-ruanjinjie@huawei.com>
 <20241011102459.zxmegrcro2tv6b46@DEN-DL-M70577>
 <D4T2M90I0282.D2DYJ3EITRTH@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D4T2M90I0282.D2DYJ3EITRTH@microchip.com>

> >
> > Wait, should vcap_del_rule not handle the freeing of the rule?
> > Maybe Emil can shed some light on this..
> >
> > /Daniel
> >
> 
> No, this is a bug. I made the mistake of thinking that vcap_del_rule freed the
> rule.
> 
> However, it frees an internal copy of the rule, which is made in vcap_add_rule.
> The local copy must still be freed. I reproduced the leak and the patch fixes
> this.
> 
> /Emil

Ah, right. Thanks for clarifying!

/Daniel


