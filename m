Return-Path: <netdev+bounces-302076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RTATLGWyPWoC5wgAu9opvQ
	(envelope-from <netdev+bounces-302076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196686C9145
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:57:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=XoyEJGZo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302076-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FAD03028839
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 22:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC03B8D5C;
	Thu, 25 Jun 2026 22:57:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D503B8130
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 22:57:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782428239; cv=pass; b=LNvrRBSGe7uV7dSp9tj//1vSRyDEOqwOpPlOaxyzKoT7l1ZtUWhaWQZt1n1OgSNqqsVBM6EEa/6VafLYUrp2xZUtAnIKXFSYvt0kUf4Ld7qeDAxJfYnkJLaF56jNZPYBydxbOtRrQjKk1pkfmUVjluERVGyDXqmG+FvZVE9Da+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782428239; c=relaxed/simple;
	bh=xkH15FZFPfzdbt7oqrjJ4BwR0haRCPDMfbq8JYs5Gaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daYg7yjwU/e168UBgcwp8KzjnxcOp7/A+ap9pgqjkA32sSYhzX9lTtL9o1p9aGwYAMxxvJhSTmQJdShvGAMTjBHEyvapeYtdFX1j4s7NPBJEJT+q5hOyvzlBgq+8ybz2sdgrb8VUZvZhp+VwJ1ExvD/3KDzlIAb8O6E3W4A11pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=XoyEJGZo; arc=pass smtp.client-ip=209.85.217.41
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7353fc918d9so267920137.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782428235; cv=none;
        d=google.com; s=arc-20260327;
        b=GKxtyVhLYV/mxyx0fcAwRf/vjeVUOYMHKNlFv1La7DlSm4rvjp+Ulk7sfotGScId3P
         U14Y4bMph6ZXAb7LuY+WKweBvQw0ut8dS9497KWjotSnFw7AIR/X/W4Eit3cpcnTCu4v
         IugE0P/Z3XqdlOHJW2QiVLCHcnfCMc0MLR1R+gvYYCeghwOay4AKRyu7nYdc4uRb10PT
         yLuji3rlvrsgYlnDyxiSLNX/WQsI7OOnfRZjyksHzTRfMjSQ+rSztovKCQMwSA8lZzMu
         PnD51+ZXjzmsXCDPGU+yCHqJIPKtFH17yRnONWkkjHmD/c0v19jrNq6apEVKarSTLrIa
         ckRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkH15FZFPfzdbt7oqrjJ4BwR0haRCPDMfbq8JYs5Gaw=;
        fh=LU11JMcjY9vo5ppFJ6akUH2cvBnFemuXZu0FQ67UH9I=;
        b=q8Rv7if3KEf+Mx4ryuHL5yFE10njmXmj7N/IY2HHwFKpJ+7mtt4e+hKFGJwMZ+pL7U
         Mbl25Bk45TCW5Xt58xTCdeiJqUYdH7U/9cEHpgAwwGBTKXVIfO1OoOX9EbH7lGha9VVv
         l3X9dG+SfQ4a0I8/9DzmlmjLKMOueXx+2Iq3FbARPIK8raOaQO0i4AsZlL8pyEq9Pv1w
         McO00LEnUeIRHrRl2FBwUCXNpEDqM31+gmAb0PkhZaYfJaa9leoiaVa1eKbrV2WhxjzJ
         f/JUu1u6ebEXLDvU8zFqt2MJkMrkOAUGj2XAVmkj8vazv/ObcdmfWW2sk2Lg0vvlDkew
         9PWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1782428235; x=1783033035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkH15FZFPfzdbt7oqrjJ4BwR0haRCPDMfbq8JYs5Gaw=;
        b=XoyEJGZoELhVRJBEti/SB2KEYsxlvd1GLFDJY1ASCovzeGDvXc6FGAbrCzuCbBkSzS
         oin1+OZao27xLq/ce0K/K4vCwlUFtmOkd0GyeolDB/byUI1S69gbua4rZ2+OFsJv7Y/n
         fcDrgBcUiWoAjVmIHhzZiLn0NozHWeIOH1eG7vBfFimN+zr6l9o905yygehdNAtHYF5e
         91wyr7umX7lbNUwIZFReDcI4fjkQzarAbPGLQ0/2aJINW9K4cXXa/GZTdM7XK5H1drct
         sU67Wvz4Yw0kh+CxTKgSZQrH0h7upcmuX0z6SXg/vA6pA5/pDJ6QAPm/bxyHTvGTB3XI
         W7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782428235; x=1783033035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkH15FZFPfzdbt7oqrjJ4BwR0haRCPDMfbq8JYs5Gaw=;
        b=G6U8XzBvPyBeQvwc35QNl8AOur9ZQIJSkMtyAlx0DHIgRnvXsa6uHLMhRkhtz4CAFK
         FX072ff2wzgeShWX6lRWxp721r90CKkOmTim91PmYKBs5rK/ScrcNoXs463qwWk5tChl
         1xneOTTWkzkyLT9ifEpuEzsdWrEF1mAMwXq5YhC5KwLDwlnhplCsDTx/j4PFnsVGDEQD
         ezc7u761G+9OgdQXcu3OcTsUtAYFUfp9y9B9GKesRtozB65+8wmafNQeoWqJnIXOltQ4
         HKz1eC24JWHikYTdy20OO3FqhQ6jqZxJ0fmmBprAslDikeJhpC6bTbJ2OYoOHDDW+8e9
         JVOA==
X-Gm-Message-State: AOJu0YyUAYYTqPdIoNEgDr+5IfO0ymh5KNfCnvi/3MsLhfWhL4VeI/Ay
	h4/zuWTsec9ZhV8DjsdovMi6Iq5fjbyc6yADwvY2H2X5qJFOcvV7iYXC3ogTReXrFARtq0f+kPq
	O72WDB0lkvhf2NBRfhyN8Lk2sad7vkZ1YZKIYIjMz9g==
X-Gm-Gg: AfdE7cm6DTSZLKNzmOj5g47Smg93O/garFZ/IdeKU9kWaL1WdWX1SagZYs+HoHl/hCX
	azL8R2B9yDrkgOI2u2f7721jfR06Y+5d45TjHF7VwqOpVwPCT0fQCL97lWKALaSc1PYEG6k1UxF
	cHH8QCMpvU6YH2xtXtFJ+joCXeTrBPdLwF3ONkIVCDUi79r1rd1o1WGaaOwp36swZJJ/IRMIkir
	oF5xTpurZS5aVb70tlF9RtOoiINa6UNClwuIhXhAty58i0b9JjfkC3DCJ0Ij8W/slPLCFH7
X-Received: by 2002:a05:6102:5344:b0:727:a787:608a with SMTP id
 ada2fe7eead31-734362a8192mr2593744137.20.1782428234988; Thu, 25 Jun 2026
 15:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com>
In-Reply-To: <CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 25 Jun 2026 15:57:04 -0700
X-Gm-Features: AVVi8CdOdcZMRgjrwL6pVY-FchRTaQef4J1jPkos5-zV80YQV-CAjS13UQl5OWQ
Message-ID: <CAKaoeS1dxK+SLrUPdE1J16TpL_M5mj8JTccL7C2OzfnNQEFNSQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-302076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 196686C9145

On Tue, Jun 23, 2026 at 10:53=E2=80=AFAM Nils Juenemann
<nils.juenemann@gmail.com> wrote:
>
> Hi Rishikesh, all,
>
> we have been testing the v14 TLS 1.3 HW offload series on a ConnectX-6
> DX and hit a sendfile() final-record loss on the device TX path. We
> reduced it to a self-contained C reproducer and characterized it;
> reporting it here with the analysis and a question on where a fix belongs=
.
>
> Setup:
>
> NIC: ConnectX-6 DX (crypto enabled), FW 22.47.1026, SR-IOV VF,
> TX offload only
>
> Kernel: net-next + this v14 series
>
> TLS 1.3, AES-128-GCM, kTLS installed via setsockopt(TLS_TX) on the
> sending side with fixed test crypto material and no handshake, like
> tools/testing/selftests/net/tls
>
> a server sends a file with the raw sendfile(2) syscall; a client on
> another host reads the decrypted stream and counts the bytes
>
> Trigger: sendfile(2) with a count larger than the bytes remaining in
> the file (count > EOF). This is what a generic copy loop / Go's
> net.TCPConn.ReadFrom passes for a file of unknown length (~2 GiB). The
> kernel sends up to EOF, but the connection's final TLS record then
> appears not to be put on the wire unless a subsequent write flushes it.
> An abrupt close() appears to drop it, and the peer receives the whole
> body except the last record's bytes.
>
> Reproducer results (two hosts over the ConnectX - a loopback/same-host
> connection stays on TLS_SW and does not show it). Same file, 226965
> bytes (=3D 13*16384 + 13973):
>
> TLS_HW count>EOF close() -> 212992 short
> TLS_HW count>EOF close(), no zerocopy -> 212992 same
> TLS_HW count=3D=3Dexact close() -> 226965 full
> TLS_HW count>EOF close_notify, then close() -> 226965 full
> TLS_SW count>EOF close(), hw-tx-offload off -> 226965 full
>
> So it is specific to the device-offload TX path: the final record of a
> count > EOF sendfile() appears not to be finalized/flushed at EOF, only
> by a following write. A bounded count, a trailing write (close_notify),
> or software kTLS all avoid it. TLS_TX_ZEROCOPY_RO makes no difference.
> We are currently using the exact-count workaround in a preview environmen=
t.
>
> We may be misreading the code, so this is only a pointer: with
> count > EOF tls_push_data() fills the last record without reaching the
> size=3D=3D0 case; on the device path tls_device_record_close() for that
> pending record appears to run only on the next push, and an abrupt
> teardown appears to discard it. The software path seems to flush
> pending TX records on close (tls_sw_release_resources_tx), which would
> explain why it is unaffected.
>
> Reproducer:
> https://gist.github.com/totallyunknown/a8f0ad3c54e40befde2f5a8d360fa6be
>
> It installs kTLS with fixed test crypto material via
> setsockopt(TLS_TX/TLS_RX), sends a file using the raw sendfile(2)
> syscall, and compares count > EOF against exact-count and close_notify.
> The v14 selftest (patch 9/9) sends via send() only and ends cleanly, so
> it misses this; a sendfile() + count > EOF case reproduces it
> deterministically for us.
>
> Question: should the device offload finalize and flush the connection's
> final record at EOF / on close, the way software kTLS does, or is a
> trailing write required by contract? And should a fix live in net/tls
> (device record close on the final partial record / the close path) or
> on the mlx5 side?
>

close() should be sufficient here.
I will fix this in net/tls/tls_device.c:tls_device_splice_eof().
tls_device_splice_eof() only checked tls_is_partially_sent_record(),
but it also needs to handle tls_is_pending_open_record()
(pending_open_record_frags). On the device TX path, that state occurs
when tls_push_data() exits with MSG_MORE set, which is what
splice/sendfile does while count > EOF still leaves requested bytes
outstanding.
So EOF can be reached with a final open record still pending. The fix
is to close and push that record from tls_device_splice_eof(), so
close() remains sufficient and no trailing write is required.

