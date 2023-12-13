Return-Path: <netdev+bounces-57063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D4811F09
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264F62828A2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100A6827B;
	Wed, 13 Dec 2023 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilpnGyuh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F81D6B8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F0EC433C8;
	Wed, 13 Dec 2023 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702496239;
	bh=NwKBL0nRvt7n5e3nmNBPvIX31GjIJ5RUnfxEF9Up8/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ilpnGyuhyXQkn9rUGTIJKkFbZ2e+jc2EzwYjLu5YysUfO87G8T9btUZGqQZuUYDdY
	 PqUvbpL8M0mqE0Dnc7dDIW4rWy0Q19hvpLdGzUXb9ljbbdDe+IjQHVGdNwdAXla9k+
	 ox4kzedg/ApuNkdguJc3cqMNkzcCz6Bk+/KJLHlrLdv2N+Bky6ojSIp8g5vD7b18Zc
	 otAOCNCLY5ODU4JiBnL1sWOyCPcfHaVMzAxZU4iWkJ9UVtQAzG4ADO3mF+F3gO2IA1
	 uw+1sbRXDjxQ2LW5Sx9TadVSWJo67C5OXGtCrqGr5qFAI+waJkQJDtIDvOEL9mw/Bp
	 AurblFR1Hd00A==
Message-ID: <35b2312d-1761-4f33-824b-814ea0b300e0@kernel.org>
Date: Wed, 13 Dec 2023 11:37:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] Fix dangling pointer at f6i->gc_link.
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: thinker.li@gmail.com, netdev@vger.kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, sinquersw@gmail.com, kuifeng@meta.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <deb7d2b6-1314-4d39-aa6f-2930e5de8d82@kernel.org>
 <CANn89iKYBjM6O-4=Azo=L3oTjNaFAKFiO62MzHnoAM9x3ZQGoA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iKYBjM6O-4=Azo=L3oTjNaFAKFiO62MzHnoAM9x3ZQGoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 10:32 AM, Eric Dumazet wrote:
> I have one, not sure if the tree is recent enough.

If syzbot is using radvd, can you send that config file?

