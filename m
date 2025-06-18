Return-Path: <netdev+bounces-198934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E32ADE5B3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA6B1884BB2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685827F002;
	Wed, 18 Jun 2025 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWR0Y2ch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1D27E071;
	Wed, 18 Jun 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235792; cv=none; b=Wrg9uiAy2t8ByAMJZ7ydsyQNcnO9ETAnYakh646U3mUrQd7bvYxVs/3chbUY6e5v9HB+yu00jDZjVzlmSVQuHTbr8jVW192fZ7euB+UVlsq1aT8qCtAmidY2Zc+9uPUSOs7kPQ9/A49dpRFtSgwrVgBYFbRrS5CwtQq0U3f+zi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235792; c=relaxed/simple;
	bh=nahXIBYo1sCV4ReXtP1+gdc5KP6p3q+h/ETOVZK3jA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFN0aFqzRL3mSnh/kJVJnbIcnkT21k93v/U9359j6PH9Hhar9CobtOtiQlPX6U75dVH2nfTWAywPjbNTdcT6mAU7Z8c5lYDuHEcQRSrpVvUSqmApk9+z8QPnnVGZZtiwcBQJZhctJ9ZrMZzcrMZvJeFAi4DSu1NkNR8/UBPHf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWR0Y2ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82042C4CEE7;
	Wed, 18 Jun 2025 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750235790;
	bh=nahXIBYo1sCV4ReXtP1+gdc5KP6p3q+h/ETOVZK3jA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWR0Y2chSoauafo/D020vd9PcFIQk2KPUhySCWzzrY0qqFJzMJNb0S22sUCd6Dn2D
	 xlxoEI4SQVjMjdoynxjv/bhEzmGHwXdEsOtVBRtvCwTBq3xBosBSDd6yN+eiyLV/NQ
	 yirZ/mho+2/amSFCwPHi+8ZiWdBGZ4mNWOCOP0bzIFLtA1YdJ+KBuBP0GV9QkmL3wL
	 rZ/2cSTNR8F7TNoWFAmL8zKufh08OrZgZDavg+8qTOtT1tCsXzaAw1rJMFRr6A+X1/
	 IQMkWf1pSbSbdmnnkWZ5GeYHtY0cf00ebU8xbtpioTd8K4BSa44MnnY3ZzduSnjU0N
	 giRG0v0vCb4MQ==
Date: Wed, 18 Jun 2025 09:36:23 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v4 2/3] net: ethernet: mtk_eth_soc: add consts for irq
 index
Message-ID: <20250618083623.GF2545@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616080738.117993-3-linux@fw-web.de>

On Mon, Jun 16, 2025 at 10:07:35AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Use consts instead of fixed integers for accessing IRQ array.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> - calculate max from last (rx) irq index and use it for array size too

Reviewed-by: Simon Horman <horms@kernel.org>




