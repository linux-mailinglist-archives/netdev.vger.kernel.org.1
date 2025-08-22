Return-Path: <netdev+bounces-215872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D096B30AD4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCCB60340D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59DD7261E;
	Fri, 22 Aug 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxExEr8L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CB35959
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826462; cv=none; b=r+zhVGrdS6efMgvcvy5NybgZ6TcpXlN+qYwHSCcVnbG8CIz07Wke3K328U1oPL/fVwjjPigPV1NWxcYO9Wfc3AjJjR8lUhPbttPQAT6AXQkXG/IP9mqSqA/2cwVz6pstBzI27hqp4z/2nF0YlggCQ+0zrJBKwEp2z4AXrroXgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826462; c=relaxed/simple;
	bh=j+Yb2j8C3mFnmz7WMNjNKgDTVrfq88wM83FlGUgun6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJF3czT5TYkg0VQ559hUGefhzmsHofUBPzoKIi+Ju1kPnJlmxKo/pSZLFXSrCn2C67JVVqxnE0shp4vEN8dwVoyGJw7gbBaV8C6rHAeOe141mYlh5oHDlD/gUcrAPFOAjLz2g1GgWnmWExvs+2lkj8TwB7mzvfO/r8ZhMN0zses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxExEr8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF326C4CEEB;
	Fri, 22 Aug 2025 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755826461;
	bh=j+Yb2j8C3mFnmz7WMNjNKgDTVrfq88wM83FlGUgun6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxExEr8L2faQ29gha1mxa9BuNpvCbY2e8XPxKXllL7ZRKXtLGm1G42dsY5nhjmOm1
	 H3p15NCGQeXBeARCXbotMCHFMXlvHjC43cbsjN4TAyEuJlKzXAVpXQBu6hRN21dtfB
	 JPbml5U+0qn5H1NJFTqqVhhpYvnJg/rt57+XsYpmSf2Wv8JojqvUdFBr3LfWNhq6eQ
	 BCI0iGNV8h68TOPfoxVZ2835SSpv4LO1OnhGWCUc1Pk9Q4DshJ/6wlPES7WhTy8k+/
	 Zvm49ms5ObyemOOxvl0ZQf6BqWt1jPAShHAPjy60xJpCPN06TlvzQaLc066FKZZ5R+
	 +cQMiNq5fds+A==
Date: Thu, 21 Aug 2025 18:34:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: airoha: Add PPE support for RX wlan
 offload
Message-ID: <20250821183420.45af8077@kernel.org>
In-Reply-To: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 14:21:05 +0200 Lorenzo Bianconi wrote:
> Introduce the missing bits to airoha ppe driver to offload traffic received
> by the MT76 driver (wireless NIC) and forwarded by the Packet Processor
> Engine (PPE) to the ethernet interface.

Doesn't apply :( please rebase

