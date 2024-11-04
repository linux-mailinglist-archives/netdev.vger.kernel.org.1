Return-Path: <netdev+bounces-141579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24AD9BB838
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7111F2319D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498870839;
	Mon,  4 Nov 2024 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lTSHtLS8"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDE469D;
	Mon,  4 Nov 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731602; cv=none; b=ik0aLIFoVgbfiW6V2KY7gWmXWFkY/6TB4OZAhHrmrxesutouxgIXdoUT/HpwMenIfF/PT7TlOFoE8wYMJEucU3FsFu9IQzgImM/OJuuoeoHL+91YhrudKl0d6NTT8xe6uihY3v3fD3ssWy9Tblhv/aEurmRLdCwcjCvSpw9SCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731602; c=relaxed/simple;
	bh=OuS/4i+oygUwsdbc+DVGxua1yWNGYXVWyfGEWNFamiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDth8n8HrTXcVtvfSVqDEV4j6A2BRCZILZe96Z1xF8kaVVUwqJAY4aCzMqjnD4n/o40KkNOiT/u7MpO5P8+gRw+RFvx6soZmYeWogfPqND5Uep8dnx3PUR5GjqfPXo++K8m7FXHWD6ijOKrJA9xownZD8QHlpgr1zO+4T5E8Rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lTSHtLS8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730731597;
	bh=OuS/4i+oygUwsdbc+DVGxua1yWNGYXVWyfGEWNFamiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lTSHtLS836wcVaZJDpm8Yf8qGI47kjv7/IUuPAG4uEwoXmnGr4LDmIN2uQk2Iv82m
	 Sm178fUyf/ZN8sJLsAA7CvSLgf48cQnCFrVbdors/KoZ1eCTtw4ktA/s/eA6d4ynYF
	 OrpfuFm+okUH1/UIcJNuasDi4zp1oYo8hqDKZAnRQceI1Fba9HH6pBRRyygKWkuxdl
	 xRXOUCV6dj8n0bzWIZdH6oqV12rZSeKcW6sXSjzBSNVH1N86162i8PGA5pHbMen/e9
	 yG3hm8vszU5yTpruquqB0J5+PqIppIXloKC69s6VLbQEJBzlcFvgXe1rsM0kA5VYve
	 msFOR5HntBqDA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1F2AF17E3696;
	Mon,  4 Nov 2024 15:46:35 +0100 (CET)
Date: Mon, 4 Nov 2024 09:46:33 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, kernel@collabora.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/4] net: stmmac: dwmac-mediatek: Fix inverted logic for
 mediatek,mac-wol
Message-ID: <c6fec04a-7eed-4c61-85bf-a11542df441b@notapiano>
References: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
 <9a1ce320-e1ce-4d2f-a8d1-7680155ef71f@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a1ce320-e1ce-4d2f-a8d1-7680155ef71f@collabora.com>

On Mon, Nov 04, 2024 at 11:18:48AM +0100, AngeloGioacchino Del Regno wrote:
> Il 01/11/24 16:20, Nícolas F. R. A. Prado ha scritto:
> > This series fixes the inverted handling of the mediatek,mac-wol DT
> > property while keeping backward compatibility. It does so by introducing
> > a new property on patch 1 and updating the driver to handle it on patch
> > 2. Patch 3 adds this property on the Genio 700 EVK DT, where this issue
> > was noticed, to get WOL working on that platform. Patch 4 adds the new
> > property on all DTs with the MediaTek DWMAC ethernet node enabled
> > and inverts the presence of mediatek,mac-wol to maintain the
> > current behavior and have it match the description in the binding.
> > 
> 
> Actually, I'm sure that all of these boards *do* need MAC WOL and *not* PHY WOL.
> 
> The only one I'm unsure about is MT2712, but that's an evaluation board and not
> a retail product with "that kind of diffusion".
> 
> I think you can just fix the bug in the driver without getting new properties
> and such. One commit, two lines.

Alright, since you're sure all the boards need MAC WOL this is simpler: I can
just fix the driver handling, and also update all the DTs to make sure they use
MAC WOL. (Right now some are enabling PHY WOL, mt8395-genio-1200-evk.dts and
mt8395-radxa-nio-12l.dts, while the others are enabling the MAC WOL)

The MT2712 EVB currently enables MAC WOL, so even though you're not sure about
that one, I think it makes sense to keep the current behavior ie add the
mediatek,mac-wol property just like for the others, so it keeps using MAC WOL.

I'll wait a couple days in case there are more comments and then I'll send v2
with those changes.

Thanks,
Nícolas

