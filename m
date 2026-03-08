Return-Path: <netdev+bounces-265318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GWBFnqjrWle5QEAu9opvQ
	(envelope-from <netdev+bounces-265318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8423112A
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F35BB3007F72
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F582DA77F;
	Sun,  8 Mar 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzAHgI9p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601424DCF9
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772987255; cv=pass; b=JSIrepKkjZy9M6t5bH3IcKlMYT0N+Beztd3Jdh9+BlynU+7orhYXRwCmjBJzJVWL/5Dw7MvtzusMMlye+7/Obh5+plLXCrb1QhryTGmc7YptpESBg6uzK5r/TC9xa984Mir4y0pzlUp29owhNIOQPJTUiczBBVk/j6gEyZTNZpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772987255; c=relaxed/simple;
	bh=Mqt46EtACv1QLtSkshy8MQnJU26hK8mDLGctaCw5dPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzNTdZna7p1uZXwTsQ5DgDZFyb8bIpqAd78dCOXeGa+4syMDodkC+OjT5Bh3KKje/NIKVyJWL7uFrLriFqeedpdH0GPeKkygv3azt/kvBZUYZXstYmzelfBW/cbq7XIEapammpSyP2p/vzdcjbYdAuPGLsZPWhcj15cox7PH/0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzAHgI9p; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509069a7a7fso473651cf.0
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 09:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772987253; cv=none;
        d=google.com; s=arc-20240605;
        b=ALbrMu1Gq0xaREBxBixWPLEg4PZKaJuVofsnaUuhJeJ2rYIvT8bR+aRwyBE3GgjRzh
         M8zE7cBEDPzTASpJyh5a0XqJNJ3oIK57SJM5YjlG3pduyRJlf0a4xbAHDbbLA2rSp1NF
         rnZySLHVofAWC1NxM89NN9ND8qnZc7vXAHEGSfLIbTEaG2MxLGoy2Zn/tbutYD9STtei
         suI/NndOU2bF1v5PxRUNS0lIWupOLgp6hW+AlTKwrfX78h5I7AtNquhkgEXctJ8FiGE3
         zF2/xgvG0FkBNszW9bZY8WZOZXWo+OGggWqhekGvOtpGEtUgJ0o4gfD/4qsoosA+Dfhm
         9+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lpJ0sFdSUjku1NliPo9FbRDXZMUXZW21SCvyKdtkiRw=;
        fh=XV/InAgCmYZdTCMCBjFRaPhAKHPxlJh21V2EIp3j0IE=;
        b=HRLNOI/KXsLH5BYM4NJHzMLGvJojlDUPnBSF5ztEtd7ZUp7tUOnnGmblprS26Xv30I
         HKlP6nm0ROufTclQpBlQmfd5+LK7+rvHFU2oMquF5yH1yBCafmOEkAC2qZn40lNNpBZQ
         OyV3nKDiVcz7wu5CulkLwrvxcZcz36wv804jXd65lAQlZ3MJ94ZVVhsl/HApsGsdve7w
         13p7+b4okl/3aRCoyIDoJgxddVr7CviYWIRjpTEU0Y6AaP3tt1l4ChTEpyvsWKa0+I3/
         hm7nhA/k3xWjIhbU6y78zupb//VvukAe37uID5COLbLoiWoMCwPfJDSIEpzcbYVNxVHS
         tubQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772987253; x=1773592053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpJ0sFdSUjku1NliPo9FbRDXZMUXZW21SCvyKdtkiRw=;
        b=uzAHgI9pN2Bs/4Wt8QkGPyH/B7hspxnHUUpF0J/CWYaZ661hdltpBk8uTfUhe+5tuK
         Hg49nPlGsio5Lz+fFlagt0H61uPpBWgfL0s5O4XNAroj2Ba5gvd4b5FebEgs0ubVxLPJ
         lzVw1L9PqNhZyj3XUi3ygtH4TqaYFuskCXKB43pt9UVvghKPkw/oNmYFpgCnni9nwRgW
         8fEQeDpbRogkgABlI6e/2VP44kYJXsW+5fTcHH3Ti6osF4NXS/H6GkFa9Ix60WEOE/0N
         rHbovaDbpHXkcoLg2V3kjLAIozXySFitM4GmHKdzaNfs2tfzX/k/n7ZQID+a8cRq3bay
         mGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772987253; x=1773592053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpJ0sFdSUjku1NliPo9FbRDXZMUXZW21SCvyKdtkiRw=;
        b=OjJdkPR3/tMHpeRMgiwnHd0PhAB/TzDhq1jSyHMDy8eK6PyHgwd1Pf31odllxY60SJ
         9asOdUCbcY0yM9n4S0Zj1EL64IogT9b0EkHaWYvQykKFVy8a1iDUWhzZFQfLz1zYimNl
         cFMSRMqF/aBQoAM9CJ+EHyWTiF779nzcyxg/yO4gibS8n/HpvNX3xhuYovgHmeGla4kq
         ZPMPEzt+6xkuI91amqZrpaG7uVqiVt+xW6Wiw8ZTB8PlHK1dfnlH9AVQKEb1KcFY4rVF
         c9CRLliA+UKB8z59eFT0mUN7hAlWaxKRApcO2cx1OjnRc5zQptN0KnpNs7KZ0n5FYABX
         2Eog==
X-Forwarded-Encrypted: i=1; AJvYcCWGpTGolmy+P2uQ6mHx6SpbV8SxnQjOmqzWq/XUpbiJXhPOohz1Yi7RV3KcqId+BtQ8gZqWgig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+RrTRMzIILphAy63XjjeH756CsksJjWl64hlZual49fu2FDv
	M4xsavoqsuDmE69fElmjVUtORnSnRL6p1SToKOHLMQKn4qFnjby0xyOk/iqejuIzEfIqSdvPtso
	uDdydPzUyxjEabtk47Qkv42IzQriv6nZ6AEYMiahT
X-Gm-Gg: ATEYQzzYZajMTsov0TZSJBIkbn3wr3tGEkJWaO6bNaDmWZEzpuFuFaUOjCoXx2oYP/g
	3XCZOB4dgIOMHjYp2knuFQSrwf9x+/Xeu5Xo6d7ox1MIEYs37NR70qs6Zrs2WMitCu3qSQcSP+S
	xDu7xngbq9+7uE3f3/0Xv+7MXVgkExipCiU6Ah8p758a0Ko264yXOOlQM8i0CBoONV1LeV6bdMj
	iN+LrkWsDZCiiAIi45dhKMQn0BuN+sQW+O7VTjN2CQIzFyDTdmnF0lBwpCyqNXKBm0fRG8s1BiE
	qmeGrOf/94uPRsZVLW81DeN4eTphuGW6XVFnXlb8VsCjyMmKQqc6Ay/vIFNTs8mY4ZUE5i4=
X-Received: by 2002:ac8:5715:0:b0:501:19b9:42e9 with SMTP id
 d75a77b69052e-50900e74842mr15469361cf.4.1772987252729; Sun, 08 Mar 2026
 09:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308123549.2924460-1-edumazet@google.com>
In-Reply-To: <20260308123549.2924460-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 8 Mar 2026 12:27:15 -0400
X-Gm-Features: AaiRm51q9H6u4s3SKPkZXCzH-rGcqRVUBPetQUgIeA9zSftXVjO653tnO39PA5U
Message-ID: <CADVnQy=j4XOEsAS_pJzc5Oqokd6tRdOcp35kcNt4S5a7TrCRhg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: inline tcp_chrono_start()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 99E8423112A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-265318-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, Mar 8, 2026 at 8:35=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcp_chrono_start() is small enough, and used in TCP sendmsg()
> fast path (from tcp_skb_entail()).
>
> Note clang is already inlining it from functions in tcp_output.c.
>
> Inlining it improves performance and reduces bloat :
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/2 grow/shrink: 1/0 up/down: 1/-84 (-83)
> Function                                     old     new   delta
> tcp_skb_entail                               280     281      +1
> __pfx_tcp_chrono_start                        16       -     -16
> tcp_chrono_start                              68       -     -68
> Total: Before=3D25192434, After=3D25192351, chg -0.00%
>
> Note that tcp_chrono_stop() is too big.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

