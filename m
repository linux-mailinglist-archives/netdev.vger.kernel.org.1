Return-Path: <netdev+bounces-177640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45CEA70D0C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 23:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB42188567E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44F269CF8;
	Tue, 25 Mar 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCbSR3sR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEB1DEFD7;
	Tue, 25 Mar 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942342; cv=none; b=t/o9rRs0QaTtxaev8aaYEa+dVdfrlTttcor8Kkx+KX8PYvMCLY4Lx45Z7fbRzrSZ9K41oJtByeUBJZUl3IynLYQGogBi1cpST+n3ptUt21QhE4lNLa+jlU5qlzj3r0XnT106haS49b0GipD25Ej70WCJuPS6rCh06WwNItngohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942342; c=relaxed/simple;
	bh=G9lfEWhB2JRiF7U4Vv3TjEzycmaua9ALnVznQW3ur+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxluFcIM+lLG8bVhNVhAcois6KVYGfI7hPQFPxyhzANnibT5FjesdeCG9hh70FNjrWPUutlT/tVV6cCBBiN9CB0g54uEjeg7PEHWWsva4FURlx7C1XFcdw/iQtcVbh2x3whXJAFudFDEQ9blRGrxTYIHB1XbEaiZeUaEkBP9K6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCbSR3sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E34FC4CEE4;
	Tue, 25 Mar 2025 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742942342;
	bh=G9lfEWhB2JRiF7U4Vv3TjEzycmaua9ALnVznQW3ur+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCbSR3sRzL8lSDDNn20UVldP8pkWQ8y/BgXqjEMnGc5SQ5Ei8j6MxkgqDjAC+nRRw
	 lqYG/Zy138wzd/yKTVNwPvsfYDq9scitdfpjx4FqJDQCIU+KXQ1H3LST1jSx/CCa78
	 G9b6Yl2/R/Krt3Pk4ulFhudsc0ZnxKGjxpcFcCtH2GCrMic87eak/ldOLW7A4sPyuJ
	 p98gDlg1NdAF30a8N8mh+NRnj27Ce47aqWWOkJZOC8q9gCQETxfyBYs0Yfc/sGj4IV
	 t2c8YPJNuJifWqQsuYRM0Mv3lVmLSXEF+2eL/bUc4uYbkYu2Yic6pIm1RDCdTo5QG4
	 nMmbxO0GdHVxA==
Date: Tue, 25 Mar 2025 15:38:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jesper Dangaard
 Brouer <hawk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?=
 =?UTF-8?B?cmdlbnNlbg==?= <toke@toke.dk>
Subject: Re: [PATCH RFC net-next v1] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <20250325153854.4e3b6834@kernel.org>
In-Reply-To: <CAHS8izPTxxcQog3yA=wSyTn-B6jT2U3KsQDzYb4LDW546=uoDg@mail.gmail.com>
References: <20250309084118.3080950-1-almasrymina@google.com>
	<20250324065558.6b8854f1@kernel.org>
	<CAHS8izPTxxcQog3yA=wSyTn-B6jT2U3KsQDzYb4LDW546=uoDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 13:21:53 -0700 Mina Almasry wrote:
> > Why not in tools/testing? I thought selftest infra supported modules.  
> 
> You must be referring to TEST_GEN_MODS_DIR? Yes, that seems better. We
> don't use it in tools/testing/selftests/net but it is used in
> tool/testing/selftests/mm and page_frag_test.ko is a very similar
> example. I can put it in tools/testing/selftests/net/page_pool_bench
> or something like that.
> 
> Also I guess you're alluding that this benchmark should be a selftest
> as well, right? I can make it a selftest but probably for starters the
> test will run and output the perf data but will exit code 4 to skip,
> right? I'm not sure it is consistent enough to get pass/fail data from
> it. When I run it in my env it's mostly consistent but i'm not sure
> across evironments.

skip in KTAP is just pass + annotation.
I think we should be reporting pass + result.
I don't think a format for that has been chosen, so we can just pick
our own? :) We already use our own annotations like "# time=450ms"

Maybe report a "test case" for every datapoint we may want to track
and add "# perf=Xu" annotation, where X is the numeric result and u is
a unit (with an optional metric prefix)?

