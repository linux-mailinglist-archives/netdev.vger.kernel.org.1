Return-Path: <netdev+bounces-197954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB8ADA864
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587D33A6D69
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DB1E25EF;
	Mon, 16 Jun 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b="PO4Bnw/W"
X-Original-To: netdev@vger.kernel.org
Received: from kuriko.dram.page (kuriko.dram.page [65.108.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A81DF982;
	Mon, 16 Jun 2025 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056112; cv=none; b=OAmgh7IrcuggDg20+Goe7DGl0jlf+aVmGfq98IfMCx2B7hpZiRNXIL2Sb76LbrwXp8ZZEyQUXEiAR9nis1VID2SS8ZJfun9/E1QgjlbiRl95RAuhEe6gdOUVg8tGbTG9Ow8bOr/sWyi60KO18MFfItm9ICCgjy/iV7bFsxfNhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056112; c=relaxed/simple;
	bh=PT5jc8zKUsPGqteg7K0AtCpXKuLN2LXgE5Xmh4LGDw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1U6AyhLzpqqUiXi1ylblAzmnVP7LKy6f92OuBKktGofPl14NVI0ghsoUz1m1kHO82eOD7qqARy4eTuGbNJwAfmVS1zeSFEbe1t7nSPpTy0p6+zvDPYl8SueLvOERdInLw4yo281z+Qqmyx3Xu8uxpTgsFGk5S9go3cUFcW8iT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page; spf=pass smtp.mailfrom=dram.page; dkim=pass (1024-bit key) header.d=dram.page header.i=@dram.page header.b=PO4Bnw/W; arc=none smtp.client-ip=65.108.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dram.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dram.page
Message-ID: <7a6074c2-06e2-4c08-b005-a151bf74db69@dram.page>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dram.page; s=mail;
	t=1750056102; bh=Pyd55uUfdSE64vBohqzEWCLeu2Vh31odUeCFfrMdC8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PO4Bnw/Wxij7aXdYbg/t+bYg9m4y4lbFT+hZZOUosh4J63TwJpMAc0dH2YZcETkKI
	 2hIl2KXM7MbxDAGKIBXUVRudeDPDRGpRAfqt9eyQo9lvit9CEamA9n77fimJFK7t/X
	 o35qSePJo4HUSKPv0nKZvVopspSxDz/PHNF6YmhA=
Date: Mon, 16 Jun 2025 14:41:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: spacemit: Add K1 Ethernet MAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-2-cc6f9e510667@iscas.ac.cn>
 <aE-6tPMpMfRD1Zgu@shell.armlinux.org.uk>
Content-Language: en-US
From: Vivian Wang <uwu@dram.page>
In-Reply-To: <aE-6tPMpMfRD1Zgu@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

Thanks for the review.

On 6/16/25 14:33, Russell King (Oracle) wrote:
> On Fri, Jun 13, 2025 at 10:15:08AM +0800, Vivian Wang wrote:
>> +config SPACEMIT_K1_EMAC
>> +	tristate "SpacemiT K1 Ethernet MAC driver"
>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on MFD_SYSCON
>> +	depends on OF
>> +	default m if ARCH_SPACEMIT
>> +	select PHYLIB
> This driver uses phylib...
>
>> +#include <linux/phy.h>
>> +#include <linux/phylink.h>
> but includes phylink's header file? Does it use anything from this
> header?

Thanks for the suggestion. I have misunderstood the purposes of some of
the header files. I will clean up #include lines in next version.

Regards,
Vivian "dramforever" Wang



