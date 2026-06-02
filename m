Return-Path: <netdev+bounces-294315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OgWJCjgSH2okfAAAu9opvQ
	(envelope-from <netdev+bounces-294315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA11630B03
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Pm4nah5x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294315-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61537300D911
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CB3F8EA7;
	Tue,  2 Jun 2026 17:25:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE193B9617
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:25:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421131; cv=pass; b=VZIBSJSU8XgWHFBiL+FDhGm8ygaxldJ4kauu1smJFFhGpwlDNqNi16heIyVADEdrHJ1KywhvXM1qST5YwKjDRcWKTjocCQtuPf6DfyF3/4fe6EU/jXhEi8D0PgFiuOVBfcDJdPr93FN9NoHwT6fxn0z4osa0Yt77xtQSpQcIKe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421131; c=relaxed/simple;
	bh=iPgtSJPnn2WLSAhBj9utiFu+5JnduVtlglZ5qvPeod0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnQvt8wpH9aUTNahSKzjOLVu+5Z/HnHN8ST8U9zjrFr7QxFIxOIic+rUqegZdhjK8q+jOWJNOCDqAhmXfp1dqVOV9RBUr/Ju3N4JDOyc/HWDmd06QKimyzl4VdAeB336lg6lRpEcqGlfwx5+sZFQoUK7fxCUXrt/9a0nKb9G5So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm4nah5x; arc=pass smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490afc47455so9025055e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 10:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780421129; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8efzwbdGBwTVQMb00FjwqmVqofitAJnzmdEWswzlLw2GRSO9s5C4LlRlaVasIWcrP
         8jIiwQJ6OMSUUtzCj7/cCYyilSEnZ5bF93mDQrPRsaLcgYfxSni6+cUerUonmgSOI7Gg
         yjDjrpheOUTEMH7KRkUdPFaaw93kCBboBltQqiG5Sfq2cfdRx0vdhJM1SJdHKydaVUKo
         Sb21pQAXrYZy6jGlz7cinQBYszTXv3YE+6GunaMJd1LskoVLfr90K+r2Bjqh4oHGIFJ0
         t4A09qhPv0sw4LUQTNeVYbxp0P0Fg3qj/I8XXN/uhOXngtEdGSGPZG6R+qi3+fVSLz77
         Z14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        fh=Ku/lfJ5VhBfcKOVrrNW+tjjv52XcABTTHq8lfGzqhDk=;
        b=f9yi8qxKeAm+NQK7No7oXBDzETtx94bV8wkZt8VkMsGy2GJc+YiuCHl6A/QKUfOuOH
         OBoJsnLafIkemJOYWALVS1m1DciNJmkHU4KJgB6BZJfipvHKavR/2Ohhp9LBiNXMLBRr
         r2ZI9UvCbsREVqtstOqE+u6LCwmkYyYIxaBrMcyrOyATWMT10ZcyV/Sm6uSWVw6xgjyp
         b8B0cA0/N74sPgECBU/K4sgbCO+4Y+7TsKhOwVbCL3hoKYTV2DMcKrzrT8jt4Ew72u9Q
         9k21tQGl+WPmeQ+uyFGhC6kcl4hLiQZT0ociqE30ObkYJLbGNEfMBsMzzboAIQ1quXhp
         xKfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780421129; x=1781025929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=Pm4nah5xpa3wkF6ZJXN93iQqTajfLaLnk17Wng584ZfLw6yW2f6VU85r0ZzVvoybuZ
         2dJD4fh1H+b7lHO7w6te7uv3VKo+4FCfqg5bT8+82qF6qrUCEf8Ti4RZ+CMcghcbLJL5
         BILyClz6yTr+8oG5EEWCO4J43ISN3WJv/FTqYT2ojC0rQCmTStcvzSasC8s9GY41NRAG
         KqcIPjXkAmUvmMn1FP0v+FjoatKbdQld4fpVRy9AoIKgUqdFLBStTJXcEYU9wQtRK7sw
         bKztzsF7zm8dy2R9DOg0a8bDQDg2INgwRUiv5rB8zU/F0fXu2zoEL5H5WBcYOgZ05ylf
         HWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780421129; x=1781025929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keziT7iw7tOqjOgD7A8G8bVoF7lb6QaFK2jdA0hJANU=;
        b=jh5ef28FP/4i7Nn2OlxGv7x5fyrJDHLr0KYZWReaPipfovulacS2HZF7rQs5r2PBnc
         dGFkY3K/7lCG82uOFvvGVsdFEsWqgQHn4C04nc69FY2cLkHK1jRwL/IugL3wUOUBxNA6
         /uuvxU+yr4E4YVZ14IKBGFoPzBtd5aGPI17lQBI2+OOSESPJkDjjzg/J/JlC3+Nd2p/n
         ZkgqD59ND5fmJswA5LYfbjl22+Hw30iONxc/wZuloGi0TLFWyhkRYPVM2sWRt3Ldy9tX
         ajaGP+j7rEP8v0GbYrgLISnjsjHYt7LkJqjItYh2aJBsLKoKXcDzhpUoRSWV+RcqW9ne
         0KCw==
X-Forwarded-Encrypted: i=1; AFNElJ+GejzgVSbTYvF8Jah8lhcz/BwLG9hic4asLoh9ZJiRuPCXpXYEWtht4K6S7YuX6E808Pd9puM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGC7znv9oDDo0HMiUww+YBaImSVdb7dKVwKn/Z5SDGYhW4DB9
	HGtJejICQElJ56xA2RvpOyUgL7wlyh8xvcN3MQKa3qtIGnRToUM95H96JGQ4p+jN+za0b42OoOT
	/AOA8ZMah27p35EQpFVu4XIOMLSGeeRw=
X-Gm-Gg: Acq92OHBx8y50VesveLb91OJ+XLx9uKne8bVmiuZIq4N5mxDl0G8/sEAjLw1THjP0sF
	GQLI+RAtevI0nZ3Hu+WAhkzui8s8CwVyLdWXYONe/jFVF/OSx8DZie8hpLo0nV2d1BqlBnBH5Kc
	MneMgGm+efFkRPYq/moEiMVOPYZFw6cbQ8c4w/rdPI/LLPX6ujvfa8pkdJakZl22Ovkt6ZZv7bT
	uLSZXhFNL8CWWARCsy4GGJrLGr2Y36ivHHVUzRunKD86LadT3KdG/GEHARHMD9/8um2oYYEfpby
	pgQUuhHbAHPplbVL7cc=
X-Received: by 2002:a05:600c:5394:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-490b50b524cmr11269395e9.24.1780421128348; Tue, 02 Jun 2026
 10:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601180400.1381736-1-jt26wzz@gmail.com> <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a> <ah6dLESn8tHAtxS9@u94a>
In-Reply-To: <ah6dLESn8tHAtxS9@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 3 Jun 2026 01:25:15 +0800
X-Gm-Features: AVHnY4Jp20ELFLjNCl5evWNbTrIsnG4ugFKakTtRdkdRYG8va887rnwbiwM2mx4
Message-ID: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, tamird@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:tamird@kernel.org,m:eddyz87@gmail.com,m:paulchaignon@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FA11630B03

Hi Shung-Hsi,

Thanks, that makes sense.

I was mixing up two different things here: the BPF docs say not to add
"Cc: stable@vger.kernel.org" to the patch description as a stable tag, and
instead ask BPF maintainers to queue stable fixes. Cc'ing stable@ in the
email headers for awareness is separate. Thanks for pointing this out.

Thanks also for pointing out the 6.6.y requirement. I'll make sure v2 takes
the stable ordering requirement into account before targeting 6.1.y.

I ran the suggested checks with the same reproducer, where BAD means the
program ran and observed the unexpected error, and GOOD means no error was
observed:

- latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
- bpf-next at b93c55b4932d: GOOD
- bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD

So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
does not explain why bpf-next passes. I'll do more narrowing and update the
candidate backport set accordingly.

I'm also happy to add a BPF selftest for this. I plan to send a v2 series
later this week.

BR,
Zhenzhong

Shung-Hsi Yu <shung-hsi.yu@suse.com>=E4=BA=8E2026=E5=B9=B46=E6=9C=882=E6=97=
=A5 =E5=91=A8=E4=BA=8C17:18=E5=86=99=E9=81=93=EF=BC=9A


On Tue, Jun 2, 2026 at 5:18=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> > On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> > ...
> > > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > > Hi BPF maintainers,
> > > >
> > > > This RFC backports two BPF verifier scalar range-tracking fixes to =
6.1.y.
> > > > The series is intended to fix a verifier state-pruning issue where =
an
> > > > impossible scalar path can be kept while the real success path is p=
runed.
> > > >
> > > > This is a verifier scalar range-tracking issue, not a helper-specif=
ic
> > > > issue.
> > > > The visible failure is that the verifier can prune the real success
> > > > continuation, which should not be skipped, and keep only an impossi=
ble one.
> > > ...
> > >
> > > This sounds somewhat similar to the issue fixed in "backport of itera=
tor
> > > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you =
try
> > > to test on the latest stable 6.6.y as well at see if you can reproduc=
e
> > > the issue there?
> > ...
> >
> > My mistake, the reproducer you had doesn't use iterator or callback, so
> > probably not fixed in stable 6.6. I'll take a better look at this later
> > this week.
>
> Two more ideas beside testing on latest stable 6.6.
>
> 1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
>    make the verifier tracks the "not equal" for regs' reverted? My
>    concern is that it is possible that commit d028f87517d6 does not
>    address the root cause of incorrect state pruning here.
>
>    If the reproducer _fails_ to reproduce the issue even with commit
>    d028f87517d6 reverted, then it is possible that the root cause was
>    fixed by another commit further down the line.
>
> 2. Have you consider adding your reproducer into BPF selftests? Would be
>    very useful to have in stable (though it needs to first land in
>    bpf-next first).
>
> > > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmai=
l.com/
> > > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules=
.html

