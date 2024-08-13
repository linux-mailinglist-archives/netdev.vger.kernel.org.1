Return-Path: <netdev+bounces-117997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0B95036F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D15B23132
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83F16E89B;
	Tue, 13 Aug 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO2AHxMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9402233A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547765; cv=none; b=C83hCIBIrXc8unIYAFmvA8+1kzloefe6rtHIe+R7AtXhfaBcMg/DF23ZaV1b9SHLU7uiL++ocChF2rRCkZD3P1cYva/zy95xmEhyepoo1ZqpCVUJKI6eiGdHKPUxWSbxqpiUUU1CCs6t9eKghA1EdtETLfMyYPEn0L7Cgx4/VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547765; c=relaxed/simple;
	bh=vNjy5GQmH7yNpSwDex0PylkIdnKV/B8d3Ihgv7G6zbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEyOcSQdGXG1f5OOK/cIOwP/f3R6Wx4lGXuSWUQsETgwZ1Hrq1aSHK6iiqsTvokBzGQ2L/69LwkrzKXR3m3goEsokLV9WCk7AmS5jt/eVHsRo+2Cj8mRdCFk9cxQLX/IQt/W9wmxLIcVMr04kxI8jXwA2rc5JmZUtJlPzrSMPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO2AHxMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E66C4AF09;
	Tue, 13 Aug 2024 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547764;
	bh=vNjy5GQmH7yNpSwDex0PylkIdnKV/B8d3Ihgv7G6zbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fO2AHxMHoozxkIOjvPGJsqTNgqVF8YowML3OVY/bO345IVaG/Wh9wgMT8to9//A54
	 SVoZ+pI2Vhi+e+m+dHSZfgE+PGYlj9FxYVuiaKhBGskzeneKJn2TKFGUfrB/AnzBG8
	 zpHPvO/G+hhVfXTX4f8a/Pz9sJje+IVyzou66HP32JBIdmdszElPnRx/e+6ERUUX2Z
	 fHwa/N27iG1fJZXJDxp6wiX1T3on+T8htmk2mccDbtg+OORpBxMOcCR1KtPoDW/k2d
	 oU/su3FHSDBuTBLANHYND2buTzwxkg/uakI2GV+5klWwS68LkloqXqfiatQb7drPK6
	 Om4lArqHVZkpg==
Date: Tue, 13 Aug 2024 13:16:00 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Drop serdes methods for 88E6172
Message-ID: <2m2phdcy4pdij7vbi4kknu42knjwq24cgjwc7iogfeyqgqkjk7@elwngvs6bsni>
References: <20240811162329.15171-1-kabel@kernel.org>
 <Zrogu1jaD3hp0yHL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zrogu1jaD3hp0yHL@shell.armlinux.org.uk>

On Mon, Aug 12, 2024 at 03:48:27PM +0100, Russell King (Oracle) wrote:
> On Sun, Aug 11, 2024 at 06:23:29PM +0200, Marek Behún wrote:
> > Drop serdes methods for 88E6172. This switch from the 6352 family does
> > not have serdes. Until commit 85764555442f ("net: dsa: mv88e6xxx:
> > convert 88e6352 to phylink_pcs") these methods were checking for serdes
> > presence by looking at port's cmode, but in that commit the check was
> > dropped, so now the nonexistent serdes registers are being accessed.
> 
> This attributes blame incorrectly, and shows a lack of understanding.
> No, one can *not* discover presence of the serdes "by looking at the
> port's cmode" - that is total rubbish.
> 
> The MV88E6352 family supports ports that can auto-select between the
> integrated baseT PHY and the serdes depending on which has link. The
> port CMODE tells us *nothing* about whether the port supports serdes
> or not.
> 
> Please fix your description not to spread misinformation, and
> incorrectly indirectly blame others for stuff that is not appropriate.
> 
> Thanks.

Hi,

sorry about this.

It seems that the 6352 family was always written with serdes
support for the whole family, 6172 included, even before the switch
operations structure was introduced.

But it really did check whether it should touch serdes registers by
checking cmode:
  in commit 85764555442f~1 the function mv88e6352_serdes_get_lane()
  checks the port's cmode:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/dsa/mv88e6xxx/serdes.c?id=4aabe35c385ce6c28613ab56b334b4a9521d62b7#n260

  then in chip.c this is used in
    mv88e6xxx_serdes_pcs_get_state
    mv88e6xxx_serdes_pcs_config
    mv88e6xxx_serdes_pcs_an_restart
    mv88e6xxx_serdes_pcs_link_up
    mv88e6xxx_serdes_irq_thread_fn
    mv88e6xxx_serdes_power

  and even before, in commit 10fa5bfcd697, it was decided by looking
  at cmode whether serdes should be powered on
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/dsa/mv88e6xxx/chip.c?id=10fa5bfcd697#n1885

I propose dropping the Fixes tag and having just this in the commit
message:
  Drop serdes methods for 88E6172. This switch from the 6352 family does
  not have serdes.

What do you think?

Marek

