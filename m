Return-Path: <netdev+bounces-214063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19CB280B2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF01A18937FD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FFE2FE565;
	Fri, 15 Aug 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qEAk/YCs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07131433AD;
	Fri, 15 Aug 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755265008; cv=none; b=mIKAQLNgOHiosnqhWPV2wezS3CHGB9hZw+uN/GiirQQgkkktr77ED7XSHUlQXdcachivlLRflJZjghqdeplZhJA+J4LvM6lhuNUlSiekdnpJhb/32GkbX2P+nYptEb+OUvPI/n8vBaV2rp9q4X/9I+jNATscic6g0L8OOl3e7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755265008; c=relaxed/simple;
	bh=llf4Gk1GMJOszwZxUVURpbUjzrU7HSh8RqPWrvVaAJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcq/qf0KpICCugXYF2WcYSokf9jAMOmPea7BdjzbPHKyJIp6igj0k7RIWsqrkvGlxhwBqntSwytzpsS1Ffaoh1lUEOT14FzcTUtKp3miIgO0qCeXzPAtcovdAirUotcy3R87ztQwQD+jmtv+zRi46sPh8bneC41LTG0jkRZYln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qEAk/YCs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fgBUSd93DiB/KPQmJocSjeSjdPHCjX6Q9MKbqgt4GA8=; b=qEAk/YCsY9Y/IL03gT3w3iKxkY
	FaB264x63FEzCPeLJjOegxRqLX3G2EHvUO+GArjcdVkaG5tqET0AJdz+5L4rjMsmbtPfPlo+03v/A
	EHjN8ZisaSJ+DEj/u2LwTPpxmtEQ4gKysON3tXpCAps7CrlWPzMyJrJknWRTJ/4mN5/g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umubK-004p7q-8G; Fri, 15 Aug 2025 15:36:10 +0200
Date: Fri, 15 Aug 2025 15:36:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <ade28286-33b9-421c-9f3f-da7963a69d4e@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
 <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
 <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67844B7C9238FBFB+20250815072103.GC1148411@nic-Precision-5820-Tower>

On Fri, Aug 15, 2025 at 03:21:03PM +0800, Yibo Dong wrote:
> On Fri, Aug 15, 2025 at 05:56:30AM +0200, Andrew Lunn wrote:
> > > It means driver version 0.2.4.16.
> > 
> > And what does that mean?
> > 
> > > I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> > > to echo 'driver version' to FW. FW reply different command for different driver.
> > 
> > There only is one driver. This driver.
> > 
> > This all sounds backwards around. Normally the driver asks the
> > firmware what version it is. From that, it knows what operations the
> > firmware supports, and hence what it can offer to user space.
> > 
> > So what is your long terms plan? How do you keep backwards
> > compatibility between the driver and the firmware?
> > 
> > 	Andrew
> > 
> 
> To the driver, it is the only driver. It get the fw version and do
> interactive with fw, this is ok.
> But to the fw, I think it is not interactive with only 'this driver'?
> Chips has been provided to various customers with different driver
> version......

They theoretically exist, but mainline does not care about them. 

> More specific, our FW can report link state with 2 version:
> a: without pause status (to driver < 0.2.1.0)
> b: with pause status (driver >= 0.2.1.0)

But mainline does not care about this. It should ask the firmware, do
you support pause? If yes, report it, if not EOPNOTSUP. You want to be
able to run any version of mainline on any version of the
firmware. This means the ABI between the driver and the firmware is
fixed. You can extend the ABI, but you cannot make fundamental
changes, like adding new fields in the middle of messages. With care,
you can add new fields to the end of an existing messages, but you
need to do it such that you don't break older versions of the driver
which don't expect it.

Please look at other drivers. This is how they all do this. I don't
know of any driver which reports its version to the firmware and
expects the firmware to change its ABI.

So maybe you should just fill this version with 0xffffffff so the
firmware enables everything, and that is the ABI you use. Does the
firmware have an RPC to get its version? You can then use that for
future extensions to the ABI. Same as all other drivers.

	Andrew

