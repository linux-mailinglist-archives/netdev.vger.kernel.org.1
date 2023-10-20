Return-Path: <netdev+bounces-43154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB8C7D19B4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC66B214D1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FAB35515;
	Fri, 20 Oct 2023 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Qcrij8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B035507
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 23:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF7AC433C9;
	Fri, 20 Oct 2023 23:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697845849;
	bh=rD7i5HWfwFAX1Xen8caIl4ANRUZrjeYhCRejmepVOaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9Qcrij8zEyJ81UKuhvdfHd9FG5ySDX9V3mhYiV7QnK4tZkpk2Yyo21/3m47v65Qc
	 JvvhNaZ85DL4OsBJ/gCXR6sMa8w18eiZSbLkmFKSS0EOwMwwcPgPIDSIzjed/xmcet
	 OYFbnu9Zj3iFMDYX6V8Q0rcowAcpYaQRxhRqfqZ274zxEfq3gnddfGj6I4fKjYU53W
	 rAeBUNi9uXWuXckxGmePshU7v7CiBy/V5w05B1oGxUsh3pr0xfFkLbZZx8OEL+fbbj
	 zYP4bKRs9s62bAM0aJY4u0MPmGVJEpayqi52QE1vcWM8htBEKC50tVdJ4e3Uir2zc2
	 ojqHp/DjRDfdw==
Date: Fri, 20 Oct 2023 16:50:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nic_swsd@realtek.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
Message-ID: <20231020165048.33d3bff2@kernel.org>
In-Reply-To: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 21:34:34 +0200 Mirsad Goran Todorovac wrote:
> KCSAN reported the following data-race:

All 3 patches seem to have been applied to net, thank you!

