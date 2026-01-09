Return-Path: <netdev+bounces-248573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CB2D0BC39
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D38A13007EFB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2273101A7;
	Fri,  9 Jan 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtxLUXRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3628134C;
	Fri,  9 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981145; cv=none; b=aGhsIqcL+qnqZL7SjatNPY2KKIDVjlGytDUlp0FpUqQpXArAXrnBCOzbL5nj7HK5JGuQomBwg0qKxKVZzSfzRvXCZd4O/1R81V3C9wlY/Zq8ZnhY09nQKqDAjSjqhGEwoUPETyyBKcqTDzqrFy17uGWNQccObXpPIJ5i+MhAmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981145; c=relaxed/simple;
	bh=/V2TszK+/q6htD1Z4tu5rO2qBmBu1NQ0VZJKwhNsTmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7lI+jcjWeMGcQAdVgl0Qg0IBxFvmvjv00rXX7Uk4S9dPY5oUmJ5V8EP8XJBIUwzTde9CqY2WetQseiRd5nsdmYvm0bwlZBXitBqzA8TYOPa6Cc45OLIsVHoA9mgx/Jfn5s2QyBM2s3LfS6QRGGCG0PIwQq3gKYTdYNw5u169OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtxLUXRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18AC4CEF1;
	Fri,  9 Jan 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767981144;
	bh=/V2TszK+/q6htD1Z4tu5rO2qBmBu1NQ0VZJKwhNsTmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtxLUXRVPX2k0HIFYf1/GFory8oKActYaR2W1D0zdgZSlFpgG1WPiEOsMy0M0mu0b
	 0KmOU/2k73QjKyggamZS4F7ynHeiTk73bVe3+pLwtUrxcFN9ieOEaB7jmYjyL+TnIo
	 bvYCVViFY1r6oZjnjugZJRoOffF7xxZpzrv6em74xWMlqgG44psMn+AYww/i6GlXsS
	 pPWkj4gDORnhkZ2Mh8Ag7b0ARzv1J3vAZuvXHZDKahw/CKY9JD1XEqHTseubuNOTbd
	 rAfHtV/KoAFj60oy/svKWqDW5vD2EQkECkBII/1unN3teTu27Qgaz+esDKfowP87SE
	 sxHK0SqhvNJvw==
Date: Fri, 9 Jan 2026 17:52:20 +0000
From: Simon Horman <horms@kernel.org>
To: Chen Zhen <chenzhen126@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, huyizhen2@huawei.com,
	gaoxingwang1@huawei.com
Subject: Re: [PATCH v2 net 2/2] selftests: vlan: add test for turn on hw
 offload with reorder_hdr off
Message-ID: <20260109175220.GM345651@kernel.org>
References: <20260107033423.1885071-1-chenzhen126@huawei.com>
 <20260107033423.1885071-3-chenzhen126@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107033423.1885071-3-chenzhen126@huawei.com>

On Wed, Jan 07, 2026 at 11:34:23AM +0800, Chen Zhen wrote:
> If vlan dev was created with reorder_hdr off and hw offload both
> off but up with hw offload on, it will trigger a skb_panic bug in
> vlan_dev_hard_header().
> 
> Add a test to automatically catch re-occurrence of the issue.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Chen Zhen <chenzhen126@huawei.com>

Shellcheck warns that cleanup is never invoked.

  SC2329 (info): This function is never invoked. Check usage (or ignored if invoked indirectly).

But is only true if only direct invocations are taken into
account (which I assume is what shellcheck does).
cleanup is actually called on exit as it has been
registered to do so by trap.

In order to keep shellcheck quiet I'd recommend adding the following
to vlan_hw_offload.sh.

#shellcheck disable=SC2329

...

