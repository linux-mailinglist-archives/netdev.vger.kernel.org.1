Return-Path: <netdev+bounces-281114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1l3rHPil7GnkbAAAu9opvQ
	(envelope-from <netdev+bounces-281114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89246621D
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 13:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B4830086F1
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE9337688;
	Sat, 25 Apr 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHqOfS1J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F129C8EB;
	Sat, 25 Apr 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777116658; cv=none; b=kv1R+6F25+f2ou+AUPL+ILgsQJSTApDQFokk2ArbKI/szOeHDJ3d5xDvE0tmYoiwmONXVdQx5kIzih6fI7qpa8lOnN8EclvsBbLPOb8ILv09alHC+OAZ+oTkijBiYDSaAlpQyWsmr4YbA3kpBda2KV0AeoM40Gfkqvu5zcKNMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777116658; c=relaxed/simple;
	bh=MORXr9SGKR+wqjXq7SNYz7X5HKHjTUaYDZyJdeIRxOc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fqN4b/MPjAyKNy0BUsQ++WXZSuOshVspXzMLaPvymieg6dpySi8FnrbHFshLAHMZ/txvMYOHECOK8Oo5jMCwlo3PiDWDCeOfHXp439vZAzjOXiiRDzKmAgpe2bfty9XsVwB1WV7WaaFS1lYpG56Y1nTdFwG74FdWCZq83OraZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHqOfS1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744E1C2BCB0;
	Sat, 25 Apr 2026 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777116657;
	bh=MORXr9SGKR+wqjXq7SNYz7X5HKHjTUaYDZyJdeIRxOc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MHqOfS1Jtnrc0Vxoj3qgdfJ8zP9PNEUJEjmiecXKX2+C/Owj2GkCgLt7ZE248F/aW
	 KYAv9U0dsLFNR/YIBxJZS+M6ZwurPH7chL9wX6fvpUPqlfeb7yzKx9BllRZWmpPeCZ
	 w1dBtWYPYaHbvkOjfcQrCTHjltlRGqKMeAA6gknewFpaITRFXO1DJ7zLfL3sLv49Dh
	 NjTgULpwQ8+Dx75GaqKxx0MN4hGXxiLd4mfJtTuVkdbwUZ05KZ1dRbwMXTFMUHl70m
	 hE6LzKE6r3NOOL8hg3+i/Kpa6hbELWk87aInUdU+/GCDyHD786Ge0O+HyAV9Qhc5eJ
	 dhnP99FlzbnCg==
Content-Type: multipart/mixed; boundary="===============1690637911250886597=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bdc69ebfb2c195ff1805ea4bcee33fef37570b1c49392902f421c0aecda76735@mail.kernel.org>
In-Reply-To: <20260425105942.223757-3-jiayuan.chen@linux.dev>
References: <20260425105942.223757-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v3 2/2] bpf, xdp: move offload check into dev_xdp_install()
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,sdf@fomichev.me,willemb@google.com,skhawaja@google.com,liuhangbin@gmail.com,krikku@gmail.com,kuniyu@google.com,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 25 Apr 2026 11:30:57 +0000 (UTC)
X-Rspamd-Queue-Id: 5E89246621D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281114-lists,netdev=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

--===============1690637911250886597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e59f6025067c..8635de70efe7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10359,6 +10359,11 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
>
>  	netdev_ops_assert_locked(dev);
>
> +	if (prog && mode != XDP_MODE_HW && bpf_prog_is_offloaded(prog->aux)) {
> +		NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
> +		return -EINVAL;
> +	}
> +

While this check addresses offloaded programs (bpf_prog_is_offloaded()),
does it cover device-bound programs? Looking at dev_xdp_attach(), there
are two distinct checks that were in place:

(1) bpf_prog_is_offloaded() check - now moved to dev_xdp_install()
(2) bpf_prog_is_dev_bound() && !bpf_offload_dev_match() check - still in
    dev_xdp_attach()

A program loaded with BPF_F_XDP_DEV_BOUND_ONLY has dev_bound set to true
but offload_requested set to false, meaning bpf_prog_is_offloaded() will
return false. When bpf_xdp_link_update() calls dev_xdp_install() directly,
could such a device-bound program bypass both checks?

If so, this could allow attaching a device-bound program to an SKB-mode
link, potentially causing the generic XDP runner to execute device-specific
kfuncs that cast the generic xdp_md context to driver-specific structures.

Additionally, if the link is in HW mode, the new check evaluates to false
(mode != XDP_MODE_HW) and validation is skipped. Can a program offloaded
to device A be attached via BPF_LINK_UPDATE to an HW link on device B?
If so, the driver might receive XDP_SETUP_PROG_HW and incorrectly cast
the new program's aux->offload->dev_priv to its own internal structure,
resulting in memory corruption.

This concern was raised by sashiko-bot in v2:
https://lore.kernel.org/bpf/20260425104435.ED443C2BCB5@smtp.kernel.org/

>  	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
>  	    prog && !prog->aux->xdp_has_frags) {
>  		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
> @@ -10510,10 +10515,6 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
>  			return -EEXIST;
>  		}
> -		if (!offload && bpf_prog_is_offloaded(new_prog->aux)) {
> -			NL_SET_ERR_MSG(extack, "Using offloaded program without HW_MODE flag is not supported");
> -			return -EINVAL;
> -		}
>  		if (bpf_prog_is_dev_bound(new_prog->aux) && !bpf_offload_dev_match(new_prog, dev)) {
>  			NL_SET_ERR_MSG(extack, "Program bound to different device");
>  			return -EINVAL;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24929498218
--===============1690637911250886597==--

