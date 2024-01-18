Return-Path: <netdev+bounces-64228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98919831D7F
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF7B1C2243A
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1852C1AA;
	Thu, 18 Jan 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrgG8Zhf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C22C1A2
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594912; cv=none; b=G5zgs5Acs7zB1VslRCBVe99K/muyrhBd+IfT2KXUO26vgsCNssbtAAFr8F+KvP+1hI76u3sy9Kt1Be94y/wiOUMy7lf/sV8zPd/eJoJBDtH6zpHDI4EqpQ5DaMBQ3D+D8BlyKYaUFsWMuyBTpj+ksg9A6SCfUYCbaE4wNvDc7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594912; c=relaxed/simple;
	bh=97g0l376Kv+TXTpj+CdU4cfEsPQZ2Rz1btM/w6hJawg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=Aowdmw9/7Jx2EbfPHPDnTy2eHQ46++0a3FfveNndGZgy2yxH/DF3ZlivVOvvDzfwXoO515hqMFOhw9Fw5Xe7ZMWEn/PMKreb1XlfYUZKvMLg89fBZVSoDuJe335jdkCX1be+INgtumtbf+3ytY8vO+9CazO8NTZfxL2oDXWxq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrgG8Zhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A2C43394;
	Thu, 18 Jan 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705594911;
	bh=97g0l376Kv+TXTpj+CdU4cfEsPQZ2Rz1btM/w6hJawg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UrgG8Zhfp6QZRJywHJTwzzdHEM3gEEECUl3Ki2iaAGq8WXBsDZalVKaVktj57uezs
	 QDwvPtwUq+k3TKpffxuSCyXPLgwhVo+WfAoZgC5A7pxrAO2B0/MZMbIBOTtOP34BCG
	 ozebQ9WKHxWHNqhfrY0/u3i9DnIy4UgD2JJjg8ym0wnqWRYrQ6rqodezMP745YFHtK
	 DPITQ6Qw6GzGV9OZyg9ueT7L3qlQ4I4ZLScZqWAJN1wo07Be5/bRdYKaG3BQzkgcJT
	 H+qdSKk/fw6b/uCEXLLVsCQc1ijiH0UgBcRXWZIAMlRNY2nGnUGFwrj5HFMoMY7EhC
	 WO/jJnkEIypOg==
Date: Thu, 18 Jan 2024 08:21:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 saeedm@nvidia.com
Subject: Re: [mlx5e] FYI dmesg is filled with
 mlx5e_page_release_fragmented.isra warnings in 6.6.12
Message-ID: <20240118082150.53a4d4b9@kernel.org>
In-Reply-To: <CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com>
References: <CAA85sZvvHtrpTQRqdaOx6gd55zPAVsqMYk_Lwh4Md5knTq7AyA@mail.gmail.com>
	<CAA85sZtZ9cL4g-SFSS-pTL11JocoOc4BAU7b4uj26MNckp41wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 16:27:13 +0100 Ian Kumlien wrote:
> > [ 1068.937977] WARNING: CPU: 0 PID: 0 at
> > include/net/page_pool/helpers.h:130
> > mlx5e_page_release_fragmented.isra.0+0x46/0x50 [mlx5_core]

Is this one time or repeating / reproducible?
What's the most recent kernel that did work?

