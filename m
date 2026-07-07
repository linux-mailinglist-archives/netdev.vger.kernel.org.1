Return-Path: <netdev+bounces-305603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tofUCq98TWrf0wEAu9opvQ
	(envelope-from <netdev+bounces-305603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:24:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF57200BD
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 00:24:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=isrJligi;
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305603-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305603-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E8A3050D89
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CBA3D955B;
	Tue,  7 Jul 2026 22:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CF3D9678
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 22:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462931; cv=pass; b=hoJkx8bVF8TGos3td1PotW3uX+Kaua690wNvp/GAjyZ9/plW03Bl8RVvIpTaN4ay4oSNVUAU8nbCdALRcz7Xol6QSfUpV3ZB9qS4/lGpidHw+5TLgB7MvSTEAK5cxzCfMwqUnVzMFBvGLk6jDy5zEfU1fN78i8wLtKWZibiybu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462931; c=relaxed/simple;
	bh=u2+Erg3Mqm5BTt6EwJU3P+702TeVlQqR57tsm9yrByE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggIBi1zHpJIDxS3C/uj5opgt8G3/b1MkEBOkm4GXYO8AiJdRag/pVs840QhrDa8/D3jxKEy7ZKzrPHTV8BcPNAVYFWV16cg8wEKiLbPEbOJ02lLMSQC1YiEbuJZlICm2TiVDH08vFWkptkV65k/aOKurzAHoOWvT5W3thvKRygQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=isrJligi; arc=pass smtp.client-ip=209.85.217.49
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-735f73287e2so12479137.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 15:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783462927; cv=none;
        d=google.com; s=arc-20260327;
        b=LFx5XatFhHFZogyurYakAA1s2iaSGVOjQ+Uv6Ugf24S0ZRCNVNzkOTDU0i4bKDekL+
         MtzvC/GXvFhSIgfBKR/ySWF3RVGI09XPPJnUsPlVjcIIxplm0Nqv4h9uHMW/nktW4VUS
         pRBBg3uXx4xtSQM+VT7IxLXOIu72ggHC4jqcewkcpbkUKddUmZubHp78qxNdUdKLX51w
         f9CT9Qf6OeDUIl1rdNFtgiMWCPovoEi7UdCeLa18Aec1b04mRnV197vpecwH4ijCUnbm
         VtXrWS49pM6EMCvwRMTmso7BwQO4VeVHvSrv47QFf3Dujvqzyimmcci2pKnJrdYlEJcA
         Mpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9FkF5g+SFR2M1lVFUmErdXZII4iyjWhaW0w30oVihg=;
        fh=LU11JMcjY9vo5ppFJ6akUH2cvBnFemuXZu0FQ67UH9I=;
        b=ax1IetKm0/rIYK5j7mqUkFP55r/aUbTS+nvRPHE51aBsQrjm+7fNKYs7F7Lxp4ZuVo
         YcWmldpZQ/ya1TXt/NcLhQ1k9v4E2SmlKS7UwT2/kdfHWRdmd71HDmyUJAeAwvQe6TTp
         rCuV5rhk+52iN1nPBxudu8JSv1KPUPkR0lFYmz1CJ/P22/w6AJaAWhabBis295dN43/W
         0t3Rj0ad5yR7WORSPlL9pdlXaLwpuFDRMuPKnh6xVebClxRtFJBfw+6yIO4BCelJFuXR
         OWC9B4jLHVfXBL11Y3AbUibs8Tx6xepuFYOmWI7Qg/aoaqqPpdmR5S9kIu5bMwR7Igmp
         VmEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1783462927; x=1784067727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s9FkF5g+SFR2M1lVFUmErdXZII4iyjWhaW0w30oVihg=;
        b=isrJligisGYt8IgIw8mkeuljKVcmjGB5OEevHOiZs7WFh+wyOxq73AAXhmVqJ0Path
         PE941pjESXc3ezdI+Obq7RS46V9wCdYH7cHQ3dkkcQ9Yc4zdo6l9VnsiBdyv4b3aA9kn
         kURKnmaWqXw75z8+YpYMnH+QtX6VXQQ8gugnKqratP09V2RCT8xTbOII7yMjSokrgle1
         5qAUbxxxQXG9CYIFBs+qvWkwBDmjQ0jBShrDhYCx7F3b7DCY8xHi7cEQUYiKk0DPwFoZ
         Bk2o3fkQHFtwXgTHk2L3poqP80KG0poFmiSGetjLDoYLCAxZtlnl838eyaCTw3HUPKh8
         oV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462927; x=1784067727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9FkF5g+SFR2M1lVFUmErdXZII4iyjWhaW0w30oVihg=;
        b=pKXRDD57wxBrz4O0xUB5VEKAMmksQqZMC7Zx2flxnHSgRgwvVK0Ht7mJkPB4hDZG5S
         wDyDadcA5Z4YVm3dObwXmKj/DQc2KRXBtFjUZ6Z1eINhH4jW2DeVsos+a/WcN9q43qPV
         tZGLuC0jpZjPRqa1Au+BEtgQA+n911WsoaJJUvORfay8W9WdJf1EyJxY0+xoy8wBGQLk
         o5n5SBrC+KSh/Ulii3kziphb/5XR5fosO0hXsr++YyNBNaQWQaG/KH35qSocRycfIHsh
         dTT1elm+U3qFoJpmTG60EN4Xmuvih5/wvpwj8YcDyMVQ7DpXHnGGEUqRA92vXYDnTQiQ
         X0eg==
X-Gm-Message-State: AOJu0YwBzfommiETQE318atoAJt7OEiRB1ybBQCHiSXbEMDx6EjZbkUC
	H89o774gbBFseeuF85KV6HqrEXfH1XmUuo1ue1MbQtqabPEyioAjckd0zALSMwu+4C0LJ9OGkTF
	+D6n2xWzOd4EJq+qgGF8kew39r5p3YgUN6bkls7dw9g==
X-Gm-Gg: AfdE7ckqV022aecvrKrDJDpspfjaSSQrpDC731PGN/c1cq5XCLCSQaIlhsqG2wGw3wf
	Rz2aA7LYkifOMYwpXlEidd3JscaFeyl166TlbGWgfRjHSsWXpaNhmHpvY8PWGO8cS6QAJtPgHS3
	sdGH/bQFsH3IGHtGaYWjEDMCDmzoaxehChUZAKGlCWGpxgyyLa6K2DU29iV35FoCFOWIY2s6zVP
	HjQSJT5eDQZ5GYGqggjlMZyYLp7SdCveV9Dn1Hho5ugfnSegPrUAsB15E9Ez8SE3pwCsuH2lhzp
	R0z/yJqxbJQhffgJPLwE0wOlWmkzHXj07JT3are+MBs3lLH54nBQ9pIBSHSnZGU/ewJXL/tYAXn
	lTBsTK9UaLxApVYoPiPPf9jbMiHtK7Ruv4YvX1jx2Xmn0EzCDMtxPzW7c
X-Received: by 2002:a67:ed96:0:b0:738:fa95:fb5f with SMTP id
 ada2fe7eead31-744b7ea2640mr3107924137.17.1783462927474; Tue, 07 Jul 2026
 15:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com>
 <CAKaoeS1dxK+SLrUPdE1J16TpL_M5mj8JTccL7C2OzfnNQEFNSQ@mail.gmail.com>
In-Reply-To: <CAKaoeS1dxK+SLrUPdE1J16TpL_M5mj8JTccL7C2OzfnNQEFNSQ@mail.gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Tue, 7 Jul 2026 15:21:55 -0700
X-Gm-Features: AVVi8CfcuN37Qxxiooi6Ht7bwht6L475Iyd4df2OgeWam0KE7cpAYBR6lKRCYLU
Message-ID: <CAKaoeS0HMeMtTdafvRVfp+gaqDjSPCMtf8pLNh_a+drHc0sKcQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] tls: Add TLS 1.3 hardware offload support
To: Nils Juenemann <nils.juenemann@gmail.com>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	leon@kernel.org, mbloch@nvidia.com, saeedm@nvidia.com, sd@queasysnail.net, 
	tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nils.juenemann@gmail.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:nilsjuenemann@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-305603-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,queasysnail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,everpuredata.com:from_mime,everpuredata.com:email,everpuredata.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77DF57200BD

