Return-Path: <netdev+bounces-263550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMTSISWWp2nLiQAAu9opvQ
	(envelope-from <netdev+bounces-263550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:17:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E11F9D0E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6B93051C88
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0421D3E2;
	Wed,  4 Mar 2026 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThPVbcQu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9E3368A4;
	Wed,  4 Mar 2026 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590623; cv=none; b=cpiSXHsdOgJmgn5Aa7rbStHdR0XPR7YUm/cb4bMydfiu6F1akqb1cqN7HtLvh6oIdeEO4Xa6JO86H5pdhU2MFWN2HVyGFW3d9TQOkWt6a+Fd1+aBZRLqdogMNffnGfuYC3PIOdh4+qNhLrmdEBsnInmx5XBCuUDn9PMmpLUunrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590623; c=relaxed/simple;
	bh=t2bZFUYHm1W9xUuUZukYndUcowPUzNc605Rlr2AcCJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PujUQ6GSMbHTt4owXVexUkMrln34zt0sJ86NDdy6rPeCcck/Qd0sUafAsiJWfanA/aDcKK9teftg5wy2Ik+95ONd/I4LOHDaKrj570vnMidhBd8imgyuGvKPluoY+qL7NzBnewi7czOMTV4Rct3cTy3Ms96kLfxAGwop1ldf9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThPVbcQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32C4C116C6;
	Wed,  4 Mar 2026 02:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772590623;
	bh=t2bZFUYHm1W9xUuUZukYndUcowPUzNc605Rlr2AcCJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ThPVbcQuv5BwK48/TIlJVKmGDYHLhZTWyAPG4HE1VshgkdT1ybXmZVE7Uv6x0Ct3Z
	 F6Kt0LFbkaxjkrMj5CZBTUTnx90KroMfEE7+nfBLX5TqIpFIK3Yvi+ldoXSL4+QpGk
	 XS50DqT/W2x0LarIQL4ud8QmqEvsVP4F5urP1WQOlWt80uBkKs/pdWjWJyO1FjVzWE
	 A4UJrZDa7gTdVIMR9LPVCCKhgu39mQTyW+ZErQk2vFEsA21Qrov29L3bl7kPkfPXHl
	 EdvXpZqNnFGyvC0WJ8/O1HSD4ytzhExLjpyLDQKmpP0lgRI7E5uEsEBFO5fET0KoqQ
	 35YVfA/CppjYA==
Date: Tue, 3 Mar 2026 18:17:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mr.navi8680@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, shuah@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tc-testing: fix list_categories() crash on
 list type
Message-ID: <20260303181700.25878b2a@kernel.org>
In-Reply-To: <20260228074735.10438-1-mr.navi8680@gmail.com>
References: <20260228074735.10438-1-mr.navi8680@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 182E11F9D0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263550-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 13:17:35 +0530 mr.navi8680@gmail.com wrote:
> list_categories() builds a set directly from the 'category'
> field of each test case. Since 'category' is a list,
> set(map(...)) attempts to insert lists into a set, which
> raises:
> 
>   TypeError: unhashable type: 'list'
> 
> Flatten category lists and collect unique category names
> using set.update() instead.

How did you find this issue?

I can't figure out what's calling this function in the first place.
-- 
pw-bot: cr

