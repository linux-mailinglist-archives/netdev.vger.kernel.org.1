Return-Path: <netdev+bounces-297634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cLkjDvRFKWq1TQMAu9opvQ
	(envelope-from <netdev+bounces-297634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:09:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E186689A1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:09:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cktHU6cK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297634-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297634-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BE13163986
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764ED3F9F4D;
	Wed, 10 Jun 2026 11:04:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA503F20ED;
	Wed, 10 Jun 2026 11:04:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089492; cv=none; b=gDvd1wylaTpm89AKoCInMONNLHOshN/BWMgavV7EHk7gA8hAKvzrtiaRnWWNADsq04JiNAS/3OvYK7WmlNlo5MCyNDW7o6/Kt6xCIuHLkiDSeMyfYyammHUd4Hk5PLiV4jf2w1Tvk0B2spRHzjYq9RTZzVcYbkKGDJxv0PE9s0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089492; c=relaxed/simple;
	bh=8yocV67OPMeJBR9JiIwG7Kj3THP8y9iRhOR01y14yG8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o0lZgXEmy1ThyPw6QSZ+wH+wU0LONjOSIHrmXgNrlgQAHHwdkvpgNgNu/ZD/rdaV86o4fAPVV3eRtUONZVchiG2X79Mrsqu+i8lKRnVJzS0E3a8pzsEQHAaOw4XKPr6lFlD1smXPlLNJTrfvN4pOUDH0MFZwq6Ybz306uqc7Q3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cktHU6cK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F11F00893;
	Wed, 10 Jun 2026 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781089489;
	bh=3LvvdeXPphzhkhPMpI1/NX6SyL61RLcN/O7gdww705g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cktHU6cKcrQaIFGD67yPO+Q+NVKfHy5T2VpvwmXjGb1Xyj+ym8jDBtr4vRRb7mBUZ
	 9EdTqbwa6VQsMIwEau9FemCoPwpIEqlR0atxfzDy+tUzL4P2NCn/OnrDwwQnMvx61q
	 uAd257yM4B94/FQsBhECsUgM7Of06F0ZM1at+vzjk+voCGZzoH07WqvrmY1eC3VauJ
	 4Zz+UGkZMuXNesUpg0IuuVwdvLY5oUMXWOhxe7WnuVtxgnnzox383tSRqIaRfAlls+
	 ziDFycKWZONZZw+aA/qv3qb8fY1f6MUwiC688Vu9iYNBErGFUB5m+Vj9kUz/zZlCXP
	 51rhVtN8pWlfw==
Content-Type: multipart/mixed; boundary="===============4880378473014713151=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ecc4ef518d8ecdc651dc7f8ebf7a36d40550c92740df0c3ea6db3c38a49848d@mail.kernel.org>
In-Reply-To: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,bpf@vger.kernel.org
Cc: menglong.dong@linux.dev,emil@etsalapatis.com,sun.jian.kdev@gmail.com,jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,liuhangbin@gmail.com,toke@redhat.com,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 10 Jun 2026 11:04:48 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-297634-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,etsalapatis.com,gmail.com,kernel.org,iogearbox.net,davemloft.net,fomichev.me,redhat.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:toke@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E186689A1

--===============4880378473014713151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     Generic XDP devmap multi redirect uses skb_clone() for the
>     intermediate destinations and sends the last destination with the
>     original skb. This can leave multiple destinations sharing the same
>     packet data.
>     This becomes visible when a devmap egress program mutates packet data.
>     One destination can observe changes made for another destination. The
>     last-destination path has the same problem: the last destination runs on
>     the original skb, so its egress program can modify packet data still
>     shared with earlier cloned skbs.
>     Native XDP broadcast redirect does not have this issue because
>     xdpf_clone() copies the frame data for each destination. Generic XDP
>     should provide the same per-destination isolation before running a
>     devmap egress program.
>     Fix this by making cloned skbs private in dev_map_generic_redirect()
>     before running the devmap egress program. Use skb_copy() instead of
>     skb_unshare() so that allocation failure does not consume the skb and
>     the existing caller error paths keep their ownership semantics.
>     Add a selftest that covers the last-destination case where earlier
>     destinations do not have a devmap egress program, while the final
>     destination does.
>     Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
>     Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>     Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Is the Fixes: tag pointing at the right commit?

The tag references e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with
broadcast support"), which introduced the generic-XDP multi/broadcast
redirect that clones skbs and sends the last destination on the original
skb. At that commit, though, dev_map_generic_redirect() only called
generic_xdp_tx() and ran no per-destination program, so sharing skb data
between clones was harmless.

The corruption being fixed only appears once a devmap egress program
runs on the shared skb data. That egress-program execution in the
generic path (dev_map_bpf_prog_run_skb(), gated on dst->xdp_prog) was
added later by 2ea5eabaf04a ("bpf: devmap: Implement devmap prog
execution for generic XDP"). The fix here is itself gated on
dst->xdp_prog && skb_cloned(skb), matching the commit message statement
that the problem "becomes visible when a devmap egress program mutates
packet data".

Would this be more accurate?

  Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for generic XDP")

e624d4ed4aa8 provides the clone-sharing infrastructure and could be kept
as an additional reference, but 2ea5eabaf04a is the commit that
introduced the writer into the shared-data path.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27270693851
--===============4880378473014713151==--

