Return-Path: <netdev+bounces-300828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WyPVA1m4Nmo9DwcAu9opvQ
	(envelope-from <netdev+bounces-300828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9516A92C4
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:57:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=HDjo1vgq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300828-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25E7301980B
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E9399374;
	Sat, 20 Jun 2026 15:54:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04693438A8
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:54:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970879; cv=pass; b=kLFkvTg2dEubALgfbWnIHjNaMHGOV2DyW4w7u7Z2OFRjMNcmVfy2JOUeyyPav58eY/ZnmFD44qe+RMhEVsg9P+ggD4Uv21hQDIn+EHJjGCY8eqjuJ5IRqVTsrnOmNEWbQQoonc1WUxAwK9ulZ4Nms1aAsB2J3tJnTaw1ktdrgeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970879; c=relaxed/simple;
	bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ9+ZsssSAKw/CyBWE4bOKnAbiTle5NN7P1xKwUwZyWqUC1Qqwktz+cZdJx8EcMygYfOTgv3CpUQdOK+uNEQXq8NAQ2cQCL9AN6EY7w+BrpNIJ7+2lOzKzfXBMBSqWHpIyRbF2qbav9fvmQB4N9FzmUZhLOE28LNAxisrZITd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HDjo1vgq; arc=pass smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-662bb4dc1d6so3417753d50.1
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781970878; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNXaEmTmqw6BW3NEA1zxDO/4I9/q0fCQS1YTAF/eRcSBXtT8sp9z0JnhqeSj4m+SpE
         lLFCQDFAQftIzb2BJyIydUGG3JGoecpudw6of6goeWmTjnvMCTGscI5q/3Hirro1tzBW
         aY0QJCho7elq4C4ZAs1G0Rvo+JZeNjZtZguj7FcPhgFfJd3nbcCPWk2fUVmod4cBYWl+
         5tldXs8YP3ESS4chofVzxEW2+IMoYxZg4W/xF8AKlCyY0hRbREk+F2hea7ygbalcgQgC
         SlzGp1P27FxvVe+MkBeAE9SwUvvLg3DboVAqzoacrIT7991plmRhDvnRZKBM0k2/9huh
         dRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        fh=k3Uk8+ZUYdhIB3ZI7uWiB4hw7HG8WfPbBhKMAkRUC2I=;
        b=DNRm7Ruh+o8bCZqeXbp22ZrH1qgRz6FrpzUwsCx+0XlK+UR2eATi9GsUdHkGTZHP6R
         wa8rwSgy5vI6ZH00db45ee/QDcncq31Wdm2V0s0QF5Zr4KIkH3+N/Kd6P01edLFa/taQ
         LgOu8u3rZ0H0w3EHOrx7C7LZakxMx5JSBxhdoKOzrD2+wLujS5f4Hp3SozI+XnMzUmAW
         hloJB0QmXhxqPcCPxlpd/lcpBddNv2G/cXPMyEOv9UvrvMUFVWFMBcWeFRo2aUtthDRy
         aHM7lEKOAKtysp8ZaHJ6CMFFWiyoYa8uZSn6MhK10m+pNO2pn2WWv+9ruO5ZRdrMtu6+
         kesg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781970878; x=1782575678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        b=HDjo1vgqCyQyMY9iSSxQk9BAzcnk6t74x+hZGqpe2RZ1wS7sI7LqbzRFepmJPcGj/w
         5BsnOVO/+Kg/0IWD+7iXOaEOPrWDHK6rQJS/s6lx7lAz2/XZ0PJXZKqjForf8A66Yhsy
         CIpECxztFUM+HtYu/tDzzRMk2EWcU0vM+8tVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970878; x=1782575678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uR2dpDSOv9CIo+MDbzX0/F3NMgOJ01Uve4ugPph41ZU=;
        b=LVK2lFzXYPxnF87igFcjE/F4GpEkz5Q8zB8U72bT341fNGY8I6b7Y+bVPCmy2Trbqy
         GzoLFkWpA8Hc7bDP94LwlPeypxOattabXsYY21Z5rPST2t0XkpWb62Tx/KknqYgq5fAm
         Rz59vZaCXV27lWXdo9vmdVN+STnpTEBxR/WV7S6ul+09qC8cJio6no2vBNImrFJfHlnl
         dcw3EYRTDcnMPuxSDzobkNhvtXN/75RxAWHVF5HqmBrf3Y50PY5sKRf4aMyU0H5qwlET
         82zzd3gXDyTW8Wg9N83a/xLSFwxw90eqXMogBT0+h9oc0ASnZq3+FRXXvjKugPYB7OKN
         Qh0g==
X-Forwarded-Encrypted: i=1; AHgh+RrzZn0GXO0nCA7bpEepwAUmis9YR1tAHGFRN8eh4PCOp9qQ1th9iEJJk9NqiAn4+4aySLTO3qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/OHFEEHN3hgBsO/9KmRRWZyDy2/nHHrdSec+vofgA+KF3NsP
	NPvn8Ngyra/O5TcbDt68OWaD+4LuP41CNxbZXjDdt0J/aqqcgqGr3tBSm76pVori2dkrQRyX9uK
	98R9VNOSiWBQt3LwRLM4OMpaBMzAkrd3f8YbCX/WyRUXS1Y/vCtY=
X-Gm-Gg: AfdE7cmqHYPYqFgl0sikGLQ+oieGHDVSiuTMEAriBEMB3blVnN9jn6k40xCQpv30LrI
	K4cqC2K/3xl4ZBT2pJVmUpefeVvFgPOQTAYoy2iqWNdDyWXW/wrTvoUeZM7JWe3wvQRLQAbR7e+
	flSiEGDNC53yWo3o7m1waGue+y+lrCcNvuUqzQDTkgbMs5CwXbzeTv8gGNaHWlU48CjFuwRxO9L
	iIDZLlLT1tqaqzMLaU9sk7+LMbO4ZDC6gmemKxmKK84SkT7bKdHNYNDmmGssOuwmGJduAlvmkAQ
	jFNjXMNIu2jQR1Cx/dFb0mwd/ek=
X-Received: by 2002:a05:690e:120d:b0:660:5e32:b2a2 with SMTP id
 956f58d0204a3-662fff62c0cmr7294649d50.49.1781970877733; Sat, 20 Jun 2026
 08:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Victor Nogueira <victor@mojatatu.com>
Date: Sat, 20 Jun 2026 12:54:26 -0300
X-Gm-Features: AVVi8CfVQ16Dt4Z149BETVATIkTE4DSBRfU8VpglrjahZRBgNf1eldVvT-bLElE
Message-ID: <CA+NMeC8-_LzTU_e+MA0-p72-=-P0NozcuaORsYGpyjMuAj957g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:b1n@b1n.io,m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:chia-yu.chang@nokia-bell-labs.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300828-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,b1n.io:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C9516A92C4

On Fri, Jun 19, 2026 at 12:15=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
>
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
>
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
>
> Follow the same pattern used by tbf_segment() and taprio: count only
> successfully queued segments, propagate the difference between the
> original skb and those segments, and return NET_XMIT_SUCCESS whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

