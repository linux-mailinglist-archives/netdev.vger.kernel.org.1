Return-Path: <netdev+bounces-156180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65354A0558F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EE01887F21
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4F51B4234;
	Wed,  8 Jan 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F8cCns+3"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878B1D932F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325494; cv=none; b=XZj/Ob7nn5IQRFg4N6JvXXHNxqO1iQGDENCa8j8CjzVElK1wek84nnsr3ltfCiqhNgepWHgOxbbqaAXGLIw3svQWL4TJCi0XR8wXIPEGNJFFceMpFvKyJDA4eRbx7bPsDAcJon1lDzatomDFgTvEoE9/qMB+6Z8Uot5tzAMh2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325494; c=relaxed/simple;
	bh=mkCQIxlLaUgBnpsaSxe82rCriQis8K0QbgJWwMd7+mY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE+bYEMuW0Ev3EAlhKNAFPh45J2fciAADdRKIpng45/9PxlUX0eGZj7stUpx+bcgiL8WLngyW/BTz3Q9IhbsATaljJ6TQdy4tq5Oj5Yb0rIV6RBpRm0J0sMszdh53jX6sS/SK/o1S7qkw6tAs6L65GXOqdskS7pJnCCBfuKqm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F8cCns+3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736325492; x=1767861492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mkCQIxlLaUgBnpsaSxe82rCriQis8K0QbgJWwMd7+mY=;
  b=F8cCns+3iYPhi+jUhir/y5QS2a02JRVjvUeoIcqb+SjKAKkHq7pTMVrk
   Zdi4Wvm+ykGoc0/zAJ7cTht7AClk2mct4nfoBwz+TlvZGZMToDy7ZWxjT
   UbUp4rbUdMovXziINFepy+rzLb2UGLLdS0we1UsJmaaXccq190kt2Kl3A
   hoVQdizeNEh3n8Ib9XZisMIAE9il8IgJNO0iJPcSFSWITZr9GeCfQh+9g
   W1mTRoC7jMHi5Org2z1OUnmdqW+Bc0mKFNKsaqbblmDnL9m+c8CBgIKAH
   Bx8xZaV24gdgw2QruuoKU8dO8D5rcOJ1qqUznD4/GNPibjv8J7JyiziTa
   A==;
X-CSE-ConnectionGUID: 7GbPrTS2SaintIuYjSB5nw==
X-CSE-MsgGUID: QC3CBfcfSN2Ksk0wDk3+AQ==
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="35940590"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jan 2025 01:38:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 Jan 2025 01:37:48 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 8 Jan 2025 01:37:46 -0700
Date: Wed, 8 Jan 2025 08:37:46 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <Steen.Hegelund@microchip.com>,
	<lars.povlsen@microchip.com>
Subject: Re: [PATCH net 8/8] MAINTAINERS: remove Lars Povlsen from Microchip
 Sparx5 SoC
Message-ID: <20250108083746.pk2543dxwnykz5g2@DEN-DL-M70577>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250106165404.1832481-9-kuba@kernel.org>

> We have not seen emails or tags from Lars in almost 4 years.
> Steen and Daniel are pretty active, but the review coverage
> isn't stellar (35% of changes go in without a review tag).
> 
> Subsystem ARM/Microchip Sparx5 SoC support
>   Changes 28 / 79 (35%)
>   Last activity: 2024-11-24
>   Lars Povlsen <lars.povlsen@microchip.com>:
>   Steen Hegelund <Steen.Hegelund@microchip.com>:
>     Tags 6c7c4b91aa43 2024-04-08 00:00:00 15
>   Daniel Machon <daniel.machon@microchip.com>:
>     Author 48ba00da2eb4 2024-04-09 00:00:00 2
>     Tags f164b296638d 2024-11-24 00:00:00 6
>   Top reviewers:
>     [7]: horms@kernel.org
>     [1]: jacob.e.keller@intel.com
>     [1]: jensemil.schulzostergaard@microchip.com
>     [1]: horatiu.vultur@microchip.com
>   INACTIVE MAINTAINER Lars Povlsen <lars.povlsen@microchip.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Steen.Hegelund@microchip.com
> CC: daniel.machon@microchip.com
> CC: lars.povlsen@microchip.com
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 009630fe014c..2dae9d68c9b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2689,7 +2689,6 @@ N:        at91
>  N:     atmel
> 
>  ARM/Microchip Sparx5 SoC support
> -M:     Lars Povlsen <lars.povlsen@microchip.com>
>  M:     Steen Hegelund <Steen.Hegelund@microchip.com>
>  M:     Daniel Machon <daniel.machon@microchip.com>
>  M:     UNGLinuxDriver@microchip.com
> --
> 2.47.1
>

Acked-by: Daniel Machon <daniel.machon@microchip.com>
 

