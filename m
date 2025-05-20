Return-Path: <netdev+bounces-191970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0CEABE0D4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24661BA5C25
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B31C5F10;
	Tue, 20 May 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FejLLnkT"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D472750F8
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758863; cv=none; b=KLlafKR50obLIFqMYakRgc3XHtQYMVyJP0SqLe7vrfmmJQ4JRTq3eAnIjFJ2z6si7Q/8AzVipdpygURNDRcx/hMIgR+w2nXgo8fQjOgkv3ZOSwDO1irqxsWEOMo9V+YTK+glvW1q2XRV3JZvyzl3RPiFAWqe429q35BrCDNmxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758863; c=relaxed/simple;
	bh=kcNk7MBO5q7xGKOh5IEK9yhJsUZMeD3VDy5eD2t4KUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNQps9isyWD9vFDUCbU4QNouh7l7YSTVUMk2+Obkd1vnREE64Evt2eEAG6XFnJzzORpgkas9Iv1QQPdlPilx/86iZIPpfgaZsn3EpHqnM6pAXQRXlC3yO/e9v+qK9BU+jGVeNMq9IeIElaVbIhB+IwANRnlf9yiEiOxQ9K/s0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FejLLnkT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51A3C43288;
	Tue, 20 May 2025 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747758858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3fNTYLC6c1oFNfyxnG5Eu5y1LoT4/wA09vkRV/0dEM=;
	b=FejLLnkT6xgA3QeehEFmcfzk0U8jDnpoJqN9N6PjU8s5+lYOy6Kvg8F/bNj2GTfkO8JMLt
	fj6VzdPy9vp8h4f7VFFNo7UKw6Z7hxp1KoCBKmzbdevmC2TbEpoiGYUJ3VqDf4mEp61se5
	kOZRfhDAPoJHOHDWirTsSNLLkagPCNYBYCVfLXRatZc/rHAWPG9PRKV8LULpZuqBpkYfhm
	xjGUbaAZ5dmlEwZIo6KiDtCny+GMiK4PJiGGZ1IOFnIoDn8VREY2K+YqSeFesiMCiu1VbT
	Rjp2bfZuTOfmjpmTbpYcZdyqjFFKC1VGCB7Iry/DKJwHXhfUvjHfoF44Vy0NAA==
Date: Tue, 20 May 2025 18:34:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next v2 10/12] tools: ynl: enable codegen for TC
Message-ID: <20250520183416.5b720968@kmaincent-XPS-13-7390>
In-Reply-To: <20250520161916.413298-11-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
	<20250520161916.413298-11-kuba@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejtdculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfduveekuedtvdeiffduleetvdegteetveetvdelteehhfeuhfegvdeuuedtleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepp
 hgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 20 May 2025 09:19:14 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> We are ready to support most of TC. Enable C code gen.
>=20
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add more headers to the local includes to build on Ubuntu 22.04
> v1: https://lore.kernel.org/20250517001318.285800-10-kuba@kernel.org
> ---

Now got this build error:

-e 	GEN tc-user.c
-e 	GEN tc-user.h
-e 	GEN_RST tc.rst
-e 	CC tc-user.o
In file included from <command-line>:
./../../../../include/uapi//linux/pkt_cls.h:250:9: error: expected specifie=
r-qualifier-list before =E2=80=98__struct_group=E2=80=99
  250 |         __struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
      |         ^~~~~~~~~~~~~~
tc-user.c: In function =E2=80=98tc_u32_attrs_parse=E2=80=99:
tc-user.c:9086:33: warning: comparison is always false due to limited range=
 of data type [-Wtype-limits]
 9086 |                         if (len < sizeof(struct tc_u32_sel))
      |                                 ^
make[1]: *** [Makefile:52: tc-user.o] Error 1

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

