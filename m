Return-Path: <netdev+bounces-302392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iO/RBGUVQWpikwkAu9opvQ
	(envelope-from <netdev+bounces-302392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 14:36:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A15826D3CFF
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 14:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=WW5NNTVS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302392-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D4DD3001471
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ACF3A4F4B;
	Sun, 28 Jun 2026 12:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6F3A3815
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 12:36:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782650211; cv=pass; b=aVGYF/ZfFAU/ZxyYxpulRCSpe5GBwi45WfRafOEkwmZh36dHRtfpkNYWRLfM+Iw3y3RFggOw8s309QaS9YQvNgxXLsn3Q23S/ZYxOrOFp6UJpz9hqxvqr8Rx2HoqO80sXaTvLk5IT/4NHfJNtP+sTd08FL8Dsa8ZmeITr11oRrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782650211; c=relaxed/simple;
	bh=QT3KyRx/yYFX7YJbB0Phy/hJFhtSz/3fbeRsVp3f/3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB21T1yIT4LEoLNG9ycsQDrVgKI98XcBuZ6y7aNEhgP8hQ01TXuaDbLSMvnr5Ab7kE5j1btmMGwxzYPQH1ZIzG7WS4BJhYpDsbGLDliiLr0f+5Vo7wo40hd3Mc/4UD8g59KHvuQFpsE0LVnCwuUgVbHZ/HSRjNoYpfIP2irLEpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WW5NNTVS; arc=pass smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664bb15d05dso673464d50.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 05:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782650208; cv=none;
        d=google.com; s=arc-20260327;
        b=UQFR1b9vugdvEHCHPJltt8zPLVe7Uu1gSUhNyNUAE+wDIwDKjVl+6T2F7iAw64QLed
         5vZWsixGGDVVdUOc5xa+MMtnl9sQgaiFRHOHNZ6DTXnnWBliT1SfD+EwYpcoTZXc0I7q
         FYGiztcKaYOiPd4kQTQ00JC5BuiIGeJCt8ZELcwY7T8X7O/bo+1CFOzmhNKbUBHbsSP3
         i1zJHmbQImCxAL8iCWFXXAZDS6178tO+y27Cp11iyndQXVVoO4vMSah7OoTTYzZPtQ1X
         8SEk4TVBRlzDEnvER4oo3OGz8ES/IY23pppe8w0GwY8fKZI2/C6yhPXhqmAc7qvn2fTZ
         2Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        fh=ASOfhIunJDagNd2+OgI89SLv07wThRMIAbZcqiDF6s4=;
        b=bXolY0CuLXC3zPfel18XfVi6HQBzSvhBPF/B8nt+xTuXV7uO5GlQpjBjkysl6XdK7l
         kJ15ixCMr5VGKh8W4ee7NIRcmqaDqLYqbmMFrSEcyBCfSGcqvIBg2qgUHlJmVDImt4Tt
         0khWhJvS47cTBcDgO4MmebgJONAkdt/N13API+LqkXk7n+ZktAXqA3QQVjQ45QOUjIaJ
         nMAFyy8GPBEyaeGtxZ7flePJRNjU0z6Suds2eDRgKxjeCN9cXg7/f1AGW+KDfsO262OQ
         Oncb1KUHTjehxMpyCgmiCWm47uono/eIrv2XodNZUMyif0FMXfZ2CrE5XJS6JrJ9eO2G
         KndQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782650208; x=1783255008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        b=WW5NNTVSch88pbEt7NnwwVgbRhQ/NVC1fq1rBHfIo261G8o2i2hzm6kaHp8lZUoOok
         KR7K46YUX3n4t+ch0acBDbNJ7BrdKS4wuHDbnMOsa3LbgddwXJWVi3fvE0nG0bwTPUVi
         5qVUswUKN/5YBJCvQcrI/A93ti06HC8dxgSos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782650208; x=1783255008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzP5f4zYs9UEe0wmc6361FiYfWw38ZSqAfPCOvm2SFQ=;
        b=duf/Qvgw5b1b2mchAK0G8DyTaibGm84CiM6ePrx2Wsrv5UbrHPy9QDgwsanPfjhSGX
         SChR8y42AUenoFPKlm1Fo+Swe2u4d/INqN32eTA3BwA4FnGE1iGFirKu5kZ8RM0PSI6g
         Dp1zXYf1/ggR/N+0AUU98KdraFlfFhL91gJsS1itRYQnVn2UPAPHefpADlqODmrBgZZ4
         J4+BGmJCZ7AN4Cu+vJfEl6hPgm1VvyoA6ELWMNqTO8t3RKkrbwLARAFyc7RhyrJLl1Nd
         BzDZ894x+hP6YEXU4nLsriT9PjS8dfVkrL7ctcfnYyT5u56qdfLKzpVlefvhrqrHRsiw
         JA1g==
X-Forwarded-Encrypted: i=1; AHgh+RocTN+v3E7cKAR+zT88LJcIW9N19kqwLUgAMejCn7WVeZb3emSirQIV9BYAOi3GY56yOgv5XQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmLbripI8Bxi3ju1GOimi1pcMBvqiWZEPlxKGsqy1EI9x+opU
	vfvDbNGQQd/qByh4rERUJQ79AJSvuTWFRvK+zqKsOvqA4YJC/KsXDp71Yitnn9ctV7ymxg+McTS
	5roOVyMsbQDEHwhcVLuwYRzgDwWrFvP7k4ZgpOfCKFtsEbWRx7iE=
X-Gm-Gg: AfdE7cmaaUOEDMdORkoBLYxBv+jvAhffQsBar88uBHCfAazIOTpgOS2AKdON9+qFbC/
	P1laZOuBR3668gV0eCcQOv+lTqQGl1shWokqBHUeMD1OxSyed4XzKKHzmIluwZzgzwcziXDYh0E
	pk2OhZU/nApMZZUys0Sj3h6zt+T5IJj0FazA3OGdJ8oYyNXc20v8yAhMURMFMwY9E9TyNIMgee3
	GKoPuO32uL0yE4HObzlIaAsQaSXCks6YPo9EYLOFHcWUWmMaDJu9incPFlTYPkmXkijQXKLIw2v
	FEq7jRSm
X-Received: by 2002:a05:690e:4508:10b0:660:5e32:b2a2 with SMTP id
 956f58d0204a3-66487e08811mr8856149d50.49.1782650207987; Sun, 28 Jun 2026
 05:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626165156.169012-1-jhs@mojatatu.com> <20260626165156.169012-4-jhs@mojatatu.com>
 <20260627165220.CA0CD1F000E9@smtp.kernel.org>
In-Reply-To: <20260627165220.CA0CD1F000E9@smtp.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 28 Jun 2026 08:36:36 -0400
X-Gm-Features: AVVi8CcMk-OTbWtGzb65ms48PIO_Ru3oLcwHNHpBqSVb0aZgtGM3z9o_xVpkdK0
Message-ID: <CAM0EoM=Sm82LdxrX-tckyxyGbNOawQ0DAXnEPowgyYVZbx=vqw@mail.gmail.com>
Subject: Re: [PATCH net 3/3] selftests/tc-testing: Verify bpf redirect on RED
 block with preceding clsact (egress) classifier
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302392-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A15826D3CFF

On Sat, Jun 27, 2026 at 12:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Hardcoded BPF object path 'action-ebpf' instead of using '$EBP=
FDIR/action-ebpf'.
> --
>
> commit f4ff308069725bd7a3b6c6f843ecb0fda5b73239
> Author: Victor Nogueira <victor@mojatatu.com>
>
> selftests/tc-testing: Verify bpf redirect on RED block with preceding cls=
act (egress) classifier
>
> This commit adds a test case to reproduce a NULL pointer dereference when=
 a
> bpf filter attached to a RED block (which uses shared blocks) returns
> TC_ACT_REDIRECT while a preceding clsact egress classifier is present. Th=
e
> issue stems from a stack-allocated bpf_net_context being torn down before
> tcf_qevent_handle() calls skb_do_redirect().
>
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.j=
son b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > index a1f97a4b606e8..762f86ceab1cd 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
> [ ... ]
> > @@ -1540,5 +1540,37 @@
> [ ... ]
> > +    {
> > +        "id": "fb8d",
> > +        "name": "Verify bpf redirect on RED block with preceding clsac=
t (egress) classifier",
> > +        "category": [
> > +            "qdisc",
> > +            "red",
> > +            "qevent",
> > +            "clsact"
> > +        ],
> > +        "plugins": {
> > +            "requires": "nsPlugin"
> > +        },
> > +        "setup": [
> > +            "$IP addr add 10.10.10.1/24 dev $DUMMY",
> > +            "$IP neigh add 10.10.10.2 lladdr 02:00:00:00:00:01 dev $DU=
MMY nud permanent",
> > +            "$TC qdisc add dev $DUMMY handle 1: root tbf rate 1Mbit bu=
rst 10K limit 1M",
> > +            "$TC qdisc add dev $DUMMY parent 1:1 handle 11: red limit =
1M avpkt 1400 probability 1 burst 38 harddrop min 30000 max 30001 qevent ea=
rly_drop block 10",
> > +            "$TC qdisc add dev $DUMMY clsact",
> > +            "$TC filter add dev $DUMMY egress protocol ip prio 1 match=
all action gact pass",
> > +            "$TC filter add block 10 protocol ip prio 1 matchall actio=
n bpf obj action-ebpf sec action-redirect"
>
> [Severity: Medium]
> In the setup block for "Verify bpf redirect on RED block with preceding c=
lsact
> (egress) classifier", will this test fail with a file-not-found error whe=
n
> the tdc.py runner is executed in an out-of-tree build environment or with=
 a
> customized $EBPFDIR?
>
> Should this path be updated to use $EBPFDIR/action-ebpf instead of the
> hardcoded action-ebpf so it aligns with other tests in the suite and find=
s
> the BPF object correctly?

The $EBPFDIR issue seems to be legit. Victor?

cheers,
jamal

> > +        ],
> > +        "cmdUnderTest": "bash -c 'data=3D$(head -c 1400 /dev/zero | tr=
 \"\\0\" \"x\"); exec 3>/dev/udp/10.10.10.2/12345; for i in $(seq 1 8000); =
do printf \"%s\" \"$data\" >&3; done; exit 0'",
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.16=
9012-1-jhs@mojatatu.com?part=3D3

