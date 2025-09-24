Return-Path: <netdev+bounces-226120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8036B9C71B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6921B25960
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890527B4E8;
	Wed, 24 Sep 2025 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2B+AppW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D342557A;
	Wed, 24 Sep 2025 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755138; cv=none; b=f8reu2CRJ37vAoupHhtRg2fmupjEV05L0HHTpNwJW8eiUW73IJxeXS+NlBz1JOisVX6GsZgToSnp4UZjcjP6gdCJ3fPlVrqMxMyWpjRNMUrlzrKZscWWa5Dm9PQz6vEY8b24bfDfHb6zl2rxJbYhRdiBlC9EQMJOXmF283xyHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755138; c=relaxed/simple;
	bh=5nkOcXtCrUSyUylrHVFJ3GThi+rvDI6+s49nr6gVhIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuOHLXdVwATsPgLkMWJmSq1VhEWKj3iaLtYp4Ci/NebEQ/yPl+2hXKcvYBaa+mVrv6VqVx1EtCOiE1Z+IFWnYonh4htQLioDa+kW6Fi+2lOkg+gs54ueNrJttbR9IW4hAg5UZMdcaT3KsmNIDLWb/0tA5PJl5nVWUqzi2ga4khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2B+AppW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB16C4CEE7;
	Wed, 24 Sep 2025 23:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758755137;
	bh=5nkOcXtCrUSyUylrHVFJ3GThi+rvDI6+s49nr6gVhIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2B+AppW01bYd+MqBDecD+SP/V9GbfDTxn/PBf73IXN0zz71y/75bOrFOH1ffL15l
	 USGG9YEhz/ZHlUOgLnforvbQS70LJIVGswy1eM+35tuLEoraYhcsC4TOMRB/nDPuP9
	 UADMv215SbIq3RyGg+xQmp5dQE3fV9nuKNwp0YJI2/OLnxu07gQV3lZez3r72J2WPx
	 HSVgGio6T3k726XlmEkC3RNro04vRJDTrStw/cz/LJD4R/4yLir25W9T8CwRkGhQtw
	 zFjHFI+2VjPlHvpJveCKeZrMfZC6ylNEHRf2mC9dv1I/l9MGMjgTl68qnLo78IAmRP
	 QtvXZM8V6kR2g==
Date: Wed, 24 Sep 2025 16:05:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Rohan
 G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <20250924160535.12c14ae9@kernel.org>
In-Reply-To: <a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
	<20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
	<20250917154920.7925a20d@kernel.org>
	<20250917155412.7b2af4f1@kernel.org>
	<a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 10:24:44 +0530 G Thomas, Rohan wrote:
> >> Is the device adding the same VLAN tag twice if the proto is 8021AD?
> >> It looks like it from the code, but how every strange..
> >>
> >> In any case, it doesn't look like the driver is doing anything with
> >> the NETIF_F_HW_VLAN_* flags right? stmmac_vlan_insert() works purely
> >> off of vlan proto. So I think we should do the same thing here?  
> > 
> > I suppose the double tagging depends on the exact SKU but first check
> > looks unnecessary. Maybe stmmac_vlan_insert() should return the number
> > of vlans it decided to insert?
> >   
> 
> I overlooked the behavior of stmmac_vlan_insert(). It seems the hardware
> supports inserting only one VLAN tag at a time, with the default setting
> being SVLAN for 802.1AD and CVLAN for 802.1Q. I'll update the patch to
> simply add VLAN_HLEN when stmmac_vlan_insert() returns true. Please let
> me know if you have any further concerns.

SG, no further concerns.

Please make sure to CC "Ng, Boon Khai" <boon.khai.ng@altera.com>
who wrote the VLAN support (IIRC).

