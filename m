Return-Path: <netdev+bounces-96217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD198C4A95
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECDB1F2200C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D603A29;
	Tue, 14 May 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G67QiM7R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804E566A
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647724; cv=none; b=p5ObBfAVNuIOsPSHj+BZYfkINrNOLweCbhISib0R6v03lB0c7uosJd0w/10NqrbXdR8cy3/6CFM7k7s0CUsmdDhOtevLgIkfKiHoUTn9Nd94Rx8UBMBn5vpLGwbMRWo/XxkpDG8/nmSdScQtzolL4RtDh5btO+EBo8Ammb/9Ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647724; c=relaxed/simple;
	bh=V2U6nNw5L4fYANS0TQZ+9nWP7TxAweemvbCzywi7Tak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow3JPDBJoEa+V6Bj/Z60xHMXlthF6IPcZylj9LFCRl8A0VAToEJcO8+MvbSDO8B+3bAL6RnnRZUUSXmHmpGJ64I3qEGWhozgUkXveYEWoDQOnN5kYgFbKeBlUo/terp2VO5F6TBem9ARGGAKs46cwNVsJ583pNUxKTvGJxBIjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G67QiM7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD934C113CC;
	Tue, 14 May 2024 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715647723;
	bh=V2U6nNw5L4fYANS0TQZ+9nWP7TxAweemvbCzywi7Tak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G67QiM7ROJwq/QUXaNlqUrSZPUdDWg4z6qwSClaL64LitR2IzpFmDOIRclwBQxUzB
	 OvUniW1FTxceDUM9cMpZ9BfHSxnsIsh+XeihLTIrcrbzcZgaJC3ALLy7BN4kNsK07L
	 fU4/ZuvtdF+7LIuunpGGO9LFo7eeJig8JnQgQdT79y5+lxkbbjLbP2p89RYL3OWMez
	 xYKGIXHBdImDYx+ptyfLkHd4AR9tpQkhtbSyQ1WixD3vLgxdOQ6bLcIdPZdMFmWt7m
	 nRoJzE83aP0dvl5s7tg3hlE24f23L+Eo+qZ7IUNgt0ZxDJ1//xQiVT5qDVsAMChGaG
	 C3CJSJtAqpeTA==
Date: Mon, 13 May 2024 17:48:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
 xiaochun.lu@bytedance.com
Subject: Re: [PATCH net-next v4 0/3] net: A lightweight zero-copy
 notification
Message-ID: <20240513174842.2af7d7f3@kernel.org>
In-Reply-To: <20240513211755.2751955-1-zijianzhang@bytedance.com>
References: <20240513211755.2751955-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 21:17:52 +0000 zijianzhang@bytedance.com wrote:
> Original title is "net: socket sendmsg MSG_ZEROCOPY_UARG". 
> 
> Original notification mechanism needs poll + recvmmsg which is not
> easy for applcations to accommodate. And, it also incurs unignorable
> overhead including extra system calls and usage of socket optmem.

Hi, as described in:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
we close the net-next tree for the duration of the merge window.
We will not be applying any -next patches for the next 2 weeks.

Feel free to continue posting new versions once you get feedback,
but please switch to posting as RFC.
-- 
pw-bot: defer

