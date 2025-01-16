Return-Path: <netdev+bounces-159038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E90A14342
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BA163EA4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF0E2309B8;
	Thu, 16 Jan 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xv3dhr/u"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4424A7EE
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059370; cv=none; b=mzXdQrHDgC2Vjg0drfFAUJENfgKDYS/nk8MQP0pvSAdd52svCYpP56l8ZM4dSfr63wsXMeF8rFfGiqmG96CaSOAQPsdAYnjGAzalMIih+b7GGQgJR7i0Far3pobmKBV/hOhZDUdpcJvJ0qwB+3q/ishvdQ3oZT+quAlUdbgGx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059370; c=relaxed/simple;
	bh=gmW7mnZEWm3GiEUSfBvY0bTteiclHvivM+E7Zsn7w8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUNiw1UaE53OZjT4OSGu2+gwECwpBb6CXofp1d2+O5IMoQU5FqV6FWMdfkFBHLvslKWCJ7tCEuEihh9FTIs/Gr1vcd3fi3uK33W1ECjSrQWFN5GK1LawaV3tlo4Cblg5ax4E0sZiKmG0gn2SuCXAy2JKJj4JAf3ovNv/Z4oqZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xv3dhr/u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RPaqiSiJvZL+VT0MFmJkziq8qXx7oEBBscaf9+lsCto=; b=xv3dhr/uXQdwaYB3bPyem54sOM
	P7ISK8C9sQ+jJl4+DlnQjez+/7swrvTGDRjKjuGRN8mCQVBTxvf3Pm1j4Xico+jZSA61enJZ/BQzf
	TzNcwkEwOrDoWkeuk7Ecz7sdlSEMn8SA0R1/RDOxfa3/TeS7pPzTAjhgit0gzu9gstDU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYWUX-005EEt-2q; Thu, 16 Jan 2025 21:29:25 +0100
Date: Thu, 16 Jan 2025 21:29:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Generic sk_buff contract documentation ?
Message-ID: <cfdd904f-f9cb-4a6f-81c8-53b378626daf@lunn.ch>
References: <1f09214d-0a30-4537-82ca-ebecc0c2f2bb@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f09214d-0a30-4537-82ca-ebecc0c2f2bb@orange.com>

On Thu, Jan 16, 2025 at 08:51:26AM +0100, Alexandre Ferrieux wrote:
> Hi,
> 
> Recently digging into a driver-specific issue with sk_buff->protocol, I
> discovered (with surprise) that the computation of this field (which is *always*
> necessary for protocol handlers to kick in) was somehow "delegated" to
> individual network interface drivers. This can be seen by looking for callers of
> eth_type_trans(), e.g:
> 
> - tg3: called from tg3_poll_work
> - ixgbe: called from ixgbe_clean_rx_irq
> - veth: called from veth_xmit (though indirectly via __dev_forward_skb)
> 
> This is a surprise as one would naively expect this ubiquitous behavior to be
> triggered from generic code, depending only on the L2 header structure (but not
> on the specific NIC hardware at hand). Another surprise was *not* to find any
> mention of this "contract" in Documentation/*.
> 
> So, is it an unspoken tradition for NIC driver developers, to
> "just know" that prior to emitting an skb from the rx path, they must fill
> skb->protocol (along with who knows how many other metadata items) ?

Ideally, a new driver is simply a copy/paste of some existing driver,
which already has all this code. Trying to write a driver from scratch
without copying code is likely to run into a number of issues like
this, and why would you pass up so much usable code which has passed
review and has been heavily tested and debugged.

Could this be moved into the bottom of the stack? Maybe. But do you
want to modify 327 files?

	Andrew

