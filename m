Return-Path: <netdev+bounces-267033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNRKJSCtsmlGOwAAu9opvQ
	(envelope-from <netdev+bounces-267033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:10:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E050527173F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271B53061618
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2A3B776A;
	Thu, 12 Mar 2026 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjF+aRVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5139B96F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317379; cv=pass; b=AFbdtePxJNI6ioLFLUNyki3Bf1JC/QYMhHooxkNfBL8SKa5j2q5GcYt+eLukgRxpoYcTXduKoxuv/lfXFSY3ylTdk11IxXKqxH4y2YJ2S6rCZsgeK4glcavMyfcFS9/9h3VjxSlxC13wkHft4C9SpakUdeeLx55D2nv1eMRejSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317379; c=relaxed/simple;
	bh=ZpFAmt7SrzAnytg2mt8g8AS/FBDIeJN4EMMfixJo+CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfFjVr1PZmD5JXyd+7gq8ioX79HaLUNWP53BdoEeMe7cf5S7e13Gob5FucejCD9AeX0hxaJVRf7U5GgH8Q3m/b+WslWNkEXYJADDOEv2GbM606LjzOiySr9FlWl6iW9Z97J+ey6LRnmx51tqbGmmCDMmd0eJk20uiH5q4zlPwt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjF+aRVt; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-509064418a8so11423001cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317374; cv=none;
        d=google.com; s=arc-20240605;
        b=BcfG2c3/PPIIY3wu1+xHQn2p8NDPZu5WKVCBn8YZe3B91s3yAi34FUkV9WPEJ8q8rt
         i6cpqgI40MNJs7tbe66y0PQzm8hIc/mr6T/ceehmZH8ivnPD4TGIcnRCwnmY/ydv1B9a
         uhHgdKeg+MCDT4fNvb3dAH+Cgb+8vuuMSh4eW/bfVHpCtMYAAWunUW9sfLSF6/i8vKPb
         cOyi1JZ/mxCsGQ976VtaIhK2QZj7NkAdIbqYZ6g9Figqz4+0IiogugL6RXj2RFlvYq6U
         WFsUXBo+42laI58HMhFwX4NkRncVKuLjoCJl0F+8SQ2lcnTTvgJFO+Ie07m8vdleHovm
         TGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoosqWt+4YTdacrIN0iGtpZUaHYbjIMF4j4LXXRJKRA=;
        fh=7t+NzwBATa7iTS9CQzFL7I0vuWiHJ2s8hKXP8pi5GHo=;
        b=lISE8A8PbbSkmMW0DgZQqS4VZXuQCbUFrNJjrp8opJqm7ZUz28BdYrU+V8NJHoylZ6
         hT9l1YxMmtyDhFO+Y1QRsv0/nxVXUQ96xxXL8Tgo1XlwryRXBomBr+8z+yBqx8iVefBO
         WSsbXhczZxJVYlgcctY/bG/zSz2Q/5C4bgQN2fCuxQ04hRWlQHWMRX9//IoX72NzFTrR
         Pe1Y0vctzMidw4y0D5dEzsI8XoE33W9jqT8Il7Xo0T9/JjQROgMdSv7b6CqqQreAjamN
         Ucf3wJqnt6lJ4lQkYz71cO1uNFTFq8NaBnF/6WKLxtIISpeesVeSNpgSpVsxxIqRX/1j
         o5Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773317374; x=1773922174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoosqWt+4YTdacrIN0iGtpZUaHYbjIMF4j4LXXRJKRA=;
        b=TjF+aRVt2lbh1rpWhpTSKjHuOFHPFeugyK1CMMowuICN3+JZog95Ve45w8VRWl8BCZ
         7ucaH++4RcZf2R2xw7904xV2lFm1MpHytElltY0wb4zZVJrQJAIuyjNh1XKQy+rGYOi/
         +MuPGzhakaRhZ4bAJWKSJQOsF1n9FS0E+Rq/XngzR115Jny7UVJbrosbT8dmrEu5/0Pf
         oDaC4SE7stpQrT7iWEHJbeGs7Z891Mw46Ko4bM5/UZc9c6ykivLHgRUQ/KVFrSk+RUMT
         ceMqKsr+WvbXPLj+2RomHYKqpxYMV9AsI3NXt/mLaYJ/Kt1vf7vngXzmqbYmBtOsArBP
         Q5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317374; x=1773922174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoosqWt+4YTdacrIN0iGtpZUaHYbjIMF4j4LXXRJKRA=;
        b=gnYhAsd0HP7gkNoBzxhPs6bwYBnF6ISuELq0t2lnFO2F0jhv3BK88wWCFKanY/hetD
         PZC8ul817oMZSwPxeIvMc7Zqr0iQfJgkRzxPZvl0pkw2aH0lnVVG/CPJbcDqVkdxiFUH
         1wq9dcC3GAmWPaQM6cjPg3ElThSy4eO5efdMnc6rFez7ALQUauYMa2MPNnAAk6Da0D9a
         vpp86j2wmGbYbvmTie6L6NeYuH4O/i5LHdqc1t7uhciegsWwraeQzvzWNCic1pXZhIDM
         2pc+VLa57kxxCE3FKl2f4MLflfCvwWMfBcU4/y0CvYlI77Pj52WW2xG1MGwNkRFSxEOd
         wkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0u9b/CGjMRk//huVhrbW4Fq+PAVlfnzzLGeVHossvuVoQ4aB2c3u7W2IOSe8C6MCdF1dvt5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR33zB5xqAx1LZI1no55Vw6SlSKXiSwxSUPBKtKdZDH/PJZlRg
	kwm9xBar0R40nhDUkbMoYxzZuGA27tW3C9qjUJYIAOVe+ul0juvi+sOY/vyhvxxswMpxnIRbJOi
	EAdqbT6ahEFwU8KQ5ajjTXzhgiQpqefRy90zueRMxpYWMKZGtSE9Xo6YC++U=
X-Gm-Gg: ATEYQzwYo2aGBcgWhJV98JROD44W/HFMst8+BToFI4pm5r+KR0V+vJTif7XSgXvtAYV
	4OkkFKU7A5Ab++h6njpMAi6nZ4ywV3fI0HFtpQMtMYt+9KBdGLTJr8F+YzIXDjJ2+8NaD96rCym
	ychXhxRkq7isvQW4lO8hb1lTb4aVG/sHL7IJOMPa3dtMobc6hBcoZtHwXtoqpIuqmzL5AJ0w1+g
	VI1QOssIlkMMtgbTL+T7AX+ocRw3cUqi0M46nPe2QKut/08ooMZf9IhEGsCcpV5zxorp0wYfw28
	rYzF7JNovAv4KT6Htyc=
X-Received: by 2002:a05:622a:1214:b0:509:b40:cf7a with SMTP id
 d75a77b69052e-50939fa64afmr74269731cf.17.1773317373303; Thu, 12 Mar 2026
 05:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312112457.3606806-1-edumazet@google.com>
In-Reply-To: <20260312112457.3606806-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 13:09:21 +0100
X-Gm-Features: AaiRm52sB8759wSwj575Yi_eS7_fNY80au09N_cf6UFMEMaCO29g9bYzOeNeQOs
Message-ID: <CANn89iKbPmLZyBgUfKj55K3O4cvtDQY7bHwTZHTut=t0kuKY7w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: improve inet6_ehashfn() entropy
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267033-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E050527173F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:24=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Instead of only using the 32 low order bits of the local address,
> use all of them.
>
> Xor net_hash_mix(net) with the 32 high order bits of the local address
> so that we can use __jhash_mix() three times.
>
> If we were hashing 4 extra bytes, we would need one __jhash_final()
> which is a bit expensive.
>
> Using net_hash_mix() at the beginning allows beter register allocation.
>
> We no longer use a cascade of two jhash and inet6_ehash_secret,
> this was dubious/weak.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-27 (-27)
> Function                                     old     new   delta
> inet6_ehashfn                                330     303     -27
> Total: Before=3D24855320, After=3D24855293, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

I will send a V2, it seems I completely forgot this prior patch.

commit 9544d60a2605d1500cf5c3e331a76b9eaf4538c9
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Mar 5 03:45:49 2025 +0000

    inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()

    In order to speedup __inet_hash_connect(), we want to ensure hash value=
s
    for <source address, port X, destination address, destination port>
    are not randomly spread, but monotonically increasing.

    Goal is to allow __inet_hash_connect() to derive the hash value
    of a candidate 4-tuple with a single addition in the following
    patch in the series.

    Given :
      hash_0 =3D inet_ehashfn(saddr, 0, daddr, dport)
      hash_sport =3D inet_ehashfn(saddr, sport, daddr, dport)

    Then (hash_sport =3D=3D hash_0 + sport) for all sport values.

