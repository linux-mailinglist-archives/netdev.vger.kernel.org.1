Return-Path: <netdev+bounces-39648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C87C0421
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390911C20BAB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237523AC0F;
	Tue, 10 Oct 2023 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPxbwnyK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A538DEA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 19:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33975C433C7;
	Tue, 10 Oct 2023 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696965016;
	bh=k6Bp/QgJvbCaQe/+PAmqNg1wvvo3adPRkEgiK2cZizs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PPxbwnyK+tCXADpsT4KYMAbqjQN4EysKgFIr6S6NIMg+/Fk87YL1OkJAzhLfSsrZ3
	 njBw50mtYpbrKC+yBN7O1lYlEpUFLLChfjQ+CsT52IZW9MYiMTXKxx95t82fep/ok5
	 UiQ4jc/Q0D9Hd920JlzANxQ7bGI8uNcVnRISvq02ejxCTqhcsWqyGCX3ptL021p4JK
	 cuzWFkmhbMoPZKPO79dAQ4mIsGFq2lJOqf5AbY7fCZc6AC0Mz2ZQf4D6mCOPddqy6p
	 CHUNrbPgg0h6c446+VXiI0tnSfL9vTqkX7d5MzOKDGty9uBSBynLkXgqxwOCfzGgBB
	 xtRQZ2JPpyrvQ==
Date: Tue, 10 Oct 2023 12:10:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v2 0/3] devlink: don't take instance lock for
 nested handle put
Message-ID: <20231010121015.5d9bb45d@kernel.org>
In-Reply-To: <20231010091323.195451-1-jiri@resnulli.us>
References: <20231010091323.195451-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 11:13:20 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Lockdep reports following issue:

Weren't you complaining about people posting stuff before discussion
is over in the past? :)

