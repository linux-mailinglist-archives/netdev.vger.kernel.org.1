Return-Path: <netdev+bounces-287260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCQvOtRqA2rf5gEAu9opvQ
	(envelope-from <netdev+bounces-287260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:00:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671952681E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D10531A70CF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB13D5C06;
	Tue, 12 May 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+PcSxfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540763C0A1B;
	Tue, 12 May 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608265; cv=none; b=Q1cnRCW+nzlHjLtqslC183sw8eKtZrwc+u7XgvIGv3yuiKc+a7GBDi6rvToymWg0WmOhC92GrnyV52QtWQhyrLZwr/27nPgozkWhSuFnRXoRnl/eWvThByPInJLm6edDuX9BBj0jfzk1Hi5gpbIYaeTwUqMnHbvXCHVDXAcbG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608265; c=relaxed/simple;
	bh=iRcqfMLnrkRQg9QzN1FEm5Xx9NahBc4jxGJJC/3wlFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ssFuRc+1txodSljyVDIelngt/txwawGIjTqlZCjUnMhzyvPBTer1HuHytfhYoOE0uhwaq576ddXlGk2y7lEQwq77wqJARt5vBV1t5AP85h3UI78LGW/8RSmC/akSDt3NKJE1u5HtqJ9orZky2CMbs3p8TvvxBMk7HNaYroiredc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+PcSxfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BE6C2BCB0;
	Tue, 12 May 2026 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778608265;
	bh=iRcqfMLnrkRQg9QzN1FEm5Xx9NahBc4jxGJJC/3wlFg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+PcSxfQ6SW5TJXPRZI7R9vFZRr4R8RLLg43/rr4L60rM6NJ+GFW49SfNlrwj6D49
	 haG9oKxVAQMMKYGd0IiBONmRhkiVJqAhPyuM0/3acdPCJiKwfHEIu7PJ8VKvdBYAvv
	 g01M9m3Aq5Iw/nYpywLUxP/nCxZ8Yig4/hHMs1TU4VX5C5thdqHCSaXFPwr/4IhMd7
	 qcKxACe/+OnJq/D3XWns0FEE/m+CA/cqoCij4PU0TfVukRPviRiZyGuNMNnBrPT9W5
	 37J4WNG551WbY7aVEUgvtOZhd1DsifVcheGbukLFVqCYR7kV9raAhIFVaSxoAFliIp
	 r4mll/GHOa1RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE123812FD7;
	Tue, 12 May 2026 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] Bluetooth: convert remaining bluetooth
 socket families to getsockopt_iter
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177860821104.3015105.542889541013880756.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 17:50:11 +0000
References: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
In-Reply-To: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 4671952681E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287260-lists,netdev=lfdr.de,bluetooth];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 04:12:15 -0700 you wrote:
> Continue the conversion to .getsockopt_iter for the Bluetooth socket
> families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
> small precursor that fixes a long-standing 1-byte put_user write in
> hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.
> 
> The riskiest change in this series is the SCO BT_CODEC conversion: it
> is the only one that drops an open-coded ptr cursor in favour of
> relying on iter_out advancing naturally on every copy_to_iter() call.
> Every other socket option is a near-mechanical s/copy_to_user/
> copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
> codecs + capabilities and previously tracked its own write offset by
> hand. Getting the cursor semantics wrong here would silently truncate
> or misalign user-visible codec data.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] Bluetooth: hci_sock: write the full optval for getsockopt
    https://git.kernel.org/bluetooth/bluetooth-next/c/375386737970
  - [net-next,v2,2/6] Bluetooth: hci_sock: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/317bb006946a
  - [net-next,v2,3/6] Bluetooth: ISO: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b650bf299b6
  - [net-next,v2,4/6] Bluetooth: RFCOMM: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/477cbdca7568
  - [net-next,v2,5/6] Bluetooth: L2CAP: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/fcadc2780bf2
  - [net-next,v2,6/6] Bluetooth: SCO: convert to getsockopt_iter
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff2e1268ee45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



