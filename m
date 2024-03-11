Return-Path: <netdev+bounces-79322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C6878B79
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 00:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45AC1F21F46
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679959170;
	Mon, 11 Mar 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuTpSnOj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE459168;
	Mon, 11 Mar 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199273; cv=none; b=tA8is4EC7CKCQtuIIJwIAdP0BYPoiAucpr+EBw3Yl4iRNOP3o8PKLya7NeFtDIw1JJpBuje7qHWK2MBWYZcfzAolIJs+W9bM2YNk9rDGlfmVmcxa1nYfBgaGXSqZxffnlQbu6aSUVYK/yPT1VjEW9ZXiEfNIaeXaGh68xyNUSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199273; c=relaxed/simple;
	bh=XPimoA/KY43IGicBOhobqeqOF4qVaAB057YdtvyGzxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzQkMaKV8Isb9K9ZS2uGQroxmKSDL0IJf1AoZq/cl9myl5aobduMgwfYT2G3FIPWnemibc8yovTWkKD1fRzZN6OaBdCaXJ+ByGwNF5C84PnycNxnfb+8ui+TrhvxQu8JLRXBZoIRF1c9Zs3p52jMfOUtp3+d7bYuGHM26lmsVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuTpSnOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ABAC433C7;
	Mon, 11 Mar 2024 23:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199273;
	bh=XPimoA/KY43IGicBOhobqeqOF4qVaAB057YdtvyGzxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uuTpSnOjG+wTQWRXmZ4HEA7JLb7EDuE3wONM8d9HJ6dFrXd1FCVZnJwYOyWEtbEUn
	 GWd53CAXHEfb+qy5nmy6wE0c3LOYGg8U/z7xPiLHPDaEG5ziYOUvX22dY5TZf4ewBy
	 R9Mi9iZnsXJNoo7SskMWlw6aCkmb8YLGS98cROYQ22XZiXTZ+9bH0/uvrb6KDV47x7
	 0bWF6wXvsf1H/YShwK1W6ARriFOQNXzeKV32DDHdbqyVahzEZu8aNKcGL7zfKtynZH
	 yrnrO0d8egVdHXhWrILE/w5/fqu8pqWku8Sp5lUpG+dtem940xO5CzIJGUiz61ffKS
	 iHMsbZwQtmlAw==
Date: Mon, 11 Mar 2024 16:21:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
Message-ID: <20240311162112.2e421c9f@kernel.org>
In-Reply-To: <20240310121406.17422-1-kerneljasonxing@gmail.com>
References: <20240310121406.17422-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Mar 2024 20:14:03 +0800 Jason Xing wrote:
> Using the macro for other tracepoints use to be more concise.
> No functional change.

The merge window for 6.9 has started and we try not to apply patches 
to net-next during the merge window. Please repost in 2 weeks, once
Linus has tagged v6.9-rc1.
-- 
pw-bot: defer

