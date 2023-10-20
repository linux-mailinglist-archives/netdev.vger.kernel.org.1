Return-Path: <netdev+bounces-43147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F287D1936
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68813282712
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636B225DF;
	Fri, 20 Oct 2023 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQYq4SID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DC39925
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 22:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72018C433C7;
	Fri, 20 Oct 2023 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697841315;
	bh=645CvLhogLuWXyyZifMO8kxY7yxiYjy3ZA3sngJkXIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qQYq4SIDZbbWAGhpeEAwx/MyZjmh4oFZv9QnQg3vebw10yIk246XGtbp1BRfGbcqB
	 amRvfnunCIsZhsNfaPGV+AJOfHNPjVXp/89XFORuSuDZjSkTxB54ZyC4YkHGMSxxIY
	 uafk6vXShwx4Jgx8lNcuv1rLTbvi7XDZdomKXfaEbtJ41+9PPiYOEoHkDUOarsBuIg
	 Oznf+O+P/gKt6xOoGqkO40xXZeLHx1Vlthn5EWsm15U7bLOgyNl3EFMrnMxOIBB5Rs
	 mYNaUYGIjmI2cM0wKWJ1CD1s+gic3iwWfDIDiWenRHqebUjFr7JF7ikhHKIvX7SoLk
	 Ai8/xm1DJyatg==
Date: Fri, 20 Oct 2023 15:35:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next 0/3] netlink: add variable-length / auto
 integers
Message-ID: <20231020153514.4e65269f@kernel.org>
In-Reply-To: <20231018213921.2694459-1-kuba@kernel.org>
References: <20231018213921.2694459-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 14:39:18 -0700 Jakub Kicinski wrote:
> Add netlink support for "common" / variable-length / auto integers
> which are carried at the message level as either 4B or 8B depending
> on the exact value. This saves space and will hopefully decrease
> the number of instances where we realize that we needed more bits
> after uAPI is set is stone. It also loosens the alignment requirements,
> avoiding the need for padding.
> 
> This mini-series is a fuller version of the previous RFC:
> https://lore.kernel.org/netdev/20121204.130914.1457976839967676240.davem@davemloft.net/
> No user included here. I have tested (and will use) it
> in the upcoming page pool API but the assumption is that
> it will be widely applicable. So sending without a user.

For the record looks like DaveM merged this last night.

