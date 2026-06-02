Return-Path: <netdev+bounces-293989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMdqGNVHHmqbiQkAu9opvQ
	(envelope-from <netdev+bounces-293989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:02:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C41627871
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 05:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66E8A300AC95
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 03:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B846D364047;
	Tue,  2 Jun 2026 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WG4k5pad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DB3630B9
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369361; cv=pass; b=l3jZdPisvh9iVffOB3zkDZs9MaDhJv8VJRmNNgThwhfUB0mIhyWjsJSz/FpvcFhiT18Savt5JmQGaiQel1XwFrQ34jIhsuaYl7Xl+Dh1PzSuWIl/5VcfvRgjZO6IXwspm9vL3tHC8nmOrW0UEH8SG0kPOpuQx00vwzajk5Tjf4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369361; c=relaxed/simple;
	bh=RnIW3qmnHLBRpyMDOu1mpA+jBoMl6x3qPFLQbmUMVl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KohQDHqRk3zGp0Dt+IXxThjvX3euzK9SzhZ2uZsiCI5hfKljGLMNQ0ypBjVKs+vytR01mlqQPBNskE3qrKJkUbwCNqQHutYykHsktFGZuUccIXf5C2jrZL1Wn8c9C/p4+dMG0cPmTOjP2LjKxrTp38eJSg/zl6XmPadx8VZo5Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WG4k5pad; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b944f6edso21760845ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 20:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780369358; cv=none;
        d=google.com; s=arc-20240605;
        b=bOPxfUY//UMlX2Jn0wQRuRq8eI4wszPy1aMenKCowILUiQLkQcdyf74j/tyk5Z7LCc
         BzcpF/P+uTdQXAjWomuNDU9n4d8CMJh1RjxrU/szXffDZ97TTcGkuNMlc4bWGrMHmXeJ
         F+lRYDcoWVtKJn2ZbSZbGNbnJcedJKaW9xUvo7jKNUhCUWTXr5765xpkiMAxRF7zJZV+
         8D4y+ynXoUbK4AlSgKJAZsvFIyTWXOxymi6kjePs4bIgYOX0pxzwnbhbSR4imlnWA5o6
         5bZrvA5B0ofScJz47YchnppQzPtXjSubsJ2GTpROHP13sQjACzeEOd3a6MKq3cTRFtKA
         2wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        fh=wyDp3GeBK1a+Su78oMC6Dn6mMcw1bu2Iv1qRgGVUacM=;
        b=G+hhc9S28y5E7X6MfZVbOe81BHpCfUpP8lS2mwQp2pyoIvYMCbUH3VlB8Qmag/eKz3
         VEoZq1HBFcMmwQG24/HqH3VRHcBc3Ib7od0GGhO7xDoiNAW9+2rucDiimXt3MY31OjEe
         8YKVFQLVSETPSR552Py3pl30IdsExdaNHv6i6hMAec3APi2eGzrdSgC383hQidPjiglG
         tkD2hO0RA9xsjOdnKjqJQ9egujI/3jx9ZfSJbGKWvT6lC74PEGgWIKQNgqdTNQliWn1i
         UMvxlaOGNMYNxG8er81l0PshZKPeO5AlIX0pFdHARmtcL8Igto4QKfSGY0Mo1MTe3x8G
         rENA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780369358; x=1780974158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=WG4k5pad/j+z0EGjhJfou99wweYu862hQYxAv7rIAeGZ2w9AZUA3jEXNrngRPw7BHG
         LJhJsPx+i1DHiyE45BMqRDSTGNdua/UipOnwbzfGmOhj5Vf7Ny64/mCVWRWtMcUPrzf0
         vCy/1mP6bE0SPTk61TC2V4CeKaEBMn/WOAu39hhfaQIrZK5YyDI2f5mgI5mwypxL2rY3
         rErMT2KqhzBQwzXwI7dlL3qf2+CvFr0LqLo0lcBCVr3Yo8l2u2cgbv5EA/mHALNoy8iy
         9MVD5iE5EAitiGDXPo6vuR2u5WrpxUOiCY+8l/4/lgRkOSkDDO30aKXHxu8lqisz4+Ny
         LzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780369358; x=1780974158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cX5ghXyUMI7Mq5sziM3BByCUGq4ELxb8uNFCRPHZ0PY=;
        b=HKMOdqe6AhmPRy+fsYeO5eWaincTD7agyiKIQtfSabSpDkpbT9+YlfRBfbJLSOtXSQ
         X5y5/vHp03yAif2gsA0qdGsIyiwRGdAX8w8iZxQgKc3edH0zbNvZ25bPgZOIhsBosbWC
         GZcctibpgdTEgnLlIXBPzaOqqLxwKwYV5vl1qeqO1TfiQSdgSbne7DUdTIit3e6PCaY+
         BGfHyv9MtD6AA0LbdGS1LJxD9jMvnyhYl1131yWiKby3VQZTF3jb7Vf8KxaJW19aPASb
         S6UWBG+rUNYngTkkCPh9Rd1h1OA8oVnLdQenxPTcZWJGwdr56i3NKlZLE6gK5OP2NE4I
         DADA==
X-Forwarded-Encrypted: i=1; AFNElJ94rLNkr25sK8KJPE/zGRjTI+Qde9Blc57XXg7rTwVr4x5EOa2Gd2Tfr1+ecOlgTFBWfmv3zxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv36rKpdDGXXJQuFqY9cpe9q5mdKRrP7L9A5cLOkCg+mAVRNhg
	i1Ns9T3CuAMdVeALvLd2jacbYO+Ud41IjBpT14GB1vR2kzAOFbd466RAltTthue3Zm1/iGiP1WC
	G4zjfEvX7KdLYz1hfIiPH3uIrKBF3qoS1iPxOTmZ0
X-Gm-Gg: Acq92OH0NvbNUUDBDSjd6bgJlyuCaCCNyuqBP3nRsWQIiKQOVqMbteRflimPxtfsV5l
	yN2RhUheXXlXxkEjOW5Ei2efFkq2g5AWX5JhVKY1b5dptJyVGSNlhdi2oS+RNPMPfbt8FN/HIGH
	YJhvDfRPREs6Ylq1m76mueXHptOpE85FRLxR30+6yJyKXdy6y+t0g9/ukdMLZhvJwycR/Fi9j2C
	FN0NRT4dG1QoCc+GIqEJXNutOBH0P+Ja62M63uyXFalORwGrorMNLTp45pjck9dEoTJJfy+XZrr
	5SQGn+ieIHVYNcyITQ==
X-Received: by 2002:a17:902:e784:b0:2c0:3400:5c42 with SMTP id
 d9443c01a7336-2c034005d88mr148499485ad.26.1780369358143; Mon, 01 Jun 2026
 20:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524041442.2432071-1-tpluszz77@gmail.com> <20260524041442.2432071-4-tpluszz77@gmail.com>
In-Reply-To: <20260524041442.2432071-4-tpluszz77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 23:02:25 -0400
X-Gm-Features: AVHnY4IKOEuFCYPopcTHkisDnIftyduVHmrJM7aEiXWe4ijxf-NYQbyG_FOKLzs
Message-ID: <CAHC9VhRM81w3-38sx103CFuow=+Jg4SNvJGWekNcow4s1yOAdA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] netlabel: validate CALIPSO option against skb
 tail in netlbl_skbuff_getattr
