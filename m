Return-Path: <netdev+bounces-267735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHlQMwJstWlJ0QAAu9opvQ
	(envelope-from <netdev+bounces-267735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1E28D6F3
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5334302E40F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85C2459C5;
	Sat, 14 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHq60I1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABA13DBA0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773497344; cv=none; b=AKE1827pjjzBadzxhwmNRSnQ6CPPn6Q8zZ+hZBFcGuhKscMWhn2ZudAUT95PPINnQ3g4hFuNbQNj50FvjeL5JXu+K4+QTqRwDRgV6UcmC/Lx7KeeMAKRWYZHWPm8+fNwBHzpVQKtergY7NqY4F03DkM6pndvhJfSLPKPK/2vEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773497344; c=relaxed/simple;
	bh=JeZBxGCWTdgnXP24AZ2xzC4EEtua14BDZ4rDTKgA530=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh3DDYPSEoAKGLUczqCF2X6NWuTDG1zBmKvk+i3gKhhHCDPZblUP9v7dYyCc/dbVtPs+s6u935+qP0oi089uM2/SCyTKX5cotJ1ba7mZFmlquu6lTuqlE7C6tON/wjPtW3TaPfhL4WDfGeM/BxEDg29GYbPynmJsdEe3cSHhbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHq60I1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28EEC116C6;
	Sat, 14 Mar 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773497343;
	bh=JeZBxGCWTdgnXP24AZ2xzC4EEtua14BDZ4rDTKgA530=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHq60I1rfSm0Qcqq5pRaoe8+LR3P4vrdZzFNzrdYsxEWGir5l/Yc9pjO3d5HW6jNQ
	 104bzJF9qo2FzAETRPEOuZJJ8+PUPdjsxhj9O3eTOYvJVXn/dtH2Cili5ESfb2bcZx
	 4gBVel9PQfwri33zOmqAUChOyzEtmsL0mU5KotUvSiH3Y9KOssE8iHm8HrIwzM9Lbc
	 tDOPi3ottYyLJnEI6URma8mvVAFpjpdGdWU1SNx6cdHsqvc1grKt48kv5Vg/ns329Y
	 atAkudt1gqOEbUzC8EZ1o4XBZiHPhfrmtEaaRfm3WFs8sGHDD3QL0whZrtaNnypYuE
	 aSJimDP5Rsi+g==
Date: Sat, 14 Mar 2026 07:09:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] netem: fixes, cleanup, and selftest
Message-ID: <20260314070902.4025c388@kernel.org>
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5FD1E28D6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 14:15:00 -0700 Stephen Hemminger wrote:
> The netem packet scheduler is widely used for network emulation but
> has not gotten enough of my attention lately.

There's a few tests in tdcs which need adjusting:

# not ok 363 d34d - NETEM test qdisc duplication restriction in qdisc tree in netem_change root
# Command exited with 0, expected 2
# 
# not ok 364 b33f - NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root
# Command exited with 0, expected 2
# 
# not ok 365 cafe - NETEM test qdisc duplication restriction in qdisc tree
# Command exited with 0, expected 2
# 
# not ok 366 1337 - NETEM test qdisc duplication restriction in qdisc tree across branches
# Command exited with 0, expected 2
-- 
pw-bot: cr

