Return-Path: <netdev+bounces-112540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685C939CF7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E872826F9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603F14B082;
	Tue, 23 Jul 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd2hNUmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E3DDDC
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724628; cv=none; b=mrz4HmCGE7kVE4fjFdGQ4GfwpJ6F47EgAW4UVXI1AYtnTlY+TRil+G/lXj9uMZjNptjdWH/aGtCWwog/C7+i7WCvzOl+QkznlBIXgUjdPO4a5ydiwX9/hgy3UfH6a5j6giD7TjBnPU+KjOao7R7TJyQbebszSfBV1pGvFfz5yXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724628; c=relaxed/simple;
	bh=EzKEIGdc3yENWF2CklU1q3Ha1YLMYdyjymVcc8dzLvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNQgeR/69lHetAmuBG3gRfUUFLh8CVH0T2uDplIMJOKb4KSBrVY9lC4N9xMXiSL14GHvau0McOAt9X0Wv+cON0xdy1jHn0Q6L9SqYJ5Ge7swqYrhX7tZrLn2uZQQbU83HzGpnAsoOBDjFZNhODwA1vCmakCoNgoZJmX4CUcle+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd2hNUmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A728EC4AF09;
	Tue, 23 Jul 2024 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721724627;
	bh=EzKEIGdc3yENWF2CklU1q3Ha1YLMYdyjymVcc8dzLvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qd2hNUmpei2iXjCv918onraofQdoV2If36//JsHnwmvDDAW8EL7wj09GO3c3vRojL
	 lmsUAdDw+/hpDMjkyqoNZTVv6ESSUJR3wmT83gDnUpQxhKJm3hi9AduGJirmtPFnWT
	 Zm97RYKrQAB/xSmtholeJyMmJkk+RXJC4QBxWkmtIgKz/8eJzRRWhCKVBGJ59ilNpO
	 oXRMGTl9VHioTUR3ujNTGW0Ww8Upj7m05xRte0SA7Z/3KbR1xOIEKh7NdjtyJRMIqc
	 mixhppBCyRsHCS8o3nqtLP16JuNxb6PMw3naJoD31wBtRK2vZ3jBWalqUuILs51ZZ7
	 ApazhzpgTOXuA==
Date: Tue, 23 Jul 2024 09:50:23 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] l2tp: Don't assign net->gen->ptr[] for
 pppol2tp_net_ops.
Message-ID: <20240723085023.GA24657@kernel.org>
References: <20240722191556.36224-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722191556.36224-1-kuniyu@amazon.com>

On Mon, Jul 22, 2024 at 12:15:56PM -0700, Kuniyuki Iwashima wrote:
> Commit fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and
> ppp parts") converted net->gen->ptr[pppol2tp_net_id] in l2tp_ppp.c to
> net->gen->ptr[l2tp_net_id] in l2tp_core.c.
> 
> Now the leftover wastes one entry of net->gen->ptr[] in each netns.
> 
> Let's avoid the unwanted allocation.
> 
> Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Hi Iwashima-san,

It looks like this problem is a resource overuse that has been present
since 2010. So I lean towards it being a clean-up for net-next rather than
a fix.

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

