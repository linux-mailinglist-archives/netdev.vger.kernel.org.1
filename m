Return-Path: <netdev+bounces-300629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s86RDBDrNGpNkAYAu9opvQ
	(envelope-from <netdev+bounces-300629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681296A43C5
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fs+GLxc3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300629-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300629-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 442AA3008A5D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6133F8D6;
	Fri, 19 Jun 2026 07:08:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82340D579;
	Fri, 19 Jun 2026 07:08:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852939; cv=none; b=LbA7zSrla01gbt1C+wJGlugzVtYbzwRMe9ptqc+AZ1W0hctp8K4NYusIlUl3JpOV7WCUWU3T35yWPWuqmCW8w1E3cWYZPv4nf4dOHq2BPyPHlUB49r63gqBSDKAJfILy0vIy+LhyrNfvRYhfOCkON3moNVr6NGg1Jh6n1eU7mJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852939; c=relaxed/simple;
	bh=J3TsOZyALZLv2Ge9eOw7b/RW9oDRDk51X8FkIq5J53A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UmBdGIgd+OaLmFqemToMyixryCLwV8+9VfcqboFVp6vuVOT0xT2JFwiYsEN6hgmmFhSe4RidJ8YZhrTJaWVFk4ROigICziiqJuoom0xzgxgLweqQ+dmZrqnKacjuhvbnR0/2b7bCNeqPXKaJQWfhca6BDW7bkDV8NijoCfUjXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs+GLxc3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AAF1F000E9;
	Fri, 19 Jun 2026 07:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781852937;
	bh=RIMQb1yKuHonfOKSP0klQ3dfROBzfdEbzclWDXcbWek=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Fs+GLxc3OUyph1MNj30Soz3TdK4Onl90fcB5kJ1XqOP/gM5N2AjdYeWiGC/Nun6wg
	 WCXX92qO1JIAjPSs/29HKhywK3UXqKGPJX73WIDN+IhEzSHXfFESMKxRw8Mamh7fIZ
	 dUX6IL08/yjwmSJhle8R34jB2SkqyUPX1MjPhI5ntYa4HzjdST5326x4CaoEm3ikS3
	 +eQBkvJLGsMWW0Spx2t+zFWAA3DxfV5K61I9Jjc4MZeEJjZstbTBa6wM/JGnhiwdQt
	 m93MbA/ZQWxZ/ma7GAlwtlO30P43TbxgNj9iNdMwgSoGIjs2DCVcmM+3LCWkVmKEbu
	 K0fpXUd2dsIjg==
Content-Type: multipart/mixed; boundary="===============3794738048082045466=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3166d652f38d3acdda9304a12482191496434a5c0b706318b4f0d6e194de8658@mail.kernel.org>
In-Reply-To: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,davem@davemloft.net,kuba@kernel.org,edumazet@google.com,pabeni@redhat.com,kuniyu@google.com,willemb@google.com,shuah@kernel.org
Cc: jolsa@kernel.org,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,horms@kernel.org,bobbyeshleman@gmail.com,jiayuan.chen@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 19 Jun 2026 07:08:57 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-300629-lists,netdev=lfdr.de,bpf-ci];
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
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 681296A43C5

--===============3794738048082045466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
>
> Verify that attaching an SK_SKB stream parser that can modify the packet
> is rejected, while a read-only parser still attaches.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

This test exercises the rejection of a stream parser that resizes the skb,
which is the use-after-free path introduced when sk_skb programs gained
access to packet data. An earlier single-patch version of this work
carried a Fixes: tag pointing at that commit, and it appears to have been
dropped when the series was split into multiple patches.

Should this commit include:

  Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27809861429
--===============3794738048082045466==--

