Return-Path: <netdev+bounces-185890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74837A9BFFC
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E51B63094
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5523099F;
	Fri, 25 Apr 2025 07:46:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651B5A79B;
	Fri, 25 Apr 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567188; cv=none; b=mhVMH65DCXSbdh7W9kUy/vS/a68QRYP9vELM2p0Re1+yKPy76xbEwjOZ2vYFApJnncRUFWRBHbLSzG7tYisffwVCZCbEZbtvcDm9Ej34CEwwdUSla6ldjfWJ8cR8pUd6B9O42uuNRrmXhax7KCdgciQf2lKRLVLGfcrXhojKL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567188; c=relaxed/simple;
	bh=DKcS6revqYQuBrgnWEdHy5BJ2gFLK5tD8d5+E6CyPs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUBW/mk3W5HxdGcnac5tgnBsYkC7EoB7E6GKzkUVwjAEQ5CqfWxSqoF4ShBHo51Rcjn55Q7YDuj+eSP60wjcxz4SKVPeKZXvEMDxANAp1GUeq5uR7XK1m2PEERKe6xXiR+uKR4ErKet/w89r29cXqAJWYfB2t6fYdOISjRq8cd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 581A6341540;
	Fri, 25 Apr 2025 07:46:25 +0000 (UTC)
Date: Fri, 25 Apr 2025 07:46:21 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andre.przywara@arm.com, andrew+netdev@lunn.ch, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, jernej.skrabec@gmail.com, krzk+dt@kernel.org,
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	mripard@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	robh@kernel.org, samuel@sholland.org, wens@csie.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250425074621-GYC50408@gentoo>
References: <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
 <20250425033001.50236-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425033001.50236-1-amadeus@jmu.edu.cn>

Hi Chukun,

On 11:30 Fri 25 Apr     , Chukun Pan wrote:
> Hi,
> 
> > On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
> > which features a 25MHz crystal, and using PH8 pin as PHY reset.
> > 
> > Tested on A5E board with schematic V1.20.
> 
> Although the schematic says it is YT8531C, the PHY on the V1.20 board
> is Maxio MAE0621A. The article of cnx-software also mentioned this:
> https://www.cnx-software.com/2025/01/04/radxa-cubie-a5e-allwinner-a527-t527-sbc-with-hdmi-2-0-dual-gbe-wifi-6-bluetooth-5-4/
> 
IMO, then the schematic should be updated, I could definitely adjust
the commit message to reflect this change, but don't know if further
action need to take, like writing a new phy driver, I guess a fallback
to generic phy just works?
(google says, the MAE0621A is a pin-to-pin chip to RTL8211F..)

-- 
Yixun Lan (dlan)

