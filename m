Return-Path: <netdev+bounces-14594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5E742967
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F5E280C9C
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490B12B76;
	Thu, 29 Jun 2023 15:22:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A8111BB
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 15:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AEDC433C0;
	Thu, 29 Jun 2023 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688052162;
	bh=6h13JFmAV8S+mzKVdSd8cTenQr9Vc4RacTrMUMCF2fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtEOOpqujpm+m8cdjCBsPFL3vEWkH7YHUgBW8BSUwW4Xg2KoybG3erjWssA/5dh9J
	 szbF92545ps9Puqiv69fybiKQbJrdNrFof/SxdofXue8TlWx76xiS+oRXRdUbRVg3O
	 MOMXaVImFMGk3HwbKw/mVY2Z9SYfgPv/P04w4szVKh0YW2H7ZQPtJ0GtLvGMmqi7Oz
	 wrhh/K2KZ0rOJazsfnY/3stw4yulwmM3IHiwE+wwVRovHM13lbMgLgMWIjj5c1nQst
	 uS/sy5VorlsiQuBKMkpEKZMlKjW51ly+5aCGjud+HUTypxVMPhb/M2PzXCoqFZrHb9
	 AJL74/uOoWzMw==
Date: Thu, 29 Jun 2023 08:22:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-06-27
Message-ID: <20230629082241.56eefe0b@kernel.org>
In-Reply-To: <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
	<20230628193854.6fabbf6d@kernel.org>
	<CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 22:01:05 -0700 Luiz Augusto von Dentz wrote:
> >  a8d0b0440b7f ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations")
> >  349cae7e8d84 ("Bluetooth: btusb: Add device 6655:8771 to device tables")
> >  afdbe6303877 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
> >  d1b10da77355 ("Bluetooth: L2CAP: Fix use-after-free")
> >  c1121a116d5f ("Bluetooth: fix invalid-bdaddr quirk for non-persistent setup")
> >  2f8b38e5eba4 ("Bluetooth: fix use-bdaddr-property quirk")
> >  317af9ba6fff ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb")
> >  a6cfe4261f5e ("Bluetooth: hci_bcm: do not mark valid bd_addr as invalid")
> >  20b3370a6bfb ("Bluetooth: ISO: use hci_sync for setting CIG parameters")
> >  29a3b409a3f2 ("Bluetooth: hci_event: fix Set CIG Parameters error status handling")
> >  48d15256595b ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable")
> >  f145eeb779c3 ("Bluetooth: ISO: Rework sync_interval to be sync_factor")
> >  0d39e82e1a7b ("Bluetooth: hci_sysfs: make bt_class a static const structure")
> >  8649851b1945 ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
> >  5b611951e075 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally")
> >  00b51ce9f603 ("Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy")
> >
> > You can throw in a few more things you think are important and are
> > unlikely to cause regressions.  
> 
> Yeah, those seem to be the most important ones, do you want me to redo
> the pull-request or perhaps you can just cherry-pick them?

Nothing to add to that list?
Let me see if I can cherry-pick them cleanly.

