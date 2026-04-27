Return-Path: <netdev+bounces-281329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILl6AYFk72mHAwEAu9opvQ
	(envelope-from <netdev+bounces-281329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:28:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C655347362A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AC2E3036EA8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC193CBE6F;
	Mon, 27 Apr 2026 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt7rqbCa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A783B961E;
	Mon, 27 Apr 2026 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296374; cv=none; b=A7rVRQ8dQccUI27pVx4W/0BfZmlI7PcDJqYZ8f6d4J3ds1yDMDjNl9eBUAA0L9y7czXqDsdbFEiQEhrLMUzVK+g1qN4aFPuud/OHlTdcgCIGJMKbouwLCLprFLk6Pv16r53Q5Wig6khMmMHDJwWX7XgLSztUZGePyuBtR7Q7BhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296374; c=relaxed/simple;
	bh=BDkj7YVQFAxjnxnHDRny4xojTgohXtJAYQ0d9twVMMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKAVt5H8zWEUzttq/G/V0w4qhQJe3g6keIZf1YWCYznLLNW2S+/zt3lfrr+n2uyrhIdW2MLaa5VfhEaMmLhRKe7LAFk2vMYCmE9M9UxcFv6EIkZCgYRWcOkJnoAIqsfp7NWybyhzB+RtphHW2Zda45NNSkrQjrClzGHtmi8mkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt7rqbCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFF5C19425;
	Mon, 27 Apr 2026 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296373;
	bh=BDkj7YVQFAxjnxnHDRny4xojTgohXtJAYQ0d9twVMMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt7rqbCa543sSR7MZQrstQeoTj9Okopjt49rNPG5QZvzjmY92/FVflkpGFT0C9odc
	 sqmF8er7GOWbYpPXDU37Mkmn6YxgwGmZNfljmcHKk9mLDw5+A5eIllwsBWvl6lLQiR
	 y/ynbsk1BexGUrSbfQMglqxSQY7aspV+OSe2zvyZQ82JEMD9bR0tCGZOP2bgRtMqpr
	 P4tlTLguMZGaAcQYL/dFZLprJ8PVQPGa1MWQ4SHSnPLadqJgxhpMMJHKdnzi46tGf6
	 LCYWsTPv89j4uA4ieuEVyVDo8pm5TGilSW00wICgLQPXhcCi28HxswG2/uQh7dMfxe
	 goT38IN/8y5kQ==
From: Thierry Reding <thierry.reding@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: linux-next: build failure after merge of the bfp-next tree
Date: Mon, 27 Apr 2026 15:26:02 +0200
Message-ID: <20260427132604.3754048-2-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427132604.3754048-1-thierry.reding@kernel.org>
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C655347362A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281329-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi all,

After merging the bfp-next tree, today's linux-next build (x86_64
allmodconfig ) failed like this:

    ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
    ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!

Caused by commit

    b93f7180f0bc ("bpf: use accessor functions for bpf_reg_state min/max fields")

It looks like the issue here is that these new accessor functions are not
exported symbols and therefore can't be used by a driver that is built as
a module.

I've used the previous tree for today's linux-next.

Thanks,
Thierry

