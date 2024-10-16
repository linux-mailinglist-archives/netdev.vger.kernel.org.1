Return-Path: <netdev+bounces-136177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4C9A0CBF
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7621C215DC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A31BAED6;
	Wed, 16 Oct 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwMc9f4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9F52F76;
	Wed, 16 Oct 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089277; cv=none; b=k4dH1XuOvLECGvmVRzIPa0BGV9VJ9S1cRsZPjh5CCb1n7KoW1ETIGu1chw300/Kkn7ZRosHX44P9u7hioI2xmSci7Xt/A0spC0GicHJJCZDadggIqYtH5Nxf7+095AFqiF2b6BL+rwCOlQp6NfKcUM3GekCW5GurVEe7+tXstj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089277; c=relaxed/simple;
	bh=/Q2Fdo3DQMDJW7+zCNQDyn/3Ues5Xdu5MPKqpemcjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjXMF3cSOjQBbohHa1PBabDjMLHdeaCfoh5fqP4WG8TUDk9Of7Ep600kcC+AmCImdXyezGrWUcyrUuloRXdUO7o1USDNwqSvEfjLOfYWP6LaF5d639JDrNX+IdsPcVQM+cNch+OGYMmlFazIx/qZbRl9fV6zXq14TiCrwf5ESf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwMc9f4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1F7C4CEC5;
	Wed, 16 Oct 2024 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729089276;
	bh=/Q2Fdo3DQMDJW7+zCNQDyn/3Ues5Xdu5MPKqpemcjCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwMc9f4yT9P5bQ7c/FT4vnvjbycz0SNLuDaYnusdNchhUT/Th2/v8nyYzAei+paPC
	 U90HnaU97YXI88xPaFaUqe2F2+93Mj25Xqv6Vwvo8o9vaKdEtE+ONzgY6DPJ7+nocE
	 4WsUme/lKbHP5zzQj9CL+c41EqiqikX4ngyVDLSOsAGKnf0RAOga9zK+Su6JltJsOI
	 u7bVLq0mcZVv2j8DA0Alop8bAHVS9lllvlGiNPfqjcSHuZHrL0l/FyzWxv0Iw8ziPm
	 SelPbykMzcHENeMNAvQCMYlkkaEDHlQ62LdvHqZiHtM4kNs2sJ6j7kLZZfptch2Cvl
	 Ul2TvbC5TDsHg==
Date: Wed, 16 Oct 2024 15:34:31 +0100
From: Simon Horman <horms@kernel.org>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Message-ID: <20241016143431.GJ2162@kernel.org>
References: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>
 <20241014081823.GL77519@kernel.org>
 <d2c24d063bea99be5380203ec4fafe3e4f0f9043.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2c24d063bea99be5380203ec4fafe3e4f0f9043.camel@mediatek.com>

On Tue, Oct 15, 2024 at 05:18:49PM +0000, SkyLake Huang (黃啟澤) wrote:
> On Mon, 2024-10-14 at 09:18 +0100, Simon Horman wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Mon, Oct 14, 2024 at 12:05:21PM +0800, Sky Huang wrote:
> > > From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> > > 
> > > This patch does the following clean-up:
> > > 1. Fix spelling errors and rearrange variables with reverse
> > >    Xmas tree order.
> > > 2. Shrink mtk-ge-soc.c line wrapping to 80 characters.
> > > 3. Propagate error code correctly in cal_cycle().
> > > 4. Fix some functions with FIELD_PREP()/FIELD_GET().
> > > 5. Remove unnecessary outer parens of supported_triggers var.
> > > 
> > > Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> > > ---
> > > This patch is derived from Message ID:
> > > 20241004102413.5838-9-SkyLake.Huang@mediatek.com
> > 
> > Hi Sky,
> > 
> > I think this patch is trying to do two many things (at least 5 are
> > listed
> > above). Please consider breaking this up into separate patches,
> > perhaps
> > one for each of the points above.
> > 
> > Also, I think it would be best to drop the following changes unless
> > you are
> > touching those lines for some other reason [1] or are preparing to do
> > so:
> > 
> > * xmas tree
> > * 80 character lines
> > * parentheses updates
> > 
> > [1] 
> > https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches
> 
> Hi Simon,
>   Reverse Xmas tree style & 80 char preferences come from your advise
> in  
> https://lore.kernel.org/all/20240530034844.11176-6-SkyLake.Huang@mediatek.com/
>   Parens removing comes from Daniel's advise in 
> https://lore.kernel.org/all/20240701105417.19941-14-SkyLake.Huang@mediatek.com/

Ok, sorry for the mixed messages.
In this case think these can stay after all.

> 
>   Because previous patchset(
> https://lore.kernel.org/all/20240701105417.19941-1-SkyLake.Huang@mediatek.com/
> ) is too large, I guess it's better to commit this change first so that
> I can handle the rest. And this should be "some other reason"?

I think it is sufficient to bring to our attention that there is "some
other reason". Sorry for not remembering it.

>   And since this patch is simple clean-ups, is it necessary to separate
> it?

I do think that would be best.
But if you strongly think otherwise I can try to review it as-is.

