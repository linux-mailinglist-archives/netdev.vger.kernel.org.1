Return-Path: <netdev+bounces-226903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A94BA609A
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FE17D1A7
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F12DF15D;
	Sat, 27 Sep 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hDINF7oU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39E288C27
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983363; cv=none; b=Vo0Dy+aT1In+EIuhFHEJ1lBPdpb/g21w/4VOOLmxnK1JDPr4sGv1N0LLwg0MRSFb/jvMXZSrcJjJRDAb+pDvQaK3kAq72GenApqlg2cgpoRG6cVsj19pVf5vpY4dMJyLd4UK/tebVsj+puE8xsK2aQ3Ch2ToDr+CldmhSMEk0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983363; c=relaxed/simple;
	bh=NzSPLJfOtDzJYHcO4YuDFLcYnFyYcvWzyWXyplW5yQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghFdiZsbzFWlpBp4/tdqytUH8WE7aV+PmhT4fs8Bw63zOT8yfIBg850hQYN0sE5bWIPJXbPUnJqflzMOs0MzTBT9O7teBxk4sNT9ADphjop8TbdtYpI2/MUUETstplnhTbWn3HsNAeGPeEBw9442pilTAksmc3OgkF8279RgNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hDINF7oU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8B+JXfHJVtb+Ab1wHa0uuSShQ5lAvDzsXh/tt0MffY4=; b=hDINF7oUnEZhzoFVytLqKemS1S
	BngU4E5TdKVg0yEFRkfWueE4XlZFFHMUABZorOVUyHWs12kpq7o+WY9uyzRO+1/jes+B8xF+nznOe
	fNWeZbeoweOSlGqwzy1vXgOMeEz3A8zV3aIStpfbqd5pOOfSVzo7U3SIOk8rhj1N/MwM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v2VvD-009dsr-A5; Sat, 27 Sep 2025 16:29:11 +0200
Date: Sat, 27 Sep 2025 16:29:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luke Howard <lukeh@padl.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com, kieran@sienda.com,
	jcschroeder@gmail.com, max@huntershome.org
Subject: Re: [RFC net-next 2/5] net: dsa: mv88e6xxx: add
 MV88E6XXX_G1_ATU_CTL_MAC_AVB setter
Message-ID: <48a760f2-323f-4448-9d18-9fe651471cdb@lunn.ch>
References: <20250927070724.734933-1-lukeh@padl.com>
 <20250927070724.734933-3-lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927070724.734933-3-lukeh@padl.com>

On Sat, Sep 27, 2025 at 05:07:05PM +1000, Luke Howard wrote:
> Add accessors for the MACAVB bit, which controls whether certain ATU bits cause
> the entry to be interpreted as AVB or NRL (non-rate-limiting) entries. This is
> necessary on switches such as the 88E6352 and 88E6240 that support both AVB and
> NRL ATU entries.
> 
> Signed-off-by: Luke Howard <lukeh@padl.com>
> ---
>  drivers/net/dsa/mv88e6xxx/global1.h     |  2 ++
>  drivers/net/dsa/mv88e6xxx/global1_atu.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
> index 3dbb7a1b8fe11..74be4c485ab10 100644
> --- a/drivers/net/dsa/mv88e6xxx/global1.h
> +++ b/drivers/net/dsa/mv88e6xxx/global1.h
> @@ -112,6 +112,7 @@
>  /* Offset 0x0A: ATU Control Register */
>  #define MV88E6XXX_G1_ATU_CTL		0x0a
>  #define MV88E6XXX_G1_ATU_CTL_LEARN2ALL	0x0008
> +#define MV88E6XXX_G1_ATU_CTL_MAC_AVB	0x8000
>  #define MV88E6161_G1_ATU_CTL_HASH_MASK	0x0003

nitpick: The sorting in this file suggests that they are sorted
highest bits to lowest bits. So MAC_AVB should be before LEARN2ALL.


    Andrew

---
pw-bot: cr

