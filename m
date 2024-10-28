Return-Path: <netdev+bounces-139636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AACAD9B3AFF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4492830EE
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0371E00BD;
	Mon, 28 Oct 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV/+9XBI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A253A1DB;
	Mon, 28 Oct 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145818; cv=none; b=ltz6ApjJn2V+OMtpWen/J+3mAMKaQJiucIIb22X+YJ8ZnGKt9a3+VhZ0QmK6zHhiDPZrTG+g3B39LFqvqzjqKAY0YNT1h2ZrgJCyi68rXBqEV7p+OKxdAOu83ZdPuW912lBA9xfHWGPLa9T0YMGCbXgpRjYylRCSBnUwlnNhubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145818; c=relaxed/simple;
	bh=j7X72UG3ezrmkiAW5Ngu+qE+hQUZJPFdiDJOVTTPJts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/asbvEZlfROjhJmFMcBStBMqcBw/Q03bMP0qMq4DMvukujGloKA3Gkbez4q3nOhf9Mw5xsfim6sMLkeNa4EbHCm5rpmKsxzsLO1E7o8dL72sz2IgbowSyd3LuJNms0sMMvkbEpp5krD7uxlI3HZKdtC3sOfLWJ1IVYBYZyqFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV/+9XBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23D4C4CEC3;
	Mon, 28 Oct 2024 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145818;
	bh=j7X72UG3ezrmkiAW5Ngu+qE+hQUZJPFdiDJOVTTPJts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uV/+9XBIzKlP4Yvd7ktnNoQc7vy4X05BFIVM4VkxUi69TGuGmUNmXGgUZYkX3OYK1
	 mcdiw3quHX2gbViZWhEcd0SPBo+ougJFq099waAk/kmowLMCzQuYI+xkPTLl9Y1rtW
	 9hTGvV4yXTR5aDRvadz6Ph1BZWBY6wfb/R8PPC255vc/6xTcqIc4cI7ZPJTmNsb5KP
	 R84pCvyVTl3I8cCbxhF8sLLpsw9bXCMuTmlrw0MpAKRDS4QHbrGjMGP8Em6rlwnHm4
	 yzi5hS5qMCYhREAle2gdJgv20KqymjQrrsqDvyVg+hdQZaWJrcws7DrU6mXJX1g79S
	 bfnWuYSY3tVfg==
Date: Mon, 28 Oct 2024 13:03:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Gou Hao
 <gouhao@uniontech.com>, Mina Almasry <almasrymina@google.com>, Abhishek
 Chauhan <quic_abchauha@quicinc.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: Use str_yes_no() helper function
Message-ID: <20241028130336.3611b8ab@kernel.org>
In-Reply-To: <20241026152847.133885-3-thorsten.blum@linux.dev>
References: <20241026152847.133885-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 17:28:46 +0200 Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.

Same answer as for:
  net: sched: etf: Use str_on_off() helper function in etf_init()
Use of the common string helpers is subjective.
Please try to avoid targeting networking with such cleanups.
-- 
pw-bot: reject

