Return-Path: <netdev+bounces-219844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F25B43678
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36E358081F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A440C2D321B;
	Thu,  4 Sep 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UdEnBtBS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D302D323E
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976491; cv=none; b=EpfnEVIBduf3t7/ApRXTxVk2siv6WKvnPEHVd35xk1pi0iFFg1QfBec4Mei9hVO+N/hUbCs7+DD7ahqlFdKj4JPO/blMO0SFMMw2L6mLW8sih6HxsdpVgySwhA/AKFMFxHBRMSdVRQFeqawqRNbUm2i6xG3O6JevHEkmT0gimbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976491; c=relaxed/simple;
	bh=1x4kg/lSHFKEZwtFGhhnxS2hi/PCYsq1Mpj3GCMliTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXLxo849yOL9cTZFahdaoLGO9kzWzNfCqWprRQzM1wF53nzprax1f9dS403uqOTEt82qulFfxfShzxk2SVxhrpjXp2N04sdNEuyXMUrBPkh5jqHuBC5RbI6RsZE3gBN3keZz32Q9IGsYtizhVTTedcShieFD/jSKn2K73giMaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UdEnBtBS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756976489; x=1788512489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1x4kg/lSHFKEZwtFGhhnxS2hi/PCYsq1Mpj3GCMliTw=;
  b=UdEnBtBSkDYfCSPXb7jNtGFDjmRmggyAg8jyKzwdJvI04veaAZqFyrXC
   W+12eecJAy7YyR1ks2amSodxbCHPlpLOhiXdKw8lf9h064V6+JCy4IIHw
   CtO+EG+TAE3q6VNetIN7KClKPFuUH0wgT6VXNn2zc0uXa67SCFD1h9N1/
   Lo54UpSHEP5ebjVgvtlDlfcxh2El54QoAi97oijkRgecCTxKEhrvny2Ey
   0boh0ZQeG5KvyTXK6INsoYiL0aWTfWUlZ6mN0mhM4tGqXyaq6t4g8VR2H
   fO4REjrdTK+Fgv5Cd5oZ3vmwUsT/5ZMAoZdWJwSZ+RSlstNnKViOfK9/2
   Q==;
X-CSE-ConnectionGUID: bdgyRKsyQX65qVBU1JdE8A==
X-CSE-MsgGUID: NTKEExcBR5KFHPR5TeUAmg==
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="213462108"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2025 02:01:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 4 Sep 2025 02:00:58 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 4 Sep 2025 02:00:56 -0700
Date: Thu, 4 Sep 2025 09:00:56 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, "maintainer:MICROCHIP LAN966X ETHERNET
 DRIVER" <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCHv2 net-next 2/2] net: lan966x: convert fwnode to of
Message-ID: <20250904090056.q2w7ufpnkx33leab@DEN-DL-M70577>
References: <20250901202001.27024-1-rosenp@gmail.com>
 <20250901202001.27024-3-rosenp@gmail.com>
 <20250903165509.6617e812@kernel.org>
 <CAKxU2N_RaPLj07ZqxtefPUJCnRbThZjKhpqfpey9QB2g3kNfsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_RaPLj07ZqxtefPUJCnRbThZjKhpqfpey9QB2g3kNfsw@mail.gmail.com>

> On Wed, Sep 3, 2025 at 4:55 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon,  1 Sep 2025 13:20:01 -0700 Rosen Penev wrote:
> > > This is a purely OF driver. There's no need for fwnode to handle any of
> > > this, with the exception being phylik_create. Use of_fwnode_handle for
> > > that.
> >
> > Not sure this is worth cleaning up, but I'm not an OF API expert.
> > It's pretty odd that you're sneaking in an extra error check in
> > such a cleanup patch without even mentioning it.
> git grep shows most drivers handling the error.
> 
> git grep of_get_phy_mode drivers/ | grep -v = | wc -l
> 7
> git grep \ =\ of_get_phy_mode drivers/ | wc -l
> 48
> 
> I don't see why it should be different here.
> 
> Actually without handling the error, phy_mode gets used unassigned in
> lan966x_probe_port
> 
> The fwnode API is different as it conflates int and phy_connection_t
> as the same thing.
> > --
> > pw-bot: cr

About the added error check - I agree with Jakub that this deserves to be
mentioned, and should be a patch on its own. 

I did some testing on lan966x, and before the added error check, it was
actually possible to omit phy-mode from the DT, and still have a valid port
configuration - but then again, the bindings documents phy-mode as a required
property.. maybe this should be enforced in the code.

As for the fwnode -> of changes, those looks good to me.

/Daniel


