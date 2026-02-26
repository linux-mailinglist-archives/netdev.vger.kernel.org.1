Return-Path: <netdev+bounces-261150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PYvDKG5n2n5dQQAu9opvQ
	(envelope-from <netdev+bounces-261150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2CD1A0560
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B72943055453
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E23815FB;
	Thu, 26 Feb 2026 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEoJmjlC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5C3815D1;
	Thu, 26 Feb 2026 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075408; cv=none; b=LviQNtr+s6Du55gLE3+QrF6eRxroiBYBDC6pejUeJkCdHhn1C01//heLidFOFArPqStVhxPfnF9zCCnHovxDP2vHrlOiD9lXoKJCPvTIiHH7Avx8A/SalWB1K3zbDYdPpTXp2grUocqw3byHI1oQYiC3Y/N0udblU6sHIb+lKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075408; c=relaxed/simple;
	bh=8ER8QLa0zkIVGnKagiBVB1Mye1+VrGFuKc4qivqP3Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GL6VCwwCc+i7UYF7yw3PQaMCPQZrWTob8/vOZmvNkweVokTuT08rXmEse5477mWryBE+zMU21uM5qRogvKs06xJ86Pn4+4N3RzJ1nPeAtrIz1IElyurnuSp/QBf5k67GHpQtZbHepvBR1VVM0wTEovDqAS+19g+UQHR86JCnwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEoJmjlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81972C19425;
	Thu, 26 Feb 2026 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075408;
	bh=8ER8QLa0zkIVGnKagiBVB1Mye1+VrGFuKc4qivqP3Eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fEoJmjlCAGHbdWa+JJ97SsuJ3eCdrCnulX3bkK1ZzjZnkHUuJLinphXl/d9nhMPlC
	 A14lWIBJmaC/iEt4tddzbiy4Dq5OVtiULO5c12fr67PsKoqi6w5+TIHYf3nqWlTljn
	 hsQqSsqBEQDw6fVVioiLFdgdWCT2USwq0+goEEb5QAAFPN9cW9g5ZNVMDw/4mslliV
	 6aE5Hgx4/Mr9tHLjw6BtT5Rc7pud/LJufuL5BlK3I5qgdjaBUdGubu70Rix5XZwI85
	 OrJH+nv5xetWPUcduNSeKunsprL8zQpsy6A1jRr2yOy+jjNWyYUXTIsqgl2FSOuJkX
	 E4iZXRnmUDQ0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D061380A94B;
	Thu, 26 Feb 2026 03:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207541303.1014739.8301517056403543881.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:13 +0000
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261150-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2CD1A0560
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 09:20:11 +0100 you wrote:
> Hi,
> 
> this series restores the ability to accept in‑sequence FIN packets
> even when the advertised receive window is zero, and adds a
> packetdrill test to guard the behavior.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] tcp: re-enable acceptance of FIN packets when RWIN is 0
    https://git.kernel.org/netdev/net/c/1e3bb184e941
  - [net,v2,2/2] selftests/net: packetdrill: Verify acceptance of FIN packets when RWIN is 0
    https://git.kernel.org/netdev/net/c/745113323098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



