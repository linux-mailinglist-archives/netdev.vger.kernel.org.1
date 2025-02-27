Return-Path: <netdev+bounces-170209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA93A47CE8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9163B2767
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC922B59F;
	Thu, 27 Feb 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMzGoxaA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFA22A7FA;
	Thu, 27 Feb 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658065; cv=none; b=NHhX4+u0wBSR6x5jFHKfBUfB3jTriLXwS75LcZ6MCGX8l3T9WBpL8RTcDrMdU9TGl5PQ4m/4yZH7eSfK7YzFeURz+sAUGWT1vq2RLZeCV+1JsRM1oFkq9sG7W1zWV6SAAJHbzsd1XHsyK6Pje+aZ9i1HKYji5JXadZ5N4rgTL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658065; c=relaxed/simple;
	bh=Z5FJf61UKKmiyaePDrpiLZwI2N56lkqzxTfEsGsA8a0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4wqrR1Sht/UTqy8j0MRLU5lEBDnXHoeJjEzBAVOrtIL4cpzGVOXvG3KiH/5FiFpvnFo8Wpvgq/RPnL/YQ+qXkqcrSMUky3pe6FP+kVLulwh65tOP4tGpf74xr2YRkoFuYH0U9biKLhJ3xcKLWoT8L4r23eXpbMuszbcXO0h+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMzGoxaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC0C4CEDD;
	Thu, 27 Feb 2025 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740658065;
	bh=Z5FJf61UKKmiyaePDrpiLZwI2N56lkqzxTfEsGsA8a0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bMzGoxaAMDZN1eKwLcIqhB0FTdMi9KnsDBsIJN/zVKie/B6cgd215Qtl3Nuvklnsd
	 45mTybsMIjvIg0JZPITMtd4YOmuV/jzLNtWF3LJBkuCZmnM+tyw3gTFmpZ5/QeXqU7
	 /UECpmczMOsN8SRFA+elhRgkjoGhXf05yFuWhSN5qjlMbgKUFA0AH4jqaS4yG2d3xP
	 ep9E7WSmPpQJYuwNpMm539mAeClKKEpsCPRXdCRRU+T3/vHLcpo4XR11zTG3+fUZC2
	 KfxnI5DaHauB3j81KDSjj4ozB7nrkAaG8HUwLu+jrQx654aFVhA5YkruaHP12B0Hk5
	 vjE0FBLDYOJjg==
From: Vinod Koul <vkoul@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: srk@ti.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
References: <20250116-k3-udma-glue-single-fdq-v1-1-a0de73e36390@kernel.org>
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
 from k3_udma_glue_reset_rx_chn
Message-Id: <174065806076.367410.10114461097310533807.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:37:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 16 Jan 2025 17:00:46 +0200, Roger Quadros wrote:
> The user of k3_udma_glue_reset_rx_chn() e.g. ti_am65_cpsw_nuss can
> run on multiple platforms having different DMA architectures.
> On some platforms there can be one FDQ for all flows in the RX channel
> while for others there is a separate FDQ for each flow in the RX channel.
> 
> So far we have been relying on the skip_fdq argument of
> k3_udma_glue_reset_rx_chn().
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma-glue: Drop skip_fdq argument from k3_udma_glue_reset_rx_chn
      commit: 0da30874729baeb01889b0eca16cfda122687503

Best regards,
-- 
~Vinod



