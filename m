Return-Path: <netdev+bounces-186820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7FBAA1ACB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27D15A7C11
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED784253959;
	Tue, 29 Apr 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anMjw+PL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1425335B;
	Tue, 29 Apr 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952089; cv=none; b=au5xUJaXtNVF4w2we4Ad1Z8i0YaT9A55HxccZjpldIURBMPnF+5tnmm1YrLiA9UBV8CnO8jvdgwaiRxQRLr8aSfY4dAdWEKEyqVhwmOnBeC7L5vNb7ArWS/mlX2hHKBLEcYm2wiWxJ6DGGKM9mKvpzgfaJlSr6RwrpqWQR4dYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952089; c=relaxed/simple;
	bh=/jY1q7+JnkzS1w96PQzgOEj3Ya1LRtB8bbfspqeb6jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPgnvjD0ERg4FeWnS9Wn9aqPCYe3NewtT4cgafW/NVf/T0U7SE9p7Ith0Pv9I1GITY/5rVAp0hQklJ1A3tnvEheDUYw6kUkxvC20A90sc1QjeoJAmcRHW6m8KV7Qh4uT33AhFyXcWjU7/DvmWeFNYJNfGCENFaTm0ziPmDRjxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anMjw+PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7781C4CEE3;
	Tue, 29 Apr 2025 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745952089;
	bh=/jY1q7+JnkzS1w96PQzgOEj3Ya1LRtB8bbfspqeb6jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=anMjw+PLpXbFhZahCBbgFcHCsuvWVwtksuDFlFbXJ/GM1AokiEtLTc52CskgnSSu4
	 YwV1tmKu/3W2cz+WZHbjLSBmryKeRLuX76eF5Ky883xtzi+6B2iPoKPYLmJLVRrLcr
	 nUDa5mdb/DMou1zF44JBF+aEsyw+ohzL7liGARHE1b/8/u81y4zwtI3NA92g34xTIS
	 o5fo040scxHmnWki3opg2RNkhRnsMiHZ26maT06DY+pN/JkG64LBfAzuzmSiwTtkav
	 fdpVB9BB5NKdawcAWVBPYr/1zu/03jfyiSwddA86e7eFgQOCSlcwT2XE2PdsVz+ckb
	 mlV5Y0rOMi1FQ==
Date: Tue, 29 Apr 2025 11:41:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: George Moussalem via B4 Relay
 <devnull+george.moussalem.outlook.com@kernel.org>,
 george.moussalem@outlook.com, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: fix led devicename when using external
 mdio bus
Message-ID: <20250429114128.5b7790ad@kernel.org>
In-Reply-To: <20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com>
References: <20250425-qca8k-leds-v1-1-6316ad36ad22@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 10:49:55 +0400 George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The qca8k dsa switch can use either an external or internal mdio bus.
> This depends on whether the mdio node is defined under the switch node
> itself and, as such, the internal_mdio_mask is populated with its
> internal phys. Upon registering the internal mdio bus, the slave_mii_bus
> of the dsa switch is assigned to this bus. When an external mdio bus is
> used, it is left unassigned, though its id is used to create the device
> names of the leds.
> This leads to the leds being named '(efault):00:green:lan' and so on as
> the slave_mii_bus is null. So let's fix this by adding a null check and
> use the devicename of the external bus instead when an external bus is
> configured.

Hi Andrew, would you mind taking a quick look?

