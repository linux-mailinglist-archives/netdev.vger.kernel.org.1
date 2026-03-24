Return-Path: <netdev+bounces-270861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK/LIg0BwmkjYwQAu9opvQ
	(envelope-from <netdev+bounces-270861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:12:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50F30197C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 04:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA5273019623
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E9386C35;
	Tue, 24 Mar 2026 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYbpAbKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17C20F08C;
	Tue, 24 Mar 2026 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321834; cv=none; b=lXTtj9Q+5IAbp3RewHa2FPYMsTUvcOFQBlUfqs5CRy0HaxQgFCWGRswtDuIs2vQzSQsCT6VZ502BzgSqCX2sj9zE2IOTjAqy0RFfdAbMkdfZru+V1zbPwF85SitxXEEqSSnd5Uiatdvx7xB+cPy2/ChFJ9c4H2t6u60or7ZGoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321834; c=relaxed/simple;
	bh=h9P1O6jcr4keN+FKUU/zIhjkWkxycKTEjvIBuXQvmJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=foUTaukm4tEi/RDA2JyP/tb52OpBwbvgXHhSqZdoZtufBU8pNSMM93LFmQEi8R/PHOiPbtAVrKZIonA9vW0TiN+n7t2aMFZZgYI4JRv0qs5tySf2vmghqup2VijDKCxMwYY9WrPNibOByRr1rpNBU+tgytJQ5981FQzODBLbSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYbpAbKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56648C4CEF7;
	Tue, 24 Mar 2026 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774321834;
	bh=h9P1O6jcr4keN+FKUU/zIhjkWkxycKTEjvIBuXQvmJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oYbpAbKmUoeXgvu73RPv20O4CWVO7U7p9tpQ2vMBlCcmIkKs/2GAQor7ElaZN+2AQ
	 wUiVHQF0cZdRMlnaI7Kl2BzNrhdSb1YhL4StEUbbYgNX+ixyNH8l9Vq/VJN+FI6+D5
	 s8ED2etdIxPvz4LJJZDi6DkkDbycNAtR7IKNbbq/3B2mZcFVZqK4yiQ2QwC8eCs3S7
	 whhylJwfAJ2ZQSCNoYh/6K0xNS5gjU1R8vLud7jrcRFXZfUE8oHz+9+DnnG9OPoGEi
	 addZe9XogHLrBlq/4j8aNjTNYgiFucyiGDflNnWMjz3stBIYfzz9OpOnprAi5M4Zdt
	 yJwvzVbqCVQPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F0F3808200;
	Tue, 24 Mar 2026 03:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/4] selftests: net: fix false failures due to
 missing features and host interference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177432182228.439625.2844303525543362412.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 03:10:22 +0000
References: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
In-Reply-To: <20260321215908.175465-1-aleksey.oladko@virtuozzo.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, aconole@redhat.com,
 imaximet@redhat.com, echaudro@redhat.com, sbrivio@redhat.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270861-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu-test.sh:url,pmtu.sh:url]
X-Rspamd-Queue-Id: 8D50F30197C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Mar 2026 21:59:04 +0000 you wrote:
> Hi,
> 
> This series addresses several issues in the networking kselftests
> that cause false-positive failures depending on the host environment,
> kernel configuration, or library versions.
> 
> The main focus of these changes is to isolate tests from the host
> environment (using namespaces) and to ensure proper fallback or
> skipping when dependencies are missing.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/4] selftests: net: run reuseport in an isolated netns
    https://git.kernel.org/netdev/net-next/c/a897e194c475
  - [net-next,v6,2/4] selftests: net: rename pmtu.sh to pmtu-test.sh
    (no matching commit)
  - [net-next,v6,3/4] selftests: net: run pmtu.sh in netns to avoid host firewall interference
    (no matching commit)
  - [net-next,v6,4/4] selftests: net: io_uring_zerocopy: enable io_uring for the test
    https://git.kernel.org/netdev/net-next/c/9d463f7863f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



