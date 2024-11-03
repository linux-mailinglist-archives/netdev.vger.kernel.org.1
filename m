Return-Path: <netdev+bounces-141373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF549BA991
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44722B21C77
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375118C03C;
	Sun,  3 Nov 2024 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUhznkXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D94EB50;
	Sun,  3 Nov 2024 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730676438; cv=none; b=XfI9saRWw1oJsS0ZsEqhuq9TloToBMdmoWtSnO8ZxEvWbps14lKdZKyyTptKpJpiIlR8p5Ku7/lvQztJ+AryILmQ9oxP+snamknVhupcpjtx+wGPLLHQvRIpnJRqWcXxm2aGJplWg+ehSVtbIkKMaIeA67/X3LTmqMANFPzc/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730676438; c=relaxed/simple;
	bh=wt+FldWry9wbyga6C1VwZXY85WcEzfOC6Hjy3SqssWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+Qtk9YyX4LM5O8iWNDsns71hXUThuX1L+eII3QCCiZ+J0lUf1U7Iyw+KkzQSQmUidPXTvfvNfxERwoaP0ElCX8YxN1qqpNaZb7S9IAb4/P9p67wxUHU75OSbbiPww4b+ZshKvnNiderYD2JjQE2tJaOeq0mqcAJgs4tOj+p7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUhznkXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E30FC4CECD;
	Sun,  3 Nov 2024 23:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730676436;
	bh=wt+FldWry9wbyga6C1VwZXY85WcEzfOC6Hjy3SqssWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tUhznkXhYItpCpTkpXpmAUONBKMe0TjlonzQt0Qn5aFX5Udf3nrCCkMcsLdurEE2z
	 4eKwFgf5FCmiD89oT/aLdD3X32D1FY6oJ6OeeKBu38xJBR8v6nR3M73eb4C98laNUL
	 tp94Xp276xN1nk7EJMv5N0XUK8XTxLiDMdYM2A/817tOE8nUSWeQD4LXCOxfhuYRsX
	 pF20196n9azVrUeC8Vs7GnTMIdg2iYQbMxYzcRjwfOsRJ/+rGWya8Ovew4SMFBXNJH
	 R14kKrIPhsA6wQX1B900U3hW8aTFWln6S4byAcdJAZzajmR+scEC43hRudNuD55aYw
	 S4M17ou6sH8WA==
Date: Sun, 3 Nov 2024 15:27:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, lixiaoyan@google.com, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH RESEND net-next] net: tcp: replace the document for
 "lsndtime" in tcp_sock
Message-ID: <20241103152715.498aae63@kernel.org>
In-Reply-To: <20241030113108.2277758-1-dongml2@chinatelecom.cn>
References: <20241030113108.2277758-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 19:31:08 +0800 Menglong Dong wrote:
> Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")

Fixes is for bug fixes. Please drop the fixes tag and add a normal text
reference like:

Commit d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
moved the fields around and misplaced the documentation for "lsndtime".
-- 
pw-bot: cr

