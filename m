Return-Path: <netdev+bounces-252594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOnvKnHUcmnKpgAAu9opvQ
	(envelope-from <netdev+bounces-252594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:52:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73B6F618
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 152E8305AEEC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0236827F;
	Fri, 23 Jan 2026 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/IfW4xu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70531282E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132905; cv=none; b=OjDTOlxz9YI+UEi4AupJHAEMS3Ok8dQWCV2cOwkqeWiUUoxeAiEEh7kkpll84SmPmFeFBUeCjRHCLnf4Lhc5DhiJyVtgxQsypoB9mDJttHRaURWZnp1R4ciiM5JNemP/LdwP2/InOMW65HvGExMqKKZS24pX0ZK3iAF7erFR6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132905; c=relaxed/simple;
	bh=Z0UHI2LTFgIv/loWWCM5jw6r8E+O0f0YNdfwY4NyVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkLKNH8HrYcOh0u14kwfY9kFeZrlmHE6BKECc7R+l7sABFrfGI6B9IhdSmW2kbYJ0eqQ+r96mC3NPslPDpe6yTOVsxtSkkwDhNQuf+H1nMqjcKbCeV0CrThHrWh0lbRJIzeM7SMejhuVJ9BMprUu7qAmwMsKaj8EHYFyX5fVuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/IfW4xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE6BC116C6;
	Fri, 23 Jan 2026 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132903;
	bh=Z0UHI2LTFgIv/loWWCM5jw6r8E+O0f0YNdfwY4NyVP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/IfW4xut/bHAeJkmzraZYFVdwuxQpdvTVVkJ+dLefZRRVkOVgrX/kBaeG7a1RwbK
	 nIHiVN9M3ZrI7iNDBjcNGS9vQ9kVKkEPaRXc9etsWb+Bwt2pZnKTrbHxN3b4KN6rG4
	 X0634po8VT0hdsAWbYFhU3kNKP0JuGZB92cBortlEnVSBkh0CXA5eGn0d09lxl7TLB
	 4SzPcGqqIWBm4bx1/jD9FCXb5sIvLQhIhMLA8zgsFYzCazWj5BE0yEy14Jn7d3p/Tk
	 6fE8usGpxUrm3+L9ElE36sAdj7s22e5Gz7dLpKn6msAyW3Q8auPiinGBRYOrxNgBU3
	 nrJF2WgSiSJRw==
Date: Thu, 22 Jan 2026 17:48:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
Message-ID: <20260122174821.70553ffc@kernel.org>
In-Reply-To: <20260122192851.86670-1-rjethwani@purestorage.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-252594-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C73B6F618
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 12:28:48 -0700 Rishikesh Jethwani wrote:
> - Rekey handling: HW offload key update (rekey) is not yet supported.

Not sure this series will be merged without rekeying.
We'll need to discuss pros and cons.

> Testing
> =======
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> 
> Both TX and RX hardware offload verified working with:
> - TLS 1.3 AES-GCM-128
> - TLS 1.3 AES-GCM-256
> - Multiple KeyUpdate cycles (rekey)
> 
> Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree/master
> 
> Please review and provide feedback.

Selftests are a hard requirement, I already shared a link with more
info with you.
-- 
pw-bot: cr

