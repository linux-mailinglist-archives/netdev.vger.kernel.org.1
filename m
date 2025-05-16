Return-Path: <netdev+bounces-190903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7886AB9379
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCEF7A5F23
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9131D07BA;
	Fri, 16 May 2025 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGbgPKQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE271F956;
	Fri, 16 May 2025 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357741; cv=none; b=jONY7cFI0GBXQktKdUQNr8Hf/WeS+mVeP0uuiaZQcxV1QuPDCwnxDcG9/Ri4UDolky6DVUGiNGQH2zyzSwbbagqeWgifnWbRHtAeZOUr9DrhzTErSfJSmNp/zOMFsa5FGtu6iA5GN1HV+4HUBERqeyT1+xosUGjj1TkRRQGYFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357741; c=relaxed/simple;
	bh=LlunDUDR2TDmEZ4XUi/62Fa3/lxpELn/iGKcFemx0pY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An9X1wT3vSj9uWjVEfBPbE3POVKNfBeLcmcjHWU4CkByI+xLPp/j+wLAPxfQmMaqjuFIcUGCMN0HPxjCGIePDQMzxH+iYSymSkN5cc6XPsovkoOMVFpjZZNoWY0jI1sJzW2GQU3A0JZ3jNKLwXogytWav751eK0dL6FDYXDXngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGbgPKQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F0C4CEE7;
	Fri, 16 May 2025 01:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747357740;
	bh=LlunDUDR2TDmEZ4XUi/62Fa3/lxpELn/iGKcFemx0pY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RGbgPKQxwqSNa6sH9Id4EeYCV2OlsMGF0tPsQ2HerBXkMsznD/z1C1dV7O90isz/5
	 PvGQjMzjA7R0CEJl7QIWw6BW9uQTvj6EYlwj8YUeyEvzablmHzdgLEsLbBVjNBhCUk
	 HnbbR1dPatfKYT9qMd9bPlH50j8zjn8hnWKtt4jZj/XkJxAPi+AT/oWgrTwivLKlD6
	 cCzJmLUVLB5/3qqoiMZkD25VaGRxzw3iBAmJ64j8yLD9pIrJe49KhLUBaYdZluIFEO
	 8sBH69+tOVkmjgtGEGnxxwtTlqwra9xHqA27Y639nB4an2gwDDGKM3ufJ+jxUOPofZ
	 4inbHkljJci3g==
Date: Thu, 15 May 2025 18:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, rafael.wang@fibocom.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT
 and FAG count
Message-ID: <20250515180858.2568d930@kernel.org>
In-Reply-To: <20250514104728.10869-1-jinjian.song@fibocom.com>
References: <20250514104728.10869-1-jinjian.song@fibocom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 18:47:28 +0800 Jinjian Song wrote:
> The DMA buffer for data plane RX is currently fixed, being parameterized
> to allow configuration.

Module parameters are discouraged, they are pretty poor as an API since
they apply to all devices in the system. Can you describe what "frg"
and "bat" are ? One of the existing APIs likely covers them.
Please also describe the scope (are they per netdev or some sort of
device level params)?
-- 
pw-bot: cr

