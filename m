Return-Path: <netdev+bounces-136309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9B9A1473
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406532839F3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200161D1E6A;
	Wed, 16 Oct 2024 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xXJpZ14J"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C74409
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112184; cv=none; b=hnSL7UafZ8LjoBFjy0Qs/G4r/ZLylspf690ztQuaq+mzGxY78laub3yzk0igyApNfrLA7Uu1iMHHnl4bYwB014wPbk9nKYMco1voaWHpuFkz5QNrJCbfDT1ZZBuikaCTX4VpNzHHQQ4BY63UcU/xytsvz4egKdRqYeKtILzxfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112184; c=relaxed/simple;
	bh=fcUlWfeoZAH5/yLiqnNx62iTRiq/hJYmsL3ku0BWDvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f68Ut9T3+hbKq25b6rk6diLhR4fP2zHP/iBZ480S+9WKlpt3VfFyaqQnMShhhsC/PL8tiHunK+d7WTPoi1KIInSVIxmMaZRSSWc3ooDSMqrn7+s+JzsEJJFM3Zr13ReJqQtvnMsusKsuU2ErGdZTgLvKFc3G5LSQNU4j/OhI/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xXJpZ14J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112183; x=1760648183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fcUlWfeoZAH5/yLiqnNx62iTRiq/hJYmsL3ku0BWDvA=;
  b=xXJpZ14JqH+7B/5XT7j6xtoiE90uz2tqBTriL5ryu7boVbeFuYwmGvAO
   w1EiIYKjmSykF3lGpRTTnjMTeOFhEM0Y/ofVG2y8xOg313SsKkHvO/++Q
   /dRY8Weh33L483H5Us5AFV9IIJWvOk+jFYMLgN8i2KLqxhWNec3YUzXFa
   bX11kx98kSp1HydL0pj3N4eL/bYZDTEk0smnQURQMrfxg7H2eTLIRqjU2
   r+/gh+ycE76st8SK1bNIDEHqWtgRF0gQFZTfDokxkKczNX/7+c1ahFaXQ
   EvoIWZval4twgU1RyCXUHkAQDSFl4HDOCPt6bqT8ZGJniu60lzxeYLQvY
   w==;
X-CSE-ConnectionGUID: nUNYHLxhSzWNbTPqvhxw4Q==
X-CSE-MsgGUID: HXHa26VJR8eSJE+b03RUbQ==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="264206116"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 13:56:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:55:45 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:55:43 -0700
Date: Wed, 16 Oct 2024 20:55:42 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 02/15] net/mlx5: Introduce node type to rate
 group structure
Message-ID: <20241016205542.g5jhsxjbgyptskei@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-3-tariqt@nvidia.com>

> Introduce the `sched_node_type` enum to represent both the group and
> its members as scheduling nodes in the rate hierarchy.
> 
> Add the `type` field to the rate group structure to specify the type of
> the node membership in the rate hierarchy.
> 
> Generalize comments to reflect this flexibility within the rate group
> structure.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>


