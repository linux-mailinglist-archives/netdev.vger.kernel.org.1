Return-Path: <netdev+bounces-95285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1EC8C1D0A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C01C21BDD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F605148FFE;
	Fri, 10 May 2024 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqoTGhxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8A1311A0;
	Fri, 10 May 2024 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312102; cv=none; b=W456SW/JxbvU88/YYvIef9EQ1/SIQbIEo0iYTcDmHzWuF5ppR5zraleniuL6V9H4DLPM+jgDTfosAwU527RcFbioap9036QcitsH4M8dTPckQeklcK/XeWE0rRS9oz0s2FCvV1uPnTfP8CYvOg8g7rv2YJOofAmrAKb+2GtE40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312102; c=relaxed/simple;
	bh=+Ta6Pwu8WoR4FFGhzCqVCvFxwKMS/hKwRzp3wA+8sCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0Lp/4FoJPtudygGS/V9JYIL1tvGjei0bf5HIL3MunHyzb+ZKt5LM9FUqVm36wdsR3Dpt5NbnWRDfy7Ky/qfVuHnFqqrI4fmJ7EuANsE1NSvOIMTf0fbjrM1Sw86u2Q873z2Ce2Lg65z8ng6ua38nwNVp6sBHVMRflqTKv+TPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqoTGhxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D97C113CC;
	Fri, 10 May 2024 03:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312102;
	bh=+Ta6Pwu8WoR4FFGhzCqVCvFxwKMS/hKwRzp3wA+8sCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqoTGhxTNKp+V7lKHBn6M0UcIfkoUIfXnytVptwE6KnEgFtlHWhaB7ETTvCualcdq
	 vbM3ZeF/UlnhazK6UIlxFJoiHJket82X0c2GtSbhIqRd5LV5Se6E7IzFf4k2FpQHpY
	 pmO/KdOE1xiFip8hCf6U53kv7mmd7kNDEa3E+PO36fdDwB8mfYHGqJz32Fq76cl4ff
	 gOLqNfU7Q7axkKGiSkPw4fjqX/UduhiUWzPCvgxCd8zZUaVvZkXKpNrcSQByNmYeUM
	 1HMEKK0KF5Rx6CQwE6Dy959YE5n6Vb08RUDxYa90D/bhYWxEbmealZjPk6B61VrcTl
	 jjMnZ++Jiqeog==
Date: Thu, 9 May 2024 20:35:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v4 02/10] octeontx2-pf: RVU representor driver
Message-ID: <20240509203500.706e446e@kernel.org>
In-Reply-To: <20240507163921.29683-3-gakula@marvell.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 22:09:13 +0530 Geetha sowjanya wrote:
> This patch adds basic driver for the RVU representor.
> Driver on probe does pci specific initialization and does hw
> resources configuration.
> Introduces RVU_ESWITCH kernel config to enable/disable
> this driver. Representor and NIC shares the code but representors
> netdev support subset of NIC functionality. Hence "otx2_rep_dev"
> api helps to skip the features initialization that are not supported
> by the representors.

It's quite unusual to have a separate PCI device for representors.
Why not extend the existing PF driver?
This driver spawns no netdevs by default?

