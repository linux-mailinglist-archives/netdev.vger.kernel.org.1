Return-Path: <netdev+bounces-194679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219EACBDFE
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDF016E8FF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 00:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CC12C499;
	Tue,  3 Jun 2025 00:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOdcD/1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D072616;
	Tue,  3 Jun 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748911505; cv=none; b=GQsAdychgiAVhecDs/2TTk10/FQxkCvb3kpYcVTN6QYIBp7MQ7NYERcomKwcXP/1YRM6w2jH/G6Yk1zQYckJAoaeLxfGEfDQpzhsLKm6Jq0EGogEu17IB3vQyy/pylO07k9AqQfBirVjP7vhu9dlZVmp5K3Rx8spSjcR1Lsxcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748911505; c=relaxed/simple;
	bh=CtdqVukD0DJI27l2rhdGZkkUVaZv1kkMZXA6szMAXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo2djNUp59rizKd+UHakPhW4gdNi3pvBuzkA4WZWshEowitQzIvXiDon1PK/jZgjE8+ncd377x+aJyt37j9q+aKY5cuSU1arDb9K78kxDlfPusBY/ew2x7f2z1sxrcf3tgpAa/hBzF+I/MmoXhQYfEestjqdvsYmYoHZbyyRB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOdcD/1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB42CC4CEEB;
	Tue,  3 Jun 2025 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748911504;
	bh=CtdqVukD0DJI27l2rhdGZkkUVaZv1kkMZXA6szMAXy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NOdcD/1pHxsJW0QkTuPCdpokqjTaEs/RgqtoGRwNdPAGAR/ze2bDpWE4285V75Zwn
	 lkas9BP/nSwSOY32w2g/ZogOdB1WVQZhYRgRuK4cB7oBHNmTWOByJgBoPmZHtpGxcC
	 VIbQjL+tSr22FQS16R7KRccnEiyi3vik4YfyrO/s8EeBuH2ju/B2+muHSeVWecswjH
	 qGtpFQS/7YaASKpgWAGeDPQiio/vvnVqxDP5dHt5RjUlpR/uzaMsw8Djb1Ja1q/X18
	 MICYIcfKxydT01Dc4SpRHBUwq8f8H1lVs2okd+gMLTorvrXvtiUQvkhvFJxYMmi3oT
	 5y7jR7IsvmaLg==
Date: Mon, 2 Jun 2025 17:45:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stefan Wahren
 <wahrenst@gmx.net>, netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
 imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
Message-ID: <20250602174503.7e1998e6@kernel.org>
In-Reply-To: <20250602224402.1047281-1-Frank.Li@nxp.com>
References: <20250602224402.1047281-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Jun 2025 18:44:01 -0400 Frank Li wrote:
> Convert qca,qca7000.txt yaml format.
> 
> Additional changes:
> - add refs: spi-peripheral-props.yaml, serial-peripheral-props.yaml and
>   ethernet-controller.yaml.
> - simple spi and uart node name.
> - use low case for mac address in examples.
> - add check reg choose spi-peripheral-props.yaml or
>   spi-peripheral-props.yaml.

## Form letter - net-next-closed

Linus has already merged our PR with features for v6.16.
net-next is closed for new drivers, features, code refactoring and
optimizations for the remained for the merge window.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

