Return-Path: <netdev+bounces-184982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D1A97F2E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5653BB6F2
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A7266B54;
	Wed, 23 Apr 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ai2o+Lzq"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2CB266B70;
	Wed, 23 Apr 2025 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389753; cv=none; b=KvU79Jc59vD4nK3iUiHjeLzFE3IiTrpT0qJ8ztc76hDG4paibYCerhKubfokK6FS9OgyuKGNjOQ9VVSNoHkjQkoRHJW+Cps9YtnKV5ftoJs0Ckuq0G02GMd5Th0RqD5PEMyFPgZjPQG7+Ine5DZJEye19doykvOZaDLLfCQffp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389753; c=relaxed/simple;
	bh=dDdED1nBrBb89ziJQR35iHLFgJ9A0k3A7KcihAdoeMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1qeaQQKs+cJiNb0zbRSa0vDrfGRR61znd+2lx69niy+Z4b2QPf0x+8X4K0H/4DpRGDQtgu3AERJihxvVleo6pex2fcYAEBG+UEAY+5a7PwaLR1BYER4teOeOkhDzFX9wtR/vtAJr4Fl0uSi3n57pJWphLFYA+zdNWsR7W10azA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ai2o+Lzq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zj8MS1pWBz9tLw;
	Wed, 23 Apr 2025 08:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745389748; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbqkQ0oCVQhLChHpB4lCCWhlmmo3Fq1yx2gTxvrL90c=;
	b=Ai2o+Lzq+TT/XzSb59BRtH4QxeAsuVjW0YIWvXBvZUbWbvHLyOfR4SxwIHxCzoMZ6gXyrf
	5bcblzQGBbbluQ3Jg/ja44C8v+dNhFqX92JYueO55mG0UqY8dRHgXhvgo+E56C10mz/RQo
	9WGzni/t/N/QdtwqOuAb9r3oHwLWsM1sS9HJ5vSpkbqIXUKdJeS887ejzbclxmkHKzRTGu
	Wq9DmetDr38Htl6ps4OAIAI9gRq99wTjwxdByFadhCfCx6Xwd/ygz9XXfwSCuGRGTsuGeg
	qtcax9IlVOUK/Zb6IrGGirWUFDeNtfqUAO0fHp6g/BW0SPP6/0qbJqAVWWGvaA==
Message-ID: <5e20b320cbbe492769c87ed60b591b22d5e8e264.camel@mailbox.org>
Subject: Re: [PATCH 2/8] net: octeontx2: Use pure PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Jakub Kicinski <kuba@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, Daniele Venzano
 <venza@brownhat.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>,  Simon Horman
 <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Sabrina Dubroca
 <sd@queasysnail.net>,  Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Wed, 23 Apr 2025 08:28:59 +0200
In-Reply-To: <20250422174914.43329f7f@kernel.org>
References: <20250416164407.127261-2-phasta@kernel.org>
	 <20250416164407.127261-4-phasta@kernel.org>
	 <20250422174914.43329f7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bd44cb326753e922362
X-MBO-RS-META: r486tdi16475h8inaws1o3xcg7yufct1

On Tue, 2025-04-22 at 17:49 -0700, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 18:44:02 +0200 Philipp Stanner wrote:
> > =C2=A0err_release_regions:
> > =C2=A0	pci_set_drvdata(pdev, NULL);
> > -	pci_release_regions(pdev);
>=20
> This error path should be renamed. Could you also apply your
> conversion
> to drivers/net/ethernet/marvell/octeontx2/af/ ?

Hm, those must have slipped me for some reason. Will reiterate with
them and the error path.

P.


