Return-Path: <netdev+bounces-96724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45968C75C0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E572F1C20B19
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F3145B00;
	Thu, 16 May 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gd4VbAPm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84994EB30
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861700; cv=none; b=QpOdF6iEsir6l+IAL/PeKguUoN27TvT+frSpZqSs4A/BiWH2yds44kyAT+vsxSUsF70shw0PkS0XvlWqjjQNvkb+6Od5QdFsme5uMZAjyRvQFlGEE1GEBnYGz1KxArCCaKENxbxMr0IG2jJXCIU/mgBO95SXbtuaPzOfksi/u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861700; c=relaxed/simple;
	bh=PlunQ3/rY0HdJVcXbjPH6jHeAqEcNZS6isGp1OktUV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr44IqJgNCr393EgtttN8hKKgX87IikYTWJxfSMZb4CwnrIGVBrs8JB8QOp1+fXYgaxYh+bx1i2jB65X6Oy2dciNvLTLCySHmSdTvc5dPaaXR1kBQVxhjY6is8yuxE+Oce6J+oxLCS5TAADwDOy8GE9sOcDmfXeEmozF5CUHjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gd4VbAPm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=d+hv8K4kQuKyDNmVKm8UecUM4A/7R5UyndySQAI3Yy0=; b=gd4VbAPmVoyGbcQMRsKt32ATp+
	UfqHK6QYOePoN4hQ9OvD6o8Rdy/VpLOfiO56HQnUk+H/t+zUu4oYoUBI9XFGQWE//TJLAnNniXbw9
	mGn0HZB6nvQKgzjKOZMBZEt5K8L6Hy4SrlxxBN6l03mAOtZeYrpZ70aRuzZunawLoevA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7a0a-00FVfv-1g; Thu, 16 May 2024 14:14:52 +0200
Date: Thu, 16 May 2024 14:14:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frederic TOULBOT <ftoulbot@scaleway.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org
Subject: Re: ethtool module info only reports hex info
Message-ID: <240d69aa-7f33-469f-8281-e254d5d0c85d@lunn.ch>
References: <CAAV7vNcRbVb00vp_u1q0f6jjqwVhx4GFAzWoP0AsRA1MhAfeBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAV7vNcRbVb00vp_u1q0f6jjqwVhx4GFAzWoP0AsRA1MhAfeBw@mail.gmail.com>

On Thu, May 16, 2024 at 09:23:05AM +0200, Frederic TOULBOT wrote:
> Hello, I have the impression that there is an unwanted change in the
> output of the ethtool -m command with a certain QSFP type
> 
> I tested versions 6.5-1 / 5.16-1 / 5.4-1
> 
> The bug seems very close to this one
> https://lists.openwall.net/netdev/2023/11/23/118
> 
> lsb_release -a
> No LSB modules are available.
> Distributor ID: Ubuntu
> Description: Ubuntu 22.04.4 LTS
> Release: 22.04
> Codename: jammy
> 
> With ethtool 6.5-1 and 5.16-1
> ~# ethtool -m ens1f1
> Offset Values
> ------ ------
> 0x0000: 11 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0010: 00 00 00 00 00 00 1d 0e 00 00 81 85 00 00 00 00
> 0x0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> And with version 5.4.1, we receive the expected result

Could you check it is being built with ETHTOOL_ENABLE_PRETTY_DUMP.

If you can build from source, maybe use gdb and check what is
happening in eeprom_parse()?

	  Andrew

