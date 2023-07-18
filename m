Return-Path: <netdev+bounces-18661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323877583AD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E101F28157F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97A15AC3;
	Tue, 18 Jul 2023 17:42:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E015AE3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815F7C433C8;
	Tue, 18 Jul 2023 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689702159;
	bh=OVM9xBSWB0lSPAQfi3kP38TgLm25jCFmquqGbvbUqpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PMqmTr1fr9B3xl6BvLreVfsrK78rkKMP/lrV1x5DCMuROkdvUGgUqFjm/9oXrDR2N
	 ELAFNjhHpSmPKolgsZdmb9dIwBtfnIoqbZ3YMV4znbYBu8OHvO3RfRpCp3nk34aehn
	 CBVjJbJ361i+UrhKeFoFBQ4Pl1/2Kzc8HQxIH9Gpz3HmLuaV6yunyCb/B2QQQAcde9
	 Qo+JPgN0UoEvjF5D3mFV95Bs+RuA1rJKUobEPb0ks3z3X1qf09fz1cJHPtff65bexj
	 rQjWrZY4J4mWqLz+S6aVH6/dlYlJgUijFrreSKLlur0VYNUJjIWpGfRfe8TbAcrVCC
	 87rtNBc2tedgQ==
Date: Tue, 18 Jul 2023 10:42:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hanyu001@208suo.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c59x: Add space around '='
Message-ID: <20230718104238.5125d4bb@kernel.org>
In-Reply-To: <304ca645a55aa0affe830bd36edaf24d@208suo.com>
References: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
	<304ca645a55aa0affe830bd36edaf24d@208suo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 11:27:10 +0800 hanyu001@208suo.com wrote:
> Fix checkpatch warnings:
> 
> ./drivers/net/ethernet/3com/3c59x.c:716: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)

Networking does not accept checkpatch-based coding style fixes as others
already pointed out. Plus your patches are broken (white space damaged),
and you sent 10 of them before waiting for any feedback, please stop.
-- 
pw-bot: reject

