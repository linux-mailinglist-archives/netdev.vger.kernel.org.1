Return-Path: <netdev+bounces-132300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C869912F2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA471F21C41
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C739714F12D;
	Fri,  4 Oct 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyaH9P6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4714C59A;
	Fri,  4 Oct 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084103; cv=none; b=u3qfBQ5ZvAOeSJJoNGHVPPTiOroA9eSNj4Fo4YYBSBqA9agXy47bC1M5lkDCCBqRxmXx9TP+/+qZXSHu3DUggXSaidPJFdBSFhjDmwJUNbY57r3vSZP/bEV4mlIA2ZXPrZ2NCB5IsjM45Qcg043NpYsvBkZB6Vg9lXWJtGr8J00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084103; c=relaxed/simple;
	bh=ZSWMM4dkmXfNI2Pdhu/4PwP4Fivh7ED7OSxwyxn9qdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYCMcRRJ/jLwGePxKgrGLTzpGeOqIpMufTDJUfymB7Mg7VBCVk56KB7QBN29AWrm7goJWOk1liowWUhaidJlyLWCMHN5KuX0FYQH6jdyHuokzaywsNH4qctAGZsh2gWhmwjj5ts9g+GBrd2nJmn3b3v+yVu08DZkpdS91VM96qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyaH9P6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5360C4CEC6;
	Fri,  4 Oct 2024 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084103;
	bh=ZSWMM4dkmXfNI2Pdhu/4PwP4Fivh7ED7OSxwyxn9qdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hyaH9P6exbWCwGXVQ553vP2yK9aOCaRE2/xtIXfGARFgw1/xlhM5TNgh7ua8byJus
	 u6Dwh+yz/tM+zd0cdNj7gzXDiPam/C8NEiM92MGw2Rauf1vFzWOYc7ukEdlOzieuSN
	 vAzTWtzop8sR8brtSbxf4XLMUZIwoaLG4Jnq0WJ1aqWib/VGN4pO07CmqPfX6+ksbR
	 HVoqlTZw34RWbQlaE4QqJEFHV3iyBLpf7CzV7XiITH9I+Z08N5hwqmgT2lMK0pHulv
	 SZAu1MFd+krJIzTaH24QjIsnzGAwzl1Wj0vaWRIfxA5oHDDOyYGvVcPmbWg4L5OZGz
	 +nwV0lqHlTNtQ==
Date: Fri, 4 Oct 2024 16:21:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tarun Alle <tarun.alle@microchip.com>
Cc: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5] net: phy: microchip_t1: SQI support for
 LAN887x
Message-ID: <20241004162141.261d2dbd@kernel.org>
In-Reply-To: <20241003162118.232123-1-tarun.alle@microchip.com>
References: <20241003162118.232123-1-tarun.alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 21:51:18 +0530 Tarun Alle wrote:
> +	if (phydev->speed != SPEED_1000 &&
> +	    phydev->speed != SPEED_100) {
> +		return -ENETDOWN;
> +	}

Patch no longer applies, probably because of commit 5fad1c1a09ac ("net:
phy: microchip_t1: Interrupt support for lan887x"). Please rebase and repost.

When you do perhaps drop the unnecessary brackets around the single
statement in the quoted chunk?
-- 
pw-bot: cr

