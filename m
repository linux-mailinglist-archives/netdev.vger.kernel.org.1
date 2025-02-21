Return-Path: <netdev+bounces-168663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226CFA40121
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42507189F379
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90321B9DB;
	Fri, 21 Feb 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBCblYak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0C1D8A14;
	Fri, 21 Feb 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170113; cv=none; b=MmxLc8Yh6jcqxWFyLdJ6db5eKRg8lbdOlUNTvo9xCq7txhiRvizc3BYKIJuciDB65ofMGcl4m2HNgzhoRSPo8YizHD91eZMvNYT+Nopc6ZWA8/9JQNG4JONNxH9r3v1HYa+1EhPzAg8APIGZi8loBxwbqsbYxl5AbStVL+Qzmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170113; c=relaxed/simple;
	bh=tah1Gs/B++YekM1GkZ6AN9/xlO/76z4hZGv/TUt22z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HesaegFTsfQGrL8XK10oiHdtdbitMWDo4igCN1BzPwC0SzC439ye54Wip22PLZ4XZvROhZjnlu8rhd2XNAO17L3izFw4G7Vf5RVcdcQeNhfB1yrXplUeJcK/1r+SwFlilMmEu5Jt/x/rFIeYbI/nu7OcC6wohgrnD+YhDfY9iGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBCblYak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AE1C4CED6;
	Fri, 21 Feb 2025 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740170113;
	bh=tah1Gs/B++YekM1GkZ6AN9/xlO/76z4hZGv/TUt22z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YBCblYaks7r2MZKt9bUPG14CMJBoQ3BMZZJhO4v4b1PDcCxXtTztZkvRL9/CxDk83
	 C9hrgaWxVwrCeR5p449MGQmwB3gHBVl0HaXttMn8bF+vYEkqWSINVWgAyX9TeJUXN6
	 k1pZDbeSNapOCbHC28zwgZi5kuUQ7mfoCPoSR3dDS35nwwGVIR0SO3YxepOcIq8JKV
	 /VWIG24+sikdsJDndmkMngLysqF2EBlXfcbcwniW1ZTy4+5wPabJBJ/lqevAskR2v2
	 RndxTzhBmGwAfb3Rkd2ackZa+Py0eHZKpMWtLyRu+TmpKZmvhstwFlVHg9MJMh55UT
	 REDwJi1edcOJg==
Date: Fri, 21 Feb 2025 14:35:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: disable RTL8126 ZRX-DC timeout
Message-ID: <20250221203511.GA359929@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeba10a2-809a-4583-bd35-1f363c824e14@gmail.com>

On Fri, Feb 21, 2025 at 09:12:09PM +0100, Heiner Kallweit wrote:
> On 21.02.2025 21:01, Bjorn Helgaas wrote:
> > On Fri, Feb 21, 2025 at 03:18:28PM +0800, ChunHao Lin wrote:
> >> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
> >> device will exit L1 substate every 100ms. Disable it for saving more power
> >> in L1 substate.
> > 
> > s/dose/does/
> > 
> > Is ZRX-DC a PCIe spec?  A Google search suggests that it might not be
> > completely Realtek-specific?
> > 
> ZRX-DC is the receiver DC impedance as specified in the PCIe Base
> Specification.  From what I've found after a quick search ASPM
> restrictions apply if this impedance isn't in the range 40-60 ohm.

Ah, so it looks like PCIe r6.0, sec 4.2.7.6.1.2, is the sort of thing
this refers to:

  4.2.7.6.1.2 Rx_L0s.Idle §

    - Next state is Rx_L0s.FTS if the Receiver detects an exit from
      Electrical Idle on any Lane of the configured Link.

    - Next state is Rx_L0s.FTS after a 100 ms timeout if the current
      data rate is 8.0 GT/s or higher and the Port’s Receivers do not
      meet the ZRX-DC specification for 2.5 GT/s (see § Table 8-11).
      All Ports are permitted to implement the timeout and transition
      to Rx_L0s.FTS when the data rate is 8.0 GT/s or higher.

> >> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
> >> +{
> >> +	struct pci_dev *pdev = tp->pci_dev;
> >> +	u8 val;
> >> +
> >> +	if (pdev->cfg_size > 0x0890 &&
> >> +	    pci_read_config_byte(pdev, 0x0890, &val) == PCIBIOS_SUCCESSFUL &&
> >> +	    pci_write_config_byte(pdev, 0x0890, val & ~BIT(0)) == PCIBIOS_SUCCESSFUL)
> > 
> > Is this a standard PCIe extended capability?  If so, it would be nice
> > to search for it with pci_find_ext_capability() and use standard
> > #defines.

I guess we could tell from "sudo lspci -vv" output whether this is a
standard capability.

Bjorn

