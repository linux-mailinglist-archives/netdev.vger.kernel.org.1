Return-Path: <netdev+bounces-108953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA1D926580
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDDEAB22011
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F217DA06;
	Wed,  3 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc/uBGHA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8417A589
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022559; cv=none; b=p5Hg1yPhjtRScGNPsIj1hniTqQTr/xw7EbTI48N34h1PBGomJeZIA0S9pxdZBY1dNG3Bd6e2Q1sKtuO6W5CsHujpW6yMr2437VgZgEV9Z/Pm7TXLkMnjbPzVGVQkPnHfrM5VlmwF3xybPoJj2uYNWGXcH3Fm/iKywWdWIzv5bMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022559; c=relaxed/simple;
	bh=LuFsF0HDICMm/T537Fsy90FqGLc4Uqx/yJxVq+dRp0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byXyeLRfqhsys3pAYsVhaavxyxdxazyoeLZQOmfzboWw51bDTdX7gFkn/4KLE3cKi2nJNnH0fcrp2F0e6CJVCd5Zo+TpxIND7MvF+hUtfSZCSgOG/CTgmpDHAMWOwcmv9xqlIiMnZslqNFXKIKaoBbljJLy7GAoEVBHLDcH5fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc/uBGHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA51BC2BD10;
	Wed,  3 Jul 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720022559;
	bh=LuFsF0HDICMm/T537Fsy90FqGLc4Uqx/yJxVq+dRp0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pc/uBGHAyg4mnWp605OP/I06hDwQ0/MB/xaFcupW+FzQfHorT3lLMPFDrrDY1rHLa
	 AtaxWi5YiPbMDDIR+Y4tx/WNIGp8hpWFnEwPC5JKCmJRjg3lMEwm7z2T+9gpjGHFwW
	 NL03szMqz8OlBoAqFhjArTFpKOikT7G5wuN8Eue7forY0qa90qASYoS7EgLx87UkZk
	 xNheP3wxkYtsOv1Ftx4h9c6M+8tmFaEdPE6FC1VFDMgWUiUpv7UeY2tBOkCewd2Xjg
	 uThNkk3VD6Mt7nmsct1AF+GKKt79EETvE7RPXnaGCyHVJm0MyqMuWGiBQavmaFd9CI
	 k0zzK+ZvSP27A==
Date: Wed, 3 Jul 2024 09:02:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <ecree.xilinx@gmail.com>, <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next 09/11] eth: bnxt: bump the entry size in indir
 tables to u32
Message-ID: <20240703090237.599a1d5a@kernel.org>
In-Reply-To: <969b53a8-0f66-4b5b-9465-c2e5d6d4164b@intel.com>
References: <20240702234757.4188344-1-kuba@kernel.org>
	<20240702234757.4188344-11-kuba@kernel.org>
	<0a790e16-792b-448c-abaa-a4bf8cc9ebb0@intel.com>
	<20240703064909.2cbd1d49@kernel.org>
	<969b53a8-0f66-4b5b-9465-c2e5d6d4164b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jul 2024 16:02:38 +0200 Przemek Kitszel wrote:
> On 7/3/24 15:49, Jakub Kicinski wrote:
> > On Wed, 3 Jul 2024 12:51:58 +0200 Przemek Kitszel wrote: =20
> >> OTOH, I assume we need this in-driver table only to keep it over the
> >> up=E2=86=92down=E2=86=92up cycle. Could we just keep it as inactive in=
 the core?
> >> (And xa_mark() it as inactive to avoid reporting to the user or any
> >> other actions that we want to avoid) =20
> >=20
> > Do you mean keep the table for the default context / context 0
> > in the core as well?
>=20
> it was not obvious for me that this is only about the default one,
> but that would yield more uniformity and cleanups I guess

I'll add a note to the commit message. Initially I was hoping to add
context 0, too, but there's a number of gaps. We will hopefully
converge to that over time.

