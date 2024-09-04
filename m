Return-Path: <netdev+bounces-125019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F096B98B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021331C21F49
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CA1CFED8;
	Wed,  4 Sep 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzMcoTNG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9D148314;
	Wed,  4 Sep 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447633; cv=none; b=VLCq/3weFGmRnj6OpzDfZ/bOFBNzaIlC/bzGQs6IWGPNOtDUC+lAKGLIMjV1lg4pO0EOK+kJRjbkTZVTlRak68sHm6bJGWxXHHJJmv6ooYekhbN13m5G/hLnQ+u7JRZfcAepQjg4Wr9gVtijqZ7uV5dNBtosU7blPtX4e1GLJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447633; c=relaxed/simple;
	bh=UygYcQ/LzVP31nPaZsHI4RslRa+sYEIGCbUhhIJlibs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alL/8zfMd8yO6ymoWIGz7eJITXlBIrivu4Sa1YRx7eZWFPFvaaujB+0rjp7XNGr+Xad3CXMfp6M7d5miwcfEHBDc8s426AXDYhtHaTtlfkSXCAUjyY1ELmjlb0izwJ5UsCKt59GMspzVdMMqZA9Xu1mV3n2boQpavBi5AvrquWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzMcoTNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25DBC4CEC2;
	Wed,  4 Sep 2024 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447633;
	bh=UygYcQ/LzVP31nPaZsHI4RslRa+sYEIGCbUhhIJlibs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nzMcoTNGHjXlh9L3pbV4jst00qzkXgCGMJ9rxVBzMjP6ClzKuU+79wtacmQSIL9TC
	 9x76i5jTn31kpggWXpcTX5rg/rXLt304Dz1Uikp0iVJwNloEtmWKu7oSeDxiYAQDxO
	 CvPgl8KjIYoDryV5Qptge2qldMyzZamu3PHcPEQRU94PQCsfDx77UFpQ2AiOSh8Vkt
	 39BnNSxG4VIPaoCgv6QxQl2nNst54888IfpkAYteQdtBqU3DQpUixOle0MkEP4U5wn
	 /q4lQlKnZvXjKHJ2EDl0cveCZ55Hsx5oZOHUKBM5eVJKREtA9zHW8v201IMen1z+Ct
	 N3W5yEZaczC1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE53806651;
	Wed,  4 Sep 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12] net: microchip: add FDMA library and use it
 for Sparx5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172544763348.964331.11456457635020343519.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 11:00:33 +0000
References: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
In-Reply-To: <20240902-fdma-sparx5-v1-0-1e7d5e5a9f34@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 rdunlap@infradead.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jensemil.schulzostergaard@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 2 Sep 2024 16:54:05 +0200 you wrote:
> This patch series is the first of a 2-part series, that adds a new
> common FDMA library for Microchip switch chips Sparx5 and lan966x. These
> chips share the same FDMA engine, and as such will benefit from a
> common library with a common implementation.  This also has the benefit
> of removing a lot open-coded bookkeeping and duplicate code for the two
> drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] net: microchip: add FDMA library
    https://git.kernel.org/netdev/net-next/c/30e48a75df9c
  - [net-next,02/12] net: sparx5: use FDMA library symbols
    https://git.kernel.org/netdev/net-next/c/947a72f40f69
  - [net-next,03/12] net: sparx5: replace a few variables with new equivalent ones
    https://git.kernel.org/netdev/net-next/c/e8218f7a9f44
  - [net-next,04/12] net: sparx5: use the FDMA library for allocation of rx buffers
    https://git.kernel.org/netdev/net-next/c/8fec1cea941d
  - [net-next,05/12] net: sparx5: use FDMA library for adding DCB's in the rx path
    https://git.kernel.org/netdev/net-next/c/17b952108681
  - [net-next,06/12] net: sparx5: use library helper for freeing rx buffers
    https://git.kernel.org/netdev/net-next/c/6647f2fd8df0
  - [net-next,07/12] net: sparx5: use a few FDMA helpers in the rx path
    https://git.kernel.org/netdev/net-next/c/4ff58c394715
  - [net-next,08/12] net: sparx5: use the FDMA library for allocation of tx buffers
    https://git.kernel.org/netdev/net-next/c/0a5c44085089
  - [net-next,09/12] net: sparx5: use FDMA library for adding DCB's in the tx path
    https://git.kernel.org/netdev/net-next/c/f4aa7e361ae2
  - [net-next,10/12] net: sparx5: use library helper for freeing tx buffers
    https://git.kernel.org/netdev/net-next/c/bb7a60dab43b
  - [net-next,11/12] net: sparx5: use contiguous memory for tx buffers
    https://git.kernel.org/netdev/net-next/c/55e84c3cfd06
  - [net-next,12/12] net: sparx5: ditch sparx5_fdma_rx/tx_reload() functions
    https://git.kernel.org/netdev/net-next/c/51152312dc99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



