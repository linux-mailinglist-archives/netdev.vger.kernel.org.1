Return-Path: <netdev+bounces-239293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB6C66A96
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3334FBCF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3232727EE;
	Tue, 18 Nov 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeeVak7y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874F26ED37
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763425712; cv=none; b=WyG+DIqO3aB+el2oyJnTUQQ7pMbZqQ2DJMnqaQ/SE20IJ7aE21xZcYOTnPEyfR0cp16S+c92nk701Ay5HunTAGHX9ebXMCDw3Y3SB95I1LUxWkuU+mavSztl7cN87YW4Ph5abHvWxVW9f4fdEZnu40N1oksZxdyR0yRKyPLNrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763425712; c=relaxed/simple;
	bh=RHr2EZN2twAfY94Nzt0TiuWBj/Io8X19h6LYryaVofU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rp9IIOgCJMlzhDpw7NtcprInp/ZONHgU7UGR2gpCYvJxnTPioLzvyyTDC3P0BlbP9Czg029aoMSSrm6bpdPuTvJoPYEqEjaR8F4EGfM2VEzrlvpsOEUBF3kjRcC/hFKWcW71jtz6GzVLPv00TGk7sUUqYwzhxXPBBlFh94KQV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeeVak7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DFAC19423;
	Tue, 18 Nov 2025 00:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763425711;
	bh=RHr2EZN2twAfY94Nzt0TiuWBj/Io8X19h6LYryaVofU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PeeVak7y1dKI3Mq6X99MHZT6FOwNvQbO+t7g59gK0l8fyJD54vtRG9/NQr6iYGp5M
	 KSPZar7TV2L0Ts+ROpRZEI3KigUfAsNRgifTXMVXv0t1VKL07a8NKVPLc+cdr4+4n7
	 0bLkIZTK3b2g5eQOjlzlq2o1DgEsa7SNIrMl4BmNsChYgIOstadfBPvrjO1Y9+Ek15
	 5gzy4+yPWzogjfv6LzdQ5meadJr+ATeSX0eV+TMc2Hvn37FH6e1RaOOnStF3zAncr6
	 YmrNeQJeN0xi61wB2BbLuSk9HHXsgbakQoQnRIsn7WMleb8NEFIhlVJ9yHAYGtd+yl
	 vVjyIaRGnCc/g==
Date: Mon, 17 Nov 2025 16:28:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] fix 3com/3c515 build error
Message-ID: <20251117162828.66e0b71d@kernel.org>
In-Reply-To: <20251114.175543.1553030512147056405.rene@exactco.de>
References: <20251114.175543.1553030512147056405.rene@exactco.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Nov 2025 17:55:43 +0100 (CET) Ren=C3=A9 Rebe wrote:
> 3c515 stopped building for me some months ago, fix:
>=20
> drivers/net/ethernet/3com/3c515.o: error: objtool: cleanup_module(): Magi=
c init_module() function name is deprecated, use module_init(fn) instead
> make[6]: *** [scripts/Makefile.build:203: drivers/net/ethernet/3com/3c515=
.o] Error 255

This patch is missing the usual markings, could you please re-format=20
it with git format-patch? Or resend it using b4?

