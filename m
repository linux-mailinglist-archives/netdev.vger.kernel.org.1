Return-Path: <netdev+bounces-96168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544398C48D9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0870F1F22C4C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2A83CA6;
	Mon, 13 May 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRbx4i4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C283CA2;
	Mon, 13 May 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635603; cv=none; b=MLY16aJvw7fRNvdDmBXvnfng9jTGnuN7C4H1RIiXunSnGICpmaAUCaqWR6ZwWjueW9laNu6nHDdyI5oi7Gkip1y9Nl2qWUVmh/OVh/VR47YxS8EaDBYKKDqm5dcB4Kr5vkre+mVUb4IiDnRFnbZX2KwbYjHY5noqe6IfZjVgK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635603; c=relaxed/simple;
	bh=WA+X+xAY+TKPyLAsDRuAky5tns2p1o6EgG+uqq3+OTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBVJQo3qN1eVp503jXtPlEQwImSrD/gvA/WlSSC0viuZmBEOeMBch0lx1w4Qfv/H7aviq+9lX78gLxuj6tLV35a1D+JluLtvPTY/gXkPphWebMnPEo6HOWyHudRuGw1aV9bCGBhZES+c7oeFQnUm6MwAvmznm9oRawTyGanBhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRbx4i4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89B5C4AF0E;
	Mon, 13 May 2024 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715635603;
	bh=WA+X+xAY+TKPyLAsDRuAky5tns2p1o6EgG+uqq3+OTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRbx4i4LemohiZbJDl1aW1B4kFlLoFFxrPiuSBFmem7lSJbqeCGycHIEx0PSzpKLY
	 MHNfmiYTMGDzzsHv0TG4YaJTvYehP9OBGac1xx3yiOBHApm6GQHwgILin0Sj08UMot
	 7zvYhT39TWPoIlGVwveSep4aBYbNgd9Rd2Fcz6vuq4ClI1c12alSvs74QK8UAbeecY
	 9kMxbkYzPGQ1hq4KDAlrTyF/1gKnSRsNivovFRkOwnRTQxdJrbkzRgou2x0JDsgizQ
	 GwlSRMWsWYp/XbBQB0VGCA9kvmWiHNhwM5ahXtGaMolOia9yfmJ2gTNEcEy2F0FW8C
	 7t6Y8Yw6l2X2Q==
Date: Mon, 13 May 2024 14:26:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2024-05-10
Message-ID: <20240513142641.0d721b18@kernel.org>
In-Reply-To: <20240510211431.1728667-1-luiz.dentz@gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 17:14:28 -0400 Luiz Augusto von Dentz wrote:
> The following changes since commit f8beae078c82abde57fed4a5be0bbc3579b59ad0:
> 
>   Merge tag 'gtp-24-05-07' of git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp Pablo neira Ayuso says: (2024-05-10 13:59:27 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-05-10
> 
> for you to fetch changes up to 75f819bdf9cafb0f1458e24c05d24eec17b2f597:
> 
>   Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config (2024-05-10 17:04:15 -0400)
> 
> ----------------------------------------------------------------
> bluetooth-next pull request for net-next:
> 
>  - Add support MediaTek MT7921S SDIO
>  - Various fixes for -Wflex-array-member-not-at-end and -Wfamnae
>  - Add USB HW IDs for MT7921/MT7922/MT7925
>  - Add support for Intel BlazarI and Filmore Peak2 (BE201)
>  - Add initial support for Intel PCIe driver
>  - Remove HCI_AMP support
>  - Add TX timestamping support

There is one more warning in the Intel driver:

drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_list'
was not declared. Should it be static?

It'd also be great to get an ACK from someone familiar with the socket
time stamping (Willem?) I'm not sure there's sufficient detail in the
commit message to explain the choices to:
 - change the definition of SCHED / SEND to mean queued / completed,
   while for Ethernet they mean queued to qdisc, queued to HW.
   How does it compare to stamping in the driver in terms of accuracy?
 - the "experimental" BT_POLL_ERRQUEUE, how does the user space look?
   What is the "upper layer"? What does it mean for kernel uAPI to be
   "experimental"? When does the "upper layer" get to run and how does
   it know that there are time stamps on the error queue?

Would be great to get more info and/or second opinion, because it's not
sufficiently "obviously right" to me to pull right away :(

