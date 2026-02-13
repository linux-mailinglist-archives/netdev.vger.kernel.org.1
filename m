Return-Path: <netdev+bounces-258543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INowAsmRjmlbDAEAu9opvQ
	(envelope-from <netdev+bounces-258543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:51:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5B41327D2
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53955310750B
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6C23815D;
	Fri, 13 Feb 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldmmeYzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7C225788;
	Fri, 13 Feb 2026 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951025; cv=none; b=GspzpZ1YbT47jeH/dA1Syk01BHPuF6u/ttQWC3Fl9qguVD4vp0z3P9mx3thNoTP6zmcpVR3qQSUglMUFMb0wvYK+Bq6WY4lD6bEJ2RkN+5i9lBUYgScyVs/eaoFJEbJOiMXI7eddhxUpujgiTkjOWgJhZogZWvM2kru+DlAmqis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951025; c=relaxed/simple;
	bh=rZ0Enbq7t+02yptP7jGArY+vcNDi/oAZFC1GAMmFMsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdzheGx6rdvez0sgCI8po2yt3hWzZAUrRqrqWu/qEfDCmaRvRAfKIYESUq1KX+kHsFiPDIzvCm4t2cAdo4BHvA9XfZ4IKBKxdt8BVbIAHqySQsD1LTsoyhPncyq+a0G34jQnjjItzCdw6dm873i7orqn1cOMh/neMYY5Hb7xvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldmmeYzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F0C19421;
	Fri, 13 Feb 2026 02:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951022;
	bh=rZ0Enbq7t+02yptP7jGArY+vcNDi/oAZFC1GAMmFMsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldmmeYzIzKjHedHN4UEM8pVXyBKbZpQIEiYSpSshF8V9xG+A8m7WrXACI31OmuBAU
	 Fi5k2g8OP9LIrzV1uJ8t7W1IG4XU9e+k+LAnGiup115UGSMYNmaZ8thHuJhnKwTaJg
	 KXkKiJ2Rpldvmq3LwwpLTcQ53BhoxY8TFB9rRk1uybaqnHcRjr8Qr8nvL3V7EAH+xO
	 o2vmxBktvTPKmL4jZMV8wPJ8e4r66xeY1xXCj5TWASgSFDptLvTc6ne3zX1mbzGZO8
	 210tFzTa08d/wsxsJCvRVnshh+V8fPB9kq8aJiFi3ofPt5Z07aIfrSEWvNhnEl5Zdm
	 1ZIciIKGGXUlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2633931093;
	Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: lib: Fix jq parsing error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101657.1819996.11130371621799049236.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:16 +0000
References: <20260211022146.190948-1-yuehaibing@huawei.com>
In-Reply-To: <20260211022146.190948-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com,
 razor@blackwall.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258543-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8C5B41327D2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 10:21:46 +0800 you wrote:
> The testcase failed as below:
> $./vlan_bridge_binding.sh
> ...
> + adf_ip_link_set_up d1
> + local name=d1
> + shift
> + ip_link_is_up d1
> + ip_link_has_flag d1 UP
> + local name=d1
> + shift
> + local flag=UP
> + shift
> ++ ip -j link show d1
> ++ jq --arg flag UP 'any(.[].flags.[]; . == $flag)'
> jq: error: syntax error, unexpected '[', expecting FORMAT or QQSTRING_START
>  (Unix shell quoting issues?) at <top-level>, line 1:
> any(.[].flags.[]; . == $flag)
> jq: 1 compile error
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: lib: Fix jq parsing error
    https://git.kernel.org/netdev/net/c/10ec0fc0ccc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



