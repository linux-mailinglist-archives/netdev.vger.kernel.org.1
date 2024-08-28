Return-Path: <netdev+bounces-122814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44C962A7A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E05281ACE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FE189505;
	Wed, 28 Aug 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS0PVg/f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EC187FFE;
	Wed, 28 Aug 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856003; cv=none; b=nttnBDNMx91FbLmvnA+ENWPoVapTAwhjxrbLXwdsFrM3IUibiAfgn52CDq7CT2nWVrv53FDEgTwHmltqMoFMU7C7AEHEc/6X2owjGTIZjjaChNYcFmR3RidXyamEEHzx8aluqnilbpn2K5DYBmWy9Bpks2bpUGFW1AraO2KoDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856003; c=relaxed/simple;
	bh=7BmJb8DZ1zSsCexHnskcTVlm5B48OEfa99EGb8zOnrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFhgUxfJloK3Kzx8UYTS/l7PQ/vVp4W7xmbciMdYLK/Vn4pGqBvISwxJ/Lt1catRVKneA4CemKiXdbohbCM8/W9vIcJ2NYFY9W4DDXqYb6l4hMQ/ToEVaf19VFe6J8uw3x7I++6mK/nBOszQ2eMy+qpvusYhRSzTtJdfJLUB/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS0PVg/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B9C4CEFF;
	Wed, 28 Aug 2024 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856003;
	bh=7BmJb8DZ1zSsCexHnskcTVlm5B48OEfa99EGb8zOnrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZS0PVg/fL0wzJ2f01KmVkVqptguJTTuJKQntPMiTmMGXkC7KCMkel1kbksKxJdNI2
	 oJqEc0+yd1t2NW88J0XQYSKcZ1NptjcNFmpMxjyVQDJYrkKSmQ/XxxYgSK16RJcLen
	 ZLlLAQFLX/zLd/PJNAHAyI8jG6YOUEtegoDXRgaNE7WLbHe78mZMVarBW3yvW55GTU
	 ZcjBLO4ULEHooZKf3TLJGAxaSoUpz+utKo7mfuXvm5j5FKzz7t2VB2AHkiYfxenGS9
	 frbk1X7TNFMzGESHQRYE037qH/e0dPQO2TAWiPEb5GKbk3VlCO8Nbi/atShRWn7e04
	 3iu9JVjePxsDg==
Date: Wed, 28 Aug 2024 15:39:59 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5 next] net: vertexcom: mse102x: Use
 DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <20240828143959.GI1368797@kernel.org>
References: <20240827191000.3244-1-wahrenst@gmx.net>
 <20240827191000.3244-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827191000.3244-2-wahrenst@gmx.net>

On Tue, Aug 27, 2024 at 09:09:56PM +0200, Stefan Wahren wrote:
> This macro has the advantage over SET_SYSTEM_SLEEP_PM_OPS that we don't
> have to care about when the functions are actually used.
> 
> Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
> stuff if CONFIG_PM_SLEEP isn't enabled.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>

One note, no need to respin because of this.
This series should be targeted at net-next.

	Subject: [PATCH m/n net-next] ...


