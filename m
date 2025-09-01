Return-Path: <netdev+bounces-218952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62145B3F140
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 00:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758997A3DAE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422F284689;
	Mon,  1 Sep 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DhSCe94T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084342065;
	Mon,  1 Sep 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756766842; cv=none; b=f9HugVYO/VKCIruQ3vKtNivPsJMVNQGxa0++iIpo+zV3xnw4P/Tx3SE5OClG8Oukjjhtl03jLR4KI5cW4wXBGX9uYxBK6PB3OtGNgzyHTAnESWXdxIz22qnMIxOKVcAW1nDfvIJPCnjAqt3408hLe/q/tmBMCh0P9O0I+WApu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756766842; c=relaxed/simple;
	bh=ODFGiBb6kpgc4C/Tip3YxVTfo5SSzbzCx8PtnmactfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/wmykVf8lLWYJS81RSGz8auxC2K8bbchDVUVEvsOHlvOG/KzHOB9xxNm9fJeqtKJdgDMF+iJ+vzrgFLvylfPAdytCNN/nh60unPbe3+ne0NxtZHR2d+o0E53XZTP2cP1UEc5ylL+aEu5KUFOa0MoO74u7XsL1kiSbo8cU/cZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DhSCe94T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2zcgRmIXCbrIKc8FxkKITlNihcAQ6h2DXOsEm8mAF18=; b=DhSCe94TnGa6VnplH5DLlL0vHA
	r4Urt0wwe1CScuy98/B8P3sNOOgHQgY3D7uo4RLV/r/z8p+FDamsHXiw1TLOAc98wSfQbJj9nD6w/
	65Ty6MpzVtNMw+Qh/rVJJCgsjlijuHSOGpNC2RIoesxBVm9iSh5dxzY2xu4UzMTJiIgY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utDIl-006p2z-QY; Tue, 02 Sep 2025 00:47:03 +0200
Date: Tue, 2 Sep 2025 00:47:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
Message-ID: <7b5a01ae-f3f1-4029-8b43-87861a8f8b8f@lunn.ch>
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
 <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
 <aLNst1V_OSlvpC3t@shell.armlinux.org.uk>
 <a5411ede-5312-4510-a559-e3b09e7e763b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5411ede-5312-4510-a559-e3b09e7e763b@gmail.com>

> Usage of the deprecated binding was added to this dt file with ab9d8032dbd0
> ("arm64: dts: ls1043a-qds: add mmio based mdio-mux support") in 2022.
> At that time the binding had been marked deprecated for years already.
> I think it would be good if dtc would warn already if a deprecated
> binding is detected, so that CI can complain.

I don't think the DTC compiler can help. It does not use the .yaml
files. You can compile a dtc file to dtb without any outside help.

What i think we need is 'make dtbs_check', with some additional flags,
like W=2, looking for such deprecated properties being used.

	Andrew

