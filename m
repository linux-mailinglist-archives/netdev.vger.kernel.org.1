Return-Path: <netdev+bounces-153838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFAF9F9CC0
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E482016C1B7
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B61BC085;
	Fri, 20 Dec 2024 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ua5IMR4O"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D11A2C11
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734733991; cv=none; b=PNIA2pEda65qzXvIb5OWpRUhBj19uL1j7FLmcpXTAbseKx4SGSi9MGC0IHurZpD+5Y19cdZvrsYOhKlOa+98UKmyk0eW6Wwk0pa9To5CXlm5b5o8PgeDQ37kngGW8hoVRNsDnuOlTB6nro5d/HaYtCok7XoZ+/jzQf3B/wqkCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734733991; c=relaxed/simple;
	bh=/JOS0vLaxrWZ2zVkDTHyQuaLjEDnlJs7toD5ObliA9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPGCMmveeUaBEvQLdThiM3Zt/JTTQmIRsD82UJ3qkopfO+92JjC5X3+sK17cI/jpHmhN9/0BY7WlP+dfMtL6rIhHNOtswBrzv/QXpkeOrYM7MpN1sRgVXKZ8otfVGgE69saLtGWiYfxHu07RQZm85skDDeXMhWe1nBztVvdi9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ua5IMR4O; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KiRfxPJLHJzlgjJOsafIe1I/afuTd3XKOOQPboTEFqg=; b=ua
	5IMR4ObtI7KHn0M0IJj1wKvw620nVJeyNV4hI794IDheFzP040p7zORSEhgJNKsC+0VvEQ9j9+2Ju
	mJivYJzLpMQxs7IbRybAVa3jMjjPNMXE0zi7S3wTq/26jo0ulDKXIBP2ocoKNMX4nF2Q7A8XfRyol
	H9A/i8yI7NWwby0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOlYP-0028FL-Kz; Fri, 20 Dec 2024 23:33:05 +0100
Date: Fri, 20 Dec 2024 23:33:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard Bentata <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	Kieran Tyrrell <kieran@sienda.com>,
	Max Hunter <max@huntershome.org>
Subject: Re: net: dsa: mv88e6xxx architecture
Message-ID: <fbbd0f33-240f-41c7-bb5f-3cea822c4bf9@lunn.ch>
References: <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <B50BFF9A-DD1D-45AC-80BF-62325C939533@padl.com>
 <20241220121010.kkvmb2z2dooef5it@skbuf>
 <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E1DC313-33DE-4AA8-AD52-56316C07ABC4@padl.com>

On Sat, Dec 21, 2024 at 08:43:50AM +1100, Luke Howard Bentata wrote:
> Hi Vladimir,
> 
> 
>     I think we need an AVB primer. What identifies an AVB stream? Should the
>     kernel have a database of them? What actions need to be taken for AVB
>     streams different than for best effort traffic? Is it about scheduling
>     priority, or about resource reservations, or? Does the custom behavior
>     pertain only to AVB streams or is it a more widely useful mechanism?
> 
> 
> AVB is an umbrella term which encompasses 802.1AS (gPTP), 802.1Qav (CBS),
> 802.1Qat (SRP), and various application layer protocols. This patch series is
> concerned with CBS and, tangentially, SRP: the existing mv88e6xxx PTP support
> sufficies for 802.1AS, and the application layer protocols are of no concern to
> the kernel. Further, the existing TC abstractions for CBS also suffice, and the
> patch series simply implements those.
> 
> Your question: what is an AVB stream, and what (if any) state needs to be
> maintained in the kernel?
> 
> Stream reservations, between “talkers” (sources) and “listeners” (sinks) are
> coordinated by the Multiple Stream Reservation Protocol (MSRP). (Confusingly,
> _SRP_ itself is an umbrella term encompassing MVRP, MMRP and MSRP. The existing
> MVRP support in the kernel only implements part of the MRP state machine.)
> 
> MSRP coordinates talker advertisements (consisting of a 64-bit stream ID, a
> [typically multicast] DA, VID, bandwidth requirement, and PCP) with listener
> advertisements. It also coordinates “domain” advertisements which establish a
> mapping between AVB or SRP “classes”, and a (PCP, VID) tuple.
> 
> At a high level, the kernel does not need to know anything about SRP: it can,
> and IMO should (like the PTP state machine) be implemented completely in user
> space. Once SRP has established there is sufficient bandwidth and latency for a
> steam to flow, it adds the stream DA to the FDB or MDB, and configures the CBS
> policy appropriately on the egress port.
> 
> The catch is what to do with frames that share a priority with an AVB class but
> are not negotiated by SRP. These frames could crowd out frames from AVB
> streams. Marvell’s solution is a flag in the ATU which indicates that the DA
> was added by SRP. This is the one case where a new kernel interface
> (specifically, a flag passed down to {fdb,mdb}_add()), could be useful.

For a moment, forget about Marvell. Think about a purely software
solution, maybe using the Linux bridge, and a collection of e1000e
cards. Does the same problem exist? How would you solve it?

First solve the generic software case first, and then offload it to
the hardware.

	Andrew

