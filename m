Return-Path: <netdev+bounces-60826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067A821978
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CBF1C21766
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C4D27E;
	Tue,  2 Jan 2024 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iweyEfqw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6585D268;
	Tue,  2 Jan 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mNUcdwvWGUwjHTRc5GpPuiCRKuHVVL6jcqIW7ONyyxU=; b=iweyEfqw8Y/04GZjMZHThgKf6A
	qJwuHnk8gqZUgxBhrwrn3hqeWhUe7RK8hYk0XM8EBurULxY7fKw5mvpg6T3aGs9VEVIWktG8arZ8L
	QzREIWKAVE14IV3JtRyOtMDiznB64YL0amIt+mz6xkNm6Pzt8eO9phc/1nJx80Qim0eS6hruEeSky
	FSftyYBczFscFPh44ELOdlog/KVsDyrwoses8OTjf2Ud/pLPo6fp+K7jn9p5ktnkAT8bVxA00b6c8
	mmuqjzlR9aJty3De8TJ3d9ocoeCB9lr0dwmUuBO0o5qW6E+u3J+/I/nmY/gcANwmVppt81HrRgWKI
	ZbqEWhHw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60846)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKbl2-0006NJ-1F;
	Tue, 02 Jan 2024 10:12:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKbl4-0005Ar-Oy; Tue, 02 Jan 2024 10:12:26 +0000
Date: Tue, 2 Jan 2024 10:12:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, davem@davemloft.net,
	kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
Message-ID: <ZZPhiuyvEepIcbKm@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
 <20231219102200.2d07ff2f@dellmb>
 <87sf3y7b1u.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf3y7b1u.fsf@waldekranz.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 19, 2023 at 11:15:41AM +0100, Tobias Waldekranz wrote:
> On tis, dec 19, 2023 at 10:22, Marek Behún <kabel@kernel.org> wrote:
> > On Thu, 14 Dec 2023 21:14:39 +0100
> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
> >
> >> +MODULE_FIRMWARE("mrvl/x3310fw.hdr");
> >
> > And do you have permission to publish this firmware into linux-firmware?
> 
> No, I do not.
> 
> > Because when we tried this with Marvell, their lawyer guy said we can't
> > do that...
> 
> I don't even have good enough access to ask the question, much less get
> rejected by Marvell :) I just used that path so that it would line up
> with linux-firmware if Marvell was to publish it in the future.
> 
> Should MODULE_FIRMWARE be avoided for things that are not in
> linux-firmware?

Without the firmware being published, what use is having this code in
mainline kernels?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

