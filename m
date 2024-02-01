Return-Path: <netdev+bounces-68118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB76845DD2
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CAA28DF74
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622575397;
	Thu,  1 Feb 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNUwkLYJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FB525A;
	Thu,  1 Feb 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806512; cv=none; b=tC4nON1Rt8WfuLgXxf6mzMpHj6iVA76yL5iU6TuDJRnRklgbZjAgDHTTipwZgh5zfMawhS1HPcnuKxPN1WweNtOLBC+Q9jaM5qj2VFrAowBMG4Io0oDbNf8iz9cscXniCdN/JkZnBH++cip0639qJlhMfE9qxB0q/9sgaMZAqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806512; c=relaxed/simple;
	bh=2TSUAbR0Gkq4REMDUEHDd31sCa1PB2ICZT8fSejooYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ua4aVdWsmpUi/3NipSO3uR/BgIlZOFPIzj6OK+gQD5BnMQPB3B4twWMr8y18rXr7qx1CwZBPPozhSkrtr2yCKSnBcZPpyRfAMkTwQR97tqAaEhTMN0FjT3UovGL2gkpRxXCY5z2LsiTBMQyCiScpPNe9dtLqDcPRl4/ceRSstxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNUwkLYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33004C433F1;
	Thu,  1 Feb 2024 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706806510;
	bh=2TSUAbR0Gkq4REMDUEHDd31sCa1PB2ICZT8fSejooYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNUwkLYJca8aJEfDnaKpoJcJ3/Hi/4yI02fK2ep9J/TOHlst49m0pvHWnLUvkED+G
	 HLBy6pZk94L/KF+jDDN/Jo0DdYEYBUtwLTVrpUZWdHxgRHYNVptzldQ1aHhdADRPua
	 U0uAjztRaVnFRHOLHb4UFQ4JYXa337UjfwjDMNwcCz1kQqKAI15XS6YZNg0svXYF3f
	 VtSX1YCt380QN899t7ZRjg9+uyl4qtTtYFzU9XDb5XS8st64RMCnLN9SccgD1nlcGq
	 7tNB6/gXK+WkyZ3lLgH6aifbOX6wNQk00t+TYYTNhWbdzczATwu0DdKFUBYe6qofyu
	 +oB2Y522iv7Tw==
Date: Thu, 1 Feb 2024 08:55:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, Andrew
 Morton <akpm@linux-foundation.org>, Mahesh Bandewar <maheshb@google.com>,
 weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, andrew@lunn.ch, leit@fb.com
Subject: Re: [PATCH] blackhole_dev: Fix buil warning
Message-ID: <20240201085509.40a0bb76@kernel.org>
In-Reply-To: <20240201133238.3089363-1-leitao@debian.org>
References: <20240201133238.3089363-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 05:32:37 -0800 Breno Leitao wrote:
> Subject: [PATCH] blackhole_dev: Fix buil warning

Since Jiri suggested a title fix I reckon we should be a bit more
specific, still. Imagine this title ending up in a quote or a Fixes
tag, could be many things.. How about:

  net: blackhole_dev: fix build warning for ethh set but not used

?

