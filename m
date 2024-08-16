Return-Path: <netdev+bounces-119074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6F7953F71
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067891F22E74
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2129D06;
	Fri, 16 Aug 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnVbxBhl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2B1EA91
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774741; cv=none; b=Rqp0T1dJKXQNMyg0seXBdwU/ucVeATYefr3q2Nt/8gHfKjdI4T6aeGF8v+Vxcan+DEEmDXexXZ/OBoSobjdQA7So1Z/tvAWGh+su/nkHOz/9AC3ohyJjspRJzGpVzH1ZcLE9JAMFh1FkWEQEpqBopD3WIa9TIGTLuuXszZclOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774741; c=relaxed/simple;
	bh=YFjMrSXgCN1nVlCX2RdbDkJgwz9xaYyB7ptYGJEgBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNZGdf6tu0uigFC4Q/+esrLGHHE7be6Be8u9nWQp0v9f12sysFoCY9XYH0VPXqXTerN2ROXn969YTggFR6Y1IkcnlO3E2RwyWxLn6HeDlJaaCEcoNVCd6WG8n/zMr5N7u58lKEwFblwv2w3OPKi8wKwAvGMH/ka0BU8ZvddKdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnVbxBhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD7FC32786;
	Fri, 16 Aug 2024 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774740;
	bh=YFjMrSXgCN1nVlCX2RdbDkJgwz9xaYyB7ptYGJEgBBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnVbxBhlHhCib4vxgdSK0r6ibZEZth5rJOkvLAw79jUKmnC8x8EoHqD2c5m2nyxcJ
	 J7YI0nP6HDPbqJB3ZPiNSx7fivo+jSC6BfynP4RqJGVnxY4vktSDcP5bwFQMsZR9A6
	 iW1tvImuubBkxxtMcBjoyXy2yhbfwoN4WCT0Rlh79s2jlU7eTn6Gi0OU8mg2CXxgpZ
	 v4JK7tMM/GgZ3TzXukoTpUm/Ye+/ktbgEPimSDB80D7GCnNNVF80RKkKGA3dig/Amh
	 OgMt/65Qyefsf/RUFlCAmIZwBoZKYMwGsa5Fr75zRsb17T5r3lprcLgDTQxv8pxYXv
	 g8xLYRNZki4qQ==
Date: Thu, 15 Aug 2024 19:18:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, joshua.a.hay@intel.com,
 michal.kubiak@intel.com, nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: Re: [PATCH net-next 0/9][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
Message-ID: <20240815191859.13a2dfa8@kernel.org>
In-Reply-To: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 10:32:57 -0700 Tony Nguyen wrote:
> Alexander Lobakin says:
> 
> XDP for idpf is currently 5 chapters:
> * convert Rx to libeth;
> * convert Tx completion and stats to libeth (this);
> * generic XDP and XSk code changes;
> * actual XDP for idpf via libeth_xdp;
> * XSk for idpf (^).
> 
> Part II does the following:
> * introduces generic libeth per-queue stats infra;
> * adds generic libeth Tx completion routines;
> * converts idpf to use generic libeth Tx comp routines;
> * fixes Tx queue timeouts and robustifies Tx completion in general;
> * fixes Tx event/descriptor flushes (writebacks);
> * fully switches idpf per-queue stats to libeth.
> 
> Most idpf patches again remove more lines than adds.
> The perf difference is not visible by eye in common scenarios, but
> the stats are now more complete and reliable, and also survive
> ifups-ifdowns.

I'm tossing this.

Eric and Paolo are mostly AFK this month, I'm struggling to keep up
and instead of helping review stuff you pile patches. That's not right.
-- 
pw-bot: defer

