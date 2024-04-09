Return-Path: <netdev+bounces-86288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F889E513
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82951F2271B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D07158A28;
	Tue,  9 Apr 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8oIrGlv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E3158A09;
	Tue,  9 Apr 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698926; cv=none; b=S6ziQvZwSYySoOKHHs0eV9UzdVJLYk0Cz2DW4XcZtMOv1dcjQcKiP1PNsq4eJYRElbqcPdB0wEg2TrVNzJcqPdP+Bv+g5rIkiBby4th/Bq+YRXAYkiE/USeajJo2aRbFkIHuPi6MZLX4dB9Xg9texltS1Tyz0BDIH2i2RTf70ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698926; c=relaxed/simple;
	bh=5I1KP0MI3m2b78fWq623tWUuBU2WB1RVyh5tQpUvABU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMr+gSgIqomYrUtQj0MEA0bHAvzJWne4nryAsFj0zNeRTRvu/u+XqMN7nkcFS0P9MJgXM3t1LpU5X8oqYwfA0ie1dDItpUjK+vFx8W+iyCy65XCOAW581DMDAlNPFpyjI98JF7uaFTE0gMM415UwWrCWTwEfGRDlrzgIHMZkBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8oIrGlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDA6C433F1;
	Tue,  9 Apr 2024 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712698925;
	bh=5I1KP0MI3m2b78fWq623tWUuBU2WB1RVyh5tQpUvABU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j8oIrGlvoDxbi3j/516Cm5YFo5s1GnfkJb2iZ5gV5X0luxOT0mDFAkkJ6A6SGne37
	 VRsGjGqN2tLqC/uOIioWPZ1od9drdbGbuxES53flCNRPlL4+3RIEvcF3v8OcL5dZa+
	 7DKfuXDL/CBiQ3C6aqOTbzLRtmeIGVjzmJYd4Qqk0611B9yw8PFWuBjblVahoQzpqa
	 uIiqA10UlwOQVhQF7QV+6GKHxfKgWyGhKI3YvpeQL0GjJ9EgKFD+1xgUyxnnynfGjR
	 W35hiPfk8M/x5RCdtlGiZbEi/38cdXV6uVmAlDYQvd7SLba4U+ikLKFPQ1wmu5OsVU
	 23MrTtMBmhFxw==
Date: Tue, 9 Apr 2024 14:42:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Li Yang
 <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Zhang Wei <zw@zh-kernel.org>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] MAINTAINERS: Drop Li Yang as their email address
 stopped working
Message-ID: <20240409144204.00cc76ce@kernel.org>
In-Reply-To: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
References: <20240405072042.697182-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  5 Apr 2024 09:20:41 +0200 Uwe Kleine-K=C3=B6nig wrote:
> When sending a patch to (among others) Li Yang the nxp MTA replied that
> the address doesn't exist and so the mail couldn't be delivered. The
> error code was 550, so at least technically that's not a temporal issue.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

FWIW it's eaac25d026a1 in net, thanks!

