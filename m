Return-Path: <netdev+bounces-110079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FA792AE86
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B4A1F22F89
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D866A8DB;
	Tue,  9 Jul 2024 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQiDMCAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7A57CB5
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495100; cv=none; b=RCkEhIDj0603s0fecf/7nJhsbRSptjIWWNxOZENSsde9Sm7m2ZZgiQebf8IOQnlUk72c0y+mDO3679dH31br4oauM8QYKy60Q4/IVdaTQ0nEGr/ZFiiqPxb0VbNiBfZEZk2Gpd0/dvSQepK4gL0RLCG+j3G2ruMNqYWSIBWgaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495100; c=relaxed/simple;
	bh=SH6cp9Qs/YW5nb7+V8tRq/dWuhwfjOtvFnrXlR9rNr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeOsezZ741neGHQJg9+o0OXbSiSC8YNzlroNi3CAj7jD/2eptnm01B2l0Mxptn7PJ7i6YGBKTTR3+zwlqQ9GyxijfQPQUXDnznP5gPz13q1HT1CNWdWvzycZ0xogccNHL1wY1KmukVN1vnDIcOX7UlSi+RqQk9uzSidzwZ13/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQiDMCAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E31BC116B1;
	Tue,  9 Jul 2024 03:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720495099;
	bh=SH6cp9Qs/YW5nb7+V8tRq/dWuhwfjOtvFnrXlR9rNr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQiDMCAMABFDjgq2NXz9zckgMHQQD+zsDaYZixJpoWXcM33nP5jC574UoZtH+rdeO
	 BVNVIpR9rJ/TT3Rd3w/XschGLHVurXCoLUiqJl43BV/9TtYmiVf44hztep05s6oSUn
	 Sa7DyrtRysBhtSKSCM/JhHxvwAczF3krbW+FChldIp03bLyzQdFL6RDbdsmKq4X20a
	 lsfleaWzQ+Cvue9vD5hZt9MPIzPOFjbLpysu1BzhCHY7h685vVP9HdxqzTWvydvHDv
	 CGh6GMlUQCoUqQwjg2KRMkvRvdxCeiorhEIEybtW4uHRVY0Tge48xUih7b6dwfW5Bi
	 PQlbovzRrP8LA==
Date: Mon, 8 Jul 2024 20:18:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com
Subject: Re: [PATCH net-next] net: tn40xx: add per queue netdev-genl stats
 support
Message-ID: <20240708201818.53eb0f61@kernel.org>
In-Reply-To: <20240706064324.137574-1-fujita.tomonori@gmail.com>
References: <20240706064324.137574-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jul 2024 15:43:24 +0900 FUJITA Tomonori wrote:
> Add support for the netdev-genl per queue stats API.
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> --dump qstats-get --json '{"scope":"queue"}'
> [{'ifindex': 4,
>   'queue-id': 0,
>   'queue-type': 'rx',
>   'rx-alloc-fail': 0,
>   'rx-bytes': 266613,
>   'rx-packets': 3325},
>  {'ifindex': 4,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 142823367,
>   'tx-packets': 2387}]
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

