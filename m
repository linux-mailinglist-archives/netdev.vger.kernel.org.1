Return-Path: <netdev+bounces-26604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C71778547
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9394E1C20F1C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23387A2D;
	Fri, 11 Aug 2023 02:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5917F1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A75BC433C8;
	Fri, 11 Aug 2023 02:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691720243;
	bh=ogJZg0zRDQxUzCYcgWZSjvsQRNJ2oocP7rCaRKEpELs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCdFklMPxviu2JRhZzcM7lynnvUnHIEC7FHy4RjT9Es1K45PKwhqEiMEJctY1j5ea
	 axoH8Vc7LhXE4B4Y+IHRgGQY6brluY4pDfcOlC3fHYK6x4GrjhKLpX3qqBShTkRQp/
	 WgqgBpq557OG9AiHn6fFs414kuKs/8sR6CVK6q3VG3HR5gd42bgahRTZRqNpfRUJq0
	 /ijXmBXZhLf7wb+nazent1+dEzkWnR9XO5LBn89uimE8F76Le9epRVnEjN1fXzZ28k
	 QudHuj7YVJsrUVImtzepneNcpVeNo5cF+g7MH1klkXzlYBrPzlW7FngB/sVJV15CzP
	 i8GZxg3a6rziQ==
Date: Thu, 10 Aug 2023 19:17:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v3 10/13] devlink: allow user to narrow
 per-instance dumps by passing handle attrs
Message-ID: <20230810191722.7c19f190@kernel.org>
In-Reply-To: <20230810131539.1602299-11-jiri@resnulli.us>
References: <20230810131539.1602299-1-jiri@resnulli.us>
	<20230810131539.1602299-11-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 15:15:36 +0200 Jiri Pirko wrote:
> +	struct nlattr **attrs = info->attrs;
> +	int flags = NLM_F_MULTI;
> +
> +	if (attrs)
> +		flags |= NLM_F_DUMP_FILTERED;

Are attrs NULL if user passed no TLVs?
TBH I'm not sure how valuable NLM_F_DUMP_FILTERED is in the first place.

