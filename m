Return-Path: <netdev+bounces-228889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1048BD5996
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96C004E8778
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA8928E5F3;
	Mon, 13 Oct 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vNub39Rk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FC2C17A0;
	Mon, 13 Oct 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377736; cv=none; b=OeUz/lGzz28FHlQE//SHyn63+IjB7U2RaCFoJ8PIE+3ChBYQT3xkn1hbx8XtbQsoUWb2hUxYeKHpAHeIvXSXmE73amdOo7NNrCANtf7LE0M+9MZW0Y1Nyo3HwjLa//LTNtDNw3mZfXh72K+Ga8JZh/L+sJiIw9//oDUEH36p2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377736; c=relaxed/simple;
	bh=JtFCyElHrPbVi6NyIHhf0BhdPHbVecZAR7ohlUh/1mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/XByALXqlUCd5DAs4OAOfRP+chIcHUcsCqX9QzTIWWB7WNux9pV2S3CAX7H/lXmcWpLJyzFzPYS2bimbyyyg0+whyf/0cYvTNQw0fMoHuoyChPNL0kJ5qcDkfsQuq1+C2n9KnkojuKusg//H14pPH5sJYERnx5BZ9uHSwQ3OJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vNub39Rk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/5x8dL0xsIo7cj6ap3szP9/ntLRtTJN8gwrwEdFC8g4=; b=vNub39RkJxbvP5HhMHbHcpVa7/
	48s+qhW9+bJg34PX/vXoRxSW+/sN3buu0xl8qFsRDigj62aQHBf6PLe8/E27eRpdYGwP5ju6uXb/z
	V4V9Vg4KHbPCh9zZeJQITKtz4AXCxLRWJFpDOZH+zHlw3y2iFgW0u6Z+2B+4MwfMdXao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8Mf2-00Ap28-PU; Mon, 13 Oct 2025 19:48:40 +0200
Date: Mon, 13 Oct 2025 19:48:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbe: Add 10G-BX support
Message-ID: <3a936cc6-14e7-49f8-b312-d66330f955d7@lunn.ch>
References: <20251013-10gbx-v1-1-ab9896af3d58@birger-koblitz.de>
 <b5dd3a3e-2420-4c7c-b690-3799fac14623@lunn.ch>
 <70d926a1-e118-43d9-8715-70feebc214a5@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d926a1-e118-43d9-8715-70feebc214a5@birger-koblitz.de>

On Mon, Oct 13, 2025 at 07:17:18PM +0200, Birger Koblitz wrote:
> On 13/10/2025 6:31 pm, Andrew Lunn wrote:
> > > @@ -1678,6 +1679,26 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
> > >   			else
> > >   				hw->phy.sfp_type =
> > >   					ixgbe_sfp_type_1g_bx_core1;
> > > +		/* Support Ethernet 10G-BX, checking the Bit Rate
> > > +		 * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
> > > +		 * Single Mode fibre with at least 1km link length
> > > +		 */
> > > +		} else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
> > > +			   (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
> > > +			   (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
> > > +			status = hw->phy.ops.read_i2c_eeprom(hw,
> > > +					    IXGBE_SFF_SM_LENGTH,
> > > +					    &sm_length);
> > 
> > It seems like byte 15, Length (SMF), "Link length supported for single
> > mode fiber, units of 100 m" should be checked here. A 255 * 100m would
> > be more than 1Km, the condition you say in the comment.
> > 
> > 	Andrew
> 
> Bytes 14 and 15 refer to the same information, just in different units. Byte
> 14 is the SM link length in km, byte 15 the same in 100m units. BX offers a
> link length of at least 1km, up to at least 40km, which would overflow to
> 255 in byte 15. In theory one could make a consistency check between bytes
> 14 and 15 by dividing byte 15 by 10 and comparing the result with byte 14,
> but in terms of identifying link lengths of >=1km, checking byte 14 is
> probably enough, in particular as rounding of byte 14 could be
> inconsistently done, making the consistency check difficult. One could also
> check for byte 14 to be 0 and byte 15 to be < 10 to identify SM links <1km,
> but I do not believe such BX modules exist and again, there would be the
> issue of rounding for link lengths >=500m.

Hi Birger

Byte 15 containing 10 would be a Single Mode Fibre which is 1Km long.

You also say:

> BX offers a
> link length of at least 1km, up to at least 40km

which is ambiguous, you use at least twice. Should it actually be:

BX offers a link length of at least 1km, up to at a maximum of 40km.

So a 10GBase-BX module with 1Km would be allowed by the standard? A
10km 10GBase-BX using 100 in byte 15 would also be valid? A 20KM by
using 200?

Is there anything in the standard which says you must use byte 14 for 
10GBase-BX?

I think to fully comply with the standard, you probably want to look
at both bytes, and if either indicate > 1Km, enable the feature. And
if the two contradict each other, whats just OEMs making the usual
mess of SFP EEPROM contents.

	Andrew

