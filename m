Return-Path: <netdev+bounces-250411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722BD2A8FA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D5D303021A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058633E350;
	Fri, 16 Jan 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7Z87/fS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65BA271450;
	Fri, 16 Jan 2026 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533070; cv=none; b=DRCbeYdn/M9a8qhGjsAnsSHkCPgEW5HVTPSaVwPlVGOkshLPI+Az++NUpRtS8tCYthA+5oU/BXybMTHB2AyuKTTocul3zlf9nxTYWa+3jUwAptGmjwBtu1HYzvwQmck1+0uqjY8Hs6LhVfNuyQAqFvL5O3SO6OJWmiE90Dv7tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533070; c=relaxed/simple;
	bh=KQWIKFhIXKwpnawXhuI50mbD7zUL5C7YdyjLcK0viS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is+UUq6ArUTcMgXnhyVl29JlcSPAvsuSM2MV6XJqgoF14gjDLHux5LM4aGrmcHednPkihj7J6G/53Q3mBM/HZNDf1fAv4egTaVHvqWNbkesDHHstkNNTBNO53inrVhmUjtxIb5mLPEalNUKDuSI3E2aGR8VgXZH4FFPVztWbx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7Z87/fS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DDC2BCB5;
	Fri, 16 Jan 2026 03:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768533070;
	bh=KQWIKFhIXKwpnawXhuI50mbD7zUL5C7YdyjLcK0viS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V7Z87/fSTYgco61K4c0UrRiSCu3XYGzkoyIsJbG/dXMg9hCEYHcxm+4s00sL4gtge
	 /ogZLhSc0qaGNCQHZKDVASTL0rpssJ8y/roScaLKUsQ4L0V66VwxFUkTIvWjRv1DSu
	 bcj9zZGa7SgyVPS2pUAwkEvrvEcj+vIgaJpvd4O/7nEKBt9i7B8iwn7R9BrqrStlR2
	 O8ADsf2qG/oFyJXeui7h9KV9woHlifrGnC4uqeke0oeAOQlEgxpnAYSCbHrnU1LstL
	 rmBasyxzFGSKuQphbtU4r5B/01IglRTSPlHGJN0uEV/MZ9gDGdMrmnZVciIOd/6Vec
	 IouFdwatDS/8w==
Date: Thu, 15 Jan 2026 19:11:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Minqiang
 <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v3 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <20260115191108.1a7eac9f@kernel.org>
In-Reply-To: <c1b9bc590aa097c98816a3fda6931db9b3d080af.1768519376.git.daniel@makrotopia.org>
References: <cover.1768519376.git.daniel@makrotopia.org>
	<c1b9bc590aa097c98816a3fda6931db9b3d080af.1768519376.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 00:07:37 +0000 Daniel Golle wrote:
> +__diag_push();
> +__diag_ignore_all("-Woverride-init",
> +		  "logic to initialize all and then override some is OK");

This seems quite unjustified to save at a glance 4 lines of code.
-- 
pw-bot: cr

