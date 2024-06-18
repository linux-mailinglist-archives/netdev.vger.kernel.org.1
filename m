Return-Path: <netdev+bounces-104587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0590D71B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39121C255A7
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C640879;
	Tue, 18 Jun 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcJWtPJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A281D531;
	Tue, 18 Jun 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724073; cv=none; b=mlwyWRE9y7qa/WUJvNnm6ALJVGaI+BT3UmSqfQeXpiYfhYX8irlpVno5qa4hdtoUE3kMzJU7grO1kT9I+qkBjbAI9Cw2nzc47WqAU1bX18+kgyrNgBxKKqEd8dcmAB5zMyYqYYbf6ODuqlPypsfgN1a2TrkIkSzzD2ij0Cgi3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724073; c=relaxed/simple;
	bh=pftZobImKhsOZDGQpcO6l7rtiCtIORxyQekHLEb4TL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijdFVyESzw9kZb4Q92YkCoO56wzcU0lAfTeM6U4Mq6xURlNHKqsujxBF5CWjKJ9GCzfJW0p5JHHy8CeLzFS48JQOaHZSoMLlglkuYeqsvD/MP85SiOEeeYVWbub22yoo3pGwUTBZmBHhPhikpkScEFV1xgHZ2UcNrDIzBU76gC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcJWtPJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C07C3277B;
	Tue, 18 Jun 2024 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724072;
	bh=pftZobImKhsOZDGQpcO6l7rtiCtIORxyQekHLEb4TL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcJWtPJf3vEj86v2xNuwAcgNgX+rYIaB4a7zu8zFgUJwtPpYlgkTf+mv2C7xQTTuU
	 lqvIzkBWi10sytsNherZxhuDxCp5t2IUftghf/la/fsOvUdEI3g2v4A8CL5Ml+Jd0l
	 Nxp5hWsfHb/v/8/ma6QtA/W0SMraGM2TclONNXOXRfdbqUlqLoIWde+uvzJBdcbb2a
	 Edsb272wNYVU9x6cnnlJhsjZDVOQ6QnfYjRnkU0Q/+ZQLqdK6ckKo9gH1IyqtDuyYA
	 mmDBMU/rCkCokdRrTlZPU7OEQIPkdkuuwnk5U7MrxAvDjeuvZhNu0rdL4rlVfwqCnM
	 2x8/M5bFsgRVw==
Date: Tue, 18 Jun 2024 08:21:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Daniel Golle <daniel@makrotopia.org>, Qingfang Deng
 <dqfext@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Message-ID: <20240618082111.27d386b6@kernel.org>
In-Reply-To: <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	<20240613104023.13044-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 18:40:20 +0800 Sky Huang wrote:
> This patch moves mtk-ge-soc.c's LED code into mtk phy lib. We
> can use those helper functions in mtk-ge.c as well. That is to
> say, we have almost the same HW LED controller design in
> mt7530/mt7531/mt7981/mt7988's Giga ethernet phy.
> 
> Also integrate read/write pages into one helper function. They
> are basically the same.

Could you please split this into multiple patches? maybe:
 - change the line wrapping
 - integrate read/write pages into one helper 
 - create mtk-phy-lib.c and mtk.h (pure code move)
 - add support for LEDs to the other SoC

