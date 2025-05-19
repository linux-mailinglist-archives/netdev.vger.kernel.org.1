Return-Path: <netdev+bounces-191685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC082ABCBD9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5FC188ACE0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A923BD0F;
	Mon, 19 May 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDL2puIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2923A9B1;
	Mon, 19 May 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699079; cv=none; b=McIAQpNArTgyDKlFNwJP2Fr+LSua3D4ql01uAWhRFE8fCJLILFrsMnOx34lApsq8+3WiRga/juKIUUP3YzGHuNRKUo1eRYvJCmcfFluNDQ8aoj5jwQBM0ML/wTID9RN6AkBHgd/0L3JF92UKqzhLgMPLYoffug6BaRnx73BFlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699079; c=relaxed/simple;
	bh=ld8fEAbyAJ/eXUwUBtpIevulmKNgly05/V7s2D1ToSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtOmO2or08avAA9bX0mEGsQrRC8FMzZoJuOc1zbgBN4uHVe0m2i+LlIDo822fdT5LsqQij5TL7ttMTXGe0VLerzyxEw3LQSdJ3CsI401bj4zohsCrKzxx76dNfv2hVrHF4U60aVubFshP7wWmOyq3URDqtNDlZES/0KiODL80nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDL2puIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8498C4CEED;
	Mon, 19 May 2025 23:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747699079;
	bh=ld8fEAbyAJ/eXUwUBtpIevulmKNgly05/V7s2D1ToSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDL2puIBF82J4DAU5izVvmtq37M1KQ3azlAGVpuSLKUmEL2CijlTfGbxvzjIP4+jn
	 giruBkcdNXnNnW/WUwhx+WdwLRnVtrPYZiD9zx0kxTY8H5RBlTI3PCQaVPi1iMLgvW
	 Eq1gisDhBKTB+WJ8WnzP19OY56qZc8KdSXgIMJqFcztHO74wxEsoozyChBx4u7VMsN
	 PVVERdI3i8eFx0dEot3zeebpVqy2VBWwSCKE/n0g3/mueVjdphOQC5A9FQF2oE4LQD
	 95qOL2ca+qCuVt/4RH+ibNQGqqI4UNJkouTEUudIKUnZpQRCwGT3oWPDygRkTOuQ+p
	 oA51LCG+zhevg==
Date: Mon, 19 May 2025 16:57:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dlink: add Kconfig option for RMON
 registers
Message-ID: <20250519165758.58157a0b@kernel.org>
In-Reply-To: <20250519214046.47856-2-yyyynoom@gmail.com>
References: <20250519214046.47856-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 06:40:45 +0900 Moon Yeounsu wrote:
> This patch adds a Kconfig option to enable MMIO for RMON registers.
> 
> To read RMON registers, the code `dw32(RmonStatMask, 0x0007ffff);`
> must also be skipped, so this patch adds a preprocessor directive to
> that line as well.
> 
> On the `D-Link DGE-550T Rev-A3`, RMON statistics registers can be read
> correctly and statistic data can be collected. However, the behavior on
> other hardware is uncertain, and there may be undiscovered issues even
> on this device. Thus, the default setting is `no`, allowing users to
> enable it manually if necessary.

Kconfig is not a great choice for chip specific logic.
You should check some sort of chip ID register or PCI ID
to match the chip version at runtime. Most users don't compile
their own kernels.
-- 
pw-bot: cr

