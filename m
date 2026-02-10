Return-Path: <netdev+bounces-258040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODOyHkHqimk8OwAAu9opvQ
	(envelope-from <netdev+bounces-258040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 09:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EA1182D0
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C481230309AB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7F33CE8A;
	Tue, 10 Feb 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB1k02Rw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB121E08D;
	Tue, 10 Feb 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711614; cv=none; b=b33vg20NSml330jqXpS/VbDTqy3jEP97yi+z90OZ6Qaj80g+GvcoaodgWk3FNIFn6vTPu8+Srt+aYqxR3e+wxNPZKyyiZ3SObvX8mvmIA8hhcNga4g8Bhg3XER7ioTsPkXH7WuJbR5//82G9jkYIpeWv55Pwk9bSVD9qZuwH0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711614; c=relaxed/simple;
	bh=gzKyHW5EDhMsVaY4ptJWceCdQbgnJX82jnGxCiTL5FA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1F70tTjss51qBCjvuH7gJe/xBog0fjxLrfSEHUDHW/gmYCOY3k5NVlx2Upzd6KUh2fFWf11D4LWzfLnd7pozgID6LBxZZ6eBukH133Yhca42d8bUQEAEI+C2aZ1utlzbehzj3l4sL+NZvbuGv8rMscrhPaZCnsuqsLGacD9A2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB1k02Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E72C19424;
	Tue, 10 Feb 2026 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770711614;
	bh=gzKyHW5EDhMsVaY4ptJWceCdQbgnJX82jnGxCiTL5FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XB1k02Rwx3gB4dEp9MdyAj1+378VwYH65Tvt9/yh5MkDdtKVJSVTQQWi52TaM5iQq
	 cKq79ame6sT+oJTSwUefl7GWqEy7XNE45nG3JBlZM3vbMy/Cqa3m1ftr0NLz4OUoFP
	 pK6pQCbGMitIQSCMgMFO+rYvSwSprhRKBTJixWCNC8g4718mVwTfsNmBl64qxD6Suh
	 S87XrUC4WbaPJPHnzVhWgc7Ym9Cl0HTvZ33Vrz477C3vpv5AHOiQMwjdZRlG8DYmNo
	 2Idly9vVd9jAutLBtIBqzNzsWEEPcqx00eIDKiDRDTYpxhfk3BSmJJRGfXJA9Bycu6
	 YPvwmRFXfw8kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2211380AA5F;
	Tue, 10 Feb 2026 08:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: dsa: mxl-gsw1xx: setup polarities
 and
 validate chip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177071160940.3405385.3501969498439733641.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 08:20:09 +0000
References: <cover.1769916962.git.daniel@makrotopia.org>
In-Reply-To: <cover.1769916962.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: hauke@hauke-m.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258040-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[hauke-m.de,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF1EA1182D0
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 1 Feb 2026 03:41:34 +0000 you wrote:
> Now that common PHY properties make it easy to configure the SerDes RX
> and TX polarities, use that for the SGMII/1000Base-X/2500Base-X port of
> the MaxLinear GSW1xx switches.
> 
> Also, validate hardware in probe() function to make sure the switch is
> actually present and MDIO communication works properly.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: dsa: lantiq,gswip: reference common PHY properties
    https://git.kernel.org/netdev/net-next/c/431b777762d7
  - [net-next,v3,2/3] net: dsa: mxl-gsw1xx: configure SerDes port polarities
    https://git.kernel.org/netdev/net-next/c/ffd034ac0912
  - [net-next,v3,3/3] net: dsa: mxl-gsw1xx: validate chip ID
    https://git.kernel.org/netdev/net-next/c/a046d6fc54d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



