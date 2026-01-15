Return-Path: <netdev+bounces-250243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C331D259E5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0BAC301B810
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEA2C08A8;
	Thu, 15 Jan 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHyLs57T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EB2BFC85;
	Thu, 15 Jan 2026 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493081; cv=none; b=fV+GCsMuaNRti+PrHq3okaRlBZJXPTP3wN5W4XFsxShKBohxHFab5Z2ujWA1wrcEVnSwzOttt7ja/vaGCF2lysu5z/6msVFphDuEGa3VML5sX/36cJBPDIYfTubp9JzqgDSz7Cq+RG26ODkAR9mk+PvOegC73WyXYNHpQmtWBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493081; c=relaxed/simple;
	bh=VE6kYNx2SzH/A4QC3j/Bhcms/BhuO8QMuFZGjQwPbEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYf6nVwEhEhim33EgjlaT2TOsk4qGW4kfqKcASgflXh9gnrd5Qifn4TivGgeykXqDfSbTgC7N4BXQZy/f5vvfM4FFrug1hILYV5WM8e2VytXPLHHe6BXOhJjY5qmHIIdcOMelpXrjjTsTOtOc6IG61O8NIucBQKJi+tWc2tgqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHyLs57T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE8C116D0;
	Thu, 15 Jan 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768493080;
	bh=VE6kYNx2SzH/A4QC3j/Bhcms/BhuO8QMuFZGjQwPbEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHyLs57TSHDpYyYbKDaDMg1CidjvBMEFp/7Jsveo2QSS9LK1kzLiE5DorVFQSPiZ4
	 DXUbk1hcbJ5KwXXTMRsBGeILs76xkch/Y6zFQJ1tdg7xV9SLRUaD7woPqzbhqgM/BJ
	 g2VuDCUttvglZpVIDI8nzcJ8ykbQ+vIhuonDGvefQZ//oasfnNkOuD6jHav0SHdRTN
	 F+JIlH4qdeRsxRHoxUGqSsmU6yufACBQ3aflDXhPbaSAGERVaD8tCunqLD05dF+ClX
	 FBCehTGB59H7UL64x5Q9Hh5kjUHAYnri8bmSkoMqOUwU17JCi9OOB7/E272AI7rUDh
	 55QJitB1P/BEQ==
Date: Thu, 15 Jan 2026 10:04:39 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-mediatek@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Message-ID: <176849307902.695520.7167171864091079229.robh@kernel.org>
References: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
 <20260108-airoha-ba-memory-region-v3-1-bf1814e5dcc4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-airoha-ba-memory-region-v3-1-bf1814e5dcc4@kernel.org>


On Thu, 08 Jan 2026 16:05:07 +0100, Lorenzo Bianconi wrote:
> Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/net/airoha,en7581-npu.yaml  | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


