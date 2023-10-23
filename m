Return-Path: <netdev+bounces-43532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F309F7D3C9E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AAEB20CD0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D21B266;
	Mon, 23 Oct 2023 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHqgLgwG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9301208C9
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4223C433C7;
	Mon, 23 Oct 2023 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698078778;
	bh=0M244WP+B22z6pXqP9dzivpUFrbkfNxne47wn1L0ZW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UHqgLgwGnbMutjeOm+NYV0HlNhagHkMAAACFBUqKPMeurN3bBYDJuBwMQw4VjmPoS
	 qfZb9IDIC0GpOUODsjbTzy0xygvAm7LqMLnCQ6+Adqlxbm+7An0xmz1CF/OKawyV0R
	 8zlqsYNmUMaXVz2mE+kJSFBDZYQ1t0NgRmxH1iA9BrvWYNwXOTB624kcHckSLvKcdW
	 5+PGhbNnpiSgTGYUGDNZFFt72OlYO1Lg/n22vXVL9Wx0T4VPXngwYs3BiocVVbS46p
	 +2KVSpxcKlZmiMq1n/NEqlZy1RAbEHPGbO3ZU3sdryW/WRsm4Ic3+aGSkdHzqzwbpt
	 BgHG3e6v2E5gA==
Date: Mon, 23 Oct 2023 09:32:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc: Edward AD <twuufnxlz@gmail.com>,
 "syzbot+9704e6f099d952508943@syzkaller.appspotmail.com"
 <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "reibax@gmail.com" <reibax@gmail.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ptp: ptp_read should not release queue
Message-ID: <20231023093256.0dd8f145@kernel.org>
In-Reply-To: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <0000000000002e8d4a06085267f3@google.com>
	<20231023024622.323905-2-twuufnxlz@gmail.com>
	<MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 09:01:40 +0000 Drewek, Wojciech wrote:
> Consider adding a target to the subject: [PATCH net] in this case

The buggy commit only exists in net-next, [PATCH net-next] 
is the correct prefix.

