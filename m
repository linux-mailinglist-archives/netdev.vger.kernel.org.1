Return-Path: <netdev+bounces-190811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFAAB8F0F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4886FA02BD6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801225CC6F;
	Thu, 15 May 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pixRz9KE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317E25CC6D
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333458; cv=none; b=RmW1NqAe5mAD1pXGyuDeanVNF4+danQeLemozXBsaydzryQO7gi3ImDfgtjW10XHIu+04EDTQ9rFIUUQldJtWXC4RIuUCkqEW1xV2nWmcHF0P9AxBD+mT/wJhz0fm2/wxBgZJCidr3Zmsv/mkAclAUh0vnlMJO+btph/ZHWo3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333458; c=relaxed/simple;
	bh=2+mFgRNfvFNsag+4HEJev9dtnK53JAW3qxKoYAtaCcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaYJ9bVNW9GLUs4wzIY2my70V3RMgFjRx1FoKjVx8yLJdSg/7mN8BBnHzL+5ayjIfDZ32NJ+hnt16ftV9jgQcOQ7aCh8qCCUtvMJfEtG6pVfgWBE1yHp7EBdy3cp2fhp0AWFj3uBgYWX9fGlv9bSJLotj2Zgz5q1tXr8aKJHlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pixRz9KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7233C2BCB3;
	Thu, 15 May 2025 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747333457;
	bh=2+mFgRNfvFNsag+4HEJev9dtnK53JAW3qxKoYAtaCcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pixRz9KE9265Hdihpv8ums0GOuHBPjc5H2hkdS8mcLuq4uvyL0CKm3qIXTORfJiNc
	 29P93HcBcIWPwo1904ARtyTPOoG4QT+pxWICTyC3SOvlqUDFS46JSQssheiESdxXod
	 JhzHWV0oK93lJ4E0a+3na3kUOVf/6j8QVuZA1Rqyy2beiWDWYiH6L38snhu1Yu2ZyT
	 AA7jfy0HVZperaYeU32jBHtBRMHRFtob2mTBH2ehWtaQxbqJ3zZlWXUzOHKTBiKJxN
	 /CM/P2VFHs5pnyIJsNwN0T9F5EopIXh/g3hc/7T6TNR0VvcCHv1Rk2XyG4MaaCoLCT
	 9LSGzP+utAj/g==
Date: Thu, 15 May 2025 19:24:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net-next] net: sched: uapi: add more sanely named
 duplicate defines
Message-ID: <20250515182413.GX3339421@horms.kernel.org>
References: <20250513221752.843102-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513221752.843102-1-kuba@kernel.org>

On Tue, May 13, 2025 at 03:17:52PM -0700, Jakub Kicinski wrote:
> The TCA_FLOWER_KEY_CFM enum has a UNSPEC and MAX with _OPT
> in the name, but the real attributes don't. Add a MAX that
> more reasonably matches the attrs.
> 
> The PAD in TCA_TAPRIO is the only attr which doesn't have
> _ATTR in it, perhaps signifying that it's not a real attr?
> If so interesting idea in abstract but it makes codegen painful.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


