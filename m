Return-Path: <netdev+bounces-107471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9091B1F0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EB1C21B5D
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043531A073B;
	Thu, 27 Jun 2024 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7y4IMsZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8519EEA9;
	Thu, 27 Jun 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525837; cv=none; b=cpT+r5MkzIeZ9JL9XQ7B9UG7Pw1kx+NugpFTY+1E1kI9NxxyQT1Rc2NSFJGoMjZ41VXqMgLxx/LpE6xc1+EBSqnbD/OUh+tkctuTbQydeJ4taa2LpOvsZUDqZnYRGu+BWypuaOdEhpUPzubsqQ6qwjikSJ2tVvTqrt0aR/bZy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525837; c=relaxed/simple;
	bh=RiFKoqVaODr62ak+BrlloaLP2+NvVq9fXgjAQ/mLJBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQenpgl6/fpOHBhc03ZNrWGdxLCqMo1KpZWeSJotn2H23ezu70iu3CHJ4JHeeGaDSd+cltY1VxGSDmqeTjBZtyHEDhMuovKiRGlpDKWa2Hqot9DVjsDRjqP78+ttpZVM7v9yTqyjox25zIlAWT1K8AfLPiq1ofaRgGdTm5ajvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7y4IMsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED92DC2BBFC;
	Thu, 27 Jun 2024 22:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719525837;
	bh=RiFKoqVaODr62ak+BrlloaLP2+NvVq9fXgjAQ/mLJBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X7y4IMsZJ4j8n65g/jptu+TXNl2QhY9PDj5zxAJinwgDrCae2TUFjXXKsJYYX1+9V
	 VWSRJQ9/gx6w26QhDSGvtT3NkSRdBNskZOTA3Qk1AijrB/virWfwlok22VCAY/Nvmg
	 pSroOmWzR31cv0Xu0HrE9J9xi+ABEQm24EsBrF4V2HTnJAzsbpLzd+3MHuqT/yYWdX
	 qxEoW3ZRhOfaqe6UlVb/N6sYD9anJoUXXWjSJ4j+4rzxr5sKIlL+Y4q1iS9SkCec/2
	 cCQmPIhXBotTPhLwI2niOQi+PmekjK/ynqDpUUtYLfnNKFuGGfYeX2LLQwwnySyjR7
	 8BV46ZD27VsQA==
Date: Thu, 27 Jun 2024 15:03:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next v2] net: core: Remove the dup_errno parameter
 in dev_prep_valid_name()
Message-ID: <20240627150355.023acba3@kernel.org>
In-Reply-To: <20240627134131.3018-1-yajun.deng@linux.dev>
References: <20240627134131.3018-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 21:41:31 +0800 Yajun Deng wrote:
> netdev_name_in_use() in dev_prep_valid_name() return -EEXIST makes
> more sense if it's not NULL, but dev_alloc_name() should keep the
> -ENFILE errno.
> 
> There are three callers to dev_prep_valid_name(), the dup_errno
> parameter is only for dev_alloc_name, it's not necessary for the other
> callers.
> 
> Remove the dup_errno parameter in dev_prep_valid_name() and add a
> conditional operator to dev_alloc_name(), replace -EEXIST with
> -ENFILE.

Let me be more direct this time - I like this code the way I wrote it.
Please leave it be.
-- 
pw-bot: reject

