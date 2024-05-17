Return-Path: <netdev+bounces-97026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB88C8CC7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEB81F237D3
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C2140361;
	Fri, 17 May 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehWfqDZy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E613FD8A;
	Fri, 17 May 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973908; cv=none; b=RMRxAvUzdl+IVvSmHTFW8s6sVq1fJyhes8wtm0tn/pqt3s1jCYoXQmBwHK6vOdzWR36p/1RGbt1G3+gU5I5a+2fnuxfh2NU0d2ET8npY+izGbUCjI1V44+OHbxEeCrzVAZbdHAsApYn3CaAT7eXcytR9LinNznsY+sfU04l6yKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973908; c=relaxed/simple;
	bh=/3O6xh3ZRzV6Si7LjW+KRUeE2S5HEJe+NnuEgo/XM/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUWUL/xNfK3eJpEesN/mvNIKvG56Nrft+VheYp47vTfJD+85RL1z0R7VbeWbzUL6svMtuhvd7o649CV25t90orhqu+x76s6Xp4PpZbRJ7LRopvSdN9AInqNOG9d6x1j9hVZNLiuNw6yei6qkdZUUNC6tw3OQWcpDdt2uhCGkPJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehWfqDZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F968C2BD10;
	Fri, 17 May 2024 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973908;
	bh=/3O6xh3ZRzV6Si7LjW+KRUeE2S5HEJe+NnuEgo/XM/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ehWfqDZyq74VWpQAs1krpCW/3GkAIu8oUERjHpj+WWDelG7m/EV3fZVqq/RgY+AD1
	 5P20CyRJtXxtvcFjHYmWfzDlu1XFaw3wVjm7PCAkTPDUnQeEcmlFfBoMX/5EW6QWy+
	 9Ycf/YVXt5Tt0pd9e4QpNzFpKwq3gfZNhXCDavjAKhuEt9ATuttREzdCd4Pc1yllK6
	 tAQ9Pzn24jWmxSCNMUOnn3cFzLeUPokEZHfJ97HTJtGnWd5AHqukirSZfeTeEBqKcN
	 XrBrI6oU86GwEpOuPJ9gk1ju3flFVBvk4eMCqv6sD4f9R0UHYPdJQFiEheCHitjGH/
	 CH4u01eUj1DGw==
Date: Fri, 17 May 2024 12:25:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <harini.katakam@amd.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <michal.simek@amd.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 0/2] net: xilinx_gmii2rgmii: Add clock
 support
Message-ID: <20240517122506.76c24f6c@kernel.org>
In-Reply-To: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
References: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 11:17:43 +0530 Vineeth Karumanchi wrote:
> Add input clock support to gmii_to_rgmii IP.
> Add "clocks" bindings for the input clock.

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


