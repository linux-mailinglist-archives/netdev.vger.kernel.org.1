Return-Path: <netdev+bounces-301253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J7ZkMw8AOmqfzwcAu9opvQ
	(envelope-from <netdev+bounces-301253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:39:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F46B3DA2
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UE+cMsR1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301253-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301253-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF7C03008619
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15038A73F;
	Tue, 23 Jun 2026 03:39:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76E337BAC;
	Tue, 23 Jun 2026 03:39:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185994; cv=none; b=JOLtR/AprX5ek0+Tp5SpWB61bly4RiQAFJEIxT6gcMA3wrAz9Mc2cI0kOLf4GJisTYg6pNqvIfyo6LzajhlhTqcYzbRJfSnpIQBnBBAYDxXVU7ERouRM7pbOtyDvJa5JusTxYrTU374NnjdDKQaiFEdH/Haxnk7PXHk6hdcJl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185994; c=relaxed/simple;
	bh=4rDFDSWIPN+GaR3KuHk5JKqQr8cXRoTADue0mfXb99k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cRX7XtPOJSnjyC0INsDFm48lwmlI3qP2qBXo9Y4aM+US4xh4wwvClEfTPhWr9T2r7MtztXyGe/8edwAVs4dEqK5vs/r3O8sU3QceLiu1c7OgWCJsn0B1InE4KztUCGX7DHc6hbgkj7x5WtB/j4QbN02mJMSOxWXc60t8FPHPQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE+cMsR1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5772A1F000E9;
	Tue, 23 Jun 2026 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185992;
	bh=X6sng07jg3BJFP9zD+bLGFxsbWYewF/i5x/VM+aUpb8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UE+cMsR12FbJmKUyPZnM2m//3XJEePFGV8KxLAOykD7wnKf8dJYTOcd5x7ekwJrcG
	 JsiR69tTYC2XNsCVGG9S2Ji1p4ZMk0mvmYDcDIzNJEayhxcMdl6INzlicl8sZvFCHN
	 hKSOjCx0xAo3q2RO9OzQuyYcPcFyWBnS+rBlQ8vcMIXVhmGHXhHSvkAkU0i06R/hTc
	 r9PuxGx1/GxC6qo4L5MYP2/ol/0Y3vbzBSa96ZSk619fK+BuX8FpnztMNKsxsgDvk8
	 hNJVABPkZ9bxvMC/i0r+pI83beTeXJHgA/vwzosc6xTV5ZqKPYNrOwUgBfwFNYMfWA
	 PffxLPuEjZkHQ==
Content-Type: multipart/mixed; boundary="===============6750014670296811348=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d7ccd7fa70ea8bf65dfbe87cd55c796c40088e4b2cb8dd690ad9a8681385168@mail.kernel.org>
In-Reply-To: <20260623025147.1001664-4-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-4-avinash.duduskar@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
From: bot+bpf-ci@kernel.org
To: avinash.duduskar@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,hawk@kernel.org,yatsenko@meta.com,leon.hwang@linux.dev,kpsingh@kernel.org,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,eyal.birger@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,toke@redhat.com,dsahern@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 03:39:52 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-301253-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,iogearbox.net];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[41];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3F46B3DA2

