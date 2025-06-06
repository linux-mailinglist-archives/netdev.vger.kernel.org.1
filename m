Return-Path: <netdev+bounces-195436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 839EBAD02AF
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071821891CB3
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E57288C03;
	Fri,  6 Jun 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2dB0woI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301D2882C3
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214797; cv=none; b=c+cvRs8kZG9HLJEMYLBgBiV6CD39u5+vXO+IyICpxkFSGYpM6T6jXq+I+56DOMwJx8SEz9lj9Mj6l9tEEe1vgvqVupukv9BZr8OOlGChYue4ZVZfgpya91OUf6JDJrIMWlRQ/sKsyr2DpevIgiYXi9n/okEsDYRl3UvBtQQ+DAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214797; c=relaxed/simple;
	bh=rbkt1vFbEpEG67TORa7aQaKQzX8SCwJt+mP3srP3T/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt8yUMz/kKngf5NmkzNDSXdBPiQgNqNXyKpufO3jbh8hljcw1aSmA3vcRoctJFjSL21nN29uwGFXZS69umZ77LQqUFuMbXzjJq93sXlHvFDofaIp+tZuPyCVfhMi1rnVF03sIQGlPAY7ErB1h7KBbUMl0xw1UtsHPXsLSVgwZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2dB0woI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2409C4CEEB;
	Fri,  6 Jun 2025 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749214795;
	bh=rbkt1vFbEpEG67TORa7aQaKQzX8SCwJt+mP3srP3T/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2dB0woIpQuM3ePNFs7Yxctnn+7vHMhKQRzTSbCqFJIseU8FTxBwcGUgOnYJ1CsCI
	 TGFkZOgGZ8QBzJSlGZHGpcgMudnYK4vjcDKwT1nGQY8wRSQlVLVHHvMeVAWobI5oMG
	 ZmwXa3kzwJUBjlNqSdRbDiL5bwSbeCXIUjOHgyN9Im0YoTlGH4lj5f5YHmFDCEm8Yc
	 gqFxf3RcGE74E63O/EzTJAVJArvH5+DZ23H6UeSs8vKxPLBDEXELRCO5sgv4ejEowl
	 9BoUhWBP+6mcMiMpMh7/Xw7lcvwTwaNdOo4GD7Kxaxryip2GF3m5noLuu07z3/mN0N
	 oUt9VUuWeE/GA==
Date: Fri, 6 Jun 2025 13:59:49 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org,
	leon@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Message-ID: <20250606125949.GE120308@horms.kernel.org>
References: <20250423103923.2513425-1-tianx@yunsilicon.com>
 <20250423104000.2513425-15-tianx@yunsilicon.com>
 <20250424184840.064657da@kernel.org>
 <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
 <20250605062855.019d4d2d@kernel.org>
 <CAMuHMdVMrFzeFUu+H0MvMmf82TDc=4qfM2kjcoUCXiOFLmutDA@mail.gmail.com>
 <20250605065615.46e015eb@kernel.org>
 <96f53bdd-13e4-4e4b-ab8e-3470782df3b2@lunn.ch>
 <CAMuHMdUk8G0MdoCA9ZyKDJNRC0pbcR0CpfLzpe347OBALADt0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUk8G0MdoCA9ZyKDJNRC0pbcR0CpfLzpe347OBALADt0g@mail.gmail.com>

On Thu, Jun 05, 2025 at 08:49:30PM +0200, Geert Uytterhoeven wrote:
> On Thu, 5 Jun 2025 at 16:05, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Thu, Jun 05, 2025 at 06:56:15AM -0700, Jakub Kicinski wrote:
> > > On Thu, 5 Jun 2025 15:39:54 +0200 Geert Uytterhoeven wrote:
> > > > On Thu, 5 Jun 2025 at 15:29, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > > On Thu, 5 Jun 2025 15:25:21 +0800 Xin Tian wrote:
> > > > > > Regarding u64_stats_sync.h helpers:
> > > > > > Since our driver exclusively runs on 64-bit platforms (ARM64 or x86_64)
> > > > > > where u64 accesses are atomic, is it still necessary to use these helpers?
> > > > >
> > > > > alright.
> > > >
> > > > [PATCH 1/14] indeed has:
> > > >
> > > >     depends on PCI
> > > >     depends on ARM64 || X86_64 || COMPILE_TEST
> > > >
> > > > However, if this device is available on a PCIe expansion card, it
> > > > could be plugged into any system with a PCIe expansion slot?
> > >
> > > I've been trying to fight this fight but people keep pushing back :(
> > > Barely any new PCIe driver comes up without depending on X86_64 and/or
> > > ARM64. Maybe we should write down in the docs that it's okay to depend
> > > on 64b but not okay to depend on specific arches?
> >
> > I agree. I expect in a few years time we will start seeing patches to
> > drivers like this adding RISCV, because RISCV has made it into data
> > center CPUs, where this sort of card makes sense. Its the fact it is
> > 64bit which counts here, not ARM or X86_64.
> 
> And perhaps little-endian? ;-)

Yes. My experience is that looking at Sparse warnings can yield many
delights that are lurking. Many well aged by now.

...

