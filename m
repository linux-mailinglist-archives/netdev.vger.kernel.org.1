Return-Path: <netdev+bounces-171633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E25DA4DEA1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39647189274D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C702036FE;
	Tue,  4 Mar 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTJCMPui"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9D1FBC83;
	Tue,  4 Mar 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093538; cv=none; b=oCPE4N1MTF9xMQYPt0LBGAHOOP49O6hzNCE74DklCJbTcEtcEe0t731v8Qv6aHqsfTHbut+KEWZzKmaZVOCNzdlqebnwJj13Av/qN1/JSGLp7e9nY2WiB/H57JuMsqrJpk9STEwSkw3nEoNazJx8i8hl8aXC7RNNgvpNSTcmRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093538; c=relaxed/simple;
	bh=kId64MTN2SwW88P18+0OurZ0XEpuA7JeJv0/MwjsJj4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tmJdvsMgsfKn9G78Oy9b5f4WldcewzY8lj7BZicfH8j8sqLhvwsbzMvPsAbt6JvikoTz8m8857eFyB8JWaftHCecOHtGOugIuw//2PVxkwt+Yg3hme4g1euygDD4bz3+AoKngkT1AY1TkM2IofWkpd9KAGnBP4hd7Ruar9UVZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTJCMPui; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741093536; x=1772629536;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kId64MTN2SwW88P18+0OurZ0XEpuA7JeJv0/MwjsJj4=;
  b=DTJCMPuipPj8i6qG95Q5UnX43JqWvowBcTfkiuj5lfZzebn6Lcujv9f7
   MRteT0eYcmC/a76AIQ8HLxcq+ADXadE4iox8JP02sP2lPjRJjJkLOvsEX
   HZQyq+BYDSoCi/G+0wL2VhyPf0rPNlbX6OjQUkKFs6fJ/uJK0ORd9F0fX
   akzzaV0co8oDe2sC4M+yFooaFsihlW4SKLgGZIc2+JVLNIE09Xur5cdle
   r9rDbMnGykUWwE9yHyDBl/4oUAsom6O6U2flgO/w2BqJvxDrk3MSjUVne
   tBhJlSKoaI6baBr207oZ/dO6MpGXtNYb6M0a/a5M0UOlOPwHHJutwIqa9
   A==;
X-CSE-ConnectionGUID: FYYHDh0ZSReB0kZB5cSE7w==
X-CSE-MsgGUID: 9DN7PhtOTMy3KL7UzqjY8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41187713"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41187713"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:05:35 -0800
X-CSE-ConnectionGUID: bmwojJy2R9y2fe7aUkBKJw==
X-CSE-MsgGUID: LIenP46HT/eSa0i+DPjIHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123563998"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:05:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 15:05:24 +0200 (EET)
To: Paolo Abeni <pabeni@redhat.com>
cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, 
    Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
    Simon Horman <horms@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
    Jose Abreu <Jose.Abreu@synopsys.com>, 
    David E Box <david.e.box@linux.intel.com>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
    Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, David E Box <david.e.box@intel.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
    Richard Cochran <richardcochran@gmail.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jiawen Wu <jiawenwu@trustnetic.com>, 
    Mengyuan Lou <mengyuanlou@net-swift.com>, 
    Russell King <linux@armlinux.org.uk>, 
    Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next v9 3/6] arch: x86: add IPC mailbox accessor
 function and add SoC register access
In-Reply-To: <48885074-b590-41e6-9794-49ec12713cce@redhat.com>
Message-ID: <d8e04cf2-afb9-dead-f7c2-297c66969081@linux.intel.com>
References: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com> <20250227121522.1802832-4-yong.liang.choong@linux.intel.com> <48885074-b590-41e6-9794-49ec12713cce@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-97556846-1741093524=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-97556846-1741093524=:931
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 4 Mar 2025, Paolo Abeni wrote:

> On 2/27/25 1:15 PM, Choong Yong Liang wrote:
> > From: "David E. Box" <david.e.box@linux.intel.com>
> >=20
> > - Exports intel_pmc_ipc() for host access to the PMC IPC mailbox
> > - Enables the host to access specific SoC registers through the PMC
> > firmware using IPC commands. This access method is necessary for
> > registers that are not available through direct Memory-Mapped I/O (MMIO=
),
> > which is used for other accessible parts of the PMC.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Signed-off-by: Chao Qin <chao.qin@intel.com>
> > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
>=20
> Hans, Ilpo, are you ok with this patch going through the netdev/net-next
> tree?

Yes, it you can merge it through netdev trees.

The function added into the header is a bit large on footprint front but=20
there are not that many callers so I guess it's okay.

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-97556846-1741093524=:931--

