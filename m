Return-Path: <netdev+bounces-213890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDC6B2742F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747F3582C6A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E72BAF9;
	Fri, 15 Aug 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql1GX3OS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F51F92E;
	Fri, 15 Aug 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218664; cv=none; b=oVaDHpa/n+X3LcmaK27FT3PcSKfGzF7Yg1ddkaCmap2AHG04GYUwsrx8JC8jq144ESKMMCKReLnAaioZ18axYnZeWDfdOock17wVZ8GJDVlLO6ayUxBSJ9RyUDOO5a5K6ODq5fNg3aLEMFeFF1Ofl+rCvqmPk39rbrS8u4umtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218664; c=relaxed/simple;
	bh=tCgQh7vbWR7GLS7Dvxp6J8vUAFhtzPpoYfT8KURAxSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+xm/uoBAMbXj+ASjpyIwnuL1d81uV4lpIqciRU9UnHfsKPL5vj/B+CANc2bjrgPsN9VvxpDQQj1xeaYrrc8upGTNCYQCWJGo38JXy4yl6Uh+yJL0qeDEfSIw4in2jVZLWnpgGPdyeE4dy8DEwT2XvjdwQpSMFx6Ck6f7qt4bt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql1GX3OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E822C4CEED;
	Fri, 15 Aug 2025 00:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755218664;
	bh=tCgQh7vbWR7GLS7Dvxp6J8vUAFhtzPpoYfT8KURAxSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ql1GX3OSEWLcHuef9Y/XLmAFF8GNU+IRpSHY6fPST9UZ2gaW5ApaCUmrNuHofKuB3
	 BHILxtW7lF1O8KHMxdED1TAS+rBqswRL80IgOb+dm4vAGzHVBRx/df6Ir03mHIj0tV
	 ktDXMAoQf7sxieDkiYn72DxwZnfo8RPb9JDV8KkH22j3Ewkzv6LGA4O1VUHa/ctnzj
	 AdGzYXdM+hqWUNuklri7btaTItUT76daFmXaaQ56FkwWOUEl9AUOpKaAqlq1lWLFNx
	 gjBuU0cEcjbcwISsa2ohBLm3FUQJQH7OIq7eYQZKpzFOHmd1fwTZu/ExmdF4A6khJg
	 8X8av7VnZDnwg==
Date: Thu, 14 Aug 2025 17:44:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Po-Yu
 Chuang <ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <taoren@meta.com>, <bmc-sw2@aspeedtech.com>
Subject: Re: [net-next v2 0/4] Add AST2600 RGMII delay into ftgmac100
Message-ID: <20250814174422.17ed3e32@kernel.org>
In-Reply-To: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
References: <20250813063301.338851-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 14:32:57 +0800 Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the 
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to 
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration 
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay 
> properties for each MAC type. Corresponding changes are made to the device tree 
> source files and the FTGMAC100 driver to support the new delay configuration.

First patch doesn't apply cleanly, please respin.
-- 
pw-bot: cr

