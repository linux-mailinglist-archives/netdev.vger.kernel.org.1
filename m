Return-Path: <netdev+bounces-138689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1C59AE8E0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE163B276FC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074381F5831;
	Thu, 24 Oct 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft92kQfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3A1F5837;
	Thu, 24 Oct 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780085; cv=none; b=ssF0h7WQiF813v/GEqe6UldCJNle+jTQuyzbfjQWIelMNHsRlDpqexT0FvcZ/58lTmIQ78zneZPx65Fr3R4up0v3xYhsZ/+Sg3titGV+eFKe7p77+p1qr6tEdi3NmCZ9FjHEC3sYWKqv30kT0GjmLvritCTtEzEoJEXZfl4uCrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780085; c=relaxed/simple;
	bh=0kRGC0VMT8PExSwlsH5fR6XLTGLcI9KDWObMnFj6wz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRIUM04j4T3kko3z9Ox10KgNY6wI08yozxxYqubanR1FYbyVJsPaeE/W1SzBeahD1SHOWGb24JJ2nd0mrVVAw2VGgcWB7Kr/YWVFUA3xSyZXGxJhYPW09de3Un0Td8RxewHmFt2rspYYctNcl5MH5FMG2TloiNEuCIBM5GluMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft92kQfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2EDC4CEE3;
	Thu, 24 Oct 2024 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780085;
	bh=0kRGC0VMT8PExSwlsH5fR6XLTGLcI9KDWObMnFj6wz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ft92kQfVqLRg9/dwH3WJ4uqFDupkRlaeyBaTa/WeY+vszDQjwH4NYOLnTTnMj8dbo
	 0bt5QUKZxrzjEYGys1h+2/H/gZiw36OXKE8phv1ccC04YRBp7m8ByXrtkgkJ4j03jS
	 2ckJcZgYPKc9ejakqf70KgRWyp1zOMiyF1ZS8NHjWSZV4a4hIIyJi7B7aoN/jwOUP0
	 MBrYxMSOUajnWJBZGrBTBLhjDSenhLTHDjevlB/J6BkA0Ya3y2ys/aKNJN1/I/B/k5
	 A5fEzCaBmAAsLSvhrqaJoj77rB0tLCijd/pvgHUZ+Jwi4SYP3opqxFxxdKhJPvTkem
	 ujfalPiQhYlwQ==
Date: Thu, 24 Oct 2024 10:28:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kees@kernel.org,
	mpe@ellerman.id.au, broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
Message-ID: <ZxpZcz3jZv2wokh8@sashalap>
References: <20241024140101.24610-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024140101.24610-1-pabeni@redhat.com>

Sorry for the spam below, this is another attempt to solicit feedback to
the -next analysis tools that a few of us were working on.

Bigger changes since the last attempt:

   - Count calendar days rather than number of tags for the histogram.  
   - Make histogram more concise when possible (the below is *not* a good
     example of the new functionality).
   - Add more statistics to the report.

On Thu, Oct 24, 2024 at 04:01:01PM +0200, Paolo Abeni wrote:
>Hi Linus!
>
>Oddily this includes a fix for posix clock regression; in our previous PR
>we included a change there as a pre-requisite for networking one.
>Such fix proved to be buggy and requires the follow-up included here.
>Thomas suggested we should send it, given we sent the buggy patch.
>
>The following changes since commit 07d6bf634bc8f93caf8920c9d61df761645336e2:
>
>  Merge tag 'net-6.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-17 09:31:18 -0700)
>
>are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc5

Days in linux-next:
----------------------------------------
  0 | █████████████████████████████████████████████████ (14)
  1 | ███████ (2)
  2 | █████████████████████ (6)
  3 | ██████████████████████████████████████████ (12)
  4 |
  5 |
  6 | ███ (1)
  7 |
  8 | ███ (1)
  9 |
10 |
11 |
12 |
13 |
14+| ██████████████ (4)

Commits with 0 days in linux-next (14 of 40: 35.0%):
--------------------------------
3e65ede526cf4 net: dsa: mv88e6xxx: support 4000ps cycle counter period
7e3c18097a709 net: dsa: mv88e6xxx: read cycle counter period from hardware
67af86afff74c net: dsa: mv88e6xxx: group cycle counter coefficients
64761c980cbf7 net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
4c262801ea60c hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event
ee76eb24343bd net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x
246b435ad6685 Bluetooth: ISO: Fix UAF on iso_sock_timeout
1bf4470a3939c Bluetooth: SCO: Fix UAF on sco_sock_timeout
989fa5171f005 Bluetooth: hci_core: Disable works on hci_unregister_dev
6e62807c7fbb3 posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()
10ce0db787004 r8169: avoid unsolicited interrupts
b22db8b8befe9 net: sched: use RCU read-side critical section in taprio_dump()
f504465970aeb net: sched: fix use-after-free in taprio_change()
34d35b4edbbe8 net/sched: act_api: deny mismatched skip_sw/skip_hw flags for actions created by classifiers

-- 
Thanks,
Sasha

