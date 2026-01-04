Return-Path: <netdev+bounces-246783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DECF1283
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 18:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7DDD30001B3
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616332264D3;
	Sun,  4 Jan 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvxG510H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC651D130E
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767546094; cv=none; b=jgrodDple6MByCFbhb6VPOdNdYSWVpafph1mq7oxe7KD/u0SpVR7poYt67s9LYFurFV+WbE1UJuqoGMmKHslbT0o886P4tulbFa8GKQomnbPzrpLUGhcnm5xSG4hwp6C7tpl04i8KzzLjo6Ly3t4HpB4WdnQtl9i/20+Mg+Lrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767546094; c=relaxed/simple;
	bh=J1U8JdaD6aGP3KbjHWTGB2V3IERIpL0RY6vTFQA7jc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLhwGfXNi4tstXqsXgU7wTYY31MjCX3bCE4WM4Kp5RGnd+wufOFoXFTxxJVOwfit/2P8YbQkL6tIYgUF1wJ+3d7bNPmIQZ/HjCK/grsxVBYEiQP71PIipoYE/jAh+kfGQkdIp9qgA/TTeL/SsRqkybx2owRfkzBx83/yqSEIZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvxG510H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798FEC4CEF7;
	Sun,  4 Jan 2026 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767546093;
	bh=J1U8JdaD6aGP3KbjHWTGB2V3IERIpL0RY6vTFQA7jc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IvxG510HHvT7zIlm8mqvg7HwhC3GXPs8JSv3DemghHShkWFKJXmxkn+3VuPDw1/8W
	 Y0Qnf1qTHIXpACfVmwkRHCWJquuj2jandfcw83Af/wV/i0yrddkSQTTr6cKt3zG9lC
	 cp7E3kDThzeLUHJfcbICtn2Bf7bHxOdypZX5xgkHXFsU8g632T2SY8rOuGhzqBI9aO
	 eC+cq2IvatjRAlX0PHNMNrVkU4yW3aF+fPa93G9sMMSLiFzVybfg//1+FXljOlW17F
	 xVBuNTSfWLOcIxDBhoVK/O9+XyQz44+f8JyuJPGeH9ByRgIvRNP6ZS8VaWHhjZKMCl
	 kaY9H2TPBPJjg==
Date: Sun, 4 Jan 2026 09:01:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, "olteanv@gmail.com"
 <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH v4] net: dsa: realtek: rtl8365mb: remove ifOutDiscards
 from rx_packets
Message-ID: <20260104090132.5b1e676e@kernel.org>
In-Reply-To: <1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
	<2114795695.8721689.1763312184906@mail.yahoo.com>
	<234545199.8734622.1763313511799@mail.yahoo.com>
	<d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
	<20260104073101.2b3a0baa@kernel.org>
	<1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2026 16:54:53 +0100 Mieczyslaw Nalewaj wrote:
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for 
> RTL8365MB-VC")
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Still white space damaged.

I asked you to read a document, have you even opened it?

