Return-Path: <netdev+bounces-213136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBDB23D74
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD891AA2A4C
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B54C92;
	Wed, 13 Aug 2025 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXQ7wQDw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD92C0F87
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046977; cv=none; b=NkILIcSaQiqs1KscNkbSbDeglSf+iTK6ObpLJx4zzT5imKTbR99Pb1JbYyofGZhSSOAy+uxmku8NVKFM+0OXH7UCcDQGBDfZ+Jx/8b7WvuJCQC4/rEdMPLyBJ8gYip/mPyuGQVTsBw4QQbceiVwVhhzzraG9uJw30IkRKmRBNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046977; c=relaxed/simple;
	bh=DsxZ6UWm+jDFLWQ0jYAOmouMrSk5jUvEHCGgvHwGTnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIFMLaQ1h2RpdEbi45D4zdkDrNwYoUUjac/jp3JpLYHxlCLfHprZ2+iAHNnG+bWwgMzn6STufIpX/dcPphmsaXHFm0Bv/ducI0ggJjSwV931rpcYiTeoZcxTxD7STMR0gldggVuJ6AHU6m8SAq3H1Ap5Y0ki5TsZhYp3sfPw3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXQ7wQDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B53C4CEF1;
	Wed, 13 Aug 2025 01:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755046977;
	bh=DsxZ6UWm+jDFLWQ0jYAOmouMrSk5jUvEHCGgvHwGTnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXQ7wQDw6CWKRhdzixjwoWRx6MMb+9kSnkvmJla6XhDG39VZ95RAUqc7giWUgBWsU
	 8rzk+z326d4UxDUB5mFFMBJ3IIyE6m8vtwRcbGAsgyH0gA1ju4JVyzZxKY9jClVtWL
	 XxoLrTHCJgzRpf35Es6zVlz3YKBtJp2pkyZCZMJ/Mdp1tzvcx5XJYL+Oz5CHvIKcPU
	 BnStcRsSJ9I31h0I5oj7XhnzpSPZWUvU49k+sY56ahO2/FPQEWt5iMSMEMoyq+oK0h
	 +rar3CVizqPevNZziommxvWRBKXpsKc2LdWV08dt0daepOWJkan6ER1RAaOKO2y/ZO
	 gF1/Qe5ZDGfiA==
Date: Tue, 12 Aug 2025 18:02:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/4] selftest: af_unix: Add -Wall and
 -Wflex-array-member-not-at-end to CFLAGS.
Message-ID: <20250812180256.712d316b@kernel.org>
In-Reply-To: <20250811215432.3379570-2-kuniyu@google.com>
References: <20250811215432.3379570-1-kuniyu@google.com>
	<20250811215432.3379570-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 21:53:04 +0000 Kuniyuki Iwashima wrote:
> -Wall and -Wflex-array-member-not-at-end caught some warnings that
> will be fixed in later patches.

Makes sense to enable the warnings first when writing the patches,
but I think we should commit in the opposite order. Fixes fix then
arm the warnings. I'll reorder when applying.

