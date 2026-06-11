Return-Path: <netdev+bounces-298083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C4y7AEeVKmr0swMAu9opvQ
	(envelope-from <netdev+bounces-298083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:00:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA06711D9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:00:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n6SHBimz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298083-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05251300A333
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C313DBD72;
	Thu, 11 Jun 2026 11:00:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF593DBD41
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:00:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175620; cv=none; b=W/7ypud1xQXALeFXudSCbynLXJahBwh2dPwZaZ7i2Nw7BmQWao1X1jzLGEjzc6pClS246WyHtkzFAjX0WsNsYv+KrE/7n6IlQai7W/kG6ejDTXcV7PvCSjFP48xyBM5X24jdW4nGL4BB6tke92ZSF3hQjYnUNpExmXyzaBQInzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175620; c=relaxed/simple;
	bh=5GzLJ/4RHNNPaSYUc/5rmSpGjYQ1cCXk3IR0WKn/esY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TqxfclskJLTY4teoDkUGZfjdvUnLU2QzS9PlzO3BX9BabApOSAEc26NVe5xY5FsmxtBja1TGjdCNQGWO6w6/WjW/5660QjrW0z2CwvZPMoM4p4R6HykHm3qc/TR2IzIEVdaRfJBhhz//g+Ksswp6DTW00/j6Ex0RtTxyhefEi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6SHBimz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0F1F00893;
	Thu, 11 Jun 2026 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175618;
	bh=vcDqTo91bW3Yq4JNsgc2zdbNeGxbYPO1wwfyyQ+UlhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n6SHBimzzn+DgVK3RGtURY9UszYpuYYo+oA2R6Dwt6Mmg9JRT31g0EU2T8GTdMXz4
	 KC2OmvmkWJEdVn8BVLJOHA0uzCI90qF9DuCT6Rcy6h1WxTGqGPcC133twOfW7NOLKS
	 dLFsp5hgDgSIPFT6zrYi4Ov5361r1X/cNZ7dAYXHfSgjq2pDKDDJwzO/iK6p1zanmz
	 RIt4pskVajpQJFxA2IGctrPmj7TQpaI04Q51uuIyRnswwO0B/Rq6jgya6YkXhDuGX4
	 t+yldfRxnjynU73Ubj4jMnK0O1vJPOmWhEFoKQZzxrjaIwgleOd8C72mFfIFD5tp6E
	 dU1XxOC6o/mBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567543930E4C;
	Thu, 11 Jun 2026 11:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: shaper: follow ups to recent fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117561588.3897339.6842708895073002638.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 11:00:15 +0000
References: <20260609183224.1108521-1-kuba@kernel.org>
In-Reply-To: <20260609183224.1108521-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298083-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89AA06711D9

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jun 2026 11:32:20 -0700 you wrote:
> As discussed previously on the patch set with real fixes the xa_locking
> in shapers is a little confusing, remove it.
> Link: https://lore.kernel.org/20260506000628.1501691-2-kuba@kernel.org
> 
> The remaining three patches are an attempt to silence AI reviewers,
> I believe Sashiko was complaining about these non-issues. Not adding
> Reported tags since these are false positives.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: shaper: drop redundant xa_lock() bracketing
    https://git.kernel.org/netdev/net-next/c/f26cddcf2a8a
  - [net-next,2/4] net: shaper: drop unnecessary kfree_rcu in pre_insert
    https://git.kernel.org/netdev/net-next/c/3500dfa6ff0e
  - [net-next,3/4] net: shaper: add a comment why we don't need kfree_rcu() in flush
    https://git.kernel.org/netdev/net-next/c/3b4ba5726338
  - [net-next,4/4] net: shaper: add a note that we expect cap dumps to be tiny
    https://git.kernel.org/netdev/net-next/c/7421a813778b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



