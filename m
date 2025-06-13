Return-Path: <netdev+bounces-197672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA76AD98CD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1486F3B901D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAB28DF07;
	Fri, 13 Jun 2025 23:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Rx6NPy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10428D85A;
	Fri, 13 Jun 2025 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749858999; cv=none; b=DdbIqk9ZPAp85OckwcTDPpW74yI69eWDpxmhHkWSvxX+FTS3vvhKGjI0KeGETwsx6wglNiFoEWykzW01TXPvtg1HBb9DqikU2Lwv9Wm98HIr6Dw6iJ2BK597gJE+2U5fBOxfBgWCtr5AhYOb04xZOh65R2IlvN5T9CEFBON99aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749858999; c=relaxed/simple;
	bh=yR9bKkZKQoLog4iOy1x/HGcsEloMHAaSYdv50DKocgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAlzpw0tor3QcOVW7SEF+zq3oiwO4IX2QYV+YItHho353pW0vgQzpeurOe2isojGbsh4BFuwYrSc32MAjHDx8u8YQsKM3/bxny0FJJBePyTYCtW3n2qabVSKykUgASwUGik8TbHe9dqk3eLBRnDf3Pz/w6LmN/rNWTdVyMOjd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Rx6NPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B82DC4CEE3;
	Fri, 13 Jun 2025 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749858997;
	bh=yR9bKkZKQoLog4iOy1x/HGcsEloMHAaSYdv50DKocgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f4Rx6NPyaqYwGHdY2B5DRRrF+Gh7EChynqUWN8QUzKOXXCLptUL5HAnhXPIFfbrqf
	 eCRt4Nymf4OCKY2lg65R6iYHjdILn7ItHIXNDI3WQcrYYJAgyH6AcNwUJaqnMaqqC9
	 aDcAPe9hkLQzwTbRErRgfAFZ/vhpVdW4fkJBVviSFAVobmPTzayEOROY73NGd8w/4c
	 dnI/+Nl5+DQDo3n4LkdOMoNFzelRqDvKwOU4MAWgRkmFOeYxVD19ojGixKFfqEVVJz
	 1q2NdBtw4T/4MDGSmA4kVTN9u+VTRdIunheUL5xZaWyYKm8BpLBz3fhBbhVmR56g+S
	 8L3/+15nmutkQ==
Date: Fri, 13 Jun 2025 16:56:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
Message-ID: <20250613165636.2fcdffa9@kernel.org>
In-Reply-To: <aEt6LvBMwUMxmUyx@mini-arch>
References: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>
	<aEt6LvBMwUMxmUyx@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 18:09:02 -0700 Stanislav Fomichev wrote:
> Where linkwatch_do_dev (potentially called from ethtool_op_get_link and
> bond_check_dev_link) might trigger ipv6 address assignment so I'm not
> sure how this all supposed to work under rcu and without rtnl lock.

Yeah, linkwatch seems to also try to allocate memory with GFP_KERNEL.

> Tentatively (untested uncompiled):

I think miimon recheck period may be rather frequent, but given 
the above going back to rtnl is probably the sanest way out.

