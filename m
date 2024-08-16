Return-Path: <netdev+bounces-119167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263959546EE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16B51F22090
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E922198846;
	Fri, 16 Aug 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry/XhF5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935D197A95;
	Fri, 16 Aug 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805387; cv=none; b=OImqL7VZdQs8CcQcD4uOo8e3X8biTcg8dFLCF4ou7wMc7YPGZqnyV+NIPcfPwWVawSs8CpoEhEPJGZxWh3KL2JhKbXyJikbCyLJLGmAHzezC7BrW/T8B4W5Q40s23azi24VaxhfDUHS1eK9UAp0oxTnKT0dx1q3n9f+c8w9BA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805387; c=relaxed/simple;
	bh=Pnm7zjL8JHWRTp1+0UnuCc9iHbfO2yIHf39ihHwzyuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCvJLcN7fBLtJV5WTAamTyvJQQyE77GgJDa3dZ2jWRj96LqEf8k8WZHA+JUHg6EvSdyqsln/XU+THYSVsW6Ynx4UcSiaS9J5puVfL7J0O2mp+fSmQOiDJvjG8YeeMPYuWBcBTmRmyCk2pJotN8H610bTUCJJ1ODwK5gREhKPgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry/XhF5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F04C32782;
	Fri, 16 Aug 2024 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723805386;
	bh=Pnm7zjL8JHWRTp1+0UnuCc9iHbfO2yIHf39ihHwzyuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ry/XhF5YEphFAj+TQS0GYeABvTKPYZGaf693DZzQGmtH3bYolzy5cvbPElGwS4/tM
	 rq16ZV/ankWeDOZI3bAl2f1oa1qelU4czCGExRBUve5ScKHLiORDfKnodg3TPlhfsE
	 rNu/VMoE7p9pTM+NtmJLaURC2a9uCeEWYmQvbMMu90kp0OG5/kVl19jUsdaDRqZJOd
	 Py5MM09fBKz0UeTLW1jrq3nDn8EskLYJI8kfj1T0yQu0CaFw9VzM0dGwRULQqzDp9R
	 qXdrYSddQkmBMexeMm3jjHExL4YqKaVFo1DW6RQO2kBZL40Fd3Aq+WRDFI1lMpeYOB
	 dElFBtRbsrALw==
Date: Fri, 16 Aug 2024 11:49:41 +0100
From: Simon Horman <horms@kernel.org>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: remove redundant check in skb_shift()
Message-ID: <20240816104941.GQ632411@kernel.org>
References: <1723730983-22912-1-git-send-email-zhangchangzhong@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723730983-22912-1-git-send-email-zhangchangzhong@huawei.com>

On Thu, Aug 15, 2024 at 10:09:42PM +0800, Zhang Changzhong wrote:
> The check for '!to' is redundant here, since skb_can_coalesce() already
> contains this check.

It would be nice to mention here how this was found (e.g. found by
inspection, flagged by private static analysis tool, ...) and how it was
tested (e.g. compile tested only).

> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