--===============6750014670296811348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
>
>     Cover both directions of the new VLAN flags in the fib_lookup test,
>     38 table cases plus dedicated cross-netns and XDP-redirect subtests.
>
>     For BPF_FIB_LOOKUP_VLAN the egress cases assert: without the flag the
>     lookup returns the VLAN netdev's ifindex and zeroed vlan fields, with
>     the flag it returns the parent's ifindex plus the tag (including via
>     a neighbour resolved on the VLAN device, in OUTPUT mode, over a bond,
>     and through a DIRECT|TBID table), with the flag on a non-VLAN egress
>     it changes nothing, for a stacked VLAN (QinQ) it returns
>     BPF_FIB_LKUP_RET_VLAN_FAILURE with params->ifindex left at the input, a
>     lookup without the flag returns the inner VLAN device's ifindex, and
>     a frag-needed return reports the route mtu in mtu_result while leaving
>     the swap unwritten.
>
>     The VLAN_FAILURE arms are IPv4. bpf_ipv6_fib_lookup() restores
>     params->ifindex with the same save/restore the IPv4 arms exercise, so an
>     IPv6 VLAN_FAILURE arm would only re-test shared code.
>
>     For BPF_FIB_LOOKUP_VLAN_INPUT, an iif rule on the subinterface routes
>     the same destination to a different gateway, so the asserted gateway
>     shows which device the lookup used as ingress: without the flag the
>     main table answers, with a matching tag the subinterface's table
>     does, with or without SKIP_NEIGH, and BPF_FIB_LOOKUP_SRC selects the
>     subinterface's address. A VRF-enslaved subinterface selects the VRF
>     table through the l3mdev rule and, with DIRECT, through
>     l3mdev_fib_table_rcu(). One case sets BPF_FIB_LOOKUP_VLAN as well and
>     asserts both directions work in a single lookup. Resolution semantics
>     are pinned: an 802.1ad tag resolves its device, PCP and DEI bits in
>     h_vlan_TCI are ignored, a VLAN ifindex resolves the inner QinQ
>     device, a tag on a bond master resolves while the same tag on the
>     bond port does not.
>
>     The error cases assert -EINVAL for an invalid h_vlan_proto on both
>     address families, for the TBID and OUTPUT flag combinations and for
>     an unknown flag bit, and BPF_FIB_LKUP_RET_NOT_FWDED for a VID with no
>     configured device on both families, for a VID-0 priority tag and for
>     a device that exists but is down. The failure cases also assert that
>     params is left untouched. By contrast, a no-neighbour case whose
>     input and egress devices differ asserts NO_NEIGH reports the egress
>     ifindex, not the input: only VLAN_FAILURE rewinds params->ifindex to
>     the input.
>
>     A separate subtest moves a VLAN device into a second netns while it
>     stays registered on its parent, and checks both directions refuse to
>     cross the boundary: the input flag fails closed with the tag and
>     ifindex untouched, and the egress flag returns
>     BPF_FIB_LKUP_RET_VLAN_FAILURE without publishing the foreign parent's
>     ifindex.
>
>     The tbid read-back check is skipped for DIRECT cases that set
>     BPF_FIB_LOOKUP_VLAN, since a successful swap packs the vlan fields
>     into the union the check reads.
>
>     Re-run the cases through bpf_xdp_fib_lookup() as well: the egress flag
>     exists because VLAN devices have no XDP xmit, so XDP is the primary
>     consumer. bpf_prog_test_run uses the netns' loopback for the xdp context's
>     device, so the lookup runs against the test netns' FIB, and the
>     path-independent results (return code, swapped ifindex, vlan tag, gateway)
>     are asserted to match the skb path.
>
>     A live-frames subtest (test_fib_lookup_vlan_redirect) drives real
>     frames through the XDP redirect path with BPF_F_TEST_XDP_LIVE_FRAMES, the
>     native xdp_do_redirect() plus xdp_do_flush() path. A reducible VLAN
>     egress is redirected to the physical parent and delivered to its peer;
>     a QinQ egress returns VLAN_FAILURE and is passed to the stack, since
>     redirecting to the VLAN device would drop the frame at xdp_do_flush()
>     (no ndo_xdp_xmit). The redirect program distinguishes SUCCESS from not;
>     the table and netns arms pin the exact VLAN_FAILURE value.

This isn't a bug, but could the changelog be tightened?

The description runs roughly seven paragraphs that walk through what each
group of test arms asserts: the egress arms with and without the flag,
the input arms and VRF table selection, the error arms and their failure
modes, the netns subtest boundary checks, and the XDP redirect subtest
behaviour.

Much of it carries rationale, so this is a soft observation, but someone
wanting to understand the per-case behaviour can read it more quickly from
the test table itself. Could the summary focus on the why (the two new
flags and the invariants worth pinning) and lean on the test table for the
per-arm specifics?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27999579457
--===============6750014670296811348==--

