Return-Path: <netdev+bounces-16565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A174DD59
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E5D281335
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9D14A9B;
	Mon, 10 Jul 2023 18:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD514AB5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C52C43391;
	Mon, 10 Jul 2023 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689013794;
	bh=bv1BTYWvDF6jdR4K3b0/OVRixRNMD++vQrds7exgRUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dv300fezJEkaoc84W+FoOPKetxJMulFBSqUTnwkzVn9+0IpaeRcmaE8CAgRtYANIp
	 JSZ3CdytlYujo4pRnXgnzBOZoS4CcGQDDvuHjAnoezBWy/yKbS/RKKaYNlvRnYzxFt
	 loKaVUrhAFgzefCWqSGV+tluPOmGFFWMebZwX11iYdh87u/rILwb+SRXn1pHURCFDx
	 WPezgVpZKFZIcmxa+XArTuQmSdBAt98C6i9j3Z/PbIdZjdk7MlZJxOzG6oEXihJWbm
	 4ylaR+6xIvwhw0h5WU/nbQQITzph+4DZmzRVyEzeFYjM9Dt52Xy9MoA3jvkaI2gNDq
	 nY5Jakaa61spA==
Date: Mon, 10 Jul 2023 11:29:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 aliceryhl@google.com, miguel.ojeda.sandonis@gmail.com,
 benno.lossin@proton.me
Subject: Re: [PATCH v2 0/5] Rust abstractions for network device drivers
Message-ID: <20230710112952.6f3c45dd@kernel.org>
In-Reply-To: <20230710073703.147351-1-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 16:36:58 +0900 FUJITA Tomonori wrote:
> This patchset adds minimum Rust abstractions for network device
> drivers and an example of a Rust network device driver, a simpler
> version of drivers/net/dummy.c.
> 
> The major change is a way to drop an skb (1/5 patch); a driver needs
> to explicitly call a function to drop a skb. The code to let a skb
> go out of scope can't be compiled.
> 
> I dropped get_stats64 support patch that the current sample driver
> doesn't use. Instead I added a patch to update the NETWORKING DRIVERS
> entry in MAINTAINERS.

I'd like to double down on my suggestion to try to implement a real
PHY driver. Most of the bindings in patch 3 will never be used by
drivers. (Re)implementing a real driver will guide you towards useful
stuff and real problems.

