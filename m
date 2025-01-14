Return-Path: <netdev+bounces-158068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254ADA1056F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126EA7A227F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47B428EC78;
	Tue, 14 Jan 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSMNQRPf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86190284A7C;
	Tue, 14 Jan 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854211; cv=none; b=IbWg+duWqKe6A2Fi9ubH9hiuKYkpobiJIvwQHVQqFEw62xS7hYcM6FnxrdCFpnSPMfEp8Yip026lpjSH5kOk/SYxNPU/Ups6yLapzKI/1R1nBGXnMIAFf2gixu6DCmw7qpF0aPJb0Pm0JvI43wQZPXVxkMILKqZLzvLLaViJVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854211; c=relaxed/simple;
	bh=eLtr5K7Xjdv0cMpF3GIt3LabOZFwfihuPtDo5jsK2so=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIhTmfegyp5hkG9OoOwmtT2YzGJFfBIQ6w3k7xx8PNILSOf2Yne/kZ46O0wZ7RCX4mhpVpkyZhAUEvOUmU6YY6qPmltYy/Y0aFmYr0zo0peqL9TzKLfwMdgIug/FojZ/cJUq8SKo0JdrQFUv4YRNHcOCUW+rlJ2/9E5WqBaWopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSMNQRPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11896C4CEDD;
	Tue, 14 Jan 2025 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736854211;
	bh=eLtr5K7Xjdv0cMpF3GIt3LabOZFwfihuPtDo5jsK2so=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dSMNQRPfNWSP/t/ZXP0ZSPJDMvZrBa2o/+fHVuMyOqgXqiSlIQvMnAXQuftlBRfAS
	 PWpDa6MPZqAzZgSTgF/0I7bfRFZdYpYJVgaWr07lkeTHvZpaQ7BEwpQFjqzz2Rmw+s
	 3lEQwFmWyRvPr2rch0yVEJ2JDstb7D+beeiGDwh9GPLxzwUTqhgXWtRoTpPapcyuuv
	 kwhrWpd3Fftf10MicANRf1IZI4q1U+Y/ov5dOT4JaGBZbdDHOisrMDIS1D8rQtkgBI
	 B3YSkUsJrF4zs6u4wxAJBTDdimqmMKiGV64izclZdF449bIpJ8mQOUembPvgCZpjdD
	 wfAB5EK1FBjoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C6380AA5F;
	Tue, 14 Jan 2025 11:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] Add Multicast Filtering support for VLAN
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173685423375.4146688.6660643987473950530.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 11:30:33 +0000
References: <20250110082852.3899027-1-danishanwar@ti.com>
In-Reply-To: <20250110082852.3899027-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: aha310510@gmail.com, aleksander.lobakin@intel.com, lukma@denx.de,
 m-malladi@ti.com, diogo.ivo@siemens.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, rogerq@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, michal.swiatkowski@linux.intel.com, larysa.zaremba@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 13:58:48 +0530 you wrote:
> This series adds Multicast filtering support for VLAN interfaces in dual
> EMAC and HSR offload mode for ICSSG driver.
> 
> Patch 1/4 - Adds support for VLAN in dual EMAC mode
> Patch 2/4 - Adds MC filtering support for VLAN in dual EMAC mode
> Patch 3/4 - Create and export hsr_get_port_ndev() in hsr_device.c
> Patch 4/4 - Adds MC filtering support for VLAN in HSR mode
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] net: ti: icssg-prueth: Add VLAN support in EMAC mode
    https://git.kernel.org/netdev/net-next/c/816b02e63a75
  - [net-next,v4,2/4] net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC mode
    https://git.kernel.org/netdev/net-next/c/04508d20b017
  - [net-next,v4,3/4] net: hsr: Create and export hsr_get_port_ndev()
    https://git.kernel.org/netdev/net-next/c/9c10dd8eed74
  - [net-next,v4,4/4] net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode
    https://git.kernel.org/netdev/net-next/c/161087db66d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



