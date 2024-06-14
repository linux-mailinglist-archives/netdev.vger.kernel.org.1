Return-Path: <netdev+bounces-103448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F84E908142
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 04:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D041F232AA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02942042;
	Fri, 14 Jun 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX+5kW92"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2219D880;
	Fri, 14 Jun 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718330528; cv=none; b=B/7Otv+YvzeR8iSkwFDTcsmoPmCc9qw3nSK/mSe6gxLqOwBKj3nCCh9fYtETbYuPrqM8aj2rbLdp+lmmkvmuKOZrmKvv9KWsTPCSTmnxc3i69Ty95oiIYocZZFAI0xyV5UHzaFCaiZp6Vlb51LVM6NVVjqy1sGo7aDRq9n0T92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718330528; c=relaxed/simple;
	bh=i0Unidx12tTiWIx1eeP25XQcBZgQqPxSt9lxWiYuap8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfnjCAN3iI6IV6EqH0MPOMxHl+9Xwgnmq37FG5X0k30arSb8ylKEt8fblowRzI1I2+F9tdJqjRYB/dXujdbbPF4MmcWIu4eUnANU6QfRDV5N0xLPf73qy+kZNLqYRqcTwX/ca2Lu0TadM75DvLo479HPZiTQU6i7SqKaCsZrFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX+5kW92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC2C2BBFC;
	Fri, 14 Jun 2024 02:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718330527;
	bh=i0Unidx12tTiWIx1eeP25XQcBZgQqPxSt9lxWiYuap8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fX+5kW92Y+Jr4MYaW0r6yc3tCOpFxqFzU/3ASQzn1OiaK/8UoEmrEu551ANdjVSWj
	 GnoakdxOGrrBJtxA/wxDrZrqnhAfODJkuCoibR8M1AxPEAYg9zpaIQEJUtgnW8kfVS
	 SbDsJod35FAsOxmpISOMGrneGM8c61viSa2ZSpoYC3jmsgf92RJSPdaaHk52t9q5dP
	 xaaX01kx3R69yLEDkIWXshGgVv+J1NS2Y2dtbevUQKCeBVXcQX80wkRJAF5XyqMygK
	 0/a3I5ew67QTg3G80TWyi17VNmgfrfdXIhzBPFqHldI0KqiZQy/6Jo1u3nMax26nV+
	 SIpgQ2w5+tV8Q==
Date: Thu, 13 Jun 2024 19:02:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU representor driver
Message-ID: <20240613190206.77280642@kernel.org>
In-Reply-To: <20240611162213.22213-3-gakula@marvell.com>
References: <20240611162213.22213-1-gakula@marvell.com>
	<20240611162213.22213-3-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 21:52:05 +0530 Geetha sowjanya wrote:
>  obj-$(CONFIG_OCTEONTX2_PF) += rvu_nicpf.o otx2_ptp.o
>  obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
> +obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
>  
>  rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
>                 otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
>                 otx2_devlink.o qos_sq.o qos.o
>  rvu_nicvf-y := otx2_vf.o otx2_devlink.o
> +rvu_rep-y := rep.o otx2_devlink.o

You gotta fix the symbol duplication first, please:

drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf rvu_rep

