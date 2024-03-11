Return-Path: <netdev+bounces-79273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176C87891B
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8982819F9
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576DD5579A;
	Mon, 11 Mar 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeFqc87L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD45467F;
	Mon, 11 Mar 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186633; cv=none; b=V8+i+XBMiylUMFsZTxjJaFHxMmhHR3NEpsxUP2oTPuoVkb9E7TemwdY2kRnrZDb5NvlGOhoocTZVLRtkFL4MIcQRNDVwMMFvgiAzQHOC2VVuVJ/nZE3IEnLiyIjb3OTzZ0LRw++v8NxUDhw3PaM2AHxpdeUYkOC91YISwH6StUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186633; c=relaxed/simple;
	bh=z2jOsQ2xKPATAtbSTLCpoLzHFS9MMbw2YcRF1xX2ZEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWyIIE5YhfQ8KzJ9DCgBm/g8R8nuyuwQy/Imdo91niHaGUZRUMKZRcAQUq5D3zxPlFyh8wKeDyXhRt3VQ4EQdGvoPewuZiqmE9i7fYK34t9M7g1LFqBo8wFovimiLmsrtQyRpMdM6xZZrHBVDbikhtuBGkMcpQUrypJjYYZlMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeFqc87L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0843C43390;
	Mon, 11 Mar 2024 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710186632;
	bh=z2jOsQ2xKPATAtbSTLCpoLzHFS9MMbw2YcRF1xX2ZEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QeFqc87L/JM/pC12iWuXBEXSpC0OlEfHxMyA/ioYSItXfqupmKd3xASpWmil9FiF2
	 3ebtELxYP3gyxnNshlgT+EGs1XtqKQr+QghSpBSiMW7dL9ACq9MqsX1emFTv8Tfx8y
	 7nPyzcolUHuKbAIVpftpccJi/lKIBiuExbUsdS4RxK3tv2Z9mGzP6K68+XEKXFvx5b
	 ZeNemMiifTfe72Nr4ezWFT7x3iNokQy7aMDRDVtrCardgK3mFNWjH74iFQEsxdwLiX
	 IDFGPFsEgaSB1axX85wB7VThV0hJxIXvKnaC7reNRTc2uCT6KShg5xW1zi+CXQYEyH
	 RL8NK9poJeUUg==
Date: Mon, 11 Mar 2024 12:50:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>, <netdev@vger.kernel.org>,
 <netdev-driver-reviewers@vger.kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [ANN] netdev call - Mar 12th (note time change)
Message-ID: <20240311125031.2f5ade77@kernel.org>
In-Reply-To: <Ze9bFepLhiQIBmio@lzaremba-mobl.ger.corp.intel.com>
References: <20240304103538.0e986ecd@kernel.org>
	<20240304103657.354800b0@kernel.org>
	<Ze9bFepLhiQIBmio@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 20:27:17 +0100 Larysa Zaremba wrote:
> > Sorry, ignore that, ENOCOFFEE.
> > The next call is scheduled for the 12th of March, not tomorrow =F0=9F=
=A4=A6=EF=B8=8F
>=20
> We have a topic for the 12.03.2024 netdev call:

Great! Let me change the subject perhaps in an attempt to turn
this into the reminder:

The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
is scheduled tomorrow at 8:30 am (PT) / 4:30 pm (~EU).

NOTE NOTE NOTE: we are already on summer time in the US.
So for for those who switch time at different points
this call will likely be at an unusual hour for you!

