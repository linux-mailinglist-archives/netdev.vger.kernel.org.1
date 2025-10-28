Return-Path: <netdev+bounces-233529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A7C150BF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC996452F6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361A2376FD;
	Tue, 28 Oct 2025 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z64UND9x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAC1E1A33
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659944; cv=none; b=gHTlSrXjaoLlMIMIq8wHGioV1NsX+z/NTxU9OXbDyst1g7ZSOXUeRr/w6QpuEprUdDC0m3+jyDUd6e+8aQCm2YiEUb931u2cTHtvECDZHxHw/ep6v+hCDVRXKay3JJRQZt9W9jNY1u8ne0LRSYX5uBKLLBvmmd21AoTIiov2ibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659944; c=relaxed/simple;
	bh=nRLuX8pY3dyvzjD/sEPuxXQJlhqD7nqLDGP/lt9Zylw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjlazZ3nn+ajRbE8gMA6xG2b/TG3vCUQyfD9kxMJsGT/PXzmfGxA6mi1BcLvlI5xTh4KCaHfCr8M8f9ZNL5Qo3zAtuMzBaZvQWvUYxlxBvFzkfmViLhGnwbBt9pp46ip4wS9RXvVI1GP+a/nPHeUvB1bSExQLBPWcubPH0L0Eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z64UND9x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bgg6DG7CypupFai/a/ImxX2vljkR3xJPIapnRIuzQfw=; b=Z64UND9x/dhuFmPtF1jtkekcQe
	1/rduzxAFT2QKLYhd4wMZPtMqSrlS2Vn+U/dVE5atR4RoGDUuWlOBeBPx+pgFepedahzeU8LVtW7/
	szZsRatZIoPLRLpCIy2JLT4fbZwmfrsc/+9EFprf6WBWj1LcCjxne0iGHeEfhYdknubk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDkDz-00CIeU-AT; Tue, 28 Oct 2025 14:58:59 +0100
Date: Tue, 28 Oct 2025 14:58:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, ast@fiberby.net
Subject: Re: [PATCH net-next v2 2/2] tools: ynl: rework the string
 representation of NlError
Message-ID: <53ad4e54-47c7-4afa-a296-635e10192f8c@lunn.ch>
References: <20251027192958.2058340-1-kuba@kernel.org>
 <20251027192958.2058340-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027192958.2058340-2-kuba@kernel.org>

On Mon, Oct 27, 2025 at 12:29:58PM -0700, Jakub Kicinski wrote:
> In early days of YNL development dumping the NlMsg on errors
> was quite useful, as the library itself could have been buggy.
> These days increasingly the NlMsg is just taking up screen space
> and means nothing to a typical user. Try to format the errors
> more in line with how YNL C formats its errors strings.
> 
> Before:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument
>   nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'miss-type': 'header'}
> 
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: Invalid argument
>   nl_len = 88 (72) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'msg': 'requested channel count exceeds maximum', 'bad-attr': '.tx-count'}
> 
> After:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument {'miss-type': 'header'}
> 
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: requested channel count exceeds maximum: Invalid argument {'bad-attr': '.tx-count'}

I think as a kernel programmer, i would prefer EINVAL over Invalid
argument. If i'm going to be digging into the kernel sources to find
where the error is happening, it is one less translation i need to
make.

>>> print(errno.errorcode[1])
EPERM
>>> print(errno.errorcode[2])
ENOENT
>>> print(errno.errorcode[110])
ETIMEDOUT

I suppose the question is, who is the intended user of ynl? Do we want
user friendly messages, or kernel developer friendly messages?

	Andrew

