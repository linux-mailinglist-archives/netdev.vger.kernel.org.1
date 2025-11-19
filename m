Return-Path: <netdev+bounces-239756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B52C6C2C2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9AD24E2D70
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697B20298D;
	Wed, 19 Nov 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERlSWBDP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5901C5D7D;
	Wed, 19 Nov 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513433; cv=none; b=ZsyRd393cS2MHScoSLfkqJFgZl9RmTEfoaaVmxWxnQDUgB5awy92CCvtUoVX+ZWR6euTOJ8qiCG1Ya9Xbdje+w9Ixz2x8Z+KatHixlgjmxBY4UGNuL4uTFNQy0z3ttZsOviITnArdOpS0Cog9rocePLjrZUL1d4QE/DFSMyADoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513433; c=relaxed/simple;
	bh=aDNZQ3grOmvLo0XdWNIfUDJpL88GIHWAlZqtP83f/5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc5Z9s4PzI7GtMjYLpK4GLqjBa5cZ47oEFnd618AjNdu7nLSRXevYV1T1A51Cr8VE3G0YaYIivPhkdYDfUjAN7kQkAYeK1Mxhpl8sJFGgDoYe3wyyIEz6ROmOkSsCRrF8JDM1btjKk01AXdqUiaPtWJxXaTewMqYFxIasAv81rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERlSWBDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9576CC2BCB4;
	Wed, 19 Nov 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763513431;
	bh=aDNZQ3grOmvLo0XdWNIfUDJpL88GIHWAlZqtP83f/5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERlSWBDPFOjY1XAU3/jkzN6ZvXBXZGEhxPAG0oyRHp0rraobLHZUcXNkOGEz3e/SJ
	 h6R2bDfOjl5HVcAZsQfNXfNGmc/Husck/1uicI8qHFirFhJvacJQxOBJn0yuu3MM+5
	 u9z7Rw07NFcfpfsAqPTc0apXo0lC8AJTYnbdKtOSaNKof3dtuJeQP0F5uE4GVPgx1h
	 gSYewrnKv/zV8sP/iXVJjAVuM4DFb+Lew1hqEvw9xau+qw7FjLy8eroVWKvjtOFNJl
	 PTA/XWSaYuInInpQOeicOnVzJRcCIwbN97NWhTe1hSeLD9Z+PW7t9lxmOdoOMqtZ9f
	 FNlMsCzmP00eQ==
Date: Tue, 18 Nov 2025 16:50:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <20251118165028.4e43ee01@kernel.org>
In-Reply-To: <aRz4rs1IpohQpgWf@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
	<20251105183223.89913-5-ast@fiberby.net>
	<aRvWzC8qz3iXDAb3@zx2c4.com>
	<f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
	<aRyLoy2iqbkUipZW@zx2c4.com>
	<9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
	<aRz4rs1IpohQpgWf@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 23:52:30 +0100 Jason A. Donenfeld wrote:
> On Tue, Nov 18, 2025 at 09:59:45PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnese=
n wrote:
> > So "c-function-prefix" or something might work better. =20
>=20
> Also fine with me. I'd just like consistent function naming, one way or
> another.

IIUC we're talking about the prefix for the kernel C codegen?
Feels a bit like a one-off feature to me, but if we care deeply about
it let's add it as a CLI param to the codegen. I don't think it's
necessary to include this in the YAML spec.

