Return-Path: <netdev+bounces-289413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGi8Fc9KDGrHdgUAu9opvQ
	(envelope-from <netdev+bounces-289413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036157DB63
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64D903026EF5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3F480DF4;
	Tue, 19 May 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThOWcw+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240B23392E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189542; cv=none; b=HlDVtA4yAS5ooELwC3i9E1GOEY1MaUcYEqAJTzHAEwQeY7eZjrp28pkLogouGPsrxTVZyF/F9GVHIHEUK1JofsA6YiDdPQlCRBUjVrgJ/YdCUVGL2dKg6ItvMuJLAqYl54fYi9U9H+8H6myqVhYl6xc56pAlzUrj32Uhj/EB4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189542; c=relaxed/simple;
	bh=Ov4GDPN2ETdPra5n4pOJZFwWVsd5z7GrhE6ttDBAhOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eui4uGpD0wQikVUKY2fwhqV2Sq2DihWvW4SIwjFxbgTHiOAY398kKTvOaeLlwvU6NCxMVQnmPkaEJRq9U/fs5Qezc/5wY9dMK/te+h//Yju/Yfe4UpRTjIrkFPfe+3fUwm4R56ioB8CtsXNHs5LUHpNe7vPKgZ5YQFMxe3krbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThOWcw+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED4EC2BCB3;
	Tue, 19 May 2026 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779189541;
	bh=Ov4GDPN2ETdPra5n4pOJZFwWVsd5z7GrhE6ttDBAhOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ThOWcw+sc/uZv+JntCTVPGVhEWTUrisXErlDQA2zQzORvkG4bsMK2pBMnIJIrSoPs
	 2rnuwwqyf5NkX7NQUlt+0x+ei21MEBpJOr8HiKG9Dz7igUZKYOOIIjfWASGcTQh3A3
	 9GotdaL9yq/NvnjGTCPUUlWci8LMYnyk+/RdU0IknP3yzHS//QN3Zye1t8wcR1o3qk
	 jeMpXQKPbBAWi5TaaR4b5XJ+vvfnIZVwbCgU6X+7fdkO4f+JbKesWV4XD/mJVXWGUC
	 L/sLVLII0+oLhl8oLk7W0y5CvFbDyNl1MMq4zAyJBfwpa0rAQ2cxc4CcmerwXOZ+Sr
	 W6nQvTNxNTj0g==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E282E792C0A; Tue, 19 May 2026 13:18:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
In-Reply-To: <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 19 May 2026 13:18:58 +0200
Message-ID: <87cxyrmyu5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-289413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[toke@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,toke.dk:mid]
X-Rspamd-Queue-Id: 6036157DB63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rajat Gupta <rajat.gupta@oss.qualcomm.com> writes:

> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
>
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
>
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>


Also applied this to -net and ran the TC pedit selftests and the
pedit_* scripts in net/forwarding, none of which turned up any
regressions, so:

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

