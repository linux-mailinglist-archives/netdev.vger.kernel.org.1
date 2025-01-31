Return-Path: <netdev+bounces-161778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E5A23F0A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970413A7710
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A21C7B62;
	Fri, 31 Jan 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="556/dFeN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3F1C54A6;
	Fri, 31 Jan 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333208; cv=none; b=GFmCjTFwVvz45AuWsVLa5aAiNob0tmNEkfh/GtW8fjNf7m5Ee3GvuwrKC3LDhQCw5F/TRQIc7upf+8JG+U6sGp0xuqI5rlT3u4mrUModXkR9CnviOL4oYarsL3UXoTAteafF3UatubbETfvbVQHa+gF+z3NLjBMvgX0wenKD8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333208; c=relaxed/simple;
	bh=FZhwMfs9fD5RA+73mQJnoO+Nm1Cc7xy26j1wGSrMuwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDmeIU37K6uH32KjXZbvYQLV5NQB/7VyzS3/xBLgbUeGh3jXIwNmWl9WWIkKsLikugpX4WDcTkUGDd7iwXC6fAnwCDpc5KxHaAldBvRuOk86MBTmXlic9QdvBbthSfl/VZdWg0h/TKZKtzgQriLDeIaErEh2zZ/1Ovd8MCRGaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=556/dFeN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5cyljd9OIda9+79SRYr/QtAErJYk/aKrcLSUZ+ZZE2U=; b=556/dFeNsCV0rY2ToK3iDTqQkT
	3iRhlODgOJylJLHCCMR+58HmQzGZBmwXK6fppeNlB4BAQRiV/d9oNtgLOqszV8aE8xViAVvLpsIo7
	FvQMg5SlglEoIx+540S5En4a5Ti3p+vqf3ueAnUTVAKVxaPS4MCR9NBW3+w7RZLugEPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdrsI-009iHd-3k; Fri, 31 Jan 2025 15:20:02 +0100
Date: Fri, 31 Jan 2025 15:20:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Netdev <netdev@vger.kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Yanteng Si <si.yanteng@linux.dev>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Theodore Grey <theodore.grey@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Steven Price <steven.price@arm.com>
Subject: Re: next-20250129: rk3399-rock-pi-4b NFS mount and boot failed
Message-ID: <8548ba31-762a-4ccb-b832-3365c9d5caf4@lunn.ch>
References: <CA+G9fYtqv_S+nK2cZB623yUuQS7HL18ELARpq_6W3_5m9ci7zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtqv_S+nK2cZB623yUuQS7HL18ELARpq_6W3_5m9ci7zA@mail.gmail.com>

On Fri, Jan 31, 2025 at 04:07:24PM +0530, Naresh Kamboju wrote:
> The arm64 rk3399-rock-pi-4b boot failed on Linux next-20250129
> while mounting rootfs via NFS. Whereas other arm64 devices boot fine.
> 
> rk3399-rock-pi-4b:
>   boot:
>     * gcc-13-lkftconfig
> 
> First seen on the the Linux next-20250129..next-20250130
> Good: next-20250128
> Bad: next-20250129
> 
> Theodore Grey bisected this to,
> first bad commit:
>   [8865d22656b442b8d0fb019e6acb2292b99a9c3c]
>   net: stmmac: Specify hardware capability value when FIFO size isn't specified
> 
> Anyone have noticed this boot problem on rk3399-rock-pi-4b running the
> Linux next-20250129 and next-20250130 kernel.

Thanks for the report. Steven Price <steven.price@arm.com> also
noticed it, and there is a thread started about this issue.

	Andrew

