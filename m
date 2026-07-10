Return-Path: <netdev+bounces-306636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTUxAcMpUWoJAQMAu9opvQ
	(envelope-from <netdev+bounces-306636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:20:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24B73CFFB
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:20:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lJtupQe3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306636-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306636-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C27A301FFB1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD11371D08;
	Fri, 10 Jul 2026 17:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622A36C581
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:17:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703862; cv=pass; b=KQ84T4C0fjxyNADq4mghGUc6bZJH4hqEBCh5nCGJkqqeBHeU5+erPlasJMax4LkYNhQwXZuTs7y53tcuSJFSj3e3JaMJiaMsR9LBdUfrxFQaj5nxB8zy7rmkhoWlUqB4sRYDHDbuQNkc61k8E0OLISACSEt92b/GDJGwM4yE/bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703862; c=relaxed/simple;
	bh=cloqDt+kKHjFhVMDkHMf7Pt1Uk9qilaHb1q0dagfRco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBxKmF5DVUU/ynq+cANWA9O2iHLhyhEF1XjL771VYvaHnddrFi2ia/IuQX1fuMlsPenawi3HLsJELzS/r7ezaPGIHF1bljLUFEEC5tx208Z/+YmuONHKI9xkemLGE9FwojKflKPHWiDeTvxDZDk+J3YaMh3EhQblKmbwVdD5Q5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJtupQe3; arc=pass smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e69a2db34so15886567b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783703860; cv=none;
        d=google.com; s=arc-20260327;
        b=CnngmDIvQk4s6mTNR0DdjkoyqKnsXRIBzymxGkKBoRzfWUbX1ifgPtv9NQDa1yoNm2
         KgUp4PVzgxPqjXXRk1N6tWdwUQmDODgP13ZKn8tVc0LCOqImvyYWGoD3/2SYwCXpNXIS
         gSAqhij2fv1EskX0T6D0jJKRQ4xqgvRQ8Im3RjVUpLlWgMRJ0O/qeHwr5DYqSYuZ4nt4
         h17UR9thfRzTWGrpUNTdNuMUQ8frJdBzhhnj9Qh2vtYPyBaxdEueV8sbI0XPRuIgp9J9
         JPBe7+roqgF0U0CJCZY2FhDvO7QHjLCv5yUVjmNcy6YM30XWIBcMeFno6V/o0ohFyuJ2
         MRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        fh=yu+yCh2gIM3olk3OsCIOOnHRNYf20d60BF4D2avzEpw=;
        b=a95TuDxNchqTwBMqdJZj8EhlOhzfJGKr2fEAAP3ju9P11LeH0fCFAwB097UcArA3CT
         e2BolK4DF7n+gVeO8FmfDgJM+YfpHtr8HvtmXy65EiyiQZKqdsZ/HCJkL96jM3oI9okz
         +XE21dq1Dgwk/yPA4mDtwgE0V6avUA2uoVDJUwKUR36U5cR7oUzEqBMJVtvzg0m0qCEK
         bT28Evoa/6am1v9Ao/9FqyEcy0WSNBxtzbKLoyocRqjgNgc3radsRzmNedvTd2g5dVaQ
         SRKsMvKObcf5HEsZCG0hOlHXgNf6e57i89uShUE3B+foGXtRXRxdLbWjXtp3t9SdaIMx
         yWRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783703860; x=1784308660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        b=lJtupQe3SrpAbPZUuiHs2menfQWKGZW2ijLP4KOkPcEZ23srM2OCwSzQMi0MsmLKyB
         VsBSiQhNe+PmcZLvRUtOn0x3Nhgk0yh4B0LzzMTHnckUtTx9VUmO1FXfnUkCbGY9G03/
         hykzLbBNj6ZW7+kOk0ihVt2Q2KB6ZbuCbAnSQcAyHQCF2B/pbOyClxdTCR3Vrs6Fett2
         D3AxFl90JDzvGXERBCr2wP1TKzUC2NDqDalq7s0uNclROz1YZ7sVPVfRWYgM1XLBho1k
         uRw87jefvrIpG6IBcDiPP0zjPOmNk2HtXRjc82VWVvKOjKeM3hfi8DuXYAyt63ztIHkW
         Tymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703860; x=1784308660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yP31KpZ0prxpwQHwr+ymc81I89H9wJeBHrNHNNhnqc=;
        b=I1l/GIutcqal9/FCrmqNqsRIrYXXsDzb405IlJiBY9L8cTQ/ZjI1dG+tS6TMyhvwr5
         DPOAbpnX0Q0QgXLM3TajwpU6WrNoP2/LzqweR1zMLOJiDQiCm6YeGnsLawlC27bM0Lu1
         8lUjfiDibl5mRK+jjjGlQWSs7Vj0qVxQ0HD60QlBE4XvDnqJcSepOclZ3Ou11tVpjoch
         B6EctwCm/xJkOeLZ0UQRgmmlLR5AC992jXgmlHH4HZujKyNBrCzRghP3sBKz9DNaB5G4
         qckhIn6ywRUoZRraSD9PifFFirfcvGMmqeO2MBm4geKIm6hF6bwwgVO8yl3GEYZ8tQ/D
         zRwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXAnHtxvvxYpBuH6KvjF4xzB8ZMHfBSBDe7R9nq9bud68q46aPhE+F4yx9N1LAG7fXIy3hDI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaBmB6L56OT8Zcu5K1FG3fK73OHShTQh3Z5DbPwqbzzejl6yN
	3+8rkd0KMDNOc+JAyz/mg68bUBjE1IOWKTpLQU7PDz6nzUOYv2cTO535BNgrapm7FjBcnYoWaNy
	XxcN994c1zPNCzGyQkeDXtGzeq/RniVc=
X-Gm-Gg: AfdE7cm6AZq6FAHbP5pxrChfysqgzabCzJwxJCWDtHVGg8wLumkDfs/pjm+WWiR8inu
	D8oq81yg6SXZbn1hwn+cwKN2OjIby1ok4kFYl3+/6VsQOkHDpexLbPu5ogWMtVw7+SvqSlsER6U
	bWh3tDe07Kg7wZGgXjWvRWkNnFymtY7XfH7WbMBeBuUNRBq/BNeBvxUmgEq2SegVT8rx2a2d7XX
	K5g8SGNYgFMcbc0sTYdI318o+czgaWwSnG9TNhmkBvbXnolM1nR/MgToRzQgBkfe/6ISj1GP3lT
	RziIP3KXFBDFlZEyp7UjIWGSmw==
X-Received: by 2002:a05:690c:6f05:b0:81e:68a2:89d5 with SMTP id
 00721157ae682-81e68a290efmr72264847b3.55.1783703860098; Fri, 10 Jul 2026
 10:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709191925.2811195-1-michael.bommarito@gmail.com> <5bb0177a-8d42-4301-8cf1-db4630f18437@kernel.org>
In-Reply-To: <5bb0177a-8d42-4301-8cf1-db4630f18437@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 10 Jul 2026 13:17:28 -0400
X-Gm-Features: AVVi8CfKhE_3n1rmJO_w_NXuQObQrOpTY7H7ae8Vyd0BpFgvocII4BQ36A63jjg
Message-ID: <CAJJ9bXxYfCPgh6ZsMCXf6YrpEPPzKmOcDwD0L1cNcWAefBFTLg@mail.gmail.com>
Subject: Re: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is present
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gang.yan@linux.dev,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306636-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D24B73CFFB

On Fri, Jul 10, 2026 at 12:19=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> I tried to reproduce it on my side using packetdrill-mptcp [1], but I
> was not able to test with KMSAN: my kernel boot, but is stuck when KMSAN
> is enabled... By chance, if you can try this reproducer on your side,
> with and without your patched kernel, that would be great :)
>
> [1] https://github.com/multipath-tcp/packetdrill/pull/203

Can you try with more RAM and make sure that you have these set too?

CONFIG_CRYPTO_USER_API=3Dy
CONFIG_CRYPTO_USER_API_HASH=3Dy

I was able to get your PR #203 test to trigger after using -m 8G +
AF_ALG under vng

  BUG: KMSAN: uninit-value in mptcp_incoming_options+0x1da9
   mptcp_incoming_options
   tcp_data_queue
   tcp_rcv_established
   tcp_v4_do_rcv
   tcp_v4_rcv
   ip_protocol_deliver_rcu
   ip_local_deliver_finish
   ip_local_deliver
   ip_rcv

Thanks,
Mike

