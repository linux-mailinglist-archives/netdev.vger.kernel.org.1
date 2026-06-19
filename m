Return-Path: <netdev+bounces-300630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VKF8OzPrNGpdkAYAu9opvQ
	(envelope-from <netdev+bounces-300630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:09:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5B6A43DF
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:09:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CQ4Vn1VL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300630-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300630-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 447CA306CC5E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1F359A89;
	Fri, 19 Jun 2026 07:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9623546C5;
	Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852941; cv=none; b=MgunTcYA2hCeEBFzsq0Q02qAqX/pJaDbEtIGuENpMxaDUfLjrJoGw3zGKysjzT5gR6JI7spK2dFSzmIjsazKmZznX4YO4iJ6DtPetzvJMS2RIXtM0LK9JXxxEx7L4yJAPT0CHN0nFSB/INk/7POK1hjzwL5SbvTkCyBiLwb2FM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852941; c=relaxed/simple;
	bh=Tiso43pDMy23Il4Q3L9MYRi/ohAadXxDqKPj23OKa38=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QTeFQ/4/86fTFGE3DaGCoWv8Y7vja7XP/7CqVCSpsrke1rUrH+yV2kOxPAzpQdHXf0Y0HsRtV/+a2ZQ3VgsQQtgBIE7MVL4dc1ncEUvoGjzjyy/D7a3zxOenS1cbqmHLLH83bSB202oDlL6U31v+I99zZ/MiOWKeuITOAtCYLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ4Vn1VL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E85C1F000E9;
	Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781852939;
	bh=5WrPA1KpRetg2BPKOpisB4uo6P3OEkWjhbEdh0thGZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CQ4Vn1VL8RscqXEuv1NxcGQshEZZTA2S7Vuo8i4BhrPNusZk6SyQTYA70qCi4Qs9Z
	 z5rYKO1HEoa2vDFWvfrZFV+NhxjoHV5QNeLQ1AXyS8MKFCJqFFW4bp4OCgm1LVHs57
	 t3V5g1DpEX1munMMvEMJA+Y7h7S7ZzoayVA5apTaGxjb+JxbZXMfUtTySb39j9ThyM
	 7JNBw95ZoIEwJLLQ024TG2Dkw2TNCb7NmexDNJtMVGF8euhO8QR20Yeq0i4AA7ixhS
	 5SuqH61Wj8aYXRMbOUijrZlKwqftkY5AAt2fxiP7C9K4jyUH/62HUfiM5Mv13/uPk5
	 0Q8aAkkU/gm2A==
Content-Type: multipart/mixed; boundary="===============1744918091706664894=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09e6a462b410be0756bf7c80ff66c27874ce0f3582e548f12625bd2794b95bc4@mail.kernel.org>
In-Reply-To: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-2-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v4 1/3] selftests/bpf: don't modify the skb in the strparser parser prog
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,kuba@kernel.org,edumazet@google.com,pabeni@redhat.com,kuniyu@google.com,willemb@google.com,shuah@kernel.org
Cc: jolsa@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,horms@kernel.org,bobbyeshleman@gmail.com,jiayuan.chen@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-300630-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,iogearbox.net,meta.com];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:kuniyu@google.com,m:willemb@google.com,m:shuah@kernel.org,m:jolsa@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:horms@kernel.org,m:bobbyeshleman@gmail.com,m:jiayuan.chen@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,cloudflare.com,davemloft.net,google.com,redhat.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A5B6A43DF

--===============1744918091706664894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: don't modify the skb in the strparser parser prog
>
>     sockmap_parse_prog.c is attached as an SK_SKB stream parser and modifies
>     the skb. It calls bpf_skb_pull_data() and writes a byte into the packet.
>     A stream parser runs on strparser's message head and must not modify it.
>     A resize frees the frag_list segments strparser still tracks, leading to
>     a use-after-free.
>
>     Make the parser read-only. It only needs to return the message length,
>     which keeps it attaching once packet-modifying parsers are rejected.
>
>     Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>     Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This removes a use-after-free where bpf_skb_pull_data(skb, 10) resizes and
frees the frag_list segments that strparser still tracks for the message
head.  The buggy bpf_skb_pull_data(skb, 10) call and the packet write being
removed here were added by commit 82a8616889d5 ("bpf: add map tests for
BPF_PROG_TYPE_SK_MSG").

Should this carry a Fixes: tag?

  Fixes: 82a8616889d5 ("bpf: add map tests for BPF_PROG_TYPE_SK_MSG")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27809861429
--===============1744918091706664894==--

