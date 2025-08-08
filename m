Return-Path: <netdev+bounces-212286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87492B1EF14
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465E53B986A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A828853A;
	Fri,  8 Aug 2025 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVoUTQL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8617288508
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683076; cv=none; b=n4KVdXctdonrwnIxhL5PZvz7HX8K2ptW1Ajf/7KtSpG0q1QlMrFsvFPNtRUUDN9ln9Fr0XJJ2Y/7EgOMge6Kj6lyRLP77FsUX1jAg33YBLKScIrC7hQyQbr7s8dGQFWbMmS/b+/sQ+yDKhnZynLGWiqpZuz/25XqQNScqBFBpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683076; c=relaxed/simple;
	bh=8AYVxCrrkvw134gqGIu9c6umW6dNLI4SldjgR/jGTJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q60o50NS87z3L09gSFIn0O8bwubOiIldbDahUU/Wba4ZSxykWRPT/LOv9/Jsk/K5dIm0VM2CvzBIJV7X9A80CX8P7a/wjxgs6DlnwgT+NS4eW6nZERxLevjTZhXFQ1TE/PQ8xotCzL4MQr4rZwJhB6CNDiZIOnRog3VviGahHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVoUTQL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256F2C4CEED;
	Fri,  8 Aug 2025 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754683075;
	bh=8AYVxCrrkvw134gqGIu9c6umW6dNLI4SldjgR/jGTJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVoUTQL5cv349towlWp7qB9gcbf2YAOw24mU4efJM6EVuXmae44+7TB75t/cQJDfg
	 XqyYAk6fjOHM3TMJmwzttMpZ11CM6GudQb/kgisIcf0CwjqsxlGTAz6d95XpZRb1Iz
	 RgOJBqm7vvCQLoL5J1vUA34daxs9YPOlri7kY6+N8duLP+WLdpNFYNP8MTjRJik1D9
	 4NojIB1sf5PJV0Fsgz21gB9gZe5VS/TdlxqnhzYGrtaIZSJZP8R3/cFGQUgaxjuHu6
	 pJxdXZtUCKvK/fAXZL6swiymS9ZShRfvXTZMBRqo7tTEuc/zgJOJjzZU2Qhksa/Ycq
	 5C0sQRPT4JF8g==
Date: Fri, 8 Aug 2025 12:57:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 net] docs: Fix name for
 net.ipv4.udp_child_hash_entries
Message-ID: <20250808125754.1d550551@kernel.org>
In-Reply-To: <20250808185800.1189042-1-jordan@jrife.io>
References: <20250808185800.1189042-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Aug 2025 11:57:56 -0700 Jordan Rife wrote:
> udp_child_ehash_entries -> udp_child_hash_entries
> 
> v1 -> v2: Target net instead of net-next (Kuniyuki)

No need to repost, but please read thru:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

