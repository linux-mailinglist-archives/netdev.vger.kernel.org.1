Return-Path: <netdev+bounces-68299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4B846710
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 05:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1244A28B5E9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A38EAFB;
	Fri,  2 Feb 2024 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPLvGV7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E8FBF2;
	Fri,  2 Feb 2024 04:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849104; cv=none; b=QhmsDb76Iul8xcSK+4fgbK/8dhd0BqmNP7AfbyLXIwuDlxZ/LavlIwgmpn0NoKc/Jwmg+U2ZKv9DitywBnntlorylhiaz9YkcUSf0/AHFGNj/jo/4K2GCimQTieCAdIH9A7q8RHqYEOtqqSRGRx4eBW+Abf7Pmid/PIzt9wc34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849104; c=relaxed/simple;
	bh=u4J5s1U9NIplgVd/BG+PSy8kpo0VLHq5aR55HiViwTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/+pThCaNvZdLTBNg6Gu4zyafe4bvGdBnnSq1orJ2c1zuxiAGO/2kWbTVX0/EKBKXRvTFkvHO09IOK7SWybIlVlIdjYvBiXRCW5PvIcx/gJCLJUOnHVmSYK76+byGswgHWWH7Hjb5Z9p0JOpjgYrC2FO/O9kNq7BG079gr1Fy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPLvGV7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113FBC433C7;
	Fri,  2 Feb 2024 04:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706849104;
	bh=u4J5s1U9NIplgVd/BG+PSy8kpo0VLHq5aR55HiViwTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPLvGV7Zspu6Se3TI/IT6SOlX+S0dXTtB0N85HRzb5bRQGFOfDt7cbwjwSq0Dp9vB
	 gLfrUOvwjmWEG76j0g7uahl+2onR6zUAy1/uegKpY8nIHQ+eZXxXW6dxHSpnPW75iU
	 XqR4kBDhhhUyW0+ub+xd/QA7Nq3NyOMpyWmuQyFH5BJgtWNS0X+41qFui1YFIMIGZF
	 VkD3cckzLRSwJO45Lv6MK483+d2DVZ3FvxMk2A5nvQLZbWPXiEyRaI3JAtvLU3DN/6
	 F9+azDCQvEIrdse5V585gaTw+8tFuMA1iee174rvBrtsjhIqrAVRvY3SW7P9tgCYB4
	 yGiwohY31aRAw==
Date: Thu, 1 Feb 2024 20:44:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com,
 netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux.dev, rostedt@goodmis.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 0/5] net: switchdev: Tracepoints
Message-ID: <20240201204459.60fea698@kernel.org>
In-Reply-To: <20240130201937.1897766-1-tobias@waldekranz.com>
References: <20240130201937.1897766-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 21:19:32 +0100 Tobias Waldekranz wrote:
> This series starts off (1-2/5) by creating stringifiers for common
> switchdev objects. This will primarily be used by the tracepoints for
> decoding switchdev notifications, but drivers could also make use of
> them to provide richer debug/error messages.
> 
> Then follows two refactoring commits (3-4/5), with no (intended)
> functional changes:
> 
> - 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
>        function to make it easy to trace all of these.
> 
> - 4/5: Instead of using a different format for deferred items, reuse
>        the existing notification structures when enqueuing. This lets
>        us share a bit more code, and it unifies the data presented by
>        the tracepoints.
> 
> Finally, add the tracepoints.

Is there any risk with conflicting with the fixes which are getting
worked on in parallel? Sorry for not investigating myself, ENOTIME.

> v1 -> v2:
> 
> - Fixup kernel-doc comment for switchdev_call_replay
> 
> I know that there are still some warnings issued by checkpatch, but
> I'm not sure how to work around them, given the nature of the mapper
> macros. Please advise.

It's a known problem, don't worry about those.

