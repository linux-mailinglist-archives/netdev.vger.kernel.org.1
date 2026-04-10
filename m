Return-Path: <netdev+bounces-277613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIAbO3SE2WmvqQgAu9opvQ
	(envelope-from <netdev+bounces-277613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C53DD6CF
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 274EF30658AC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F736E495;
	Fri, 10 Apr 2026 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUgqET5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14629366052
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862650; cv=none; b=jSjZkDXti5Gw2DcSseZFODRN4AYoCPl1sX5Bd+743xcmHVg36e+iMo4Kw8i8rljpvp89aXynBkQZSfSBxXAVU9a5gN7UD748YHNnxocN5J07nNUuA+zdJEo36KG3WUjslb3Yqu5jf0OaRO4q3kETaS8KlSpMBkhly6sBqE4sbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862650; c=relaxed/simple;
	bh=J4LOl9rF5ZCwKIsleAPXSM56vZS43EMCOiWOUy1W4vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdFysXV42gHlgY2s69vT99TkKw2A4g9E9nwNDwwLTDBWldp23sW511EBjfN8HQpFfuVRfUa3dAN7cPTWf8WswmDTWWbHOMsExzuI0bLukTPCxZw1Wg+qfu4xrpxGk8sa1QP+bufQ7BwWij+TmaWfBzbDF0ARlBbk1VX77wpak00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUgqET5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80CBC19421;
	Fri, 10 Apr 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862649;
	bh=J4LOl9rF5ZCwKIsleAPXSM56vZS43EMCOiWOUy1W4vM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hUgqET5Ocr0nbQxBSw6DgCwzy3dXUangtyph7ynq/pgXfUX+ERN+zA19p2TgdzDC7
	 2rNpk5txApudlMu4/4DANexqTQgh2iUYQM6yBPSFFYv5aFs5iFwcGNvaKRY8/UfFUn
	 EzA/TEa8lilr2MmJ501DWxH1Q+I+Om4ik8pa9+nI4a3NC9jGVeLk/QrJwv4nzr/bMx
	 UvwxGEoilj6hvZ7TZL9ZgBM/Z20LlMfQZUG5c2NaUPkzc2u8m2bcHt4VpAtU+ygZ0m
	 WMTIXsv2G7Ept7Nz/I1OGMjpjn/Y8d2WuK+n9An4GKD0QCqnK48e42DDVjdM0RuAYV
	 iGBqmycPIvN7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCBF3809A88;
	Fri, 10 Apr 2026 23:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] iavf: fix kernel-doc comment style in
 iavf_ethtool.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177586262379.2678602.4461794362716512859.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 23:10:23 +0000
References: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260409093020.3808687-1-aleksandr.loktionov@intel.com>
To: Loktionov@codeaurora.org,
	Aleksandr <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, leszek.pepiak@intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277613-lists,netdev=lfdr.de,netdevbpf];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.194];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 644C53DD6CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 11:30:20 +0200 you wrote:
> iavf_ethtool.c contains 31 kernel-doc comment blocks using the legacy
> `**/` terminator instead of the correct single `*/`. Two function
> headers also use a colon separator (`iavf_get_channels:`,
> `iavf_set_channels:`) instead of the ` - ` dash required by kernel-doc.
> 
> Additionally several comments embed their return-value descriptions in
> the body paragraph, producing `scripts/kernel-doc -Wreturn` warnings.
> Void functions that incorrectly say "Returns ..." are also rephrased.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] iavf: fix kernel-doc comment style in iavf_ethtool.c
    https://git.kernel.org/netdev/net-next/c/3f3a2aefbc66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



