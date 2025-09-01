Return-Path: <netdev+bounces-218751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E0B3E448
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E40B481593
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F588340DAD;
	Mon,  1 Sep 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEE7KJGv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A1340D82;
	Mon,  1 Sep 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732257; cv=none; b=S43+EEzsslvSj3/saMGDhUO+cF88tJODVB7afiOyd4stiC97xm7w5YzBCoLVZcG5OfDomb00xPcgdwQnPC+XjRQ2aVOWtaPZAahmML8v7a1WLiqHzxSpKAmw0TZPe5q2zNeRgKcVnHUZ3WkWRzL2lQMR8TMrL9nJ3p3KpkNLH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732257; c=relaxed/simple;
	bh=4V77czxSAI6Dzv+0pZ9aaqwXdKgHJawuK0Oq1EYy4M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS1xRV0J6NnHdynReafCHrErLl7cD4v80EKcVQ6xduCvPLlXeqiR8SBQbu4lovlC0DYMN6Yl+P6EW1dMYlM09DGNotLiwHMHsLK/IzqFDYJqZwsHAJVYls9dgmVqIDG0nNpyicz0POK/S+YYL/AA7IT9qsA3xUS/aJNDSzXxUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEE7KJGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F3AC4CEF0;
	Mon,  1 Sep 2025 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732256;
	bh=4V77czxSAI6Dzv+0pZ9aaqwXdKgHJawuK0Oq1EYy4M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEE7KJGvaGrK/p/d50+/c7Qs1IwPOL98hX+Xb3AjyrK1hqW2uJD7Ep5hXuh+SAiLV
	 Z4/XqyQuawOh9xj7vnMRQZGv+heGUcVfiHxf/OqoAY/BNVwtFfk460M92CVqrY+lYO
	 KSxH11Ha2C/wXZBrCStgNtV20BPEBuQhw+S2B8gsfdO72wVqhYzE5KQWvTLu5+X498
	 gKtdXApx7vgUav0/JnBC1Pxa8DbiKlCxXl14Okm3XuSxrLsU5FrPx3ULl8vVixNW0N
	 cHE7kXIk4tWo/ONOURjITD+xrv0f8nZxuMmUsTYaqo2/sy/8WGEvUvodC6/dUcS8lo
	 +iLvSVyehNpfg==
Date: Mon, 1 Sep 2025 14:10:52 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: qualcomm: QCOM_PPE should depend on
 ARCH_QCOM
Message-ID: <20250901131052.GC13652@horms.kernel.org>
References: <eb7bd6e6ce27eb6d602a63184d9daa80127e32bd.1756466786.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7bd6e6ce27eb6d602a63184d9daa80127e32bd.1756466786.git.geert+renesas@glider.be>

On Fri, Aug 29, 2025 at 01:27:06PM +0200, Geert Uytterhoeven wrote:
> The Qualcomm Technologies, Inc. Packet Process Engine (PPE) is only
> present on Qualcomm IPQ SoCs.  Hence add a dependency on ARCH_QCOM, to
> prevent asking the user about this driver when configuring a kernel
> without Qualcomm platform support,
> 
> Fixes: 353a0f1d5b27606b ("net: ethernet: qualcomm: Add PPE driver for IPQ9574 SoC")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms@kernel.org>

