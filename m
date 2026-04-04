Return-Path: <netdev+bounces-275346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAbcNdHg0GklBgcAu9opvQ
	(envelope-from <netdev+bounces-275346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:58:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51439AAEC
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4E230B678A
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37D3ACA54;
	Sat,  4 Apr 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkrXkfcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E253AA4E6;
	Sat,  4 Apr 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775296293; cv=none; b=XobRqn+3dHCkMHbw8Nc3uoG5a8VYixMKnizRup6ToHNxuyzBWJaxTsbm6DqgLCCCtLpeR48oaH24Jg9cNooRrXY0n2ENg02zMPgN6gW5MfYf/lc4G51hMPA6hc64PcyFIAfPVCRT+8oxAokjnngDdSVdpJVTvGI99yhhxQ6RnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775296293; c=relaxed/simple;
	bh=iW0Kz1I/7vvZL1AuGBv0fXtK4FYcJ+nHOoU93LgFuc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOEoM0Lza3dQZVLs8ae0xNUx3QiImJwsf3Ci2gSlK9sPCQQZZBnN5KO+fzZFjX9emJBLHeJaGvBXQVms3DuUlPhq+tlUTXYDx2NwXWItgCWmY6SJemGtOTM+Dia/yD/MMXTMDd03Ovuoh0n/v9aapCEU/TdphSop3CogELKAOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkrXkfcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF4C19421;
	Sat,  4 Apr 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775296293;
	bh=iW0Kz1I/7vvZL1AuGBv0fXtK4FYcJ+nHOoU93LgFuc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkrXkfcwpep5vMJJzAWHPWkSn1A9HeXvD3V4FEpNtUPdh0g8DICYxYppHwieSawaE
	 aSjJvFfKUDqul9L6RiHWw5coXEXkD24w4Br8v6zEyuPoE8j4mqZy0P7iWtOcnIV+Tp
	 K2vpzjR2Zht2on5zQiw+Jwxx2Ho1sKfUD40exw+7jpd1niKEuj4y9wim8MybxGy6ZF
	 Tf2Nlk6O7/AOEZMrGTT0KSLub6HWpbS55/lYNKatcskK+VI/zqulEloIERLB8YANDl
	 IpO8kvAIMlqOYvLnzpJbcNZNjc5sihlxP5OhSuMDsP2U5LNE8JekX2KC07BHM9Nud1
	 yXm8OkHO0cQMA==
Date: Sat, 4 Apr 2026 10:51:28 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yousuk Seung <ysseung@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 7/7] net/sched: netem: fix slot delay calculation
 overflow
Message-ID: <20260404095128.GA113102@horms.kernel.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
 <20260402202037.176299-8-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402202037.176299-8-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,networkplumber.org:server fail,horms.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-275346-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,networkplumber.org:email]
X-Rspamd-Queue-Id: 3E51439AAEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:19:35PM -0700, Stephen Hemminger wrote:
> get_slot_next() computes a random delay between min_delay and
> max_delay using:
> 
>   get_random_u32() * (max_delay - min_delay) >> 32
> 
> This overflows signed 64-bit arithmetic when the delay range exceeds
> approximately 2.1 seconds (2^31 nanoseconds), producing a negative
> result that effectively disables slot-based pacing. This is a
> realistic configuration for WAN emulation (e.g., slot 1s 5s).
> 
> Use mul_u64_u32_shr() which handles the widening multiply without
> overflow.
> 
> Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Simon Horman <horms@kernel.org>


