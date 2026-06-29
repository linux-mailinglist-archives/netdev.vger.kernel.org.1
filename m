Return-Path: <netdev+bounces-302762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+BnLiS0QmrX/wkAu9opvQ
	(envelope-from <netdev+bounces-302762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3C6DDEBB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hc76mXVB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302762-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C22DF3003363
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059E346766;
	Mon, 29 Jun 2026 18:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEC2D0C7E;
	Mon, 29 Jun 2026 18:06:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756384; cv=none; b=QotSf8HKxr3S0EwQaseZMr1Q/pL83RdYYP20GzwPG0S1tbv44AZx+cfhSYvQ3zTAnsHEHJP2eHFHiVYno3Ms0ypexzes9jWFPXzYqEntLABhW/QTqy1kgiplg4/zw0nSg4uL8pJULklSQEbxVjtGgvZ1fXrYGb2YwBdrn7SGmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756384; c=relaxed/simple;
	bh=ISc5SyCOpS0axCv9I7/0PAfvIIvOLejgS1CCA3ntoB4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SYP8aNoVut9iwZzlHnkTz3+1hk/LIY/ygUsiYBqbIG/u+W4ZhjKQtCyFCaJjQaWFlXYtebuW7JlYl4+nRhWT2KwoqVibhPBsYLHJTqQrsGx/HhsIB7yAta3YvcCv55Pov2N7fFO5DXmVVUCHsD/VRob6U6Nv5cYETyV+sUIGa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc76mXVB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABAE1F000E9;
	Mon, 29 Jun 2026 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782756382;
	bh=15dZbETBPdvycW7dlHbmw19eotEmkycpFDuovtTBY5E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hc76mXVBx/xAmA7fOoTVWhqc9v3QMpG7oxGdePrhTwK2EQT2W0AnO0bFLcVDKAVT/
	 gQmj6yjP99RURYeZUj4aei4iRmS+4iK0Y3YAF8UxW5TVsQg1hnRQ7bLFkCW6JshPFI
	 EpCQW1rdzRL6QsAlQjeKftOujACNAv/nWjkRrmZGPeJTEZgaNF5+2iukkWGWN60wPR
	 pd1ch5ayR59W5jeO5Cb9gHoSbEP6bp7oovcPzfIJ3sifeguevPbiYrC4MadLmclnOe
	 9GiL4UFPdLskjlprWC/iSY6u+Bkb1t31D9MSJ3aM28uH83zm8mOe059clxGY6is++g
	 ulK2pvStV55JA==
Content-Type: multipart/mixed; boundary="===============1636887923003465919=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ebc38cb448d37cbb143f80680a4e489e5a06bbb5106faf0c381ba97efd9a10df@mail.kernel.org>
In-Reply-To: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete from tc, xdp and flow_dissector
From: bot+bpf-ci@kernel.org
To: rhkrqnwk98@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,john.fastabend@gmail.com,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,sdf@fomichev.me,emil@etsalapatis.com,lmb@isovalent.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,shuah@kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 29 Jun 2026 18:06:22 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-302762-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,fomichev.me,etsalapatis.com,isovalent.com,cloudflare.com,vger.kernel.org,iogearbox.net,gmail.com,meta.com];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:emil@etsalapatis.com,m:lmb@isovalent.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net];
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
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B3C6DDEBB

--===============1636887923003465919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>     sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
>     write. That gives the order stab->lock -> sk_callback_lock.
>
>     The reverse order comes from the SK_SKB stream parser.
>     sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
>     verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
>     __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
>     deletes from the sockmap and takes stab->lock:
>
>     A tc, xdp or flow_dissector program has no reason to update or delete a
>     sockmap, and redirect does not go through here. Drop them from
>     may_update_sockmap() so the verifier rejects it. It also closes the
>     matching sockhash inversion.
>
>     Suggested-by: John Fastabend <john.fastabend@gmail.com>
>     Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

This fixes the behaviour added by commit 0126240f448d ("bpf: sockmap: Allow
update from BPF"), which introduced may_update_sockmap() and added the four
BPF_PROG_TYPE_* cases that this change removes.  Should it carry:

  Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28391303635
--===============1636887923003465919==--

