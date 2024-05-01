Return-Path: <netdev+bounces-92677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1722C8B83E2
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C58AB227A8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DC34400;
	Wed,  1 May 2024 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEHa5BBI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AA2114
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525728; cv=none; b=Fua3/WiRBhROJqCbA7j8s0+gmEO2DqrRZbLvafTpLgRF8xZQYTpFWI71+PFybzW5w0kE0XGNwlX+ZtbrNynlUJ0frc9wnXd+LzoEHLBGNZKC1oGXoBTWZND80KmH1SqJJyDAha9ONlPwlTofF1AavEWZPVUQqGyVsp3lVpsEPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525728; c=relaxed/simple;
	bh=ee2n2Yu28Thho0hZZh7wzYjFIPWj8HWaoGP2qC2Ib3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOfbADPjUPOuklwQInDRulV5sUVi3LEjQXLy6vTOMsb3EIQimDFd+Wv7lc+IIL9VYEO1z9Qk3mZ/3lhXNvPEbOR27Wz1lYypo/VrCOobqeu3Zotj3Le5GJ3u08dG4oLnvG0KVABQSNAogg7VUzbpFwPDegXiK6UvXpYPxJsm+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEHa5BBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA27C2BBFC;
	Wed,  1 May 2024 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714525728;
	bh=ee2n2Yu28Thho0hZZh7wzYjFIPWj8HWaoGP2qC2Ib3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEHa5BBIxaJabhR/8b+McIbBZ1ehMBO74S3PKDiRzLpWN0buar6+72jymabU1ZtzI
	 Nyg/Tq6UTRI0ytULlLnw6qTtqq4iVMjdNa2l9nBJoYZsZQFIT8BDH+v1RhKmTL2Dqz
	 E6kF+FUlMRP5vEUt5df3iNOMrM4/sTRaWsoFfwpYUBGXrfKuAP0hiodrk3r7kxwZcu
	 mIh+Yps4PHQKQPsyLa2JRJcye5OhlejwF+b56uZs2gVScBdBZ3d3vWSnE1nMpSklaT
	 OORZFRdAb+owmj1sggwmbEXlcQ8r2sS7DIc8YpEIdEV+28im9UOH4tUE03uC3wgqlT
	 gK1/vLVPDJunQ==
Date: Tue, 30 Apr 2024 18:08:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] test_bridge_neigh_suppress.sh now failing in both
 configs
Message-ID: <20240430180847.43ff7c63@kernel.org>
In-Reply-To: <ZjDOn9SNq8baOfZB@shredder>
References: <20240426074015.251854d4@kernel.org>
	<ZjDOn9SNq8baOfZB@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 13:57:35 +0300 Ido Schimmel wrote:
> On Fri, Apr 26, 2024 at 07:40:15AM -0700, Jakub Kicinski wrote:
> > after we forwarded the trees to Linus's branch on Thu it's now also
> > failing on non-debug kernel, in the same way. It fails every time
> > for us, so should be easy to repro. If you find some spare cycles,
> > could you take a look?  
> 
> Will check

Thanks, FWIW I just noticed that vxlan_bridge_1d.sh suffered
similar fate, although in that case it's the debug flavor
that started to fail.