To: Qi Tang <tpluszz77@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, fw@strlen.de, lyutoon@gmail.com, 
	stable@vger.kernel.org, Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,strlen.de,gmail.com,codeweavers.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 07C41627871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:15=E2=80=AFAM Qi Tang <tpluszz77@gmail.com> wrot=
e:
>
> netlbl_skbuff_getattr() locates the CALIPSO option in the IPv6 HBH
> header via calipso_optptr() and hands the bare pointer to
> calipso_getattr() -> calipso_opt_getattr().  The consumer re-reads
> calipso[1] (option data length) and calipso[6] (cat_len/4) and walks
> calipso + 10 for cat_len bytes via netlbl_bitmap_walk().
>
> ipv6_hop_calipso() validates these bytes only at parse time inside
> ipv6_parse_hopopts().  An nftables PRE_ROUTING payload write reachable
> from an unprivileged user namespace can rewrite both bytes between
> parse and the SELinux peer-label consume path
> (selinux_sock_rcv_skb_compat -> selinux_netlbl_sock_rcv_skb ->
> netlbl_skbuff_getattr).  The self-consistency check
> (cat_len + 8 > len) inside calipso_opt_getattr() is defeated by
> mutating both bytes consistently, allowing a ~232-byte
> slab-out-of-bounds read from calipso + 10 whose set bits become MLS
> categories driving the access decision.
>
> netlbl_skbuff_getattr() has the skb; gate the consume on the option
> fitting within skb_tail_pointer().  The IPv6 option layout is
> type(1) + length(1) + length bytes of data, so requiring
> ptr + 2 + ptr[1] <=3D skb_tail covers the option and its embedded
> bitmap.  When the bounds check fails the packet has been mutated
> after parse, so return -EINVAL rather than fall through to the
> unlabeled path.
>
> Runtime confirmation (SELinux compat path with selinux=3D1 enforcing=3D0
> and a CALIPSO DOI added via netlabelctl): Udp6InDatagrams increments
> to 1 with the mutated cat_len, showing
> selinux_socket_sock_rcv_skb -> netlbl_skbuff_getattr ->
> calipso_opt_getattr -> netlbl_bitmap_walk runs end-to-end past the
> option's true bound; with this patch the consume path returns
> -EINVAL at the bounds check and the counter stays 0.
>
> Cc: stable@vger.kernel.org
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Fixes: 2917f57b6bc1 ("calipso: Allow the lsm to label the skbuff directly=
.")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/netlabel/netlabel_kapi.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Thanks for the fix.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

