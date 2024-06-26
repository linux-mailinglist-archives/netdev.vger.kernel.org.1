Return-Path: <netdev+bounces-106710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D2917550
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37A11F2216A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB579EF;
	Wed, 26 Jun 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIJdSj1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294646125
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719362691; cv=none; b=Slhzu4hhEY/LioEWx/Asnspq3GlJtTYvYreif5oV1jQQ3NU9NhHKqU4NRG141zvBUjYzLEtVVkDMj5ztBkO0lq32m6+yM5TIKrfJCnq8LEZR09eS89CSbhaRih0AlwLV5thCZYHj+FZIzg3URj0Nd09DQfwpP+J94HJzYFKs7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719362691; c=relaxed/simple;
	bh=meM/glDigaFBA8kcG9mlFtFMxqzImr3i3eWuQXvJJvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbD/Lm50cOSTQogg4nCchV7L4rcCEGE7XoNT8CluXU5sjayyhlOg7Nrs5YvOijAiZ1tOCt2VKGc/VnxBV+u2m1Tl8rmXcGzOUoR+QS6U0DGJnP1LtBu/UBiEVjMdhbN0cKCsW5wjnf5+kyQ5Ot8/b0YTvnE2dWEnneo3Sy3GE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIJdSj1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB87C32781;
	Wed, 26 Jun 2024 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719362690;
	bh=meM/glDigaFBA8kcG9mlFtFMxqzImr3i3eWuQXvJJvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dIJdSj1Dn6mhLa22l1zPE+Up5sR8weABMcdYdp+zf6LCXdcG83CzGZPafffBhwDPw
	 rrKjbTXS7CPoF2A0cEhBRoHuPTomsQA4KMf6/2ZiiAInleNlbWXoCoSp8udYek5gtC
	 1Phwbb+i/34rIfHLoPDkr/pj+3Da4jpXW12ncbclSdTu6UDsOuZvy3gnNocKFHFkku
	 zYn0zTsDywhFWu7zmdVexnVjzmuXBwrX6YDxY1lFpfgHOVDUgy8NYcC2OtCRB1dIdd
	 EPXRXsANfM3WCDWljKZ3DVNNB0kK3Rler91vTERsdR1mj+ZU/sDfA9lsa8QergBII7
	 atOSDP3xcLytg==
Date: Tue, 25 Jun 2024 17:44:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rao Shoaib
 <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
Message-ID: <20240625174449.796bc9a0@kernel.org>
In-Reply-To: <20240625013645.45034-3-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
	<20240625013645.45034-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 18:36:36 -0700 Kuniyuki Iwashima wrote:
> +	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
> +		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
> +		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
> +
> +		ASSERT_EQ(ret[0], expected_len);
> +		ASSERT_EQ(recv_errno[0], expected_errno);
> +	}

repeating the conditions feels slightly imperfect.
Would it be possible to modify EXPECT_* to return the condition?
Then we could:

	if (EXPECT(...)) {
		TH_LOG(...
		TH_LOG(...
	}

