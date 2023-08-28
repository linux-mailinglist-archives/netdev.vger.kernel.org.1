Return-Path: <netdev+bounces-30958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145B78A3A2
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 02:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159FE1C20834
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A843365;
	Mon, 28 Aug 2023 00:16:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBD360
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71429C433C7;
	Mon, 28 Aug 2023 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693181804;
	bh=CloNNqXikUmJ2ZpbFmaZ+V5uB5sGVfGuPybVyl8BEDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oNQL4pr1PXXCF0jyvGHyMpIw+SGOz5e35LmNLGxgnCqorUdg7OvdHGDPstjOpJR8I
	 9vsmuJ8Ikf7NacIDwz5ZvvxcRJpkei7iQ/zsOXGYTre2CP7t+oyRPntN5c5n0oxmg9
	 D2hDZphRkAnDrHk/u5Hn/rp9UhhrdbqVI2QZpLbwh7J7ojmKmnwy7c83a9p72o90Wz
	 JV33fBA4ulzmpPP5KtkiKuEegQCguCbMCvMpp3uWWVKYTKs1QYNVFiNwT3zC0A8EWL
	 0C7CHhOQq3/9soaqfuXo6U+S+3sNHHwaz+LxRTEIPWzza5/8aMF89xz4V33+v1D/cV
	 XAyZyBZacMHpQ==
Date: Sun, 27 Aug 2023 17:16:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com
Subject: Re: [patch net-next 00/15] devlink: finish file split and get
 retire leftover.c
Message-ID: <20230827171643.57743e55@kernel.org>
In-Reply-To: <20230825085321.178134-1-jiri@resnulli.us>
References: <20230825085321.178134-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 10:53:06 +0200 Jiri Pirko wrote:
> This patchset finishes a move Jakub started and Moshe continued in the
> past. I was planning to do this for a long time, so here it is, finally.
> 
> This patchset does not change any behaviour. It just splits leftover.c
> into per-object files and do necessary changes, like declaring functions
> used from other code, on the way.
> 
> The last 3 patches are pushing the rest of the code into appropriate
> existing files.

Conflicts with Saeed's series, could you respin?

