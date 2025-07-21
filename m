Return-Path: <netdev+bounces-208676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43556B0CB56
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2AA542AFC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65F238157;
	Mon, 21 Jul 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqI3VtLZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A86EAC6
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128481; cv=none; b=B573cgHl9UwA9rXZfZuq0PTMjJuhO5e0v+MIvCAVdk0BZknQJD6q2cuhqn8t3CKWuBTZL+MH2CvUWNSb8QdTWFzVt2HAg4k2Xqyczx/bhZ9VJqOmuudyJRyBkgb1P35Qhvu7I3zFtygjcniWiRjADZwIYfewhV36/cVO/uetbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128481; c=relaxed/simple;
	bh=pgzpr4307hHT4m1uZB5LVv1aroEIL3zPPiKIY1i4F4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJFratJysp3E5A9YuCzTkzQi4GNQiUCD8vAz0MZW3pacOiUCSOIQx2udXviMuFZwMALF3F8vxT79mDZyflKBq7un7l5hifNGR/ltFnPHDXKKJXpiCV66dxPAJex7xwe2NZov0Qi/Tisnl1AmbZrymVf+9UNY+P2iUhTV7TSelSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqI3VtLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1596C4CEF4;
	Mon, 21 Jul 2025 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753128481;
	bh=pgzpr4307hHT4m1uZB5LVv1aroEIL3zPPiKIY1i4F4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dqI3VtLZZN3LDw1OFNXXlf9dJHG7VlVEON2odEpmoL5p2b/rPI+1OxhNtMpsOQhuG
	 NkxvJaTunryz8WLIX7mOIrOFc2eCp6zs3BmzUIqj6VKagmbGSlTy5ohViKnx1Fxk/b
	 sWWZrea5H5AvX0yFOgKHBJMOTTreUz4w5BldtuY8da5rKE6LbN3vpIM4y+DMpDcimY
	 kdnbIjOi50nm9kjSDlvKPpbSQmqs7nF+4QujsO8Hg2XKFtnSH4rCsWvh6TkN40/qhN
	 gjU0ypcrphpAB1tCMb00p86cth+MzVKXRQfxieSmiAv6Rnpf2afiw1it6G3s/Se2Jr
	 IcBchBgw9I+zg==
Date: Mon, 21 Jul 2025 13:08:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jv@jvosburgh.net"
 <jv@jvosburgh.net>, "pradeeps@linux.vnet.ibm.com"
 <pradeeps@linux.vnet.ibm.com>, Pradeep Satyanarayana <pradeep@us.ibm.com>,
 "i.maximets@ovn.org" <i.maximets@ovn.org>, Adrian Moreno Zapata
 <amorenoz@redhat.com>, Hangbin Liu <haliu@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
Message-ID: <20250721130800.021609ee@kernel.org>
In-Reply-To: <MW3PR15MB3913774256A62C63A607245EFA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
	<20250718212430.1968853-8-wilder@us.ibm.com>
	<20250718183313.227c00f4@kernel.org>
	<MW3PR15MB3913774256A62C63A607245EFA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 19:23:19 +0000 David Wilder wrote:
> >This test seems to reliably trigger a crash in our CI. Not sure if
> >something is different in our build... or pebkac?
> >
> >[   17.977269] RIP: 0010:bond_fill_info+0x21b/0x890
> >[   17.977325] Code: b3 38 0b 00 00 31 d2 41 8b 06 85 c0 0f 84 2a 06 00 00 89 44 24 0c 41 f6 46 10 02 74 5c 49 8b 4e 08 31 c0 ba 04 00 00 00 eb 16 <8b> 34 01 83 c2 04 89 74 04 10 48 83 c0 04 66 83 7c 01 fc ff 74 3e  
> 
> Hi Jakub
> 
> What version of iproute2 is running in your CI?
> Has my iproute2 change been applied? it's ok if not.
> 
> Send:
> ip -V (please)

iproute2 is built from source a month ago, with some pending patches,
but not yours. Presumably building from source without your patches
should give similar effect (IIRC the patches I applied related
to MC routing)

> Can I access the logs from the CI run?

Yes

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2025-07-19--00-00

> Is there a way I can debug in you CI environment?

Not at this point, unfortunately.

> Can I submit debug patches?

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

