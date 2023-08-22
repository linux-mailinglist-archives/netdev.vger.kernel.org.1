Return-Path: <netdev+bounces-29734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E122E78487A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6ED1C20B2B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F322B574;
	Tue, 22 Aug 2023 17:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799652B544
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4DFC433C7;
	Tue, 22 Aug 2023 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692725872;
	bh=cgwoAZ+oPhXsfMPQkJe9+jL333w4VKeyDL7/7MY3uVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFbf+y4ZAmZjqLp384mR9qzZ3/xySAqrVNcjnxSAE/PESVlDyx+E1SmXsW0Perlzr
	 jsWVI0d7rfNu1XxmjAf3BASKqtWIFf5kbEuS4sbplfSe9luKEpUdqkmkao8lcBAfwT
	 G4pcCXRGAmxWLA4kqzojJ9z8kFFrRxCeD/CuQwjXnHL6qS5q3TGL0Q9gTIDZIOE9s/
	 5sgTiQqCyF/A0KM/ZDQUhApTYcBPIwpFDs7fysSDRg68qeoSGBEFqrgdwuCEeC7u8K
	 pFFQSA4UQP5VYOh07bIXyTTY/co/9gNNN9uvyQoZ8WQO95C9N6QAYjLEbPb6MgMq3g
	 aw+Tekz3P06aQ==
Date: Tue, 22 Aug 2023 10:37:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <jiri@resnulli.us>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v6 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <20230822103750.6dbb6fc2@kernel.org>
In-Reply-To: <20230822031805.4752-2-justinlai0215@realtek.com>
References: <20230822031805.4752-1-justinlai0215@realtek.com>
	<20230822031805.4752-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 11:18:04 +0800 Justin Lai wrote:
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  372 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2432 +++++++++++++++++
>  5 files changed, 2832 insertions(+)

Please split this into multiple patches, I already asked you to do so.

Individual ethtool ops and vlan support should be separate patches,
perhaps you can separate other features out, too.

