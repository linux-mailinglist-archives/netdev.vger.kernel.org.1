Return-Path: <netdev+bounces-132510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BBC991F94
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AC61F21554
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96235189912;
	Sun,  6 Oct 2024 16:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30D1A716;
	Sun,  6 Oct 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231374; cv=none; b=tOg7b27e6aA0YGKmvFNDlzTO/FSbWDZZuMb/dhXhcZO9kT5xpcePdFOxMfnOiZ9uMEDWFDU7ssRDFIaP4zS7SOFE2CufoGB2FFarUus0IBGFItIhUhz2zLLl5F1Xh+29iC7+ZGZZcrs1+OkPN1QA5oNgKe8LLLiMV4SpY8V7WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231374; c=relaxed/simple;
	bh=EWSaAX9p9y8xz8bTqbnZbyO/TzqHqojOs5Qs6ahAuDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmZ5PlrU7+AuVihdTM3d9bDKj0iIwUZyZa1F57ZtAGzweZg74uuZnq0p89o/R9Zqc6aYJLWX3QErQbIBvS3z4jtvF5ptseOe+4OcYroENJibRTWyeF11MITKwBaIMW/ixA1xaXiw9jfzGKC2quPCAtwojmbYBjpcbB4R0DXB16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sxTvM-000000007X7-1hLS;
	Sun, 06 Oct 2024 16:16:00 +0000
Date: Sun, 6 Oct 2024 17:15:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <ZwK3t_uEErLXlaQy@makrotopia.org>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
 <20231219102200.2d07ff2f@dellmb>
 <87sf3y7b1u.fsf@waldekranz.com>
 <ZZPhiuyvEepIcbKm@shell.armlinux.org.uk>
 <87mstn7ugr.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mstn7ugr.fsf@waldekranz.com>

Hi Tobias,

On Tue, Jan 02, 2024 at 02:09:24PM +0100, Tobias Waldekranz wrote:
> On tis, jan 02, 2024 at 10:12, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > On Tue, Dec 19, 2023 at 11:15:41AM +0100, Tobias Waldekranz wrote:
> >> On tis, dec 19, 2023 at 10:22, Marek Behún <kabel@kernel.org> wrote:
> >> > On Thu, 14 Dec 2023 21:14:39 +0100
> >> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> >> >
> >> >> +MODULE_FIRMWARE("mrvl/x3310fw.hdr");
> >> >
> >> > And do you have permission to publish this firmware into linux-firmware?
> >> 
> >> No, I do not.
> >> 
> >> > Because when we tried this with Marvell, their lawyer guy said we can't
> >> > do that...
> >> 
> >> I don't even have good enough access to ask the question, much less get
> >> rejected by Marvell :) I just used that path so that it would line up
> >> with linux-firmware if Marvell was to publish it in the future.
> >> 
> >> Should MODULE_FIRMWARE be avoided for things that are not in
> >> linux-firmware?
> >
> > Without the firmware being published, what use is having this code in
> > mainline kernels?
> 
> Personally, I primarily want this merged so that future contributions to
> the driver are easier to develop, since I'll be able test them on top of
> a clean net-next base.

I've been pointed to your series by Krzysztof Kozlowski who had reviewed
the DT part of it. Are you still working on that or going to eventually
re-submit it?

I understand that the suggested LED support pre-dates commit

7ae215ee7bb8 net: phy: add support for PHY LEDs polarity modes

which would allow using generic properties 'active-low' and
'inactive-high-impedance'. I assume that would be applicable to the LED
patch which was part of this series as well?

In that case, we would no longer need a vendor-specific property for that
purpose. If the LEDs are active-low by default (or early boot firmware
setting) and you would need a property for setting them to 'active-high'
instead, I just suggested that in

https://patchwork.kernel.org/project/netdevbpf/patch/e91ca84ac836fc40c94c52733f8fc607bcbed64c.1728145095.git.daniel@makrotopia.org/

which is why I'm now contacting you, as I was a bit confused by Krzysztof's
suggestion to take a look at marvell,marvell10g.yaml which would have been
introduced by your series.

Imho it would be better to use the (now existing) generic properties than
resorting to a vendor-specific one.

In every case, if you have a minute to look at commit 7ae215ee7bb8 and let
us know whether that structure, with or without my suggested addition,
would be suitable for your case as well, that would be nice.


Thank you for your time and support!


Daniel

