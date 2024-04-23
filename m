Return-Path: <netdev+bounces-90510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B684F8AE53A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D6C1F24208
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2685631;
	Tue, 23 Apr 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heuh6PxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28285274
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872763; cv=none; b=WashJoY56U8TUEHhmBvwraCmbdsUEEyc+J8KJlH1gKcnh6vO+oQi9w5fMhXsNOCAXcGizpsqToS3CUbsVlhvTC6jdWU530ipuxez0r9k4EmWOcr19jd3Im8yB5E/1kVLJs57Fdmm02b8tx+FLpxCtKkKdIPCmci4vdRB1whDccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872763; c=relaxed/simple;
	bh=ItzHgWjEcVLsXdMc9k9hJYVYwWOJnIObQkoft59pIJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEH0t/nHx9ikXEz1afm40cG/TL+ejIQ6JgURkYAclpDIaZEHUi06jmgRaHNr2PcM0bttJVUX6UyxlcCC9YSyueN+wSptK7uQ3db1dbcMimZSBkEVZa6Fxz0hma0kY8guA8lBO/KU36dcbHaQ8OIH3fmzOxvNRzcwvvHRa1HGuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heuh6PxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E309C116B1;
	Tue, 23 Apr 2024 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872763;
	bh=ItzHgWjEcVLsXdMc9k9hJYVYwWOJnIObQkoft59pIJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=heuh6PxTP8hNheqOGcnCzZvpfPBucKxwWV3+Vr55wGNd739YqVV1hw6uWKifCkYPt
	 m7/vWwp33YnjbXCV8v7hDhHXlOEMd5Fu8SbEvY/UwOrTVrQJTs4Dgqr0p3TangJL7N
	 iyPrO4Ip3T8z3mcdmnhiEvp5sGqFyKBkYLpF5IK6cVXXXLGlTePNlJpPkMFnk4meh/
	 G6tuTcBPXIqTT/D+f/sTQMwoAbcixHrfZV7ahvpNzZOV9vP098WxRsbGpdjrcYV1rZ
	 /Wfhq3v1kIu9pZl8OsHFP2kXGH7M8LIcsdLD0fv+xXp3wWYSkYTgeEoJplwJKX1ZMI
	 esCZLapVwHhKw==
Date: Tue, 23 Apr 2024 13:45:57 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Raju
 Lakkaraju <Raju.Lakkaraju@microchip.com>, Frank Wunderlich
 <frank-w@public-files.de>, Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: sfp: enhance quirk for Fibrestore
 2.5G copper SFP module
Message-ID: <20240423134557.2a2f67c6@dellmb>
In-Reply-To: <ZieebbTQ0FP0yiXx@nanopsycho>
References: <20240423085039.26957-1-kabel@kernel.org>
	<20240423085039.26957-2-kabel@kernel.org>
	<ZieebbTQ0FP0yiXx@nanopsycho>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 13:41:33 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Tue, Apr 23, 2024 at 10:50:39AM CEST, kabel@kernel.org wrote:
> >Enhance the quirk for Fibrestore 2.5G copper SFP module. The original
> >commit e27aca3760c0 ("net: sfp: add quirk for FS's 2.5G copper SFP")
> >introducing the quirk says that the PHY is inaccessible, but that is
> >not true.
> >
> >The module uses Rollball protocol to talk to the PHY, and needs a 4
> >second wait before probing it, same as FS 10G module.
> >
> >The PHY inside the module is Realtek RTL8221B-VB-CG PHY. The realtek
> >driver recently gained support to set it up via clause 45 accesses.
> >
> >Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> >---
> >This patch depends on realtek driver changes merged in
> >  c31bd5b6ff6f ("Merge branch 'rtl8226b-serdes-switching'")
> >which are currently only in net-next. =20
>=20
> I don't follow. You are targetting net-next (by patch subject), what's
> the point of this comment?

I wrote that in case someone wanted me to send this to net, instead of
net-next.

Marek

