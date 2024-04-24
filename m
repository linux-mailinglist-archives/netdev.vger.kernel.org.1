Return-Path: <netdev+bounces-91036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6E8B1179
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2092A1F2215F
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98616D4E7;
	Wed, 24 Apr 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bkRJF73Y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AA16D4E5
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981075; cv=none; b=F/wp20thhrU92JaccPlJRkfm68YYyn6Wz9igL68Jnqy1DGo2QIh/6vOqQgyVeT5STTwxAlSLimVwOxAjBPdM7ums/y3ZLonIjJODIosjI1WCUSfA0d6BYPum7Jtr1FA513fLa2ZqYpkuEVpWzsomMaaQBANT6QnZbh/1AfNdlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981075; c=relaxed/simple;
	bh=IvAUaFtuF2ea7Lq3yti3FerEcKsXvbj4TlkLoeRp2QM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKluGnDU14w3Lva8H9nnFCVwvGMe1Y4f8iBS5BwKLNev0DiW0H8i5ys4Y30dyXxJ9DPWvfHKpGHF5XHMiD93kbk/YCRWCcA7k0FJNZk+rHhxcsJLse9tOdBXy4sxCclW/cXP0mllDDezCmBCzCueYEJxfioyu1IWU9f2C+MVE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bkRJF73Y; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713981073; x=1745517073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvAUaFtuF2ea7Lq3yti3FerEcKsXvbj4TlkLoeRp2QM=;
  b=bkRJF73YjAQgf35Hi75uVg9yeDfosGXQwBL7dWb/Lh+tWjTWfgeDK/W9
   5aX4a+lHeK2C17YqWiscbU7qo8YFEaJB8eOGt3AWypff0jhDBa9flIkXY
   H6uV0q9PgUAjCyNpgFGfMnSyoel7MlSi+VnbhP+4mRKkYrf418JKPpl3w
   OXU1aRFVcRrG7Uot3KjraS7tn0jDnMSLy3Rn1MsI+FdfEWhSRwh1CQCA4
   V5ABi55osSpNPpWBol21YVpreQNT9+ux8iHj3pTv//KoVq/bFLKrXurD1
   hcpwulA4Txmwk/ldQjr+ATIwnhQvFtBBqAY2xBznR6HAb6BDM0fejNahU
   A==;
X-CSE-ConnectionGUID: RdrmERWdR5e4I58u+yGC1A==
X-CSE-MsgGUID: zV89mFEyShODsnCYraSgdw==
X-IronPort-AV: E=Sophos;i="6.07,226,1708412400"; 
   d="scan'208";a="24562274"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 10:51:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:51:11 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 10:51:08 -0700
Date: Wed, 24 Apr 2024 17:51:07 +0000
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
Subject: Re: [PATCH net-next v2 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240424175107.x6q3a7e26e7wpy6s@DEN-DL-M70577>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
 <20240424-lan743x-confirm-v2-4-f0480542e39f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424-lan743x-confirm-v2-4-f0480542e39f@kernel.org>

> Correct spelling in comments, as flagged by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> v2
> - Use 'extack' in place of 'extact', not 'exact'
>   Thanks to Daniel Machon.
> ---

Thanks Simon!

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

