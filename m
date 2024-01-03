Return-Path: <netdev+bounces-61346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5614A82379C
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 23:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6550A1C24694
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDF01DA3B;
	Wed,  3 Jan 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH6ifGNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B151EB24
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 22:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C51DC433C8;
	Wed,  3 Jan 2024 22:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320284;
	bh=LKC8+IKlRrfEyYQDG06j9Zcdvb4Dp5Hc9BmGZYnbbQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vH6ifGNOzcvteNinAzfj2+5vjIuj9YgPFzbIp185l2OoI1Iw22+cYiaEmXOAU3qEK
	 SqJomu5s9khCYm1oVsEWvodBLAQ469XS5GBcZa96Q/pYZa2DfemE15opBVTq7nR1Pl
	 WS4vdGLOW3w2pdwtr4dRbvuGJpeF8moAwRTFZ2OvFH57FM7VQI/jhd6RN3vtnckiSC
	 apvAM+YmfNrle8ZL0sxR94ndFzCMgoUxRo5iKt5LGDXaW3wvVvJjL3Gj+AgGgvqwZ7
	 YSx0qcPOalhUe0GAV3SWKdU+nTouqEaJLEcDmwQYTs3XV2TMa7xjqg/mG2Cg3jihmZ
	 cFIgEdfJAf9RA==
Date: Wed, 3 Jan 2024 14:18:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Woodhouse, David" <dwmw@amazon.co.uk>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v2 net-next 00/11] ENA driver XDP changes
Message-ID: <20240103141802.12670bf5@kernel.org>
In-Reply-To: <c26e254e84f044adbd3c1e5fd364501a@amazon.com>
References: <20240101190855.18739-1-darinzon@amazon.com>
	<20240102100807.63f24fa3@kernel.org>
	<c26e254e84f044adbd3c1e5fd364501a@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 07:08:02 +0000 Arinzon, David wrote:
> Apologies, I've noticed the failures in patchwork and decided to act quickly.
> Thank you for the guidelines link.
> 
> Shall I resend v3 after the waiting time?

No need, just a note for future submissions.
I'll get to reviewing the code itself later today, fingers crossed,
and then we'll see if v3 is in order :)

