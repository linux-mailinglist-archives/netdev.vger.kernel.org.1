Return-Path: <netdev+bounces-274579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BuoMoR/zmkqoAYAu9opvQ
	(envelope-from <netdev+bounces-274579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A28B38AAC4
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025963043FA9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7D3DEFE5;
	Thu,  2 Apr 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiunMrka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2562D0603;
	Thu,  2 Apr 2026 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140522; cv=none; b=RV9byVoqZuAe5zEaiEeKSvUdbQkKVAOyOyTtEpT1n+poyyJBawwfWNcTdG/jyhnGKGBIYSXWz/T92RdMIQp5vOr7sV/4J+HBLf+uESA4Ubhco7+6aR55CN8G7vH+XWQSn1BxTbRuIe1qw8pEXkzCP8qYaf9Xr0jPkldAt/0ElaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140522; c=relaxed/simple;
	bh=Ehxrl/qgHg9vBeDxMprCB7n2Uvojn/WK7PPS3gbJYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSrCpzMAg1/biB6498u9vjr+/XNlzNks+laQK3EaMLTAwoaOujElN3yOAhYTwh2ZHJPglP5pVPTCoQNJ65H5o18CG11gKg0Vp/7Vc6pqD9ALyArwEvMJ4Q/XFb2a1LKSSIOc8W7jFaLmp78aKEf3e1Y6H8NC/+C/nEOjlrDD/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiunMrka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90091C116C6;
	Thu,  2 Apr 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140522;
	bh=Ehxrl/qgHg9vBeDxMprCB7n2Uvojn/WK7PPS3gbJYeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiunMrkaAWdLyhJiicbHDYHGMgx9FVWLxhMJombymF+QtBSKfB/SLKmKRTxmzb/Pz
	 JGmkTsvxvsIJFUwgMTkZ2i/sbh55iY2CfC6hHiP/UdLgLNfN5c4SSuGMkV0ehhvIhy
	 oaV+H5aR4tlMI1E5kuzHQsFSq34EylEQY71iqYur19GW6ZMIE5zS1Ou+FZGbkgbh/7
	 +PDeiLvWUMRUomBsIjh6yTCWhqSocIxdhmc+jTMy4zhsHjuA1P20HdlzfuF2EyqTv4
	 z7Tcle4m9m75f88ha3TeJjTeA3vwx99wFrTQjsVQuGiLl1YoXhKrpajZYQi7UJ+yy9
	 aCUcIakwqUUTA==
Date: Thu, 2 Apr 2026 07:35:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Message-ID: <20260402073520.697dde02@kernel.org>
In-Reply-To: <6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
References: <20260401052746.314667-1-leon.huangfu@shopee.com>
	<20260401132048.3a15601e@kernel.org>
	<6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-274579-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
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
X-Rspamd-Queue-Id: 4A28B38AAC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 11:22:15 +0800 Leon Hwang wrote:
> >> +def test_xdp_native_update_mb_to_sb(cfg):
> >> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
> >> +
> >> +    _set_jumbo_mtu(cfg, 9000)
> >> +
> >> +    attach = _exec_cmd(cfg, obj, "xdp.frags")
> >> +    if attach.ret != 0:
> >> +        output = attach.stderr.strip() or attach.stdout.strip()
> >> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
> >> +
> >> +    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
> >> +
> >> +    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
> >> +    if update1.ret != 0:
> >> +        raise KsftFailEx("device fails to update multi-buffer XDP")
> >> +
> >> +    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
> >> +    if update2.ret == 0:
> >> +        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")  
> 
> From sashiko's review [1]:
> 
> On architectures with larger page sizes, such as 16KB or 64KB on ARM64 or
> PowerPC, a 9000-byte packet can fit entirely within a single buffer. In
> these environments, the driver might legally accept a non-frag XDP program,
> which would lead to a false positive failure here.

Yes the test is indeed not checking all the corner cases, it should be:

	# set mtu to 9k

	# try attach xdp
	# if ret == 0:
	#    return // must be 64k pages or something

	# try attach xdp.frags
	# if ret != 0:
	#    raise SKIP // driver doesn't support multi-buf

	# defer xdp off

	# try --froce switch to xdp
	# if ret == 0:
	#   raise FAIL // replace is missing a check

