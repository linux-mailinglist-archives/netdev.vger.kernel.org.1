Return-Path: <netdev+bounces-243887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8266CA9B43
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 01:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA353028FF4
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536D320A32;
	Sat,  6 Dec 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX/0bYJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F1862A
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980771; cv=none; b=DnFrhfyZZFRtDzu/slLAPKNmJN9v8gdbkznMJlPthYgVEBZkn0a1tvK0q1o0c3Aed3dAwjcJHrtz/KrbINQTA/06MQ4YEZfSCd8m8aMXiJiTLRmWpQNhLcBlB5DMqA/cRQ/F80D49Ri7STDglX3iFh7F9ZoVJ6qNxiBC0zQALEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980771; c=relaxed/simple;
	bh=HDkiTTdDro/uCFMb2K1P+c50E6kkwAfNk4xh3BVByO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxdggvdCRhiQ0KGCUwq2lqTyFXCIXxTYGRhDWuCcVr1rdST/RehrwJos5PecqXTOh9BC+OmtYfpoL6QczaBzdyF8pM5iQ1jJwglcTAwlVnGiysXOI73KXes4US4qgi4LML7Ji++RxiwyNWaJe8kdVBxwKCgA7Qm9ojKgtHD1iKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX/0bYJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7385FC4CEF1;
	Sat,  6 Dec 2025 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980771;
	bh=HDkiTTdDro/uCFMb2K1P+c50E6kkwAfNk4xh3BVByO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kX/0bYJ5YMMhwmVxWArRJSLco0YyjzurvzDlCzjpUKb/xtwIfE1kSWKLVBWlqD12y
	 Ej/k3DKi2Y7dteVBQs6Ro2aLMReFrq38dLlwmJE/bhJabFKApfZOlBu9Izy4ChJVju
	 mM23gp4rkK+J484T2lYyAiW9HZ++f5K5Vix1FHyesXv5WbKDbHD/96q/sVb0eAFdum
	 DGgOgrJ5xIJE5aIxf9cy4YZiBWkBilf5uyLXcuWWbJhXRrdskJ5RQpTYfeH1lKFdWP
	 dIDvBC4o+3hT4KyhsJi1+y9bvj/XP4yPYzsG8iMt8PfVDtUM1GKajF/3Fj1p01IGC6
	 FVIKG/RfkiU4Q==
Date: Fri, 5 Dec 2025 16:26:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [TEST] vxlan brige test flakiness
Message-ID: <20251205162610.40143536@kernel.org>
In-Reply-To: <87345oyizz.fsf@nvidia.com>
References: <20251203095055.3718f079@kernel.org>
	<87bjkexhhr.fsf@nvidia.com>
	<20251204104337.7edf0a31@kernel.org>
	<87345oyizz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 17:16:56 +0100 Petr Machata wrote:
> OK, cool.
> 
> I think the following patch would fix the issue. But I think it should
> be thematically split into two parts, the lib.sh fix needs its own
> explanation. Then there is a third patch to get rid of the
> now-unnecessary vx_wait() helper.
> 
> I think it makes sense to send it all as next material after you open it
> in January. But if the issue is super annoying, I can send the two-part
> fix now for net, and the cleanup in January for next.
> 
> Let me know what you prefer.

I think both the fix and the cleanup would be acceptable at this stage
of the merge window. But no strong preference, I queued up the diff you
shared as a local NIPA patch so we can see how it fares over the
weekend. And it will get auto-ejected when you post the real thing.

