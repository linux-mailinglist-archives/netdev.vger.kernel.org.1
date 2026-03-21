Return-Path: <netdev+bounces-270143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5NHCX3vWm+EQMAu9opvQ
	(envelope-from <netdev+bounces-270143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 146252E2CFB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0595730041F1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C33290D1;
	Sat, 21 Mar 2026 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV1/noDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A23271EA;
	Sat, 21 Mar 2026 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057230; cv=none; b=B6o4z2mAPUZGfsvBKy7wb5D/hSQ/MAGH0cIuBBQt2LT/fX9eVvnX1F5S9Z8rGfBVegfc3sqLqwmE5E2rNrX9Cs/Heu1gAqAbVwUMcQQDHjmuwrqKrS2bAFj0yc8ZbqdTAPSodrfqLIaT8OXLVM7nOc0jF7YZXlC7JCYkuvcTfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057230; c=relaxed/simple;
	bh=oszz2+luIcotaI3mDHP5rRr89zad9VHBjN4UEAMPzNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ww06l2qieizEI00Y7OKGHWi9jeek+0LmYHTckT+4a8iCyUsy6VzLX83bntl8lqrnFWU41sqqQIgllGsgE0fq1YpZfy0nCKjjC5HSUoDpNnI1U+EOyafDrOA0pQjuU3bWLJOEBmzl4udPxxifFjJunHJBuhgg8YaKq7DN9SvHl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV1/noDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44105C4CEF7;
	Sat, 21 Mar 2026 01:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057230;
	bh=oszz2+luIcotaI3mDHP5rRr89zad9VHBjN4UEAMPzNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XV1/noDW/goeAfgw/yhJIK3yCt0S3+lkil8nQSb+rlGYQEU7VXcXtj6kt5Rjnb9uy
	 kERCZHtuMkKvxImf1X5H0sl5METevwQSY+Qm/ly8jVOk4R+F6Z7ayx1BgCZCbRmfxX
	 +x5CX7LjM4g8+tWlJIQLkTGUVic7Iq5aetgXu5Xmz/Z50iNJzqWdLbmn1S9LtXh235
	 D8k5byyYhTbWUbkpzt5qqJnbXXqhguGSohc/9+RbYisoWlmaAjrkf6EAT914QBZpem
	 V83BUEzw3wdUODeSsYRpvcFfhPZGe/PK+SphHJw4sUAtTHHMd5sqS2Z13InNGpzfIF
	 6v9jtGCGWW4wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6B3808200;
	Sat, 21 Mar 2026 01:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests/vsock: support nested VM runner
 for vmtest.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405722003.2718727.10487979147167709266.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:20 +0000
References: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
In-Reply-To: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: sgarzare@redhat.com, shuah@kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, bobbyeshleman@meta.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270143-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vmtest.sh:url]
X-Rspamd-Queue-Id: 146252E2CFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 15:09:34 -0700 you wrote:
> This series fixes a few issues trying to launch vmtest.sh in a nested VM
> environment and were discovered when trying to prepare the tests for
> netdev CI/CD.
> 
> When taken together these patches make vmtest.sh work both on bare metal
> and in nested VMs, regardless of the outer VM's user, coincidental path
> overlaps, or filesystem settings.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests/vsock: fix vmtest.sh for read-only nested VM runners
    https://git.kernel.org/netdev/net-next/c/865926e26e05
  - [net-next,v2,2/2] selftests/vsock: fix vsock_test path shadowing in nested VMs
    https://git.kernel.org/netdev/net-next/c/0c3893d37892

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



