Return-Path: <netdev+bounces-117347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1094DA9A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841E4B21CA4
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAB1311B5;
	Sat, 10 Aug 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlIJlHKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944634438B
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 04:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723262976; cv=none; b=TjvU5kSFHB0AgasePt4zxVKVccMcHfXitmf9w7dcEnukYUcB3O9einCtTGp26pWmbKBnMQmHjzBpJMzVqKQ5kjhT6hKt3cbXQb3U+14zh1ejOAs8190tbYMmyUOfZX4XdI4cywr4R7um7FOXwRZI6MubbBts+KLOYqSrOq8i30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723262976; c=relaxed/simple;
	bh=emxj5lPvbJ+nfo/qQu5O4/sYdwJg2x/64t8mqyJK+vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHyLubBQ/GgHZSxSBeW3/pCSe6JM5o/6JNJd3734ax2vyE6N1jGeh8i/qz8TnrGNmX1a+T/PPDmmASNwFQFvS2r/cv2Ir4qQxrLVKAKgvIzMcbyLibhr/+VlyVGtgCh5kpqJOUqDC/cwWCXIAlXnrR+jfu/Z1w6bJtQHIG3Yy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlIJlHKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B810C32781;
	Sat, 10 Aug 2024 04:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723262976;
	bh=emxj5lPvbJ+nfo/qQu5O4/sYdwJg2x/64t8mqyJK+vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mlIJlHKXhq+qHVEmzqWUBvfmfr1CHQWGPd9pWtcfAfxNs3JT1KbpvrcT0wo6ljOeA
	 Lm7ObO9gokNXXaE5KyXHCw6KZXAr0m0bDSh4y+tz6E8WAJK+bSMsv/VjHBcMzi1H++
	 sqCRWrxK0Zz3yqLawg/t4UodN2LzZwaFTXb29cd57j6Sx3mXnTkBsvzJ/rvyr5oeZn
	 ysZ0BZ1sB/o2H4/bEwqo7046EqQUeq5irS0XbvqI14anDWzkxAIfv5dOcwSffKLFnb
	 jcBm1gLPEMtw/sY/Tl40xXXrA+z/275rRAbiy8ii+EuoeXzNcweMjjuPmj/P70xNEm
	 vI7gRzICJh1Fg==
Date: Fri, 9 Aug 2024 21:09:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
 <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
Message-ID: <20240809210934.02d3c2ec@kernel.org>
In-Reply-To: <87o762m31v.fsf@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
	<20240808062847.4eb13f28@kernel.org>
	<87o762m31v.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 11:48:09 +0200 Petr Machata wrote:
> This failure mode is consistent with non-updated iproute2. I only pushed
> to the iproute2 repository after having sent the kernel patches, so I
> think you or your automation have picked up the old version. Can you try
> again, please? I retested on my end and it still works.

Updated now. iproute2 is at:

commit cefc088ed1b96a2c245b60043b52f31cd89c2946 (HEAD -> main)
Merge: 354d8a36 54da1517
Author: Your Name
Date:   Fri Aug 9 21:06:12 2024 -0700

    Merge branch 'nhgw16' of https://github.com/pmachata/iproute2


Let's see what happens, I haven't rebuilt the image in a while
maybe I'm doing it wrong.

