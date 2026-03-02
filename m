Return-Path: <netdev+bounces-262677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JG1KACgpWmuCAAAu9opvQ
	(envelope-from <netdev+bounces-262677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:34:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E91DAF18
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5E9B306B599
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AF3E5560;
	Mon,  2 Mar 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Gjp0Yh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6A3FB07B;
	Mon,  2 Mar 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461944; cv=none; b=eY2hbfoDy+g3HKaGT4V5u/F2AXeKXJja8qvgZihmmShKu39WtrUiVdvPc/Hz9dBJrHSkr2FPIIttoomURca4Wr3KPTqxceMeGLbJA5SriGMmTjBuzbBIahM3y9KTCuSP0ZXHTyVKSyLbyyu3T6vBDt621pnXQruxWAmhbN2m1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461944; c=relaxed/simple;
	bh=h6k0adrxzs8tkznFMKKZtLodMFWceJNPI6vZne9JVG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGfBubfjXqq5g3CbAja+wYG9ZzG5ojcDS6LFTeE73zI5HSmTwCi4k/Te89UBe5X6mNtjya8um6cGwg+9awoFZujZ1epZL0d0zfj98BJUld7YHl2m+A9W8dezpE0BD2WnG6NOCbGYsx7tE0lDbxSTyIdd1aexVpG9SrsHS6VAdiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Gjp0Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85585C19423;
	Mon,  2 Mar 2026 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772461944;
	bh=h6k0adrxzs8tkznFMKKZtLodMFWceJNPI6vZne9JVG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1Gjp0Yhe+m74gNVLN5sOY5kAfHd6jtg9FuSHLyYTgdE0nVMLHDFxNQFFrUZMhSQP
	 0dqIC0KksYWl++2xlAULAYrCn6i2dpJgDz17hkce/InpwKVpx3HaPxrSw8XjYi9oSJ
	 uRtwaado77UamHltgEpz+BEcSRYdVRE7DYJYuau6MCLKQHbrz1+SLuH80Bd2cwRx8q
	 BBsY4/T9k1u9tKNmnn38Fyq6kYRsve8jvpDzBpodzAmw2Egp8uqF5VKBJolA5LaClj
	 EApG5RPYxGeEaUn2uHTmTGHAsps2XbTu6hC8RU0PFSTXOIWaQuw3r9vPGY9AvmbnCH
	 orH3DddAAtdFA==
Date: Mon, 2 Mar 2026 06:32:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 shuah@kernel.org
Subject: Re: [PATCH net-next v3 02/14] net: bridge: mcast: track active
 state, adding tests
Message-ID: <20260302063222.068b000b@kernel.org>
In-Reply-To: <aaVFmtS1hdYSYRZR@sellars>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
	<20260302054008.21638-3-linus.luessing@c0d3.blue>
	<aaVFmtS1hdYSYRZR@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 481E91DAF18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262677-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 09:08:58 +0100 Linus L=C3=BCssing wrote:
> But why does shellcheck list so many errors with
> "This function is never invoked." Even though they are invoked
> with my above command?

It can't understand the functions called by run_tests.
We should probably disable that specific warning.

> I also don't get what netdev/check_selftest wants from me. I only
> see "FAILED" here? https://netdev-ctrl.bots.linux.dev/logs/build/1059784/=
14444497/check_selftest/summary

This one want alphabetical sort of the selftests in the Makefile
--=20
pw-bot: cr

