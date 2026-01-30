Return-Path: <netdev+bounces-255016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIdlCq8vfGkOLQIAu9opvQ
	(envelope-from <netdev+bounces-255016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:12:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AAB7060
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49170301A72E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C537284665;
	Fri, 30 Jan 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD1Dw+V+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494652AF1B;
	Fri, 30 Jan 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745629; cv=none; b=MuL1oYo+NYEWC94Iwf8uKgU54iUqLGue0xZiU12AlSFdnQPUS/rgXdza733uBgbjaSqD6FmHkYq32d4F0fEji7rkoGsSbIc/C9MyN5GmmIsaKuXiTQQUuFG0airUzztUAERXrmwcYmi8F/mKfs7I0jqGZI/582Ox/PbQ8pPVwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745629; c=relaxed/simple;
	bh=8F5A4jGWBJkuSVuaMEXUhDem5hzk7URmZn6U57Ffgfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q14Amd085fLXQvYUh/W3XsjFuaTF/D9wMr7dmzHUqDudGwW24jLaO6bZ9JE4j/oMkj9x233UAzSQ8qL+Dx0Ya/AwXNTmQGX/G2PBZWUVhWxC7ODIqam7zKEI2bpkjQG0iK5/oJVX9nzMhz2pkNc4y6wb1T6H6cYNztR1PqvdKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD1Dw+V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80DDC4CEF7;
	Fri, 30 Jan 2026 04:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745628;
	bh=8F5A4jGWBJkuSVuaMEXUhDem5hzk7URmZn6U57Ffgfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hD1Dw+V+jXRYiSk8SnexPfZABSuRRJ1nfvM1lCT6It63k23II22CgoN2MpwPCxcmC
	 B//QKasSOT7HYqLFfQENgLV8wkgz0OVvwbPDRZ6PN8KR7TFBye+xFqaKn4WHGjYIVH
	 N9JWN0mYWNUIFo9VVimAuq2h3DdfZA7otW/oUXindes18hrCqZiATONTOr5WUvIjky
	 e1UTHeb3ttQ9bPhmyAAoIZQgB+WEZWUAJ7hCTYRtVs+dPjgokAuHGgeSMMq5qruHJl
	 6iqlJSG2S6m5dnWttP0mt9x4e+Vn+rmD9fdgzZPsI43xYa8ER6+jODAf9CKrOFC/B2
	 AQBJ+WsEq/jsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D69380CEE0;
	Fri, 30 Jan 2026 04:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v7, net-next 0/8] bng_en: enhancements for RX and TX datapath 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974562161.3166473.4639684674171718402.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 04:00:21 +0000
References: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
In-Reply-To: <20260128185623.26559-1-bhargava.marreddy@broadcom.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 ajit.khaparde@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[netdev.ai:url];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255016-lists,netdev=lfdr.de,netdevbpf];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.335];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netdev.ai:url]
X-Rspamd-Queue-Id: B00AAB7060
X-Rspamd-Action: add header
X-Spam: Yes

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 00:26:15 +0530 you wrote:
> Hi,
> 
> This series enhances the bng_en driver by adding:
> 1. Tx support (standard + TSO)
> 2. Rx support (standard + LRO/TPA)
> 
> Changes from:
> v6->v7:
>  - Addressed netdev.ai feedback shared by Jakub Kicinski by adding bounds
>    check in bnge_tpa_agg() to prevent agg_arr overflow.
> 
> [...]

Here is the summary with links:
  - [v7,net-next,1/8] bng_en: Extend bnge_set_ring_params() for rx-copybreak
    https://git.kernel.org/netdev/net-next/c/705c7933d998
  - [v7,net-next,2/8] bng_en: Add RX support
    https://git.kernel.org/netdev/net-next/c/4d6a60057c34
  - [v7,net-next,3/8] bng_en: Handle an HWRM completion request
    https://git.kernel.org/netdev/net-next/c/23cfc4e8e149
  - [v7,net-next,4/8] bng_en: Add TX support
    https://git.kernel.org/netdev/net-next/c/bd5ad9c052c8
  - [v7,net-next,5/8] bng_en: Add ndo_features_check support
    https://git.kernel.org/netdev/net-next/c/5deaeae186b4
  - [v7,net-next,6/8] bng_en: Add support to handle AGG events
    https://git.kernel.org/netdev/net-next/c/c858ac8735ae
  - [v7,net-next,7/8] bng_en: Add TPA related functions
    https://git.kernel.org/netdev/net-next/c/58165c99324e
  - [v7,net-next,8/8] bng_en: Add support for TPA events
    https://git.kernel.org/netdev/net-next/c/c2effd12c96d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



