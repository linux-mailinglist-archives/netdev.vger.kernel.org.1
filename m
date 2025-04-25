Return-Path: <netdev+bounces-185811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30EA9BCA4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D038E3AEB6E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56756145FE8;
	Fri, 25 Apr 2025 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8xHJ3QH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF51AAC4;
	Fri, 25 Apr 2025 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547235; cv=none; b=oZ92Ae/VcLIMaP9KW+R+VvdXV8rwpz3OttF8zVuCgm40tJ5MMD9M/t65rOvHs3EniASQ6X9cKgEp2UAIbtBtiDR8p0ZXi/LdJjNtJrHSJe9ytpmgRsLt5VSrVar0dvnIRa49c408+VRi4IqiyORc1G18RwhN82/UZaKThOiehqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547235; c=relaxed/simple;
	bh=zhKRqLVd26FfGbO14mufcGFlylQAXcG1racRs/okgag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo9ojmJLNaRaTvObYttOa3wU6NbQbCMMulPVRyO3lXq/1bmqQxsm58JWBoiZkfwhG5LYCBeg/TOlOEahwjBWk2fo0EPkIy3RipoXAJNFe98TH03H5co+MpksRrgy+OF0zaddwnhScx2K6WtCRWW8rCLm4tjOvpWHsVhorf3bICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8xHJ3QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCE4C4CEE3;
	Fri, 25 Apr 2025 02:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745547233;
	bh=zhKRqLVd26FfGbO14mufcGFlylQAXcG1racRs/okgag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8xHJ3QHyW32cpizyk44/SZZ7fLssnULuTJhyh73dm6ah7nOv+8lQkBFycU3KCBQb
	 gjtKPXLpOLt2qIOu5gy+XDnYUYQpXo3IPhkXuCPr5JhYb2E/zRHT5iPtEiCrTbA8vk
	 0AtJeKfurLux9WVFiolGd6zSbmHF8wlHaDhwftUxAHifydoa4sIC1MSNia9uuKtfNs
	 x0zkRhpUpZDzLXR0ubHxp+qINQrvRLFOKckCEjDzbJVQ1guaZSlY9kZFDQdW3DAvCX
	 /DYOYrQans7jn++GyA6TCj3zsMcytNJQCpANb+tW9D/Q1gAObp27PuYKF1u3xeM+VM
	 R9ahJvStFzGDA==
Date: Thu, 24 Apr 2025 19:13:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, tony@atomide.com, richardcochran@gmail.com,
 glaroque@baylibre.com, schnelle@linux.ibm.com, m-karicheri2@ti.com,
 s.hauer@pengutronix.de, rdunlap@infradead.org, diogo.ivo@siemens.com,
 basharath@couthit.com, horms@kernel.org, jacob.e.keller@intel.com,
 m-malladi@ti.com, javier.carrasco.cruz@gmail.com, afd@ti.com,
 s-anna@ti.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratheesh@ti.com, prajith@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
 krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next v6 04/11] net: ti: prueth: Adds link detection,
 RX and TX support.
Message-ID: <20250424191350.7bf69fdb@kernel.org>
In-Reply-To: <20250423072356.146726-5-parvathi@couthit.com>
References: <20250423060707.145166-1-parvathi@couthit.com>
	<20250423072356.146726-5-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 12:53:49 +0530 Parvathi Pudi wrote:
> +static inline void icssm_prueth_write_reg(struct prueth *prueth,
> +					  enum prueth_mem region,
> +					  unsigned int reg, u32 val)
> +{
> +	writel_relaxed(val, prueth->mem[region].va + reg);
> +}

Please don't use "inline" unnecessarily.
The compiler will inline a single-line static function.

