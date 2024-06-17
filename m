Return-Path: <netdev+bounces-104112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206890B443
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BB71C2291D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E2446BF;
	Mon, 17 Jun 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tICN7TiS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFC481DB;
	Mon, 17 Jun 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636336; cv=none; b=lHwJXIEbZW1NspLZIIXw44RbzlF4nHwlNaN/S4gbLedUFZhEsURnYD9mDJH3nFtKimskzUj9bfGOlGVTMRlv26tSrcy8vB4i7gl87626fAsTjbNtbyh0wEadaJr51+1TOksi+7+7xCApaKPAjZWuICisGsP9uda/ykbGQIQ72as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636336; c=relaxed/simple;
	bh=ZYgKTewbWFFfcvsQ1ekl5wQ9ScldGcNbBX9Tznn6ya4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amZTSX6Dz/XT7x0VLHVb+iIMRyQwB0hATJE8kgfTdQy0D0skKAHqooNa69DmR7lzRMbFkzz4sP9S+qroOpkHZT3oqLH1AoGgY2mXbC9g5L4LZfDjFEq2Cwu34U5ZlaWN5SRAeMPGn6f3zeEhSYVP7FDi3tcJBD989vzhCMF0Hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tICN7TiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2737CC2BD10;
	Mon, 17 Jun 2024 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718636335;
	bh=ZYgKTewbWFFfcvsQ1ekl5wQ9ScldGcNbBX9Tznn6ya4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tICN7TiSxitxX2V6zbRUy739dgKwfqFNgNeI/8+s+oPFM1mLNHQ9tus6f/x7n1mvb
	 6RaDQ9J7laaviwbzrCphuXO66XSBJo8LWCx4anlsV8RBh8i/rSl/tsnlIefoDgxXdr
	 CiHWBPIHnoXpVKtl9pRxfEuv2+jcLVCxNv8533wBBxYqgu2ZPcwXhoLVRfw0ZctJzF
	 6p1BED1Ijk6lIfR7BQa6MA+YbeBthMnWMUuiRyqp8ZIf50oh+1Ad4AMAjA5ux2vqYI
	 JD1SzHksUa0KRLHGmsWituAuDtJ4n6JAJ4i2pzn6Zuxu1A5pk7Nko89jviO0/3f46t
	 k3vdkADue+Puw==
Date: Mon, 17 Jun 2024 07:58:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Yifee <eladwf@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, daniel@makrotopia.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v6] net: ethernet: mtk_eth_soc: ppe: add
 support for multiple PPEs
Message-ID: <20240617075854.29892c69@kernel.org>
In-Reply-To: <CA+SN3sogd29XG7Sgz1EOqBqtxxcVzFkB_mFq10TW+eYGKtdDTQ@mail.gmail.com>
References: <20240607082155.20021-1-eladwf@gmail.com>
	<171824043128.29237.10490597706474690291.git-patchwork-notify@kernel.org>
	<CA+SN3sogd29XG7Sgz1EOqBqtxxcVzFkB_mFq10TW+eYGKtdDTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Jun 2024 20:34:44 +0300 Elad Yifee wrote:
> It appears that the current sanity check is insufficient. Should WED
> be utilized, it will be necessary to find the appropriate PPE index
> through an alternative method. Kindly revert the recent commit
> temporarily until I come up with a solution

Please send the revert as a patch, with the explanation in the commit
message. That's our usual process.

