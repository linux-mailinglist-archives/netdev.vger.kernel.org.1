Return-Path: <netdev+bounces-288248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC7UAk7kBmoHowIAu9opvQ
	(envelope-from <netdev+bounces-288248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:15:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19954C346
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579FA30C314D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8C25B0BD;
	Fri, 15 May 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZFSFzh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ADB37C901
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834900; cv=pass; b=qOS2FXCYN+rIFwal9F4FULyDQ/5LrzdcS5WqLDUNlvChPZLHYHu3ptIha70PCjZ/G1pBioMSkmRVuC/rp06BlMiESAMxNv29DLef/6bUEYM2Exg1Pj1hbYfPtXVBYphjyzii//mQttgEOGFmJzVE66VFwPY8coVGYI+attgIe+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834900; c=relaxed/simple;
	bh=BuSU6X06PGkDc7RLhuBIQoLj+CZbz6reI7X5a6W85Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiJKA7rWpbbsjdKWE4jxB2iDSc/ABcAHrx8ZIkNKwdWmFMu+mM3atUS3It57YXAkV5DWpdFDtAzIUFj9NQ1BhKewsQawaDFV5T8D/tJiYWYuk0iu9Bhchg0H8s8WBgX20FOnMBGzqr1arjJsHs6bhyGHEejCg5Y1Tt+G9cspMnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZFSFzh+; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so72054025e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834895; cv=none;
        d=google.com; s=arc-20240605;
        b=bNK5DEy4HAqDhwePUp7DPZCEH3AfoZ4kqUapJpsEr4Z/al0KB9zTGOZVFWA5ZrD3Ag
         dmo/IvSHz4EX9MVup58rQn/oLumJQZtuRKJgDLxv7Y1OGhHSlzCW84rXPtFtqEvOZ5+X
         8/zJ6CjBAKj6tl/yCay+TGaoR6817EQRBtTsabOi0WYZI0Xs2f21AUZxsRkM4LU89ylu
         sOp07zWplLrOT8WG5mC5WXpO2q5Kpu0js5wy7eivJITPhmw3jQ0lthqMh8/hVKLanDBY
         dCMIMcTkKFc/eCT4HcBCSCAMhLA0skq3z/8wkezaOoGdA0sJ/k1+5WN2ey7zLlXHQL5T
         f4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80BVIdhlJiwVpXQGwMap7k4sOsggi2mdyxhI5ibVJF4=;
        fh=GitwFcnIBMXVk4fkH65a4P+xpF6bjq6kjmNdGDs7joo=;
        b=JGAqlk+GLQcOrmJ3vV2RZVAlEY/dZAjUlSWMIRvAazMx1XgOZU+e9WCO1Lh8KX48Az
         ROTmcDjL/f7CEwRzCouzy1gVeHBl1dobTS8ciMqwUko8rnlCLQrU5LFHBzSD2QIuZWh/
         pg4PofHFOXDDyiI07nppZDf1NMvjMnN2L80NGF8lTB+HXdukwPcE8l6Qrx3AsbBJ25ln
         +3B6QcYUSUycbICXOFyFosdjnoKSei/uPrWu5xE4adv7o0Q+nKCsG8MFhaJNwgV4CQBV
         FJZ2wcAVyl1QC8hoS5ZUzFOjoOm4XRNoxfgbQ07NlxvGQKVR0Ke82LvOBFR66zoQa1Y1
         qikQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834895; x=1779439695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80BVIdhlJiwVpXQGwMap7k4sOsggi2mdyxhI5ibVJF4=;
        b=IZFSFzh+NJVZan8eZzAKuj27YM6i2FcyLNImEJ2Uh/afCJfLe9mbfdb0lcJuM0gfjn
         IBNe/LS8rOIGEL/zTuJQofXgb1BnP/pvGzghjrAnyCiRznAIeugXGUEd+j6UjMAcJ6ce
         CxRy3trSLI7ATW7HUdYW8Va+w3XKfU/jt+75p2ZGbeW3iZ+hbA0946+3zAbDu58EgN+E
         Ml7BEiBOz0oE2Nbf1Jof1ndzs3UT/F6+2KN6+EpegOixaeC0FXEYps+/jltKASwYRFJF
         1naWLQ8/KoRjlYRXhjZatTPzQSDevDmdkk3CRz4Dg4REwbkSMAEsmZZjMs8nkub1s1Vj
         S5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834895; x=1779439695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80BVIdhlJiwVpXQGwMap7k4sOsggi2mdyxhI5ibVJF4=;
        b=pIlY87zjRw+6OJwWWxYFuxtDZkJVcHPjyoqzfMDn5TINRd14VCv4xA14T5R6zhps+y
         kmQBCHkj8vNd29u0VMMvERTh7kBK+gtO+9S0lP1hLVjH65BtuidhwPenC7wB5GAxuQkC
         65arQnCYA9Gc1aWSlwOy8lDFpiMc3Gka7WGlI+cdFN7oZoNxGUo6xyUXH0mtbXjQ/if5
         nNrebc2DYMp0GR94Tl491J03H7uSSI6zFexabk2HdDuK82LEF0WOAd1dyXVzLiAMI4nd
         ghQqMaOT+CUEuDZdg3N99VHYlS7DIjjdY080kgBoKF0JxLcS4EkMU2szrwLy/ii+wwY4
         F+jQ==
X-Gm-Message-State: AOJu0YyOlYjvCGCJ1mpaIoEWQYvJ2wy0ljD0FN2K1GXypYQWwWX20pwQ
	V4EwwCvlYP7/vxm4QyNM/Ji2luWIXcyo12aEBqDl83sQNdKgrY1jAmo76S77i3mkEpux19W3RSl
	CP6uOjY2GOVU0+1nqUx3UdeJQZoiG/Po=
X-Gm-Gg: Acq92OGsMkwIT8ntLF7DTmHOALm+WwlI32xain1xCt5jH2dhXC18d44Cu26tetyvSB6
	rlg4G3cCmtlnaW8DkplQik+vOZ6MmAiYHo3htHakLdv36TGY0iF7ow3W9AGvucyETzGqq9t+p6m
	9iSIbvEiqQsdNIMZGY/NuajLlzFH9RgHcWRj5zQ4EZcKhgY309DES9mESuxbNzwO32p2LKf5fE5
	14huY1izecvCuFwPmxYIak8cjvfIGZtbYCdI1VzzEL2jfe1wl48LsudIq7VeALMZzAwf5KptCCK
	Zh+1/nQ=
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr31749305e9.8.1778834894273; Fri, 15 May 2026
 01:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513121240.2590767-1-houminxi@gmail.com> <f7tzf21noy8.fsf@redhat.com>
In-Reply-To: <f7tzf21noy8.fsf@redhat.com>
From: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Date: Fri, 15 May 2026 16:47:47 +0800
X-Gm-Features: AVHnY4I1GuGaSSmMujdoxWL-IyKXw_JETbROO8KstmjQW9j-pAJcDpAKNH8MHwo
Message-ID: <CAJ0BgHcq9Qs__f53kcNzG1+qYXvHP2_q1+mk8=z1Fo3TNY9W8g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for ovs-dpctl.py
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	echaudro@redhat.com, i.maximets@ovn.org, i.maximets@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9E19954C346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288248-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ovs-dpctl.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Aaron

Thanks for the suggestion, Aaron.  I dug into this a bit and I think
it's worth doing.

The good news is that 3 of 4 OVS families already have ynl specs
in-tree (ovs_datapath, ovs_flow, ovs_vport).  The flow spec is pretty
thorough -- covers all the key/action/tunnel nested attrs.  pyynl
handles genetlink, dump, and nested encode/decode, so the library side
looks solid.  There's even an OVS C sample under tools/net/ynl/samples/.

Gaps I found:

  - No ovs_packet.yaml spec.  We'd need to write one for upcall
    handling (MISS/ACTION/EXECUTE).  Shouldn't be too bad, maybe
    100 lines based on the other specs.

  - The existing specs are missing a few operation defs (flow DEL/SET,
    vport SET, datapath SET).  Small additions.

  - ovs-dpctl.py also uses pyroute2.iproute for tunnel interface
    creation and NDB for interface lookup.  Those aren't OVS netlink,
    so we'd either keep a minimal pyroute2 dep for just that or
    shell out to `ip`.

  - The ODP string parser (~1500 lines for flow key/action encoding)
    is orthogonal to the netlink wire format, so that stays regardless.

I think the natural order would be: start with datapath ops (simplest,
spec already complete), then vport, then flow (bulk of the work), then
packet/upcall after writing the spec.  The f-string fixes from my
current series still apply.

Minxi

Aaron Conole <aconole@redhat.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=94 14:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Minxi Hou <houminxi@gmail.com> writes:
>
> > This series cleans up all pylint warnings in ovs-dpctl.py,
> > bringing the score from 7.62/10 to 10.00/10.
> >
> > This series applies on top of:
> >   [PATCH net-next v10 1/2] selftests: openvswitch: add vlan() and
> >   encap() flow string parsing
> >   https://lore.kernel.org/netdev/20260512070841.1183581-2-houminxi@gmai=
l.com/
> >
> > Patch 1 converts 86 %-format strings to f-strings.
> > Patch 2 fixes misc warnings (unused import, bare except, unused
> > variables, redundant expressions).
> > Patch 3 renames classes to PascalCase and variables to snake_case.
> > Patch 4 adds one-line docstrings to all definitions.
> > Patch 5 suppresses complexity warnings from pyroute2 constraints.
> >
> > Tested with vng on x86_64, all OVS selftests pass.
> >
> > Minxi Hou (5):
> >   selftests: openvswitch: convert %-formatting to f-strings
> >   selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
> >   selftests: openvswitch: rename classes and variables in ovs-dpctl.py
> >   selftests: openvswitch: add missing docstrings in ovs-dpctl.py
> >   selftests: openvswitch: suppress pylint complexity warnings
> >
> >  .../selftests/net/openvswitch/ovs-dpctl.py    | 794 ++++++++++--------
> >  1 file changed, 428 insertions(+), 366 deletions(-)
>
> Thinking about this series, it might be better to go a bit further and
> just drop the pyroute2 in favor of using ynl to generate the netlink
> encode/decode.  The value that ovs-dpctl.py brings is the ability to
> interoperate with the ovs-vswitchd odp encoding.  That we are using
> pyroute2 to do the actual 'wire' format of netlink is incidental.
>
> Some of the work would still be needed (I think some of the f-string
> adjustments) but that would allow trimming a good chunk of the code and
> let us just rely on the in-tree ynl rather than pyroute2 dependency.
>
> WDYT?  Ilya and I can work with you offline if you are interested in
> pursuing this approach.  I think it should make the overall code much
> better to work with, too.
>

