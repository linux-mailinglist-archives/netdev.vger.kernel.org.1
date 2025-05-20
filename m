Return-Path: <netdev+bounces-192012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F11ACABE388
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE13188A4A7
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F18270570;
	Tue, 20 May 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTelEoS/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1E25A354;
	Tue, 20 May 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768905; cv=none; b=dqojVJ6Kwo4tCGiGW5d/lnAnm0bw5ua3ajG9fcLbDBP4DPg7PHv36iuEaffl7zWdYmf8wBKtSKWRBiDg5SkCqptDu/Cmkn7nhMBG1uF7S6Fw9AsobQRXR2xzLqcxIH6Z4irvJdA4G7fvfcacWiOX6kj+N9iN/ChAydc0Uyakv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768905; c=relaxed/simple;
	bh=vs3CFjXmqEXOSPVSSq2eRt847mz0iU3nVHHR5d/56uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvfgzDlP9zatTb+4/nMjVVSFkw9DCJnImjQqAivbpKZxr2eFHjnGx3exlwKT+9z7jtJIBMkeZIw+VjMwV7chUvUfzgksFib+9X310MyU4GQooqgjpWro/Lc2Vpw7Qublgtc2GVpmj3EtJYLqqXjJip7VcvhGZL6ifz5m7MrxMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTelEoS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A873FC4CEE9;
	Tue, 20 May 2025 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747768903;
	bh=vs3CFjXmqEXOSPVSSq2eRt847mz0iU3nVHHR5d/56uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTelEoS/+Ch4CXVNu8XnwfONMGSWq32RyBUgHsQLJycqZhkyFy3NXwHEqtfi+hb7h
	 TyOmRv4IMy4Gd2WTDz27ccWRdaPPu+r3YIKz8DvEFJidFUb9IxOpj6oHQWyRbFp8eX
	 MMT0xXZsFI9kL+JS1iv/TQPw7dbxO5rOJo8xFhixQY2N5YYe5tuvGzTj9W6NymERve
	 FV7KENOfVGyPWgENAPjQCx0e+4yOdxsA8GpricQpQ1d+oO/ZlZ1uArSJ/Ow2IOHqEq
	 HFwmH9TW0CaBA7evhoWPwCeEuCwBp/3xgXqXWqgLPiJLR+kDExmTJDGvCBClEPQxDL
	 u3iA1N+Lpl9LQ==
Date: Tue, 20 May 2025 12:21:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 corbet@lwn.net, danielwinkler@google.com, davem@davemloft.net,
 edumazet@google.com, haijun.liu@mediatek.com, helgaas@kernel.org,
 horms@kernel.org, johannes@sipsolutions.net, korneld@google.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 rafael.wang@fibocom.com, ricardo.martinez@linux.intel.com,
 ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT
 and FAG count
Message-ID: <20250520122141.025616c9@kernel.org>
In-Reply-To: <20250516084320.66998caf@kernel.org>
References: <20250514104728.10869-1-jinjian.song@fibocom.com>
	<20250515180858.2568d930@kernel.org>
	<20250516084320.66998caf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 10:59:34 +0800 Jinjian Song wrote:
>   If it's not feasible to directly add parameters for configuring this RX buffer(BAT/FAG) to 
> the mtk_t7xx driver, would it be allowed to add aparameter for a default configuration 
> ratio (1/2, 1/4)? Or is it not recommended to use driver parameters for mtk_t7xx driver.

Looks into devlink params then

