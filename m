Return-Path: <netdev+bounces-40929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB47C91EB
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0A4B20A8D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35690627;
	Sat, 14 Oct 2023 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwTU0M1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122797E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38192C433C7;
	Sat, 14 Oct 2023 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244884;
	bh=btX4q00tpa3kANjZqjMhb8YjMQR4zKgNcnsAX/WbXJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QwTU0M1Il4XW5GQ3r52HgZ7nvJBAVq9eoymPC23J/loMDxlIsI/4HO/hz8ahpQb75
	 dWWbTu5Lx/EnIMLfXYwY+IkKxWvm+/xOra/knpRLifvmskpTglU8sINe5NbZwgXLgh
	 CGRSq0UTGq3JeES2hYC135VPRdPE/Xmg2gV5uvK4o7Dvr04rJB7F9qx1KPdaik3yYR
	 gtjMHTZEmFKCg0jgq62+SHKRfGnaK1OjPozVUO6o0G57C3hkDwiupYJxRnZVmHRyYM
	 X4dH8EuSL9/WEHLg8x0YZLGzyYPfTnROa3Gwij6K7vf8K5h+OFPO8c2zOYGX9GMZUU
	 APLJbBckyIkzA==
Date: Fri, 13 Oct 2023 17:54:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-10-11
Message-ID: <20231013175443.5cb5c2ce@kernel.org>
In-Reply-To: <20231011191524.1042566-1-luiz.dentz@gmail.com>
References: <20231011191524.1042566-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 12:15:24 -0700 Luiz Augusto von Dentz wrote:
>  - Fix race when opening vhci device
>  - Avoid memcmp() out of bounds warning
>  - Correctly bounds check and pad HCI_MON_NEW_INDEX name
>  - Fix using memcmp when comparing keys
>  - Ignore error return for hci_devcd_register() in btrtl
>  - Always check if connection is alive before deleting
>  - Fix a refcnt underflow problem for hci_conn

Commit: fc11ae648f03 ("Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name")
	Fixes tag: Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: 6f0ff718ed67 ("Bluetooth: avoid memcmp() out of bounds warning")
	Fixes tag: Fixes: d70e44fef8621 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: b03f32b195df ("Bluetooth: hci_event: Fix coding style")
	Fixes tag: Fixes: d70e44fef862 ("Bluetooth: Reject connection with the device which has same BD_ADDR")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: a9500f272b3b ("Bluetooth: hci_event: Fix using memcmp when comparing keys")
	Fixes tag: Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore NULL link key")
	Has these problem(s):
		- Target SHA1 does not exist

:(

