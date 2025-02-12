Return-Path: <netdev+bounces-165705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F3A332B9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A447A285B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4816204086;
	Wed, 12 Feb 2025 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XeuB0rWW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36EB1FFC59
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399666; cv=none; b=LAIcOMgVQHuBdIW7N/AtFsJgi58GISeSxNvMSMnDl6+I1zz3xjeOyRNXxBHCePw7qb/XE/EwXS55XUSWb9ih4xKYRBKeF6epW5vGQ+infb137Q0Hz0deVWwz8b8IzDlIv1o9mAFvUxqC2yiS6sn/ONPLmgAitIrevn2FEJDv19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399666; c=relaxed/simple;
	bh=FpGKY+sTkvZImSJW0DdMUosikAOQrEExtE06HFGtmmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIxWEGguKGQ1oI8oM+EMbOiJq8NcfO5uJXCh6yB5NiFrfbEOr8WBqpi3m2vS7qmi7lXQzVToUHGL+xTA+9pdatmN8M6LZEonSWk85Joet5Wl4yZzs88w4fxiUuIAHjG25hSfuHnT2UmAwECIcP5BBuWC8zh36LDsV8bHgr+TX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XeuB0rWW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GdCuUfOaA3CLNlzAqIMj780+oKCRDr01MGaKBeFrH9g=; b=XeuB0rWW5G3kR+WFOcZvfHMIlI
	UaKpMztMDjNb2lr+jsCPuhv3WuT8TOHPLJqzgKYoNBnI8lHMV11JSb/EVZLmQUBl4y1cLnfgie44Z
	lY44QDi7av2C6yHOdFzgEdDxuUR1J8KJabkybzQrwpU75EBUOXOBAd5KEq/EA3+LWzS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiLJ8-00DX3k-2p; Wed, 12 Feb 2025 23:34:14 +0100
Date: Wed, 12 Feb 2025 23:34:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v6 6/7] net: selftests: Export
 net_test_phy_loopback_*
Message-ID: <464ec7ed-2943-4696-a198-2495d4035f91@lunn.ch>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-7-gerhard@engleder-embedded.com>
 <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
 <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>
 <c1229fd9-2f65-40dd-bbb5-9f0f3e3b2c2c@lunn.ch>
 <09a4cd33-3170-4f87-a84b-5e1734d97206@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a4cd33-3170-4f87-a84b-5e1734d97206@engleder-embedded.com>

On Wed, Feb 12, 2025 at 10:36:00PM +0100, Gerhard Engleder wrote:
> On 12.02.25 21:46, Andrew Lunn wrote:
> > > Reusing the complete test set as extension is not feasible as the first
> > > test requires an existing link and for loopback test no link is
> > > necessary. But yes, I can do better and rework it to reusable tests.
> > > I'm not sure if I will use ethtool_test_flags as IMO ideally all tests
> > > run always to ensure easy use.
> > 
> > We try to ensure backwards/forwards compatibly between ethtool and the
> > kernel.
> > 
> > The point about ethtool_test_flags is that for older versions of
> > ethtool, you have no idea what the reserved field contains. Has it
> > always been set to zero? If there is a flag indicating reserved
> > contains a value, you then know it is safe to use it.
> 
> I'm not sure if I understand the last sentence. Do you mean it is safe
> to use a flag that was previously marked as reserved if the clients did
> set it to zero, but for ethtool_test_flags this is not the case?

We have:

struct ethtool_test {
	__u32	cmd;
	__u32	flags;
	__u32	reserved;
	__u32	len;
	__u64	data[];
};

where flags takes a bitmap from:

enum ethtool_test_flags {
	ETH_TEST_FL_OFFLINE	= (1 << 0),
	ETH_TEST_FL_FAILED	= (1 << 1),
	ETH_TEST_FL_EXTERNAL_LB	= (1 << 2),
	ETH_TEST_FL_EXTERNAL_LB_DONE	= (1 << 3),
};

I've not looked at ethtool, but it is possible the struct ethtool_test
is on the stack, or the heap, and not zeroed. So reserved contains
random junk. flags is however given a value, bad things would happen
otherwise. So we know the bits which are currently unused should be
zero. A new flag can be added, which indicates user space wants to set
the speed, and that the speed is in the reserved field. Without the
flag being set, reserved contains random junk, with it set, we know we
have a version of ethtool which sets it to a specific value.

It might however be that we cannot rename reserved, it is now part of
the kAPI, and changing it to another name would break the compilation
of something. That is one of the advantages of netlink API, you can
add new attributes without having to worry about breaking older
builds. Unfortunately, the self test is still using the IOCTL, it has
not been converted to netlink.

    Andrew

