Return-Path: <netdev+bounces-78824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E40876B20
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE09282947
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C55917C;
	Fri,  8 Mar 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZXBSzWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99275916F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925376; cv=none; b=aOHlmwAuaeUjaL7D71XiHgTavC1cOIWM4FRUWbsESx4J4oU49Xh6P94JJ9o/6D2gSzEfEsEzkgAsxLKlXbZjTTiyjfCvWZ6hRYHA+uAzcmfFQtRWLlr+Q8rHlhLDaQForSegUQdv3tRXN3zp2E2vuPv6OKsgnUnSX9YM2Whfxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925376; c=relaxed/simple;
	bh=vI5rFVTAyIC6UrsXEGoJcWtz0Us3bJRJI9sE2pElm90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxI7wYeeOHUqvwGR8VlHAsqMeTyF0qBoGQvayUNlQF0d4K4mr8REAOtGX4gyb6soZzRsUrLGWxYv9C6tDhCF1Jfe+bn0/ItGsfCMfsB7PxwspP2COFWjSNNEmChrZUnEYbzhcz+rVLEWEvM0cxxYI35FXh41gpg19MpFi0FJoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZXBSzWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9AFC433C7;
	Fri,  8 Mar 2024 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709925376;
	bh=vI5rFVTAyIC6UrsXEGoJcWtz0Us3bJRJI9sE2pElm90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pZXBSzWlVvvpn8xtAR6gx5XKVORtOh7H+VwcUw2CVvDDYEZXotwphcqxA5lBTarx6
	 A9ENjamRcIOSeHDMoo+0+/F0yUgeMQeb5LrZps+y1OU5I/hobdZ3tEO5J1M2RZ9uhr
	 m7i6zeb7fkd2pU7lPhMyappwtucXnM6+/TeAap6Q54fvsen6jbIjPkfZuxMmBMc6jX
	 m/IjQFB3v1xG2DkvxCNgu0pf9ER2Yaaf8PPSC1N/snbmY842ZJMdswthO7ypxG37lU
	 9qr2T+lhExg7/CsU6FckpnAnMTWUFik3w4/kpuC6pinPwXGJ5RfIow8GXWPpN9Ux6x
	 pWxZmWcaTfjrA==
Date: Fri, 8 Mar 2024 11:16:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: michel@michel-slm.name, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors
 without stacktrace
Message-ID: <20240308111614.043c49f0@kernel.org>
In-Reply-To: <ZetYdY7DXcElIKwa@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
	<20240306231046.97158-3-donald.hunter@gmail.com>
	<ZemJZPySuUyGlMTu@gmail.com>
	<CAD4GDZyvvSPV_-nZsB1rUb1wK6i-Z_DuK=PPLP4BTnfC1CLz3Q@mail.gmail.com>
	<20240307075815.19641934@kernel.org>
	<ZetYdY7DXcElIKwa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 10:27:01 -0800 Breno Leitao wrote:
> > I'm far from a Python expert, so up to you :)
> > I used type hints a couple of times in the past, they are somewhat
> > useful, but didn't feel useful enough to bother. Happy for someone
> > else to do the work, tho :)  
> 
> I am a big fan of type hitting, since it help in reviewing code, as also
> with tooling that help you to find problems, since the function returns
> and arguments now have a type.
> 
> What are the top 3 python scripts we have in network today? I can try to
> find some time to help.

I think ynl.py (and nlspec.py) is by far the most used / active piece
of Python we have today.

