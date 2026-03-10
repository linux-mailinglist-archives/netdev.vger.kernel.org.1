Return-Path: <netdev+bounces-265851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPVtG5V7r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:01:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19529243F7D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47CE430488BB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7630C62B;
	Tue, 10 Mar 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu3+YebS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6D30C621
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108025; cv=none; b=SuZtQXHFkKOwMmgTD8wfUu4ycaSS2mbv1zk/AvAArxzeZCI5Wb7B6kyj8j+Hd2INotl4+c14mi5TLe/RX4D68Uo2t1VEwKEtkkHZPCOprhtB1vPdhQEsuOljIl5lD2bHh7rQE7C4chBsuaYDdmnxNqwlKIX24OFW3qWN/18U/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108025; c=relaxed/simple;
	bh=QHYXqBp2Ohia/ddMydBjz9Iwgn5eekLxl1mXQyJKy20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iLSkl4JacYKoarVP2h1ijGNqOGozA3lTFmcFQaOUEkBCu9Hn6VxQEO+2TtiFX/Wx0+FLbHVqOjecytkiYNM5UwCrnlKtaWmhidldR4X8QKq+m3QuYYjIBjNAy02pARJPeLwEhcEQP7jqHQzFOan4e7xQliYviAzMpn+yOoqbGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu3+YebS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B50C4CEF7;
	Tue, 10 Mar 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108025;
	bh=QHYXqBp2Ohia/ddMydBjz9Iwgn5eekLxl1mXQyJKy20=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iu3+YebSwYOEWATrrcWekMEk4PdNXewavKEPluOJkHDlTVBjTxURZbk9/o6+JDjbr
	 ym4mWHFL1NW6x4ubqvFgPL/9KQqk1WF4dKADJoHE+Eu+iXe/uWvHhWMwvvrmMqOZKe
	 uwso0aVAk0k23lKUYKIgN1SHc7W4vHXHoXWyYyitUIDVlLdKMmMlVrZfGelOlj0Ogo
	 UV8OQVGQrVD4lxv7NVBrNX4Kkc87hFqfNKCLun53b/LTATqg45cW/5O2BveWOwJR4l
	 EZzofHmMyY53YhCjCQaYrEIZOto3VBGshPOyG6+oUNjeAQNRp8fPsZ1kgmWcCaWG/a
	 f7EavQe2Ok/RA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 804F83808200;
	Tue, 10 Mar 2026 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: avoid dst->ops->check() call in
 tcp_v{4,6}_do_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310802235.2022132.9174460358863840531.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:22 +0000
References: <20260306154322.1086539-1-edumazet@google.com>
In-Reply-To: <20260306154322.1086539-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 19529243F7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265851-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 15:43:22 +0000 you wrote:
> If incoming skb dst matches the socket cached one,
> there is no need to call again dst->ops->check().
> 
> Network layer already validated the skb dst for us,
> usually from tcp_v{4,6}_early_demux().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: avoid dst->ops->check() call in tcp_v{4,6}_do_rcv()
    https://git.kernel.org/netdev/net-next/c/82f36517a13e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



