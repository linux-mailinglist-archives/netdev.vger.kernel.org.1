Return-Path: <netdev+bounces-86804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A28A059A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662D41C219D6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853C60EF9;
	Thu, 11 Apr 2024 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLCVPXFf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AC5F870;
	Thu, 11 Apr 2024 01:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799398; cv=none; b=kYO7KOmLZt6iDlBnqf18h8MBhiskzl6NnY0FI4bJJbWTbl2YT72KVM00uYGhJdRzeD0w9hYVSQiyIecnkugFr5iUquC7aTIOLcpJ6p74nonPqG/9HuRalhde2hHni7TQ2DF4+L69e+NhCjSVcbL6j8ZjyImBLihuMKdPsJHrfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799398; c=relaxed/simple;
	bh=MWTUkadnObVjMc8frEWWWyCvBCX6wsjc33gwzU1lmqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXXh0LZ2rc/Vg2o2JJeNV+iLVxIZM6r9sHk2m6OhA4KakGSn5h1Bg1M1PE7GWljBFBUsquUgmQvhZDd7RAfEGzZAZt8g3aOB6Erv+vtSc6bTofw2LXP48GwpFv4zQO7dQa3A/7vG969UnBqAJwLIAuXN2qAUT6F3d6ldUqj0SyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLCVPXFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCCDC433C7;
	Thu, 11 Apr 2024 01:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712799398;
	bh=MWTUkadnObVjMc8frEWWWyCvBCX6wsjc33gwzU1lmqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rLCVPXFfBKMhygcc3c/PiSabC40ergjqMylxqFMbqJQgFxPoNEyo1INIR3JBXMxRH
	 3pkuPZtv9CKSGL3SNLMUR1O6xXlRWpwcodiEItGct72/nmC37FJ2T4EZHxR83g+7eV
	 +7npshUyURuv4YngCDywBcsFebv+61zXy/TfpTG5HmmvaXwFnFhhEaS+SfpSiUsPC6
	 fBOYRYAYiV2QCQDefRMnxbqSCewH0LLLsdtVSrmnshii860QPc173K2VJXfeYIXOs7
	 39LMAJ4hfzOyEtnlH+uoJpLYiufjVfc5zmSwDoJqe0wqpBI8Ot/iqsw3QjWX4lbtHv
	 G0dI0jejlBlXQ==
Date: Wed, 10 Apr 2024 18:36:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, kernel test robot <lkp@intel.com>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock,
 __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_sock,
 __cacheline_group_begin__tcp_sock_...
Message-ID: <20240410183636.202fd78f@kernel.org>
In-Reply-To: <CANn89iJMirOe=TqMZ=J8mFLNQLDV=wzL4jOf9==Zkv7L2U5jcQ@mail.gmail.com>
References: <202404082207.HCEdQhUO-lkp@intel.com>
	<20240408230632.5ml3amaztr5soyfs@skbuf>
	<CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
	<db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
	<CANn89iJMirOe=TqMZ=J8mFLNQLDV=wzL4jOf9==Zkv7L2U5jcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 19:33:54 +0200 Eric Dumazet wrote:
> > Jakub, I do not see a 32-bit build in the various checks being run for a
> > patch, could you add one, if nothing else a i386 build and a
> > multi_v7_defconfig build would get us a good build coverage.  
> 
> i386 build was just fine for me.

Yes, we test i386 too, FWIW.

Florian, does arm32 break a lot? I may not be paying sufficient
attention. We can add more build tests but the CPU time we have 
is unfortunately finite :(

