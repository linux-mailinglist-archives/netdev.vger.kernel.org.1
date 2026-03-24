Return-Path: <netdev+bounces-270857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEvyAP39wWnqYgQAu9opvQ
	(envelope-from <netdev+bounces-270857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:59:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78960301647
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B4930E28EB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B71388E4D;
	Tue, 24 Mar 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQBVD4ZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CD1FE44A;
	Tue, 24 Mar 2026 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320944; cv=none; b=SbhknaTmdOv5jzmX1SiRt3Q4Yh188SY/mE/qxLi2UyEHIhq+8MYf+aqvgwM/PMF8UL/mYQ+afEHSSNsNXGjGtXtPWIWRcfMjys5lEILPagXVEGmtNssF6PkGMZtaeriG1IIY+Zm3EvRhv/PdhPjYOSBugD9mEsNAHtA233KITYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320944; c=relaxed/simple;
	bh=vzAozaHxHyYXZ8Jh+qes1mIbLCj58jvj1PBcxongusg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leWQHLEw53uDdpBnTgIBo7DOeDRZqwCx/tgU6fuvJ5pOQdfrhR5VcWfZskNOma5wJ2B1kgQjqhnbiK3ZmMbhVkIlKzXDsv+9cDqxWDERFM3ECtbNAG6ixgbh98TppUmG89smb5vwLhs74X0oD0A8hRyMDU3ezYfcNKV7raf59ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQBVD4ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC7C4CEF7;
	Tue, 24 Mar 2026 02:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774320944;
	bh=vzAozaHxHyYXZ8Jh+qes1mIbLCj58jvj1PBcxongusg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQBVD4ZKw84JugKdSWYbkfbSxfiHeyfN0/0qwqNz/rMcf83zzw/VxqIm6dygIChJw
	 VVbPaVZupAJQYSSWtJwHdd8sSP7s363jZiT+A7VSB4dJWWe75VxPG3pSfOTcrC7g6l
	 Esif34I52mAGAq2REh1cDhJDo1KAuVrxa12HP2TrZVoKNlIro/cw6UMxZX292D0ppx
	 1OzhL6I2JUJnUS8vu5isBbyfnB5RHVP7jA9tS2F4r6LAWOHg1GO9xiFIi0U+6oXb++
	 3TARATJNXDlO2z+3bo/8awHUhOVPQF2Pt7wYt+OCAsKuGGd9W9j52Me0O1WhB/BXhY
	 TEafTloL0pQNg==
Date: Mon, 23 Mar 2026 19:55:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v9 14/14] selftests/net: Add queue lease tests
Message-ID: <20260323195542.18ea6ac7@kernel.org>
In-Reply-To: <20260320221814.236775-15-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
	<20260320221814.236775-15-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78960301647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 23:18:14 +0100 Daniel Borkmann wrote:
> Add a selftest for netkit queue leasing, using io_uring zero copy test
> binary inside of a netns with netkit. This checks that memory providers
> can be bound against virtual queues in a netkit within a netns that are
> leasing from a physical netdev in the default netns.

ruff check says:

tools/testing/selftests/drivers/net/hw/nk_qlease.py:16: [F401] `lib.py.ksft_true` imported but unused
tools/testing/selftests/drivers/net/hw/nk_qlease.py:86: [E741] Ambiguous variable name: `l`

Please look thru the Google review as well:
https://sashiko.dev/#/patchset/20260320221814.236775-1-daniel@iogearbox.net
-- 
pw-bot: cr

