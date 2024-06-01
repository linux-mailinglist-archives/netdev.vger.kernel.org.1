Return-Path: <netdev+bounces-99955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80B8D72B7
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EE52818CA
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD844366;
	Sat,  1 Jun 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtLygYHL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073232594;
	Sat,  1 Jun 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284333; cv=none; b=AYVAjuaBU5bHQf1GxZ1lEXygdMR/EAsnmoOvzNpc7mu++qxifQzxnstkYC+ZxP45Y9VHnKQ09iF6DkgmBhPGcDrEOI6TUZl41meZpfChWAmC+sdcur6MwseTJOhTuHiz39qCD5shAVygaBS9Esw3ZDxq7wy4+Y97X/xH9fWeUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284333; c=relaxed/simple;
	bh=bWqX4drNC9o6AwoxILiTunyHa9cMrhcFzjYMPovyb30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQLmSNts/DEvzPUyJG142viuB1o3VCxHfjGTZapLO8UTVPYcN7yj+XoemnZxfuSTv6+z6R1IqKu80wNhQU2hjo8Pru/VwKv22qUvhv6Byohhsf8qPJdBfeh8NkkhYE5hJL4xE004dw1vVRc3Wrxk4nJ+A6Niclx5Y3FIvTamSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtLygYHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCBC116B1;
	Sat,  1 Jun 2024 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717284332;
	bh=bWqX4drNC9o6AwoxILiTunyHa9cMrhcFzjYMPovyb30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YtLygYHLjSp4sAY5FVV96DhW65UNu1NC1loeVslwO+9p6843fVHug4VqzD5kqVWb+
	 JnPi18Cp4Fa12GkvLAtr9mcC4wbSpG7NdgYEcl2rZ1yMyxVXt7kF16GDaEBLtT/D8g
	 luys9rEw+yptp9ytSb3VYJdcsOZxkUkfmXxngNHQceiTnuUd7rVV3Kq830+ONrOSFg
	 UNQPSPFHdKSffslX1PWPclFlHmkyR4fC8Ta+S8nnPmuGaTXJH4Djz9ygClP+3KfpzK
	 aPBYKiQ6incSBIbDIv5dfmqNFwGLRHNpmQZkdx+u+6MgfW//KY0itxqKaEffaw/RGP
	 1BbgwWzaeFvwA==
Date: Sat, 1 Jun 2024 16:25:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/2] lan78xx: Enable 125 MHz CLK and Auto
 Speed configuration for LAN7801 if NO EEPROM is detected
Message-ID: <20240601162531.57670edf@kernel.org>
In-Reply-To: <20240529140256.1849764-1-rengarajan.s@microchip.com>
References: <20240529140256.1849764-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 19:32:54 +0530 Rengarajan S wrote:
> This patch series adds the support for 125 MHz clock, Auto speed and
> auto duplex configuration for LAN7801 in the absence of EEPROM.

I had to look up why this is not a fix.

When someone asks you a question, please edit the commit message /
cover letter so that the answer is obvious for the next revision...

