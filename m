Return-Path: <netdev+bounces-258552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNPnOC+Wjmm8DAEAu9opvQ
	(envelope-from <netdev+bounces-258552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:10:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65603132921
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD8A309E790
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC6242D70;
	Fri, 13 Feb 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFoBs30t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878442405EB;
	Fri, 13 Feb 2026 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952217; cv=none; b=GH9oi1mIOf8FklHJZ0LFuGNVfaLCi3B6xSeSEtiGZv2Tqo5qiB4CvT8qRyfF956Szw3XYH6FvYAr0IP1b+rEmizwG4QnkQhFoeXcMAr1xYERsTbMIjGGbJ7SpI0iH7UqRLa8GNkJUlRgCnuTCECApxv384L0H5p07bLK+TB599o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952217; c=relaxed/simple;
	bh=tOSmKU/tWO8hSmTxU7u5BqcAYLt9sCF6Ja5kJM84B6w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KblmAMBGeJ4O88l430NoZIRNU6hihKPuKbYjmT/y6rainvtvBQp9lYQ7OKlJWMX1KAv5qK6pKK898t9JT8lepyCResFzszIW6F+pFpdoJFC07GB2HRdG+xXmjhvJDhkj2BZC5KMcpZ2lszS+ae7FFFvkEdKMP6thGZ5UDJs1w2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFoBs30t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3165FC4CEF7;
	Fri, 13 Feb 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770952217;
	bh=tOSmKU/tWO8hSmTxU7u5BqcAYLt9sCF6Ja5kJM84B6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eFoBs30t1ztPVAua51pp5HT2zJ2YDwNhRK7FEopeWBl+hGyfiNppxUbt3JcoGoTPY
	 CnWTBHE2g4L7/7Ym7Gz4lyb3tBldndfuWNV+LD7k6Npr09BG0/LHUH3pXMmnY+4JEM
	 yw8xp1/agPtYXwoKJP9M/4dqV6vqM/yRP5epnzO6oNGna84AYr4wIQTlNtK+VjJpOV
	 3TwAJBgZ6fBPYQYeAByL9DvH3LTfa17moOygg+jBxJFkYRrF+hUl9LEudQF/w7HEp+
	 QHvUGTZzUMWXS0cq4E5U3oDBlP+oBM7rxh42IGRhueWnZVQj98n3Ui/PlDSq012kfj
	 mXwYzrehpFkCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 854F83931093;
	Fri, 13 Feb 2026 03:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] net: mscc: ocelot: fix missing lock in
 ocelot_port_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095221132.1827286.321634089039592592.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 03:10:11 +0000
References: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260208225602.1339325-1-n7l8m4@u.northwestern.edu>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258552-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65603132921
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Feb 2026 22:55:59 +0000 you wrote:
> ocelot_port_xmit() calls ocelot_can_inject() and
> ocelot_port_inject_frame() without holding the injection group lock.
> Both functions contain lockdep_assert_held() for the injection lock,
> and the correct caller felix_port_deferred_xmit() properly acquires
> the lock using ocelot_lock_inj_grp() before calling these functions.
> 
> this v3 splits the fix into a 3-patch series to separate
> refactoring from the behavioral change:
> 
> [...]

Here is the summary with links:
  - [v3,1/3] net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
    https://git.kernel.org/netdev/net/c/29372f07f796
  - [v3,2/3] net: mscc: ocelot: split xmit into FDMA and register injection paths
    https://git.kernel.org/netdev/net/c/47f79b20e7fb
  - [v3,3/3] net: mscc: ocelot: add missing lock protection in ocelot_port_xmit_inj()
    https://git.kernel.org/netdev/net/c/026f6513c588

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



