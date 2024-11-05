Return-Path: <netdev+bounces-141738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FB49BC27F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75E1B21AD5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0060E14287;
	Tue,  5 Nov 2024 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="immN2ZyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACC1CF8B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769973; cv=none; b=AhXURSivJNdlCjC0cuaBC/exQ2BbzfVUytT2JWyh5DHub/ig21uM0mVVMivmXN4eFN9yvyBFXeDdsPgj2WoCn5i01Vgnr1P2sfCYxTEeeor8L4wPRa5q1lchYWPu37ja/aW6PYOsE/mSVT4l3C27bA+Rsio0cRrHpLTLvFFC3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769973; c=relaxed/simple;
	bh=D/aPrIPdWVdOm1alMrBpn+mp3NIHAu1DU9vteHAHOyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2w1W3C3RftQXMnT1RDULbd7V+B6TBPmHQhxSI36QXgYpRuUrJqgUb4Zy8+6sq5yaCI9JRvjty1D6Do85ap98KBW6LhcecC56Zqb6SwOMOgteX1KBZAqH/afQslg8hGDhUyvHlwSIcWCz3ir8LTfjlLTqj8l+StOnJPpU6UUlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=immN2ZyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFA3C4CECE;
	Tue,  5 Nov 2024 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730769973;
	bh=D/aPrIPdWVdOm1alMrBpn+mp3NIHAu1DU9vteHAHOyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=immN2ZyPE5x/EGYxgUw7eJ06CkeIc+gb98NRxm+XTnVxRbChM+YiFfKWObsPdy+4Z
	 84Ed9bAxt+npFXTA2hspw/9amIHSHsPXGrjCAnGPctd5tvKJYU8CMzrp/190MlP3fI
	 Se55mUJboEQgorZItnkHpPdUTYKnfVmURkJgZCsDa8bm5DyJL4MhmfC2eUxPL7vPx2
	 uSxpimd2HpGr1B8TU42HYiZ/j+jcn6uBHdjIGvW9x/1ksH1RqijzYhsGhITfOS928n
	 aLTeoQNJaoEWJw4w3NCcGVnvGKd+mac37AsCxlnKve6wvhQms9chiLluN18/lwxlWQ
	 B/x9jDgpixFkA==
Date: Mon, 4 Nov 2024 17:26:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com, leonro@nvidia.com
Subject: Re: [PATCH 2/2] selftests: rtnetlink: add ipsec packet offload test
Message-ID: <20241104172612.6e5c1a14@kernel.org>
In-Reply-To: <20241104233315.3387982-1-wangfe@google.com>
References: <20241104233315.3387982-1-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 15:33:15 -0800 Feng Wang wrote:
> From: wangfe <wangfe@google.com>
> 
> Duplicating kci_test_ipsec_offload to create a packet offload test.
> Using the netdevsim as a device for testing ipsec packet mode.
> Test the XFRM commands for setting up IPsec hardware packet offloads,
> especially configuring the XFRM interface ID.

CI appears to not be on board:

# 26.29 [+0.07] RTNETLINK answers: Operation not supported
# 26.36 [+0.07] FAIL: ipsec_packet_offload can't create SA

https://netdev-3.bots.linux.dev/vmksft-net/results/846081/25-rtnetlink-sh/stdout

Maybe you need to add more options to tools/testing/selftests/net/config

But stepping back - I think it may be time to move the crypto tunnel
tests based on netdevsim to
tools/testing/selftests/drivers/net/netdevsim ? rtnetlink is our main
netlink family, likely half of all our tests could be called a
"rtnetlink test".
-- 
pw-bot: cr

