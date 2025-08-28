Return-Path: <netdev+bounces-218015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC692B3AD55
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1414F1C86AF3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C641E1DF2;
	Thu, 28 Aug 2025 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uArQ2skT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0581865FA;
	Thu, 28 Aug 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419357; cv=none; b=exnjWJcLN61rlDB3xoF2BbCbpcuAHYYLFdNYbZanIUcps8yAXuomeckZhQCVkdktjbdlhz2L0EtLQiATzccJNaExB56O7XW4MlMhhPX8lrVsTtTJwIObt/8vbf/6F2QWeYsqDwSf+jBw8VvEZdL3iY112DbhPktI1LGlmamLhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419357; c=relaxed/simple;
	bh=WpjLgVnsW84gTkX+v9HgvEo3Xva+iZRMWjbkkTzhEe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJDonPGJ4HROuaUpFF42mdhZPBFZhDdW8Ih0fxiPWR7ZM7D9VL+09zYFhf2P4YZE22rcAdTRZMIPOE7/jTW71XYyQiwkccDLgTZb7AxR5QSTRG9fNBHVHhRd/p54r2hYORYx29vANpeOrMcVAokLKZRFCzhQu7T94ga2d418DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uArQ2skT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF4AC4CEEB;
	Thu, 28 Aug 2025 22:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756419356;
	bh=WpjLgVnsW84gTkX+v9HgvEo3Xva+iZRMWjbkkTzhEe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uArQ2skTkRGixjydGSnYvA6T0Q4xxXLOVGitNzRJBAcdq5Cg3HUevLJW35+g19o3Y
	 0QXPuoOOCo3MzBkqdbDBg9xZsl3o1rIr8DfDuX61nyyer2wCMx3zSGMHDyFZV90XEw
	 o+FeorayiX7OcQzoKPIkomJ4HxKGgkbTCGbz6CKMWYCxDgSc8FwNu1Hi8WixMfp1mT
	 7hQGF3t//GTEcmFisDRiziZLDiUrErBaLIt4l2ClwVGskz5odHwXP0+JSErQTWB+F3
	 9AF1l/HiNXUP0f4qO+plAiTcWGFQEy1zzk3hRoGAQeXZCl9eAFjYQr6q8zVv9ejJa1
	 E/1BJgWKzmiDQ==
Date: Thu, 28 Aug 2025 15:15:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <20250828151554.7be363a7@kernel.org>
In-Reply-To: <20250828132901.76e00334@kmaincent-XPS-13-7390>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
	<20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
	<d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
	<20250825104721.28f127a2@kmaincent-XPS-13-7390>
	<aKwpW-c-nZidEBe0@pengutronix.de>
	<6317ad1e-7507-4a61-92d0-865c52736b1a@lunn.ch>
	<20250825151422.4cd1ea72@kernel.org>
	<20250828132901.76e00334@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:29:01 +0200 Kory Maincent wrote:
> > Resetting would work either via devlink reload, or ethtool --reset,
> > don't think we even need any API addition there.  
> 
> Is there no way for NIC to reset their configuration except through ethtool
> reload?

Hm, on second thought I'm actually no longer sure if even ethtool or
devlink are right. I think the expectation may be that ethtool resets
the underlying HW but doesn't actually lose the configuration.

