Return-Path: <netdev+bounces-177195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A3A6E39C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05022188B9CE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0918C035;
	Mon, 24 Mar 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcIXK+c8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB91F9E6
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844761; cv=none; b=fXrMsKjubNIrhX7+l/teO4NJMcyqnVEOvQD5ZRqH3c0HKHsWdF+gnymaKrWpUaBcLmQQWU9ouVSuCpLpx46080nsZOVT/ULETU3yvveRUirafuDD2WpL9xImSQAXL2wlg3uSbo0SN8kZUwx/1tOiTHgfO1A9Noic70jNY9cKs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844761; c=relaxed/simple;
	bh=SIbMNdtCJCZTPRSi9pXJdiNxHn1Chf/8Dk6ZJXUaAxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9K6hfzMJNySCPvXyZKFCgP3hBUTR94n1t1/NttbYdQwxZqZBzOJGizXOhJr+3HlCHY5ftlf8rn+wl8gNDQFgZkCM2d3qGPbq/sATyk0YNuZBV9z2pb7eGlMbTq2mt1ZLMrfakJC9uDLAclc54vxUTN47a6Doo+Qyu1ERcIXuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcIXK+c8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCE7C4CEE4;
	Mon, 24 Mar 2025 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844760;
	bh=SIbMNdtCJCZTPRSi9pXJdiNxHn1Chf/8Dk6ZJXUaAxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcIXK+c84a/L8OFS1rBU4DNhgll3qIE926lX7XOQ5TOfN971Zky+yCcMO7W8qB+G5
	 zVW/H8cayom1WdJjblO6eqXVbqayoevlAvgUREv6LLLxx8GpTmF6A7qtpu73QIa/3t
	 eYez6FsKqQ2mqhKdP+Y7a6NGpeYHtibE6lsuXxY2K8MUkc4oc3niKJCTeLK4HzwxwK
	 luat7CmK+RD7bepG84ruQA1feZ82BhMWjQGa09sPObiu4BxX9StMvlzIOlvXUQ1TMp
	 aW1ep3Ne+8P1+HR+27pYZi8cIBHbvJJAnWrb3/35rrY2YezQzK6KtkQrL+/wdz5u8b
	 rGHMf7iLRLcdg==
Date: Mon, 24 Mar 2025 19:32:36 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 4/6] net: libwx: Add msg task func
Message-ID: <20250324193236.GP892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <E83A0B680983DFA1+20250324020033.36225-5-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E83A0B680983DFA1+20250324020033.36225-5-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:31AM +0800, Mengyuan Lou wrote:
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Reviewed-by: Simon Horman <horms@kernel.org>


