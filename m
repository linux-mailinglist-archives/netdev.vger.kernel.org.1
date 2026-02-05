Return-Path: <netdev+bounces-256955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN+sKLohhGkDzgMAu9opvQ
	(envelope-from <netdev+bounces-256955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:51:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF246EE94E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 05:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125B5300B2AE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 04:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7A2EA48F;
	Thu,  5 Feb 2026 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii+4ZDfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2B2652B6;
	Thu,  5 Feb 2026 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267021; cv=none; b=H2RbkV4ol660IPF6JoWnt3iy+OQzV/w+7Dg3dA2Ywg71Lqj531BpsE/jxKM0NNwYRUCrJCVAZ2DgfFS8UEzlCWcczqt4L4JqxACVj4wz/4h+7ojCdZSM+jX4U8LpHRTfWcUOdSaRLTPonO71qzuVXKkL5zwyAVsOuB7fOxsBGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267021; c=relaxed/simple;
	bh=CGOn+52HseP3hzTaTZsqC/gunaSs0FybtOXk3Vrs3sQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b4JCmNF1QYnNbpIso5xw773se5ghVMBKro6D1Er+W4u1cnaw12c42l+qX/xygvISFZgiBaw5HO5ohFcMfBQqWESk3m24hn43Fa3m/QBmnHOzWYmrmFAi4xz7huPMRRe12Fe633G/mCtBTa/lHyMphjsNZPfLBb7Dt1IBAXiyZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii+4ZDfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099F8C4CEF7;
	Thu,  5 Feb 2026 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770267021;
	bh=CGOn+52HseP3hzTaTZsqC/gunaSs0FybtOXk3Vrs3sQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ii+4ZDfUA1lLQ+6/Z6El22V2iFUAmSJB14WzMd6rvKXQQ3ws/fidUbADebuR6kJCB
	 VwEfQoS9xb0r2UYJuPmIqK7qEC4lRrcErrV2OzwlV88jBzuNRVeZqYvwqCg6HOWVEj
	 7wLka0CQcvvXGZzXFF0QwOng2cWZn22D5MxEIE8MlS1LRxjA7Ri8otgL+RbZjE4toX
	 SahA2lvzu9IrCkywww7mE8/qyjVCoGme2uMinllCin91QgZndL9AEi1XQvxPy+wy5f
	 S5pyRBzDH45O/fXjXsfLUcXRfJMMV/cj1ZOAw0UR43ozvntYgfa4XlPvxJ0HAx0582
	 Gb2ul8X7Hw1CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481B13808200;
	Thu,  5 Feb 2026 04:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net/iucv: clean up iucv kernel-doc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177026701882.165764.4197190768444088497.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 04:50:18 +0000
References: <20260203075248.1177869-1-rdunlap@infradead.org>
In-Reply-To: <20260203075248.1177869-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, wintera@linux.ibm.com, twinkler@linux.ibm.com,
 linux-s390@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-256955-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF246EE94E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 23:52:48 -0800 you wrote:
> Fix numerous (many) kernel-doc warnings in iucv.[ch]:
> 
> - convert function documentation comments to a common (kernel-doc) look,
>   even for static functions (without "/**")
> - use matching parameter and parameter description names
> - use better wording in function descriptions (Jakub & AI)
> - remove duplicate kernel-doc comments from the header file (Jakub)
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net/iucv: clean up iucv kernel-doc warnings
    https://git.kernel.org/netdev/net-next/c/a34b0e4e21d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



