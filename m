Return-Path: <netdev+bounces-243683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DACA5D75
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFD94303EB0D
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75921DF75B;
	Fri,  5 Dec 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZLvY7f2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D694F9C0;
	Fri,  5 Dec 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898463; cv=none; b=XlP6kkv+YigtG7ez5Mlw2oDKs3QsxE4X1ZMyNlBL5HA4Feeq5CbTGJgtS8sbQyDyv2BHQtmd03qc79m0RDCg6qLFHK1R2hKMukuEzUiQqe75BEgU7/oR05LTLCnnGAKnL2tSPmFKnrTm5wFOO0QtDFPIDPrm6+qXhzISVrgpYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898463; c=relaxed/simple;
	bh=PAm3rWbBHsuMSjk8J1QU/ctVHIcuEvdCj9SoTv2JAO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCtU/4TFx8106M9lVG5gQ3zoS3UzQT163fNjUUlD8O6en7YheA+xEEiH/tW/2CYj5bD6W+PXbqFqYqmHzJPfSY/kdmo8B4T3HEl2gzdpDpRsEDWyG7Zu6BeB2QHa3EhaQJ1azveUDpWTzkJtYf8hOzEHZ4pO24mjjdW1zC1QMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZLvY7f2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AD5C4CEFB;
	Fri,  5 Dec 2025 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764898463;
	bh=PAm3rWbBHsuMSjk8J1QU/ctVHIcuEvdCj9SoTv2JAO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZLvY7f2alqbGYKqEWQjzB13WfZc754VBCnkNE8cS91DBXJuX2VU9v8pZt3M7vgM2
	 sd9YlNVhPyT60JrQVzK/pLZogBj/Qz8A8ODo6ySVgaetstPXquI3yiOVSLWym2x+Zz
	 XUPPMK+y/PfJv6qJnbZM4qkud69yZYGvEjkcBTPejHg3WSppqi1WQmcpQxqxFg+tHs
	 Ipgn5hEO9AE/OfxfyMEesQj7EdNoeC1TpmKRX8ZyiSUmILvGSX4epWCxELrCoS0mza
	 TNgBwiZ0wtau00lBqNuRfkhy903UFpQoVF8HQM6lD/XCk2yWbjkxBkcH2ow2axWooS
	 OpK+huN5Dlg7g==
Date: Thu, 4 Dec 2025 17:34:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fabian =?UTF-8?B?R3LDvG5iaWNobGVy?= <f.gruenbichler@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Breno Leitao <leitao@debian.org>, Paolo Abeni
 <pabeni@redhat.com>, leit@meta.com, open list
 <linux-kernel@vger.kernel.org>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: veth: Disable netpoll support
Message-ID: <20251204173421.23841106@kernel.org>
In-Reply-To: <1764839728.p54aio6507.astroid@yuna.none>
References: <20240805094012.1843247-1-leitao@debian.org>
	<1764839728.p54aio6507.astroid@yuna.none>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Dec 2025 10:20:06 +0100 Fabian Gr=C3=BCnbichler wrote:
> On August 5, 2024 11:40 am, Breno Leitao wrote:
> > The current implementation of netpoll in veth devices leads to
> > suboptimal behavior, as it triggers warnings due to the invocation of
> > __netif_rx() within a softirq context. This is not compliant with
> > expected practices, as __netif_rx() has the following statement:
> >=20
> > 	lockdep_assert_once(hardirq_count() | softirq_count());
> >=20
> > Given that veth devices typically do not benefit from the
> > functionalities provided by netpoll, Disable netpoll for veth
> > interfaces. =20
>=20
> this patch seems to have broken combining netconsole and bridges with
> veth ports:
>=20
> https://bugzilla.proxmox.com/show_bug.cgi?id=3D6873
>=20
> any chance this is solvable?

What's the reason to set up netcons over veth?
Note that unlike normal IP traffic netcons just blindly pipes out fully
baked skbs, it doesn't use the IP stack. So unlike normal IP traffic
I think you can still point it at the physical netdev, even if that
physical netdev is under a bridge.

