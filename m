Return-Path: <netdev+bounces-251658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJPpMEkRcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 652124DE3A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50DB680F8F0
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DF413245;
	Tue, 20 Jan 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4A96lDN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA795413222
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768951807; cv=none; b=FDZ6tS8cwDUbZKVQ0adywilvcnR3F3VhJGX/EKvzZHj1/DaSOuEu/DIvQZZ/rQoSMKbVBql3RtDvp4GokH7iiaf0lkgqQ6aegXYjwTSQr6GsNtI1TGWb6ubxgbkIhqj+h/GHJo9tCQsOihbu/1MH6cEFTNpel1XFsO5LFIbm8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768951807; c=relaxed/simple;
	bh=/+tH0SACF91uyws5Bh72FJVfEhUeHTM1H6lh1OgO4bM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3sDr+FYFYxLRQxbjszK+JVVovTTywSVfV/uy/sGMpKG88coWl9b35jeUmnr+lnaw2zeGby9imKFdKYGAjIDchpYX3INgxXYMHE3BvFBoG/RTmVwWvzttQ0BgBDBvnczb5F7oqv9DgVA22JHjfaWoeC8htZNL9VfBoB/uoACgt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4A96lDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF35C16AAE;
	Tue, 20 Jan 2026 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768951807;
	bh=/+tH0SACF91uyws5Bh72FJVfEhUeHTM1H6lh1OgO4bM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k4A96lDNaY+0axOj/jOWZgKga7IWro6ReUgAYjGfCOWADRJnYJ3dx6nSSX65pkbdw
	 arm1KzhhdO9hWpSb+2KE/h0cnk9gTPk5lDajsd4MwO6NAqLhmoSt60qLdaPpW47c+N
	 vfr2Yf/lI7QuCBSdbEq7gT5uoLd3olUzrcT6x/vQXmJM+X7VjxVdvg5P5Apn1FQMVW
	 KwkxrlWNI1ElMbIP3bMTKJRK57ZFvssAPgBvKje7f6uYRpiokKtkmnBEK6oofvnHaC
	 8jVKBe3HyZ16o5bnnfpjteUIymUmPYGoCgN1nw0H6aym8YK4rMMX5SPCZn7MNlC5fv
	 YXeJDB2dOkBog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119BF380820D;
	Tue, 20 Jan 2026 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] devlink: Fix resource show output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895180486.650765.4216703988085899594.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 23:30:04 +0000
References: <20260115115004.863685-1-idosch@nvidia.com>
In-Reply-To: <20260115115004.863685-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 jiri@nvidia.com, petrm@nvidia.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251658-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,networkplumber.org:email]
X-Rspamd-Queue-Id: 652124DE3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 15 Jan 2026 13:50:04 +0200 you wrote:
> When the user asks to show device resources, devlink first queries the
> device's dpipe tables so that it will be able to show the association
> between resources and dpipe tables.
> 
> In this flow, 'ctx->resources' is always NULL as resources have yet to
> be retrieved. As a result, the dpipe tables are not associated with a
> resource identifier and the resource show command does not show any
> dpipe tables:
> 
> [...]

Here is the summary with links:
  - [iproute2] devlink: Fix resource show output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f2b24087e154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



