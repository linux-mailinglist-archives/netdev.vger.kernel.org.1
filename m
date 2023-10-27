Return-Path: <netdev+bounces-44635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C57D8D66
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B11F224B2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381F1FA8;
	Fri, 27 Oct 2023 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdT3xZqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B3EC3;
	Fri, 27 Oct 2023 03:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB03C433C8;
	Fri, 27 Oct 2023 03:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698377190;
	bh=iwRUPES/IbffiIvKIcy7N/alKcfziJOM17qikqX/jD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdT3xZqqbGPFr6n/XsCrK+KOOwIjjyKPfrz7uxiWKs4UYrFL9/ta7LK8QDbs4bxHu
	 VDDzTXnSp4RW5wn3OgsTAkjL9QnoI8MRysh1qTd4O1R+ITmyzU5YiHdCagBe8eRfuO
	 zFeDPp99Ww8Bzygs7J7MZyYvzigBbI8O+FR6ONAb58gQE1Pka6dbdsV0wuj1cfNs4/
	 hz7mE+nnWsEwI2QlsPK4Y97042IxGHMcoLL7OP1XV/zb+rSLiAKYblLAb5TOoqM+kG
	 meMw++94rxbuaEFP165jbB1YMSWVBMxdx2GVonBHVwofanPcixqu0ztcPvtSixUzAX
	 hJ8f8nowzK3QA==
Date: Thu, 26 Oct 2023 20:26:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, Kishen Maloor
 <kishen.maloor@intel.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID
 0
Message-ID: <20231026202629.07ecc7a7@kernel.org>
In-Reply-To: <20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
	<20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 16:37:04 -0700 Mat Martineau wrote:
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Cc: stable@vger.kernel.org

CC: stable@ + net-next really doesn't make sense.
Either it's important or it's not. Which one do you pick?

