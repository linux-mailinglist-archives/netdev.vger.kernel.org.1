Return-Path: <netdev+bounces-64501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED79F835718
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817961F21722
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B8381B9;
	Sun, 21 Jan 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ9AP3vN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF680381B7
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705858226; cv=none; b=BexHgSDBOuBjjOFpMVi+8hHcs5RlVTr8EzAZGEb5rgOLzc1/xw/AuqqtBgAgB2iwZ5ZVKcN6a+pfwh8hHVlKMwzKqI4W9dNW1YWFnjCsV9F+robAjd/ZzfGgv9cAae3OKApry+FlwsrfFVnJYjneO9pQmoa6jvzOphMpPeEGEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705858226; c=relaxed/simple;
	bh=grWm4aTLJWC2xD/oHwnk6GfD6cYc+Ps0rhJnwnVhlGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MDJCuhpRdnZC4UcMcjerhyLYbiK/PPgOJzP87tUQ7SwxrjB1GTW2d31MqwcebGTUirYEdh3IhgFEllU/sfnxL1tclt1imoMeW8NK4FZIC9oNlv+VJXoWSYoWjKSUAeMx4Mc2cTTl+mXnmSV8P+e1lwsunIbSiAA6ZlRxmA3f4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ9AP3vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73671C433C7;
	Sun, 21 Jan 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705858225;
	bh=grWm4aTLJWC2xD/oHwnk6GfD6cYc+Ps0rhJnwnVhlGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dZ9AP3vNnmo1qI3isjGyEymS3PMf0BEJG/WRxlns+0y/vzGwxp5A700qHBfVp34pM
	 uOM/tvdyZbc7AvRLz16iz7Qhywci2FXoREvn8cVm54BSRwXOHk8qSjAr+/NHa4VxA2
	 hGFS3M6TV2yWWlf+60ICFyNJHy1Hu5qcuZSuCOAr5SEZ1uvshokOy4p7ZbCyHZwsdx
	 NgozjM8/XfQH9KTd+vRGfY5x7CIorJ9e1RzrFdV07+eZNIK5Dj5oOjDtggITrAnjgy
	 TvbsGmt7hljyLTL3miH+/2yblO2+CwlXeqCX4QvthDiuED2oGT2sp65byvy+H3NyS2
	 N0EykNlAA/jZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F712D8C978;
	Sun, 21 Jan 2024 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] tc: unify clockid handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170585822538.21563.5730055248074683668.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jan 2024 17:30:25 +0000
References: <20240119164019.63584-2-stephen@networkplumber.org>
In-Reply-To: <20240119164019.63584-2-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 19 Jan 2024 08:40:20 -0800 you wrote:
> There are three places in tc which all have same code for
> handling clockid (copy/paste). Move it into tc_util.c.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> Motivated by (rejected) pull request to deal with missing
> clockid's on really old versions of glibc.
> 
> [...]

Here is the summary with links:
  - [iproute2] tc: unify clockid handling
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=91cca2aee76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



