Return-Path: <netdev+bounces-214852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93BB2B70D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61331B658A9
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727C1494A8;
	Tue, 19 Aug 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyDG8E3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4662E40E;
	Tue, 19 Aug 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570716; cv=none; b=XJ75YFu/+vvlXX4uVqTTgLXKR2H0MFWUPhOC5G1nKF/TFCB4ZFgmF08tL2rF/mpIDoS0N48yef4mC+BPMzJ/xehav5EXpIEB84LdBgJLOyWeJ05jxyWdRilNIG0UzFoJHrDDvrXNRAXLqUoinjCGIwPb3El46QMNP9dFae3dJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570716; c=relaxed/simple;
	bh=utQ6s8+3ZwIWjuhMgsXN+X1d9ShQsn8bxKj4w09GnD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihSHvycggxa2Gz2T84cs3jgOofRMmuWtS//O8DBPx9gN3GL0VT9ivzajm6d+OY/snVYgU89NvPxkAZHEzCOi4J6m6v4JQMwLmpdGlK9KGzslGpGM9fdv07kHV7v4PUvc3k0px/K2yETOXcWeekq9iqRT42XpucN+Eay7LVz7mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyDG8E3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47252C4CEEB;
	Tue, 19 Aug 2025 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755570716;
	bh=utQ6s8+3ZwIWjuhMgsXN+X1d9ShQsn8bxKj4w09GnD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tyDG8E3/PbaalYSwaP64TxnJ2KAT5D18DQAuAbLuqDcYy2QuwERrk8Be3nrdoYn8X
	 h2aBK85AcTVw13z1ruPNpPVR//pXemtH7tL8fkAMoZfBkxpXtOuzcDscb8znJefvEz
	 0pw8ValyILikjFVCY//NsFE7H/UtY4cr2YtJY7w7IQtSJe+GvWVc0h2rFlrjRFJEk1
	 dYFZ/OnaX6SZdYdzmNWsx/TZ8XKnnR8IJsAgiBM3dpWr1ZThK6wJL8/HmSZb8O1Okm
	 K2mtI1N6cURdyoGNkg0HMiSj+vEKSa5IpRbfpNxoRjUOwLq8JeVSx/hD7H6oASreIO
	 OLZh+5v/zsPLw==
Date: Mon, 18 Aug 2025 19:31:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: mxl-86110: add basic support
 for MxL86111 PHY
Message-ID: <20250818193155.130abd19@kernel.org>
In-Reply-To: <aKHnz1e3nBxWvgFd@pidgin.makrotopia.org>
References: <aKHnz1e3nBxWvgFd@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 15:31:43 +0100 Daniel Golle wrote:
> +/**
> + * mxl86111_probe() - validate bootstrap chip config and set UTP page
> + * @phydev: pointer to the phy_device
> + *
> + * returns 0 or negative errno code

This needs proper formatting:

* Returns: 

please check with ./scripts/kernel-doc -none -Wall $file

> + */
> +static int mxl86111_probe(struct phy_device *phydev)
-- 
pw-bot: cr

