Return-Path: <netdev+bounces-106741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580D9175F6
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 04:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30623284D06
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106214AB2;
	Wed, 26 Jun 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHM527+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DA12B87
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367273; cv=none; b=TYAEa5sFtVOxT4OmIiUstYnVGxHD3DJ8AhGbuUuyplE/1Xz5gO4OjcMTIhyk5uJa5krf43EU+7BcR3P6Dx1KA5h2vf3iipb9KifIuR9FanVQzeQT4A5UnvuCbupov/tG29MtIalCyrJVzPCaIj20wquMZK1UEF89+6WbySy6nQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367273; c=relaxed/simple;
	bh=phVP7I0A19NUiHL7SBz7lb250X0mxzQdgqdZ8ccuUpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czzK/CTVpRXvkUI9W3cZJh6Wy+R9CYC3aLxNKQSQ1+NlGNNyyHD9+bEKW4IbvoTzB+T+EHIK7cPoV5CXXsJIbthv3T1zgwDEbLRc4KH3pWkWhgNs1c2uogISG0ViLxXmhx3RCvTOi1+0igMyP3URwSWSoGyJNHcfGim6sD2vyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHM527+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC67C32781;
	Wed, 26 Jun 2024 02:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719367273;
	bh=phVP7I0A19NUiHL7SBz7lb250X0mxzQdgqdZ8ccuUpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHM527+kFw/e6lCFIFslKtAN2kBPE+B6F+TLftII+spFmL+xpvSpnSySQ5iYxOKgv
	 RvrZJCoZ8qlJzpuK8fK8HtWaimSLkWqi96KN2mzDjaPPEPrFFXuebYmqxVz5AUdIj4
	 G+0HnDMc1v/2Cd0ih0X3GILa2pyaKAtOoFe4tsetedPyrAMRIpjKEfwk0NlmC71b8T
	 9hhokH1MYeovEd/C7BPwYF+2+077o+bW2YLJaR9KWm6JjI5cumOKt/jB5hiGfDfly+
	 3PVk5C8gmyCA6tK7bWfFohFPfFvt7XLiS3ZJ4aAUW1NJ753Q63l79EoDtLRGPxBnAT
	 6kPtMgbo9BR3g==
Date: Tue, 25 Jun 2024 19:01:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <Rao.Shoaib@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
Message-ID: <20240625190111.629f0be4@kernel.org>
In-Reply-To: <20240626014555.86837-1-kuniyu@amazon.com>
References: <20240625174449.796bc9a0@kernel.org>
	<20240626014555.86837-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 18:45:55 -0700 Kuniyuki Iwashima wrote:
> We can use EXPECT_EQ() {} here, but for some test cases where TCP is
> buggy, I'd like to print the difference but let the test pass.
...
> I think we can convert it to EXPECT_EQ() {} in all places after
> fixing TCP side and removing tcp_incompliant{} uses in the test.

I see, makes sense

