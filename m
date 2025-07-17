Return-Path: <netdev+bounces-207894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D116B08EC4
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E0B1C24DEF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA032EBDFE;
	Thu, 17 Jul 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmtHm77u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22731DE894;
	Thu, 17 Jul 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760926; cv=none; b=HIbXqTX2F+3SLuPE53vVe7abpXckTyBj47jgiZue2swa+rV/dQwPT9gjTQgMS5vFobTYxIc5t6oOfLYerAXH8Qxe9Cf7wi0e3FtQOB6VR93tAGBHl7fCZtOcakflJSR2i/6OMO+hvIY+EUxlrSJ1JlIaVgaM+uqTUhToVTQGKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760926; c=relaxed/simple;
	bh=KVyD7lFOvqRuleMrpnlzsXkDQLyNjWkA4eJ+WSGLfM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLu+NTgaWq8Mzm93gd4jwpRClDTObT6/95uyo+DnAyyRFEtOtWtV/APXTuioLGy9R3uztlYqHoWvUCnRDimAQ6L2wPSZwK2Wg04bQBHzLihZzTRHW4Ith5vFZbyA809H/hA7WHqkcszp2/Z/ZfVnODr8eF7XWE9JPr+g16JRYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmtHm77u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFEEC4CEE3;
	Thu, 17 Jul 2025 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752760926;
	bh=KVyD7lFOvqRuleMrpnlzsXkDQLyNjWkA4eJ+WSGLfM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZmtHm77uIqjEh59AdgGwDJEJaViM6/f/YJFwK9E6S0h9Jb+XTbD2nn+cBLESgGHZQ
	 omlIP7Xe9cSwaYxSoQsMHKbiAd6hkGVfcndXC/En/OWCAyWb/A0Wagx4KFMj2SQ2Ik
	 p1yl8sXB2Rj4ZRagval+STgnQDrvGomb4jyw9d2PS+ym0A7UcrNFLX4h2QbMRxSqoG
	 VoXEI8xMv532qlMB4fDRCL2mVA4L0na3En5rKaxLfunh9WginRpyv4gIUZExr51dXn
	 O6WcCGjQHPvqrRgcTum2IPACtAg8SYiQm41myJMz4XvBHXr6X1eCDcn3U2Tm+rMv6W
	 f/ItZzHvIOzog==
Date: Thu, 17 Jul 2025 07:02:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH 0/2] Populate of_node for i.MX netdevs
Message-ID: <20250717070204.66e34588@kernel.org>
In-Reply-To: <20250717090037.4097520-1-primoz.fiser@norik.com>
References: <20250717090037.4097520-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 11:00:35 +0200 Primoz Fiser wrote:
> Recently when working on predictable network names for i.MX SoCs, it
> was discovered that of_node sysfs properties are missing for FEC and
> EQOS interfaces.
> 
> Without this, udev is unable to expose the OF_* properties (OF_NAME,
> OF_FULLNAME, OF_COMPATIBLE, OF_ALIAS, etc.) and thus we cannot identify
> interface based on those properties.
> 
> Fix this by populating netdev of_node in respective drivers.

Seems legit, but would be good to CC Open Firmware maintainers.

If we want to make propagating the OF linkage a think I think we should
add a flavor of SET_NETDEV_DEV() which does that for the caller.
SET_NETDEV_DEV_OF() ?
-- 
pw-bot: cr

