Return-Path: <netdev+bounces-136308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0609A1472
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D8D283A07
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A71D1738;
	Wed, 16 Oct 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rBlUdoP8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876418C02F
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112155; cv=none; b=gRKHmqUtPGmZGDE6ZaDEhp+wLz8d5CtWEnlTJK35FyeKp71IANhRGsI07TGK1JqD/qW06PqM3I/aGq1a8BYJz243Tz5mRENLB39XGlKRsxobB7FerdanfG8sBHNNCvm9C6JqgmpWkKofO6thSgzvyetYHHprQabTrxslYqdZR0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112155; c=relaxed/simple;
	bh=l630eQTLeRvwcs74ZQD4gnZjMQn/FJuLHGvG6SLKrlI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM7P9zTY27AGRLTII5ApXJi/Iwdsqf7PuYk0vlyDKULZGxhnuOKW//GkayeS+kggstn428E9pJ9TYc5IMs2AjkD+eKOHl7IVsCZ524LPca+nIpHlbh8rc4DavfX9iceX5tnVhtK51mRjb1Tcxx3bCEWV+BItpXTajTUfMRYsx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rBlUdoP8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729112153; x=1760648153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l630eQTLeRvwcs74ZQD4gnZjMQn/FJuLHGvG6SLKrlI=;
  b=rBlUdoP89gM/v8l+HNK6G2IB6YNJdb2j8Z7Brma1d31iOWKtzjWRhF2C
   tYoxqaxUsnaFyY+bOnbdYjUfkkpZHBX8rhaO8zJOtNXDi0veWByaln94u
   pt65tjuO5YwrLDgssbhalNcFu+mB7SJXny5LiP4IPMazSvVNuEYd2flnH
   XMTszlN9xfu/JMdG74rOXamjmKTIUwA2YGkbOz25uJ0wW2638nUZSmuAT
   EH6lf7JWd9eLikLb3+f8IM5Puy3g0MqVFYsg28a2Pfi/EaVd4h/h6R9sw
   D1uubofmkCXtS7jLWsX38uMJP6KQuAQ1s7/4ujcCKy/8mxtZi5L1CNHKP
   w==;
X-CSE-ConnectionGUID: IC53RsJcQHesdPfTsd9w9A==
X-CSE-MsgGUID: 8rHvCg9+T8q48d6+kkqbpw==
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="32910064"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2024 13:55:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 16 Oct 2024 13:55:12 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 16 Oct 2024 13:55:10 -0700
Date: Wed, 16 Oct 2024 20:55:09 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V3 01/15] net/mlx5: Refactor QoS group
 scheduling element creation
Message-ID: <20241016205509.ibwbnue3ayxgkltc@DEN-DL-M70577>
References: <20241016173617.217736-1-tariqt@nvidia.com>
 <20241016173617.217736-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241016173617.217736-2-tariqt@nvidia.com>

> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce `esw_qos_create_group_sched_elem` to handle the creation of
> group scheduling elements for E-Switch QoS, Transmit Scheduling
> Arbiter (TSAR).
> 
> This reduces duplication and simplifies code for TSAR setup.
>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
 

