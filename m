Return-Path: <netdev+bounces-132280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FD991276
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A752283372
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A801B4F35;
	Fri,  4 Oct 2024 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKEDZyof"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB971B4F34;
	Fri,  4 Oct 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081782; cv=none; b=OlejLNtydQ8bfL3d3bs6VInQoFnKDA+Ac6lPzOc3T6NnVfXBWqJYCljEWP8t9bWogOcPoiPgcNNp9Pa29h0BPx0MatcsocD0ITGsQSmNlUp6ZDYk758Pkb0RLojZ0kZ+RFVNzR5bm6SAuaXgJcmTPU7ekptq4ntg6bjxRGT4u5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081782; c=relaxed/simple;
	bh=1BMXT1qySlfBTwPHzxMkCNg922NPoFe+hq4k1IIpchM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOs/ypOZwdw2UoeLWAbUsM6Z4tFtUB096wS7nQsPcJb5bLbnxUQLQYovtOxfRGbl1dtdRtjs/jSj5Ckw4SLDAJa3KhINA9ZSk5pnC/9uBgeCX+eJ38/R7mqRwNdpd6T9T/kOFoaMwIbYD9GLqK283fdqWDzbkzElOIBgibPnFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKEDZyof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC26BC4CEC6;
	Fri,  4 Oct 2024 22:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728081781;
	bh=1BMXT1qySlfBTwPHzxMkCNg922NPoFe+hq4k1IIpchM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pKEDZyof2XabtSvvh3focWQGj9C4vtDTvEYtE2/yYpYzb9Z9e4w/57gUHjhleEFLd
	 +S5g/F6fvX04+Dw/0JIRdtaJvlTY9/vmrh2KwlYQXD2nPN7HtDwSfmfeiCkONsuEXJ
	 orF8LJ4FMzDFKF+fE7jvh0Fn1TWiVI0EtNvJ4Yr7LNturnD3RXrkoyeBN4zbQIV88r
	 X5/7JblEWjYgxKSVKxZAjxKG2Xi/ij0YNR+5BXauWNJCzfen3WedkunLsG3CiMUMk4
	 lDlIZTQYoxYO6fr/nEtH9x6tEkVFkunFje7oJRarsRpyecQ3zM2vwNul3lxqT/I8zh
	 D8kQDeHk7x/+Q==
Date: Fri, 4 Oct 2024 15:43:00 -0700
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
Subject: Re: [PATCH net-next 0/9] net: phy: mediatek: Introduce mtk-phy-lib
 which integrates common part of MediaTek's internal ethernet PHYs
Message-ID: <20241004154300.69b30a98@kernel.org>
In-Reply-To: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
References: <20241004102413.5838-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 18:24:04 +0800 Sky Huang wrote:
> Subject: [PATCH net-next 0/9] net: phy: mediatek: Introduce mtk-phy-lib which integrates common part of MediaTek's internal ethernet PHYs

When you repost please shorten this subject.

