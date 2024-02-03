Return-Path: <netdev+bounces-68782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA128483D9
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CAC285FA6
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F9101E8;
	Sat,  3 Feb 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeIU5+/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B610796
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706936426; cv=none; b=HKde0P+ziueDEBYVTcJdObSGHfCWypieo4UMHHL3g2kR/1HIuIVz3f8AQjQ4Z6a38Nw6TbAnM5dfLuT+v7EtSDlBQs/M6XHV5IALkrME2FTbCt9sRPBVCNox/yOsNQmptDn+hOzK4W7l83E5UQpJwgWf1960l6xTfU1tGawA/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706936426; c=relaxed/simple;
	bh=V+kyw/Rj0tOHxmSxyNf0ufRGjrBLEGmnmQvTJ/RsAqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oN/VPOFRbyfHcBqnzVluaNDkYGOchlTGnsirsOqB9S2R8glnBuiAlRzvkuqR9eR9nUd1pFRifoK/4fp/GiKIEiyPlqzDmu2WdJcwONr0FG4YVvO+7a3u4IwFoMqwdsNj0lv838SXIKGqgmnJ9/NlgiZSlQxvtYzO7OlTyECC2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeIU5+/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BCBC433C7;
	Sat,  3 Feb 2024 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706936426;
	bh=V+kyw/Rj0tOHxmSxyNf0ufRGjrBLEGmnmQvTJ/RsAqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oeIU5+/lzrx+36YsAJxuSj7RkF8Bs0Mh0FyddmdvGg6gFyvmNgekFp5J06eX6cVDF
	 ngXwh18/2l4yQL1KbVMbJe4aueZrJCyVVA2pLnfRPJ/kdkVYL9PtG+BM4itbGtYr6e
	 shfluy/8d4GAPd1QA/3x6YfTJcdRRV/x+qe108jYD4hXp/GwAb9cM5zrsc5uSuEwKX
	 NE5xyclzSJOYLF7DYNigFcZv2yFllpBnezpQR3B/oULNTJJ8EVeepbF+uMLbZy3edO
	 ZdXOCKAHjRo2FC6M6e2lL8BPtSoLviDClkKPjZkDexrz+9r/S/D6gYXP5kBBZ9C55o
	 4yHMTnqZZ+nYw==
Date: Fri, 2 Feb 2024 21:00:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, pctammela@mojatatu.com
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
Message-ID: <20240202210025.555deef9@kernel.org>
In-Reply-To: <20240202020726.529170-1-victor@mojatatu.com>
References: <20240202020726.529170-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 23:07:26 -0300 Victor Nogueira wrote:
> Add 8 new mirred tdc tests that target mirred to block:
> 
> - Add mirred mirror to egress block action
> - Add mirred mirror to ingress block action
> - Add mirred redirect to egress block action
> - Add mirred redirect to ingress block action
> - Try to add mirred action with both dev and block
> - Try to add mirred action without specifying neither dev nor block
> - Replace mirred redirect to dev action with redirect to block
> - Replace mirred redirect to block action with mirror to dev

I think this breaks the TDC runner.
I'll toss it from patchwork, I can revive it when TDC is fixed (or you
tell me that I'm wrong).

