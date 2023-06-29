Return-Path: <netdev+bounces-14476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77216741E5F
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 04:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0E280D42
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0010EB;
	Thu, 29 Jun 2023 02:38:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509110E9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7E5C433C8;
	Thu, 29 Jun 2023 02:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688006336;
	bh=ylwDwkKV9fMuVJB/d6A8dgc/Rg1OxojDlaLYI3RcT/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfUlPNCAN5NWRq4sjaXqNj6oL9y2TqZjsmvm1QfQVIqU1gcQvwa8FNjeZK5Ilxrze
	 b6XebV441VAPaSOcawn5asWLedEhfcd44isiFiayl09qDM8n9UCwnLBHGS7BP2ztqi
	 t+LC/Uzdh1LFdCXx5aAWwHo6OHAvbaZiVWAeGOoPAiBVTNqCsJr6iLhhWCXTgTckSi
	 bwwgXPSNoKooMX4Bhzh6nIHy/6XbsP5uLsmhIGZWJdFhXix2UnB3b148ke7kaIwkKA
	 WrAvhLMYBBtcJEe3OixC3pA46wqzXeBRaCqQP+cJREmBYDjZsFeg2f5zwLHcsNJZ0d
	 ZPCLakfa20Vag==
Date: Wed, 28 Jun 2023 19:38:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-06-27
Message-ID: <20230628193854.6fabbf6d@kernel.org>
In-Reply-To: <20230627191004.2586540-1-luiz.dentz@gmail.com>
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 12:10:04 -0700 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
>  - Add Reialtek devcoredump support
>  - Add support for device 6655:8771
>  - Add extended monitor tracking by address filter
>  - Add support for connecting multiple BISes
>  - Add support to reset via ACPI DSM for Intel controllers
>  - Add support for MT7922 used in Asus Ally
>  - Add support Mediatek MT7925
>  - Fixes for use-after-free in L2CAP

As you probably realized these came in a little late for our main pull
request for this merge window. Can we cut this down a little bit?
Stick to the fixes and changes which you have the most confidence in
and try to keep the new lines under 1k LoC?

I had a look thru and these changes look like stuff we can definitely
pull:

 a8d0b0440b7f ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations")
 349cae7e8d84 ("Bluetooth: btusb: Add device 6655:8771 to device tables")
 afdbe6303877 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
 d1b10da77355 ("Bluetooth: L2CAP: Fix use-after-free")
 c1121a116d5f ("Bluetooth: fix invalid-bdaddr quirk for non-persistent setup")
 2f8b38e5eba4 ("Bluetooth: fix use-bdaddr-property quirk")
 317af9ba6fff ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb")
 a6cfe4261f5e ("Bluetooth: hci_bcm: do not mark valid bd_addr as invalid")
 20b3370a6bfb ("Bluetooth: ISO: use hci_sync for setting CIG parameters")
 29a3b409a3f2 ("Bluetooth: hci_event: fix Set CIG Parameters error status handling")
 48d15256595b ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable")
 f145eeb779c3 ("Bluetooth: ISO: Rework sync_interval to be sync_factor")
 0d39e82e1a7b ("Bluetooth: hci_sysfs: make bt_class a static const structure")
 8649851b1945 ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
 5b611951e075 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally")
 00b51ce9f603 ("Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy")

You can throw in a few more things you think are important and are
unlikely to cause regressions.

