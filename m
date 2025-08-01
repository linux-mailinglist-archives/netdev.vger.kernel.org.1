Return-Path: <netdev+bounces-211387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707AB18807
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 22:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DA53A5DB5
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 20:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D720DD48;
	Fri,  1 Aug 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGEh8xjd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFB77111;
	Fri,  1 Aug 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079408; cv=none; b=maX7BRDnbM6TgPLhVOfcULLFEQ60aT4FGSOpn5hbKcnsnt0r3dDsQ/Q3DPQqLtIbl2ayJPMnEt1DxnHKO/k8Ul59zkTxDp4MWw1ePwQ+JzMgcIVD6EpR4Ts18jwghljhPSM5O/MmSxWFhiKm/Ki4VHudIwllbTCWbM5kwvGOdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079408; c=relaxed/simple;
	bh=/CC5jlOrj0HOLtx2QBzIqUYDKmt4Kun4qKsf86Qthk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzsovjZJZX+lSL9aQBkylJa7OuWlH90voRM3hhmITuVbAc6wthhFRXDvJQnAEa6kKPJJfX/JL1wYQrEHXObubJmmwKNV4BUY6PMPJC8DgZP/wtNQk9simQCx5V2M40khrSs+0f+SNfAc+PL+UQF4DDs3bhqPPN095dYsMskYVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGEh8xjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBCAC4CEE7;
	Fri,  1 Aug 2025 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754079408;
	bh=/CC5jlOrj0HOLtx2QBzIqUYDKmt4Kun4qKsf86Qthk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PGEh8xjdVlx3D6kwdOX8RUNt5sIL0+hOxt3km6us5Y475r+NFwODYGc+C/bdss/2z
	 AxUkN3FEunsmKdjxsk9U9XXQVmE9TUEusXAjNs1kRHHAQWYbOqNZbsFdvK7w1jCGbu
	 WNhjTkxKG0m0uhWEtVmJc7AhVf2GXL98XegujHMP45MhpluK/jFqWZTHWRWkzi0DIC
	 nihIiqFAtqQ1Ad/feGj6+iNVLuy7VwpM12gQfKNLHDAE7RzNb/SRdhn322s7A3slR+
	 UeCoWOh9GTP9IvUDnrKW76cznA0oI99pB42mW2Swkt4msUNLCijhK9DPUGVtKL06W2
	 7e4QKsAU/9fjw==
Date: Fri, 1 Aug 2025 13:16:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Message-ID: <20250801131647.316347ed@kernel.org>
In-Reply-To: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 13:37:59 +0200 Krzysztof Kozlowski wrote:
> Marcelo Schmitt, could you confirm that you are okay (or not) with this?

Doesn't look like Marcelo is responding, Marcelo?

