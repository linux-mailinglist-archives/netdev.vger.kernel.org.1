Return-Path: <netdev+bounces-103648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AE908E65
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D621F26E62
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F719AA76;
	Fri, 14 Jun 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmTn2Hs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88516C691;
	Fri, 14 Jun 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377898; cv=none; b=nzBCjArguBD5n+MN9YpQhXUFStLvjXX+kcPdYA6i4hJvzgUbi377xrQnS9lb9hYqwzB5mroiEsk4BBVU1PoPB+KUW/Ukw6JOTtzfkZqSm85pBateqaQsClcmRMTqDNQ7HpWrqMSF8N8ihF/AKsiTJDHwWtajo9s//Nn9eo7j+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377898; c=relaxed/simple;
	bh=We2wVbvGIh4SiL1lFpPuabgIOA7n4JXD4LEC9WjQBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce2g1fQV4tAHhGEAJjHW/Hnt3HPL7GjR5hTMwDUbEe1u0OtrVFRVXmcg4Jj8UO1IUiDv50VvCj68pZfzpshDJdtIYcfjI8wpD8/YaprcAYifdARSeG5tsVzh99JKdmNKeO2SN+A7iLqW+wpl+PofxvKqmV5eWHKTpEuNFtIFlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmTn2Hs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E93C2BD10;
	Fri, 14 Jun 2024 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718377897;
	bh=We2wVbvGIh4SiL1lFpPuabgIOA7n4JXD4LEC9WjQBUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BmTn2Hs+c46ZxbfdiPMiwreMne48EC6AiOqx1IfDnHtzGmZtj/smkaPrg18MSJ6HU
	 CcWtuoA25JBt3pphcW5bblZfdauVBpVxkF53gHSI3yOacGXrSahk8kExBoljnRMnEs
	 AmcO6wzURqiw0/FOmiWhzJXr4KuwRWwbD2Zk6Yc6Jk+PbHQTuC4CjJnO18hdmTTDVf
	 f7PY65xD1riQdw0/I7r61xOWJtfSLyToyvEXhS0+tFcMl/htuPktOAv6Arm5bcg1WT
	 kpYVextxMbIqAsHApM5JIdlHnHXDAWCU7JnP3rA/zIY1kbQIILQi1ap2RTrYP/oBOe
	 9VI2g+jbpOodQ==
Date: Fri, 14 Jun 2024 08:11:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vanillan Wang <songjinjian@hotmail.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v1] net: wwan: t7xx: Add debug port
Message-ID: <20240614081136.17dd3d1f@kernel.org>
In-Reply-To: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
References: <MEYP282MB269762C5070B97CD769C8CD5BBC22@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 17:49:51 +0800 Vanillan Wang wrote:
> From: Jinjian Song <jinjian.song@fibocom.com>
> 
> Add support for userspace to switch on the debug port(ADB,MIPC).
>  - ADB port: /dev/ccci_sap_adb
>  - MIPC port: /dev/ttyMIPC0
> 
> Switch on debug port:
>  - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
> 
> Switch off debug port:
>  - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode

You need to provide more detail on what it does and how it's used.

> +	txq_mtu = t7xx_get_port_mtu(port);
> +	if (txq_mtu < 0)
> +		return -EINVAL;

drivers/net/wwan/t7xx/t7xx_port_debug.c:153:5-12: WARNING: Unsigned expression compared with zero: txq_mtu < 0
-- 
pw-bot: cr

