Return-Path: <netdev+bounces-166335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A55A358D3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C93A5572
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98D22256C;
	Fri, 14 Feb 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pERS73CN"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A112222D1;
	Fri, 14 Feb 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521649; cv=none; b=N7mJ/1+PfkyVZKkzTu7VlH6Ju5Zv6o/Lr9HRtoTwWaG1V04c2TYmUpzrjizNE7hsoE9cHiIBpDH5/+ZT277czcNREiBaZNfdNxAY0tAD4r1JsgG0A7VDxj7BlDI9YNiQ8XlAkCPvPYCOj7urbqkOrxNnw/Bm4SVfJLslmw1QmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521649; c=relaxed/simple;
	bh=a8bg8TYNJ0zD/riSdpk/IyGPixwchzk6VHth/WlqQ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAGN3nZ8uaRrmbcYa/oYZiGyTM5q7QMw6TTwyR1Cos/LjUrbnhbJL1UPoKKMvJWoYSSmgiX2ebll6+J5FOFEeoRKeld2GYk2nfWDIYnz3ouSzHD4PwMOmmfR1iKZV/BwxrAIdyT6bI+YwCCWwcibGWS28qB+4kvIyv+gxWopjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pERS73CN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DED244331;
	Fri, 14 Feb 2025 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739521644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNvBJa4Q9PSMsPDhj3s1+Vt+BAwOGndJFZntHwfg/ow=;
	b=pERS73CNJU60vhPF1OVm1TWS8RcM43zlfRPZ1EppD0bEghrGemomkYR8FoCeoLwPRfiLrq
	SkF5/1g9soVLzzc03QJyHQGZFS2h9GfXkUcTignasl++h1B1XQtzihzXoZwIpaEbXH/SyN
	Ch+Ga5kkfrrlZIwOuybPkZc5d2/+dgxwObuSRubmqduiiN/z0wjrFnp3qimQn1t2lBDC+n
	MHUraA0WmTgpfxjazyRDjhs/C2JCg2rmWqlT6TqpUJ+sOIDXqHX0oGMopYifbs+hJUHfNA
	7d5d1mmgpiSbCTT19SsqnwQHtz1FZH5AdYScflZ1uuqQ1gpJuqU30VA8rCCVHw==
Date: Fri, 14 Feb 2025 09:27:21 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: xiaopeitux@foxmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH] net: freescale: ucc_geth: make ugeth_mac_ops be static
Message-ID: <20250214092721.6fadd49f@fedora.home>
In-Reply-To: <tencent_832FF5138D392257AC081FEE322A03C84907@qq.com>
References: <tencent_832FF5138D392257AC081FEE322A03C84907@qq.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfelledvtdffvdekudeijeduueevvdevffehudehvdeuudetheekheeigfetheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepgihirghophgvihhtuhigsehfohigmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtt
 hhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Fri, 14 Feb 2025 14:11:07 +0800
xiaopeitux@foxmail.com wrote:

> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> sparse warning:
>     sparse: symbol 'ugeth_mac_ops' was not declared. Should it be
> static.
> 
> Add static to fix sparse warnings.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502141128.9HfxcdIE-lkp@intel.com/
> Fixes: 53036aa8d031 ("net: freescale: ucc_geth: phylink conversion")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Thanks for fixing this,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

