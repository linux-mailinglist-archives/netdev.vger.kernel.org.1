Return-Path: <netdev+bounces-106928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55548918257
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883A51C23381
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FB181B8F;
	Wed, 26 Jun 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUSL149r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FED17CA1A;
	Wed, 26 Jun 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408433; cv=none; b=TJg76KvMtkc1YwoX5XQ9KrSh3I3pbT2kIANq6QSklxsZ0jXZsp/Hnlad20HHQvqFY+oWPewB3pQ0NNC910BH6LUSTzwSZcBodL5QZpoeb1naH5ZVlaaBUh1bfgnzOIHyo83mfbCUbg7Ocqevu4cCEbY3H/VAKA0uV8E0+uMVW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408433; c=relaxed/simple;
	bh=hc+hknp4pzhwRX+PVOXc8ZKBg3TtI/Lca03Al5/txgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMv59/7H4LO1Z0Oi3a7id/5wp4fMtxLwOAD4ffHPQzY4+ts8K5qL0gBGWy5FC2RGVaa5rSMgJCmpmoInM4DOoJ99RdP6izaE4TXs2VhGzeNvLRAC9JQOyTwr2J4dcQP37WC1fYj5RR+4hQfL26xh/U2v7nVgr+2GCx91fRAmJpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUSL149r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5924C2BD10;
	Wed, 26 Jun 2024 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408433;
	bh=hc+hknp4pzhwRX+PVOXc8ZKBg3TtI/Lca03Al5/txgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUSL149r5mpZw0K6UIv8b2A033MGZ5xPscsZ3jfb+Ww5gi3ZpVNH0/0BG4wE3oRpQ
	 +Y4QcFKIHQr+IDNSvhephJymUeGM0dWvgtw/fkdzEnemS79gU3dhbwU56rsVmvNINA
	 7OgU7mq2eYeiTrhhWWUMTm628+3m6eYfqJPgHFYvbO67BRUA6WxrFngyA6NYs68w8s
	 O8uvJ/S9XdaYbHyKTo/BqZpIFMX82wvyqxdtNFO0BLv5ACk96XPqFOWQ1Ss6HiAilI
	 2S8SwV8eflzujwPbrtxao/R1pt+Cb14DoLjO+mkb7mD48s7nyw5txjgCgND358u+gB
	 RgW4olWXj2Tkw==
Date: Wed, 26 Jun 2024 06:27:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] net: pse-pd: Add new PSE c33 features
Message-ID: <20240626062711.499695c5@kernel.org>
In-Reply-To: <20240626095211.00956faa@kmaincent-XPS-13-7390>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
	<20240625184144.49328de3@kernel.org>
	<20240626095211.00956faa@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 09:52:11 +0200 Kory Maincent wrote:
> Do you know when and how often net-next is rebased on top of net?

Every Thursday, usually around noon PST but exact timing depends on when
Linus pulls and how quickly I notice that he did :)

