Return-Path: <netdev+bounces-131141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0198CE5D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE6F1C21172
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAEA1946B0;
	Wed,  2 Oct 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FHZNhoLG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401452B9DD;
	Wed,  2 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856493; cv=none; b=qvQLHLmTa/gZr6GiyWam7GywtRSwf8SVS5EoN+xnUBRaoYbeamelDWT2VkUtY0hCzqL1DJPu+S4dsYnW2YPxSUT68uWDZRtJRcu1/KKAfu8xDj6saHFlEWhbzQpe2G/1jchGrAe9uz2neQvlQ7ZJUAmK1goPV3PaXys+br/N9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856493; c=relaxed/simple;
	bh=fGEFrjxsQmQnKtPDCW+qxPTQ1zcM/w8fQiuopsrUu1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ0YT1YZ7KDog3cKHD6kcy/VVIlhA1Ffl0NlloidsYOoVNLeeQlpHzEHW4GSBdIuEp6tqg1Djuatoam0/rkCvHOYsdJPLPmz3P1NR28lvZhr/NaS6+xNJsekUf6QcrT8ZKQMECCfXMBe7Pwqh7YEPWTUS0zLIj0pznh+fR5Utjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FHZNhoLG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727856491; x=1759392491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGEFrjxsQmQnKtPDCW+qxPTQ1zcM/w8fQiuopsrUu1A=;
  b=FHZNhoLGxiDC/GqC96kVCt55M5Z2TVdtRJ7GIMUrtEKcfXEHZQo74c3g
   6bKbSW9OeI/pDWT7p69DiZLnbze0RpWGGIAUsDIYI63jS3DzQroOFcGSY
   9s9FnRe5mf3TeoP2FtZ4hb6gHyQ3WmF+AjbUKAtOebZe4LY1/+jg3Jeu5
   pSv0SuGSb50dTyguBpB3wCQ+MXdityYMv0yqnhfU8/tAatPONO1+FyL8t
   hed46zDKPfeB1jhUBSjU1oqwrxEXpGG4nh/wumh2W0ML7jpj5d29/GcW6
   obfBpGurffavuH4YG5KoNNOQRzouFaB9b++E7evVyCaSwVBlbkgQxUE69
   g==;
X-CSE-ConnectionGUID: QYE9ZMwUS36a1B66v8Ii1g==
X-CSE-MsgGUID: qa24kTiSTyKcy4mLkYC4Ag==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="32499423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 01:08:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 01:07:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 2 Oct 2024 01:07:38 -0700
Date: Wed, 2 Oct 2024 08:07:38 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 02/15] net: sparx5: add indirection layer to
 register macros
Message-ID: <20241002080738.w5qzwndzmoansccx@DEN-DL-M70577>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-2-8c6896fdce66@microchip.com>
 <61470f4b-2cc6-49ea-a94e-35df1642922d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61470f4b-2cc6-49ea-a94e-35df1642922d@intel.com>

> > +/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#define spx5_field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#define spx5_field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> > +
> 
> FIELD_GET and FIELD_SET have restrictions in place to enforce constant
> mask, which enables strict checks to ensure things fit and determine the
> bit shifts at compile time without ffs.
> 
> Would it make sense for these to exist in <linux/bitfields.h>? I'm not
> sure how common it is to have non-const masks..

There was a patch for this some time ago [1], it got some push-back and
never got in, AFAICS. 

[1] https://patchwork.kernel.org/project/linux-pm/patch/3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be/#24611465

/Daniel


