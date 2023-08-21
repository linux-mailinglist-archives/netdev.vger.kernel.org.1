Return-Path: <netdev+bounces-29410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC45783085
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 21:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D45280EC7
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAAF4FC;
	Mon, 21 Aug 2023 19:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9064A10
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 19:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA2BC433C8;
	Mon, 21 Aug 2023 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692645087;
	bh=bLnmPR/fj6fxgZzD4TUsyHXd4feqUx23RQO7PPhMvtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UH/tHdFOF4v1GEZMnE4oLN4QzHj9POPj4vYSrCGRzZC0hE4yM7KE3HcPXkYHFaZyU
	 oIkcEp5gXzgFdi9+MQ/VPpzqKDK5VURcY4mbjwG3qon3kto/c5Liv7S+CecgLZTsX5
	 PqmywcHUfVdrr9fAj2Yg3ITLQ/4YN6uLP2q97CF2OKvIiMonheypFwhIihZdkD08L1
	 d0BfhB4+QQrYCG7wudO668xX10032kiPaqHISA417/OW3NiZVwjNvdvP+xIGWewftS
	 Jjn3losV+WW+m7kyy7L425up2Fq88/Z+uJP6ji/+oHVKW+5cy2+yOFmLSkwku0PF//
	 a7Qio2ZUBor5Q==
Date: Mon, 21 Aug 2023 12:11:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Brett Creeley <bcreeley@amd.com>, patchwork-bot+netdevbpf@kernel.org,
 Yang Li <yang.lee@linux.alibaba.com>, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, shannon.nelson@amd.com,
 brett.creeley@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
Message-ID: <20230821121118.394c713b@kernel.org>
In-Reply-To: <20230821112237.105872b5.alex.williamson@redhat.com>
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
	<169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
	<ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
	<20230821112237.105872b5.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 11:22:37 -0600 Alex Williamson wrote:
> I'm sure Linus can fixup the conflict, but a preferable solution might
> be to drop the patch from Yang Li from net-next.  Thanks,

Slightly tempting to just move the HEAD back by one commit but IDK what
consequences this would have for people who base their branches on
net-next. So I'll revert.

