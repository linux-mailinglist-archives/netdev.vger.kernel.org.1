Return-Path: <netdev+bounces-207658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF3B08149
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE3D18967A2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A242B800;
	Thu, 17 Jul 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zck+6Lfs"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C6645
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710893; cv=none; b=FkLSykSFby0oza8/8p1oCb7221DBjQZoOCJMNbs4ijyW7RTLWPOoUAcfprSYxrtZ31mNBP8jfHvd2yRyQD8fz5VSdnCtNUAdMj7jGM7KmNWL3mu1n3+c+3wxPzaS++w/aHkQwVUgA2G/NL622+boZ6mVh5hmhlYDAj8FmyF2tAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710893; c=relaxed/simple;
	bh=Bz7Xi+Wcr9K3bvtOTxASEu6BO2bSEKPT1a8EJltOxbM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=MwRpmNEeuKR5rGyszLJgYeBdoJJHvYTfZ5uken92RcJ+wfQsZ8DSrPCM8+vTwszZH2HPmlm/40dgnpD4SViVGOH5iG0M5b0IDJwZpwiNm/FSUonigMNPvGyfFdtnThP5CiAEcTQ5GEI9UOYNGaASb+H6lFRufv2LHzuiYdHPVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zck+6Lfs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752710889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz7Xi+Wcr9K3bvtOTxASEu6BO2bSEKPT1a8EJltOxbM=;
	b=Zck+6LfsoBnkfsJIaqJcBZAbm18KKb0xxieVpBl8nRk2bj6FkfmP5uIxjhoOoxlAAt9hCf
	/fBVzv4JmTiJHEuSIpLh7AFg+fpf3sWpDc6dA6VboQKuzxGdeioZIVko8ZWPlK7g6hityQ
	8dDJHRavFzTltczM9rjdN6HsTnXF+w4=
Date: Thu, 17 Jul 2025 00:08:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qiang.zhang@linux.dev
Message-ID: <8a0a4d3149930b4dd98ba9577577417bae2d7a7e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: Remove duplicate assignments for
 net->pcpu_stat_type
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250716151115.0ef44776@kernel.org>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
 <20250716001524.168110-2-qiang.zhang@linux.dev>
 <20250716151115.0ef44776@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, 16 Jul 2025 08:15:24 +0800 Zqiang wrote:
>=20
>=20>=20
>=20> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20
> Your email address seems to suggest the latin spelling of your name
>=20
>=20should be Qiang Zhang. Please use that instead of Zqiang?

Thanks for replay, Zqiang has always been the name
I use in my life and in the community.

Thanks
Zqiang

>=20
>=20--=20
>=20
> pw-bot: cr
>

