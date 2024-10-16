Return-Path: <netdev+bounces-136311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E89A1477
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FF81C2282A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF11D1F63;
	Wed, 16 Oct 2024 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tnjh1aT5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A864409
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112279; cv=none; b=TB5Fl/NF0NSCe5WTOMMKpbMdc4EvSXRXCMQLFkLE98zvffn0JNSgLgmmlexFLOWhm6DjLgMBUgR+8l86qpE/VK0iCxepEW7chu6c/wgsx3KL3mED0udERwI1o3SzanADdCF7CXu7JO4eGdZJlJln0rdCJW80UZ7cwKy1i3hqzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112279; c=relaxed/simple;
	bh=5Vqr0TyjV/+bxFQadIoTsJsxgAjL5rHGs+L6wdVuI3Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7qxo1SKFApWhEeIDITwu3kBJA83Z1hhD1rSpoT9NYUG1I8HmWdH099MFGjcl/mtmIN0hz9EMqqTX8+dvw+Y+OdjXkl4xwNGaUYbtJeRFLW8JhK99o44BspKEHLlUwINrWt1qkUwFdeVAxAgkRb859SRdsxKvzm1xQKcYswrPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tnjh1aT5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112278; x=1760648278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Vqr0TyjV/+bxFQadIoTsJsxgAjL5rHGs+L6wdVuI3Y=;
  b=Tnjh1aT5QBZ00XiGznEJlJusK94vV9SZIFyj60UmMrPXJDUn7DSGpjvX
   pqfpCfW6M06ZImVvWjverY49x3vq+jqyHCH5730Kbo2M0lYnGvC28pFG7
   9rGYD8qyIedY/3aQ8gjQBagXxEInqgiqAXnqXXqjY8ldhzlCh7KkuPIWH
   4GixWXx+xU+FQobe3+lOaF4QNapQ8vSR3wJJ7ZFfGsVLQE2uXTM33UNR5
   OIXAFXsJAPOiBxnFJCVoUz01JVkiP00MRE7BWeHQIFiA7HL+q8boAbykf
   bms03jI6PDBgN+8CAATWkilu0UXa3pba3AwyBGLhuBholgYxdZs4loNAK
   A==;
X-CSE-ConnectionGUID: fkBTHUb6SSS5057hXWkISg==
X-CSE-MsgGUID: 36Rt3MzaR7yYyQRTwXDFzQ==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="36494934"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 13:57:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:57:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:57:53 -0700
Date: Wed, 16 Oct 2024 20:57:52 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 04/15] net/mlx5: Restrict domain list
 insertion to root TSAR ancestors
Message-ID: <20241016205752.sq5mxos75wnr2ege@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-5-tariqt@nvidia.com>

> Update the logic for adding rate groups to the E-Switch domain list,
> ensuring only groups with the root Transmit Scheduling Arbiter as their
> parent are included.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


