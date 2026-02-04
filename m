Return-Path: <netdev+bounces-256492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCm9IQKSgmmhWQMAu9opvQ
	(envelope-from <netdev+bounces-256492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:25:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B0E0000
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FDD93023825
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9159C1B6D08;
	Wed,  4 Feb 2026 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asPmuZiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B431534EC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164736; cv=pass; b=IgYn/1jxIMstFJtlRDvetrV5cAnu2tC7iGZQj1EhGbRKS/HzwUv0ovs4WOzz/ULNR8wCBfr0WmfK0qP4f8RrSLoQyKB/FUIG9nUPTohTlC+jFusclgv23qJ0lfENq7NIkJGiQrYmtr/6qwt7V3l4McgxtIHsngVpVB5s76X8X3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164736; c=relaxed/simple;
	bh=Mrltk/DCs80aTBXbn7fDkaLIA4Bpf9ypnkC6ue2NK5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzBLqYe8hvA/IK48VU5tsORcOyb2/XPPS9tyBz41TqmjXfwqXGMaF0XZj/V24eR6l1LprTTyZU7zY7Aq5wYWQvnRG8myn8tDXZQr/pTTWu4BFjzhWb5ynVPNFrI5r35iSmJfBl0UT2vqnVMT3D5IWvRmmmFpk+QYsOr1hZrvweU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asPmuZiF; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f36012fb2so7319137c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164734; cv=none;
        d=google.com; s=arc-20240605;
        b=f2ClTbHhBIx+7vSRNbm23DS5QRMxiha+aoiellR2R2Iqw8qhVlrehaIvweNBZ8BtW0
         KDO6nJPg50boCD+MlQpd7R8ThJKtJBzr5okocPuNK+uOh/FQv3wmmzBMOev3Al/pAhzV
         Q05qhSo00tob3VCNkuuPL3AbNfMErUzRzrT8RwbiWdhRVgY2BT9aR1Du9NGXj3Ix7Yvx
         vY7Go15G1JLSHIEKeQOxNuqJZaryNhDlz5QErjJVYq5icgJgod0rYVd36GuQC4gRFcvl
         403c9C5TBqX45GBUqyPEEWR598qaQ0gN3E3ZM4Vjshrq2oqGh+7ZzPZonqnxo6pCOqg+
         cVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=erRqHtT/9FYWji5NwmUG3bpGDUNykTz0kJJdilJD+pQ=;
        fh=1BeRebXQv82+6SE6Y6P5XtUTnMYe2CveO2DWeuNwBQ0=;
        b=c9xLMFk4+t0Ps/weJmEhkZJI0sQcDlDg1903iRIxPBnsYiUomR3nDrCh/hav0hsot7
         QqtrehYQ2oRiyz5e/ov2yR2t19U27YnYA2ATiOkA0W8qG2LiWyzB7WlyQdbeJSe83Wjf
         2koYTyXTx1LWg+/cR+AMShBcmjDYTnyFQydfVbFCNZ9IN8jOxZtuILhD3GTTQE7QyoCa
         tuQ2x8iFalFH3A4inCd2Fd3p0t2T9Jdnv/7wW13f9DowtR9qofpSJPyCsIkLwUyNfcFw
         Et9zUA3sC1vCTY2Iv4E0YM6GBWmPBBYhP7KgVAychZC5DR5/eND2+y34qETOmqllyXtd
         Oe/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770164734; x=1770769534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erRqHtT/9FYWji5NwmUG3bpGDUNykTz0kJJdilJD+pQ=;
        b=asPmuZiFmnVRL+U4xYCDq8DsI+XcBg1P323b6vIn+noRwROa7uQ4sxxtAHV9P+m1A5
         4ghm4ASvCU2nFFMHulfmnYx4oC36n/+uehzrallpmIEd+uVZnvYeCJ3OodItNmDy5WeQ
         o7HYEoNsVyi4fXV0uNlTts6vZa9W3x1a0LNL+t2K5shsidk1FteW4WOdFIWDeizZ8P5a
         79aqz+/g1xbOoEyOsdphWZIb1MqSXLIuz8CC/Sz9r0gaKFZrJBnF4AoiChmM5LA7CHp4
         vf2Hs6H/Ih4lfEljOrn+pPL0CtGF8xfI5N+FaQdHaRkBrJu59HBjceeqQIFO//uVTF1t
         AkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770164734; x=1770769534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erRqHtT/9FYWji5NwmUG3bpGDUNykTz0kJJdilJD+pQ=;
        b=Jz1wk4H8VnnUj4dsdt17sfaZMdZadW7bZnMdvArKxBBuBixspc3gQ2YlKrArYKB90a
         Q70IcewAWrECzzWqe9Xb2ttDYPMw+r5GzIy7TL85gn1pqbbubdgz/zgPeqdOv36boNW9
         4u7uyYtIHg/Gw+HuKH4mR/aLpG3wQ0sJpcaEqSQQkPnZDSymtZYQtwYX/i6JqvelEQTr
         dviV7yKXANv5bkCtnu9Yc94UsHU5FEjVOJ+Q8+GMSYIK0Zk6l4tNVZWaMZddyx/Gfivh
         +HbSK/RM2QdW7xwHtuNONiuYh47Z8JU8GJ+NDkazYA5qXBjJOB50XTDESEVqH8moZvz6
         O93A==
X-Forwarded-Encrypted: i=1; AJvYcCWpRRbM1GFswn0xOX0GojkkiVcWxfPTw5f6BCEoLd5ggJ2gFt7/sCo6Xta50D2/RB8b8RUxTB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs6//ihTajRjF9l2oWEVKzUeyNTMjqfqHr4jBl6AFTWG4zWeW
	OTh5lkvtsQVk+79LxYE1/eZyDae+7o/XBiF3y9RuQg3ecmB19hWz9hLnfTVSzf+HwdikzY7nWuW
	xDtWghn7LeBwHgwPPWAbxXpF+ithsBG8U6QK8+qtm
X-Gm-Gg: AZuq6aIXRo0tE1BzIQZEvSlxgRGMFzN10LGudDKwD8+BfgJHloSk11Q+tSfih8gEVJg
	mN3j0SoHb7vtnGji4mrUedn+DUWeGiIIVuLJruVgljzBzx7USUsTz5VBCGRpW53EybMJ/wnFwaV
	dnC/S/TZN4QWNDiFLC9/LK8HM1OZmnGK1ozKSE4imNVKJ2MdKfWSnRsovfNE9ya8I5vTuD8jGkw
	zmO+xqWazReqRP6r3m/Uuc5LkH3O8zP3oDU1OX2ZQzRDeeHzZsBB2sQem/jqzGCP2tRDe8MDQFa
	WAlDOomf0VhKX+E9LPsKfP+rVhTUVyIrdYLDOYXtxv0CBokQPWEs6bs/Iw==
X-Received: by 2002:a05:7022:6b9b:b0:11b:d6f2:a6d6 with SMTP id
 a92af1059eb24-126f47da831mr546426c88.34.1770164733927; Tue, 03 Feb 2026
 16:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203044226.3489941-1-edumazet@google.com>
In-Reply-To: <20260203044226.3489941-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:25:22 -0800
X-Gm-Features: AZwV_Qg9yUgxAugEeJRlvXJ6pu2pN9VqGPC4l9ZFAmbqNTBgpu_mqZxk9BcsPKQ
Message-ID: <CAAVpQUAac_ZwS34OwLDDPHQUHyJ4Er9V2cdwyiP1Op9pW73cKA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use __skb_push() in __tcp_transmit_skb()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256492-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 2E8B0E0000
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We trust MAX_TCP_HEADER to be large enough.
>
> Using the inlined version of skb_push() trades 8 bytes
> of text for better performance of TCP TX fast path.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 8/0 (8)
> Function                                     old     new   delta
> __tcp_transmit_skb                          3181    3189      +8
> Total: Before=3D24896035, After=3D24896043, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

