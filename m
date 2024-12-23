Return-Path: <netdev+bounces-154091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DF9FB3F8
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0F7A0F9A
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652211BEF75;
	Mon, 23 Dec 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2t5vs6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D01B87CB
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734978245; cv=none; b=UtDeo4F22pA5BkLGydpvo0CS+41784Fa8Ug1y8Z0WrvAsusOgC3tXjHqsUcUsMF8OvJFvztrSuLp68I6cFK8r3YP7qkluEzUTOpRAj40a4lOl1Cu5uo25l/BDU3zvh5lorzsX+JYpA1IBFlXC1NbDcP698o1p/KsMXKLtbCuZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734978245; c=relaxed/simple;
	bh=VADdV0tgt4dlF/jPS6qkACMW6RCd3387UrMHCbPpoxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar7l5FpltBciHr2ERLi4HBlM2SC2GVYmRBVTqvSAnX52+RRJ3dPURFEkZr2IZOtVg8hxWA0BNzSYqKucCfnUl5fYaFdtX0j1KS5t+BOGTNqUhwK44qHMwzB0mKHHmBjJy1vSACErwIHVj7C58qJ3dT42cH5EuM5A9+gTkfRADrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2t5vs6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62099C4CED3;
	Mon, 23 Dec 2024 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734978244;
	bh=VADdV0tgt4dlF/jPS6qkACMW6RCd3387UrMHCbPpoxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a2t5vs6m98WzZq4oNUW/X/j+SZNoxNcDuERzvuE200RxGj8IKFbXXz2yoIqjcE59m
	 dFTS6i1+6nUmv7G5ZXs+EKfo4p9WSolP+OIbDFsXoby4AXwZq4oDx/7Qn9vmcFRdFp
	 MonYZ+RNbAVWfvi9TfMrsLUT0EnRJLiC7gR06eQwckOw5PMCQ7IZLEsv3yjr+fS2QW
	 MwbetKuMuP3bO3mYSF5eR8Xx/qgvHePeYhC+X5W3/LsS4ca0V0T7qY55u+tXxM+Y/D
	 dJzya953d2ljiOKCi0X/TAxN/ljtDU7LtP+q0547g5zpbv+4c3qJecDYzNB3Tf2Lrc
	 foy41QGnQtqAA==
Date: Mon, 23 Dec 2024 10:24:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Cc: hfdevel@gmx.net, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] net: tn40xx: add support for AQR105
 based cards
Message-ID: <20241223102403.69808901@kernel.org>
In-Reply-To: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
References: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 15:43:35 +0100 Hans-Frieder Vogt via B4 Relay wrote:
> This patch series adds support to the Tehuti tn40xx driver for TN9510 cards
> which combine a TN4010 MAC with an Aquantia AQR105.
> It is an update of the patch series "net: tn40xx: add support for AQR105
> based cards", addressing review comments and generally cleaning up the series.
> 
> The patch was tested on a Tehuti TN9510 card (1fc9:4025:1fc9:3015).

## Form letter - winter-break

Networking development is suspended for winter holidays, until Jan 2nd.
We are currently accepting bug fixes only, see the announcements at:

https://lore.kernel.org/20241211164022.6a075d3a@kernel.org
https://lore.kernel.org/20241220182851.7acb6416@kernel.org

RFC patches sent for review only are welcome at any time.
-- 
pw-bot: defer
pv-bot: closed