On Thu, Jun 25, 2026 at 3:57=E2=80=AFPM Rishikesh Jethwani
<rjethwani@everpuredata.com> wrote:
>
> On Tue, Jun 23, 2026 at 10:53=E2=80=AFAM Nils Juenemann
> <nils.juenemann@gmail.com> wrote:
> >
> > Hi Rishikesh, all,
> >
> > we have been testing the v14 TLS 1.3 HW offload series on a ConnectX-6
> > DX and hit a sendfile() final-record loss on the device TX path. We
> > reduced it to a self-contained C reproducer and characterized it;
> > reporting it here with the analysis and a question on where a fix belon=
gs.
> >
> > Setup:
> >
> > NIC: ConnectX-6 DX (crypto enabled), FW 22.47.1026, SR-IOV VF,
> > TX offload only
> >
> > Kernel: net-next + this v14 series
> >
> > TLS 1.3, AES-128-GCM, kTLS installed via setsockopt(TLS_TX) on the
> > sending side with fixed test crypto material and no handshake, like
> > tools/testing/selftests/net/tls
> >
> > a server sends a file with the raw sendfile(2) syscall; a client on
> > another host reads the decrypted stream and counts the bytes
> >
> > Trigger: sendfile(2) with a count larger than the bytes remaining in
> > the file (count > EOF). This is what a generic copy loop / Go's
> > net.TCPConn.ReadFrom passes for a file of unknown length (~2 GiB). The
> > kernel sends up to EOF, but the connection's final TLS record then
> > appears not to be put on the wire unless a subsequent write flushes it.
> > An abrupt close() appears to drop it, and the peer receives the whole
> > body except the last record's bytes.
> >
> > Reproducer results (two hosts over the ConnectX - a loopback/same-host
> > connection stays on TLS_SW and does not show it). Same file, 226965
> > bytes (=3D 13*16384 + 13973):
> >
> > TLS_HW count>EOF close() -> 212992 short
> > TLS_HW count>EOF close(), no zerocopy -> 212992 same
> > TLS_HW count=3D=3Dexact close() -> 226965 full
> > TLS_HW count>EOF close_notify, then close() -> 226965 full
> > TLS_SW count>EOF close(), hw-tx-offload off -> 226965 full
> >
> > So it is specific to the device-offload TX path: the final record of a
> > count > EOF sendfile() appears not to be finalized/flushed at EOF, only
> > by a following write. A bounded count, a trailing write (close_notify),
> > or software kTLS all avoid it. TLS_TX_ZEROCOPY_RO makes no difference.
> > We are currently using the exact-count workaround in a preview environm=
ent.
> >
> > We may be misreading the code, so this is only a pointer: with
> > count > EOF tls_push_data() fills the last record without reaching the
> > size=3D=3D0 case; on the device path tls_device_record_close() for that
> > pending record appears to run only on the next push, and an abrupt
> > teardown appears to discard it. The software path seems to flush
> > pending TX records on close (tls_sw_release_resources_tx), which would
> > explain why it is unaffected.
> >
> > Reproducer:
> > https://gist.github.com/totallyunknown/a8f0ad3c54e40befde2f5a8d360fa6be
> >
> > It installs kTLS with fixed test crypto material via
> > setsockopt(TLS_TX/TLS_RX), sends a file using the raw sendfile(2)
> > syscall, and compares count > EOF against exact-count and close_notify.
> > The v14 selftest (patch 9/9) sends via send() only and ends cleanly, so
> > it misses this; a sendfile() + count > EOF case reproduces it
> > deterministically for us.
> >
> > Question: should the device offload finalize and flush the connection's
> > final record at EOF / on close, the way software kTLS does, or is a
> > trailing write required by contract? And should a fix live in net/tls
> > (device record close on the final partial record / the close path) or
> > on the mlx5 side?
> >
>
> close() should be sufficient here.
> I will fix this in net/tls/tls_device.c:tls_device_splice_eof().
> tls_device_splice_eof() only checked tls_is_partially_sent_record(),
> but it also needs to handle tls_is_pending_open_record()
> (pending_open_record_frags). On the device TX path, that state occurs
> when tls_push_data() exits with MSG_MORE set, which is what
> splice/sendfile does while count > EOF still leaves requested bytes
> outstanding.
> So EOF can be reached with a final open record still pending. The fix
> is to close and push that record from tls_device_splice_eof(), so
> close() remains sufficient and no trailing write is required.

Patch:
tls: device: push pending open record on splice EOF

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index aa4ef04e9c43..0d43ebf67b8b 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -794,13 +794,15 @@ void tls_device_splice_eof(struct socket *sock)
        struct tls_context *tls_ctx =3D tls_get_ctx(sk);
        struct iov_iter iter =3D {};

-       if (!tls_is_partially_sent_record(tls_ctx))
+       if (!tls_is_partially_sent_record(tls_ctx) &&
+           !tls_is_pending_open_record(tls_ctx))
                return;

        mutex_lock(&tls_ctx->tx_lock);
        lock_sock(sk);

-       if (tls_is_partially_sent_record(tls_ctx)) {
+       if (tls_is_partially_sent_record(tls_ctx) ||
+           tls_is_pending_open_record(tls_ctx)) {
                iov_iter_bvec(&iter, ITER_SOURCE, NULL, 0, 0);
                tls_push_data(sk, &iter, 0, 0, TLS_RECORD_TYPE_DATA);
        }

