Return-Path: <netdev+bounces-213926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09BB27574
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481DE5C02AE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1631E1C8611;
	Fri, 15 Aug 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y2CkbbVI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87475A935;
	Fri, 15 Aug 2025 02:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223680; cv=none; b=CPTdzFOYmVCEA5fMx0Ee1/Wfx5nWsj+pCgCyX5kcXB6RyZJK/ao7MNdcdQKqGrbS9WemtmjgaLatcNYZ5/H9504S/rEh+zzVo9PF6oScDm6mRJC4ofdyBaslyZ0G7ojthwGSm+78vp88dilTNoHq34FZVUvJvTotwvbCL8YUci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223680; c=relaxed/simple;
	bh=Fc785w/brSzyjcHZ+qojgkoETwGA86Fn7sAVRfGihy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s46CR7LGUkTErCh5VPN3sAfZUKTnJsy3JMJH9pnupaAGyLtbbbGCV5SkCCngaZLdBu2jkhi8tHcqvAY9QGclJ4sCXDkc3jUtFEE22Lhp8nnpaS+tJycX6gSNlwvmSnkD9duDI4H8pwRICihCvcpPKkSdLE+IJYbHSKrkfzf85T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y2CkbbVI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=04geab6hIKK7Pet5B3twJkaGfcl9pFeDEcksJ9hmti4=; b=Y2CkbbVIKFw/OW3Mltq+2bwRUD
	ZLSwlVgiRMJ1M+w79m+pfpGJ2JM3aLcU337PC+Og9ZMIOx07ymXUoiVkyFOI4P/MA7LSRGPs2V051
	zstD9HddTcsX4LHXAOFUh7VHWsoSu3sf2j7rgGzNP5OMGJKKbFTxdfdf2+OyBP/A+AFw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umjqn-004m9g-5k; Fri, 15 Aug 2025 04:07:25 +0200
Date: Fri, 15 Aug 2025 04:07:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <f91565ea-e648-4b7d-9920-0d3d792020e6@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <8a041e8e-b9a8-4bd9-ab1a-de66f943dea6@ti.com>
 <172956B3368FC20D+20250814135203.GA1094497@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172956B3368FC20D+20250814135203.GA1094497@nic-Precision-5820-Tower>

> > > +static void rnpgbe_init_n500(struct mucse_hw *hw)
> > > +{
> > > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > > +
> > > +	rnpgbe_init_common(hw);
> > > +
> > > +	mbx->fw2pf_mbox_vec = 0x28b00;
> > > +	mbx->fw_pf_shm_base = 0x2d000;
> > > +	mbx->pf2fw_mbox_ctrl = 0x2e000;
> > > +	mbx->fw_pf_mbox_mask = 0x2e200;
> > > +	hw->ring_msix_base = hw->hw_addr + 0x28700;
> > > +	hw->usecstocount = 125;
> > > +}
> > 
> > These hardcoded values should be defined in rnpgbe_hw.h as macros rather
> > than using magic numbers.
> > 
> 
> Got it, I will update this.

You might also want to talk to your hardware engineers and tell them
not to make silly changes like this between hardware versions. It just
makes the software harder for no reason.

      Andrew

