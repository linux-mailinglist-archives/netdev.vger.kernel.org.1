Return-Path: <netdev+bounces-135441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0899DF3D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38CF28292A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CC18B486;
	Tue, 15 Oct 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="enm5A3wM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D49474;
	Tue, 15 Oct 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977123; cv=none; b=OwIK7O+o+roxKM0qimB9LpZzZ4TJkr4z69AaGnqrSQeaBal6yMzeFcyKKcF2ZqSp/dn/ZHy/lqCzJbPS78rj1++E7mxfX/ZfNILP+aYH/NvFwU82QJ4VkNRw5wkt29GM9OQRigDd1eWohC4S0EOiMrmHTr58O9eoR2KnFkDq308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977123; c=relaxed/simple;
	bh=HNwnXbZISPM5dAQq/ufCyRD5g/sXSG37J6CeuntZpr4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IejXiVas4rN7tIeTkJ+KzDZJUZfEFSdXj9xrwEtQvDHhItLBTSJjtHBqM5J334Oay2jeQQcYmilJnupUfnA0mUGM+R3DDi7A7bZp+BACkWIeNJUW+HdamOIa89ziRhLsCySdHAOdLogUPaHmydkQK6ujFnza9XCqUvqaTnFnI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=enm5A3wM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728977121; x=1760513121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNwnXbZISPM5dAQq/ufCyRD5g/sXSG37J6CeuntZpr4=;
  b=enm5A3wMgstEBGcqglLUQY4/tGdv+9d1X9zz4XGCwPc68m+tmFKLXlBW
   3SPcYtXvNfpInviT7uUp84GTbnxuC/Fkicata3jF+cvjT61+ZQ42PN7Pk
   wnMpfF2qswBT5KLoRThxGSfTTiheEE6i6aOMe9vtiTdPPbVo6sGTvRIwK
   rPSG6COqMy+RdRDfDgu0dGb+G894u9mPreSPC5AD4ILXXRNmkET4aybyY
   Leg3Vxy7YqBn1EwVhOXiHtVcHIQP2BwYJrw22ndZVQQ/x3lwR7ukjdpX4
   der6Vhvkldigz0FNlgQdK2Vv/GJU+sL5KV9M/0RLf3yCxRuj31ZZuhTn5
   A==;
X-CSE-ConnectionGUID: VOCQDlkbTci7FliPfYogbQ==
X-CSE-MsgGUID: CzdCf0pGQ9+wU5rW2LqoTg==
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="36374574"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2024 00:25:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 15 Oct 2024 00:24:50 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 15 Oct 2024 00:24:48 -0700
Date: Tue, 15 Oct 2024 07:24:48 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 0/2] net: ethernet: freescale: Use %pa to format
 resource_size_t
Message-ID: <20241015072448.6ssv6vsyjpv4vnhi@DEN-DL-M70577>
References: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241014-net-pa-fmt-v1-0-dcc9afb8858b@kernel.org>

> Hi,
> 
> This short series addersses the formatting of variables of
> type resource_size_t in freescale drivers.
> 
> The correct format string for resource_size_t is %pa which
> acts on the address of the variable to be formatted [1].
> 
> [1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229
> 
> These problems were introduced by
> commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
> 
> ---
> Simon Horman (2):
>       net: fec_mpc52xx_phy: Use %pa to format resource_size_t
>       net: ethernet: fs_enet: Use %pa to format resource_size_t
> 
>  drivers/net/ethernet/freescale/fec_mpc52xx_phy.c     | 2 +-
>  drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> base-commit: 6aac56631831e1386b6edd3c583c8afb2abfd267
> 

Hi Simon,

Is this for net-next? I dont see a target tree name :-)

Looking at the docs, %pa seems correct to me.

For the series:

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


