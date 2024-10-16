Return-Path: <netdev+bounces-136312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D19A1478
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E761F22DE8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63221D1E6A;
	Wed, 16 Oct 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uAnwa/np"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A154409
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112355; cv=none; b=j91/c5MN4ufYu03v+c1CMupF+aHH9C2Em4BlhzZ1qV520DTkhkNALuuGMJHAc2JF0yXksLf8FCnCXOSPieZVJDT+V/dUSKZ9FqZRZtDI5mKeHOVSDIX6pmd4Wsn27wD8+ebPzq3aeNAmAAoPBT1P9a0X0YQpz72rMbM1FCQmP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112355; c=relaxed/simple;
	bh=Zhy/H7Y7jtfLe81AyCqPzYeGXCRLaRpRb2tLGCuhzTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEwyB+JOm1r1NWauo6wpzMrlLYeEPSOIvr5nKfuB8wb2FgKQdk6sHh5M1NKYtRJvUIrdGRXcPJXG+lwWz3Jts3QEuwuo98sKcWLRGeMaN30kSeB+7oabj+58pw16a0Fac3tmx56ZlrHkXjLke/wkWYIU7EaNo2wtldR82x9OvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uAnwa/np; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112354; x=1760648354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zhy/H7Y7jtfLe81AyCqPzYeGXCRLaRpRb2tLGCuhzTg=;
  b=uAnwa/npAmcmkcCgNn8Gb3W1+UbTxoPv+uKG+gqJc4CMMCAbXebC9Oep
   dBvk3IY4CZdKZjtujYZvO8UODs4U6qsJ0LNJz3wmbiPXkenGTYh3BW/Ff
   Dc7clWEELAYHoPRYF7411bWHOj1vlgfgreMD52xt1fyLP6/KyuUWpxtul
   7u+jMo7ar3Bxy3MRlOLs3/0R1ICLtJzFvloTcWY+BRgJFqDjHgu307rPC
   BfKQKYKEzKnQtMXr1Zbo9YkPUMkJWlkf14yJLOf0dBLwoBOkNPFR3GEGo
   Z0G9asBAtg4HRfYS23Pe2eCY/eNybLy3ecWiVGPUn5MW36zfF7kR1koDh
   g==;
X-CSE-ConnectionGUID: oIP3kzKiTAmzpq41ow59EQ==
X-CSE-MsgGUID: j2oWaVitR4aI8vcd1lozjw==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="36494989"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 13:59:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:58:50 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:58:48 -0700
Date: Wed, 16 Oct 2024 20:58:48 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 05/15] net/mlx5: Rename vport QoS group
 reference to parent
Message-ID: <20241016205848.z36ztrqnfq4ma2su@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-6-tariqt@nvidia.com>

> Rename the `group` field in the `mlx5_vport` structure to `parent` to
> clarify the vport's role as a member of a parent group and distinguish
> it from the concept of a general group.
> 
> Additionally, rename `group_entry` to `parent_entry` to reflect this
> update.
> 
> This distinction will be important for handling more complex group
> structures and scheduling elements.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


