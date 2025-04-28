Return-Path: <netdev+bounces-186584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17DA9FD4E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8505B3AF9CF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D9212FA2;
	Mon, 28 Apr 2025 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z99duIrt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662F20B7FD;
	Mon, 28 Apr 2025 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880681; cv=none; b=TWs9v+2vfSztsB9AhqWFSQ6526M9EvMtIRHjsHXqjFKoiWY3XJe+R3vsmsNPoMlrG1I3yreRB3wxVz56y34tD/rol6IziAOkiedbbqnZW7ZjhK1dlVzja0kmlLwAZX08/Q/dBm0FbMyx3VN/FbD1cHXtMjl8zyh8udXV4Suxuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880681; c=relaxed/simple;
	bh=+Igf3TPzbd4lUXpMMfvLIbo9yh62T1vW/fO3Ej27Sps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Os+gPURbbx8pMANuVaW5T0t5Xs/CCvmqnvSby/hBJIo7U0JxiDejSMasxeN48BxIPjwfmwrhqdB+z7Te+Fq1+eF/mI9bRAp1/1khLj2FXYihMPzkyBrDtc/LzhApjTUt+h8BDA/sr+IhkYF4HnrCyIDAXrJKONXfJ+hc3UkTzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z99duIrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256ECC4CEE4;
	Mon, 28 Apr 2025 22:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745880680;
	bh=+Igf3TPzbd4lUXpMMfvLIbo9yh62T1vW/fO3Ej27Sps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z99duIrtAlOCUMmQidEi9/ypYQ7FBFOXg4loWP93Y79QyTNiJ66Ug++0isvyZNPeJ
	 nOneMq/My4cqS10i6IXeQ/aJF4B4inmw3EIB2h2FIrngPHVqIb41/Cf0Q8kqSR9dck
	 PHzKPZcMlmT1KwkrRutvhxbDopGELzEABbdHd/q/z9eKcNtrkAcGmsvD2VL5By8+p9
	 Z8WnnooS86DVgy+jhC1dLP2fVR4cUHHhJMTOH7wQUcf9AspT5DmcZqv2FlZ34OyvQu
	 Xz/QOUXj4S96YrXWMfv2IrwO4xR1CSpXLMCdC2kZM+zmloGxCRHjZ2LTdRt1BycWOS
	 YLzaE1oVBqzhA==
Date: Mon, 28 Apr 2025 15:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] netlink: specs: ethtool: Remove UAPI
 duplication of phy-upstream enum
Message-ID: <20250428155119.386e62c8@kernel.org>
In-Reply-To: <20250425171419.947352-1-kory.maincent@bootlin.com>
References: <20250425171419.947352-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 19:14:18 +0200 Kory Maincent wrote:
> The phy-upstream enum is already defined in the ethtool.h UAPI header
> and used by the ethtool userspace tool. However, the ethtool spec does
> not reference it, causing YNL to auto-generate a duplicate and redundant
> enum.
> 
> Fix this by updating the spec to reference the existing UAPI enum
> in ethtool.h.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Not sure if it should be sent as a fix as there is no real issue here.

Indeed, but better deliver it to users ASAP otherwise some app 
may start using this unnecessary enum.

