Return-Path: <netdev+bounces-44058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 753337D5F60
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A98BB211B0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B6E15C0;
	Wed, 25 Oct 2023 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtGKeZjF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CE1389;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96026C433C9;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698196223;
	bh=Wzhk5GWKvNAybKey4Q2A/3TY/ldAFnqYK29HEtyA0h8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HtGKeZjFksXy7wh0RZGlHwS7/LlgbvMMMtjzzAlteh++aPHczMT5qcpwV2Za0EKwn
	 qLXw4wXidsGYCAI3NjeijCNsyh4/ItpAJWCSe7uMqD/OCPJLWNbe2ewmP1K3cFn0bN
	 QUIsdClchcVLRgF9GkxlOASwmj7XlhipPfL3BlUBWS5uDBOOFUSYwBubwogmsg68/I
	 KesZBmk2hLreQ1EuqruGf9+ViOR6ufSVQHrPtpl+Wcms5TKJdKiAY66CruoA2ZUMso
	 EOCDijNKYdWPP7bUvxGF6bzbBWIh/tYEGfezAzV7WTW/WX06FVcoumoZ1tdLuwX9Rr
	 KPZWb7a+gvqcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B24EC00446;
	Wed, 25 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] s390/qeth: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169819622350.20949.9484167363310455139.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 01:10:23 +0000
References: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
In-Reply-To: <20231023-strncpy-drivers-s390-net-qeth_core_main-c-v1-1-e7ce65454446@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 19:39:39 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_entry->dbf_name to be NUL-terminated based on its use with
> strcmp():
> |       if (strcmp(entry->dbf_name, name) == 0) {
> 
> [...]

Here is the summary with links:
  - s390/qeth: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/e43e6d9582e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



