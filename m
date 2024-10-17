Return-Path: <netdev+bounces-136609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0F9A24DA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED28E1F22E49
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50881DE4C8;
	Thu, 17 Oct 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsRsfTdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1EC1DDA09;
	Thu, 17 Oct 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174799; cv=none; b=Pvgo5g7CoymgF7du6IXMzz/k+3jVFZi5mFwfPXGr4KAA1TFWco6KSpCSpbjYaHhWMrYa/Qubu7WCJKqm9xSRdrbIuv5mkVlEmVLzTs0yE7wWWFt1oBOfO+x8M+Ja5XSE+ZPv9ouaP5fiH8CgT4ydBjnJd2W1umilKTOWO4BR+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174799; c=relaxed/simple;
	bh=dgAWsGv9y58h9ooyR9zbl/FfGLR8dAyl+LlCxHpse6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+zczboesaaZ+pZlrI6TOYDlwPewNQ9xTM9NkeYQB0AAwxnKyA5a8C3N11Ca8gRAgKc9k6NexKvEvFu4nYeWD/MEjTMq5oxx+rBlQLmu7chqTclYeajKUQkNTLJvXAO/Kjz5E1eDQeGBcygEA+idRNcvhz6MFyqQbCqV+0PC20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsRsfTdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42969C4CEC3;
	Thu, 17 Oct 2024 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174799;
	bh=dgAWsGv9y58h9ooyR9zbl/FfGLR8dAyl+LlCxHpse6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsRsfTdQZzaXZxB/Xc9T4upHZgJ0ERByj7F60SeY8LkmC1BGL+WvhOGgkl1EUcIfs
	 8t/ALceDwrMsyz3j7TFn42QWH9wd4EzeWydEHVSgos7agEMZyL6M/Ybynjylw/vh9v
	 ZOFCnkV3a5gh7VtZoABm424C1QI58Zpab8cjpXVCLmnqf429PvHgJRPGJ/i0UdU76i
	 xDPy0ZPDZir/BsJZ5TlrMOd7oTZctb6KriTjKY89Pw4XX//HnEYiCUJ/+nd9ZFnHHx
	 di6WxoxnCWiZi73sj687qZypmFVCy7xJOu+pjV0rB7hBzOKsRrqoBwPGLr8cyIe6Sv
	 ebOAwZtmcoOQA==
Date: Thu, 17 Oct 2024 15:19:54 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek-ge-soc: Propagate
 error code correctly in cal_cycle()
Message-ID: <20241017141954.GR1697@kernel.org>
References: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
 <20241017032213.22256-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017032213.22256-4-SkyLake.Huang@mediatek.com>

On Thu, Oct 17, 2024 at 11:22:13AM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch propagates error code correctly in cal_cycle()
> and improve with FIELD_GET().
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


