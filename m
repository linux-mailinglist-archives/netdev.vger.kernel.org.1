Return-Path: <netdev+bounces-117336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E994DA5F
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841821C21AD3
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6F913699A;
	Sat, 10 Aug 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExPDsC0+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B0EEB3;
	Sat, 10 Aug 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261739; cv=none; b=uYT9PSvAy8ludpEqxGG2J3qOXkWbnvm4UYW7JgxBVJqEmFKgT+YK2JajKfYZsPZ7CCkWzBScGQ5ku2kgKX/PkFDvJ46dem4LEdqnmFhNjJMcVIshMW2NLRnnhZwewq8DXv+wCn2mHNXhvoah+Ig9wwgDqqgBiA/zpwVqxRoh2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261739; c=relaxed/simple;
	bh=pDNWE9wALykBb+Y861pg6FdZ9CIfytcVsv3kZBYsu+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvF/PiE9NfxgKvjeXPJtUoyDRAHcuuUGqfciNcVN+hFNaYt31ny4S35YDr6iYNhiFj/jlglWHT8E5vIZ6sCZJn7caOE0RNjxncV5g1W5CBnw9HMNd7BRjwwu+ybfqKJd461shpcJ5ejcXVAO6s6cHQKWJ43P2M1JCqaWqQOHpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExPDsC0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A8AC32781;
	Sat, 10 Aug 2024 03:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723261739;
	bh=pDNWE9wALykBb+Y861pg6FdZ9CIfytcVsv3kZBYsu+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ExPDsC0+NUVSz2AMCD4RNRV4VSbSg5egfVBGuYXQrYMSJXY/7r9umrxq9Zm0H9E3i
	 fIsRTzg3YUvguLITQTW4SEtvUxmZkdW7a3G+k08JCATQ5t6Qbt+4AcuYRvjyz5SGhE
	 OQu5XFTF5Lz9ul2XZWbkTHoM87M+7tRfonXtN1AwKRX3jqvafgU3yJWn5pN/4dNuZH
	 J6MVKg03M64Pt2naXYWGWxb7IUTlH8gr4vFifSMZfMLWNj/FAXmha3c/x/hwTQdrMI
	 /vBNbQHyuW5XeJOmg4re2VDE71glw3WkTDZauotKqxC5RuHT1w0UKDH0tcfJE2DYSX
	 YNVCxnFIctsoQ==
Date: Fri, 9 Aug 2024 20:48:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
 imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using
 unevaluatedProperties
Message-ID: <20240809204857.7ea2896b@kernel.org>
In-Reply-To: <20240802205733.2841570-1-Frank.Li@nxp.com>
References: <20240802205733.2841570-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 16:57:33 -0400 Frank Li wrote:
> Replace additionalProperties with unevaluatedProperties because it have
> allOf: $ref: ethernet-controller.yaml#.
> 
> Fixed below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
>    fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#


We need a review tag from device tree maintainers, please repost once
you get one (or if you don't hear back by the end of next week).
I presume they may be on vacation given the time of the year.

