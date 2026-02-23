Return-Path: <netdev+bounces-260163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEQKCiKjnGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:57:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C559917BE9B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FCDD301CC85
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C21340295;
	Mon, 23 Feb 2026 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDwr/PyU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1D23EAAD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873054; cv=pass; b=JvvnpsuIeBh2beeBVPUIjPD/5NnZr7AtydEUmNLBk3BKpAvaQ1bPVkaCaze6+AYShesPlftjMVPwi4a2qw/0MQc2WSMSlBmnvgQVPB8u/oLydMJU9Sd6uNdZfcPSb/KwQCfFc7oq048F0WH8k/QfnRQo62m5TxYGHvvYpzKDMfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873054; c=relaxed/simple;
	bh=E8L0MukESFDoWu28awe/1kZ9ngPs7TyHYF3wkqN28ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPUkX2Ou12VDWXs6PIlBPw04HWC7em1QtjuwPB9c8IE6g5Y4Kaats+kV711AehDFdW7PmnY5QYZYiV29UiJMif+zWaEnbjkU69yydCKtPEoCgrhCLkgQy18T4+DD5tAtioCDEhe1mKsu51fDxLgnh1EbJjTPFYMDhxLGpXav0+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDwr/PyU; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271257ae53so4339827c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873053; cv=none;
        d=google.com; s=arc-20240605;
        b=cMK3zSM/Sy2W4mQonyPWV85F+jWQxWEoEMTQkZUL2fTrTFMp9cN/R05bewNp+eN366
         vvQMq/cSrgYdI+E+OA6ZZHKTMiERQdkbJDdVMYy9y+nl/c18rUFHSin7VHVYSZPcsXdA
         n9akmY1fgzGCMRgcHyFCPHyp+LxbqthvjShVsBMtPAfpQz4haIoL8naVz7RlXjcw/O5u
         kNc05hDxACNDKWzZpiu6B/+b6/c6/WiYiY9QhyV5eBSGrg1TwHkYzXC2J9kElm3Y+4vo
         3Wyg+X/P+oYK2KESGmvlx0qRTbeWV2++9yqdyLVGhnlZ+gpGJLZxIZKyACsq2OiizTaF
         muKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4EaRvenoBFxq8CO2WN89KyTWIKH09mSiamAMkec/+QY=;
        fh=7mG20o44u66rPzKTZAvoqPEHl6t7EeZzsjDxKaZM2BA=;
        b=NyZK54E+CyaIjaJTylmjp97WHyxzhzSfIVnM6xXN/bWawxUENpgI7K1O/ywGMZ61R8
         nqpcBazxixpdb3h9c8W+UMaonF0i+aZbYi2AAVYnjUwZWuaEqwPnCfOTvBxh6ZrGDp9L
         nym/+462tkKHURDfbwmpU3gMLOy/+13O+IXw2zY5JorZxpjO7RW9dpGR2j3jW9vS0Dad
         cG7WMDcO/af4FqYN6KXGB5FH6f4P4c8lr+c/RoY0MO1bVGAuasBXqC8TC2hvha+CTpY+
         5FMKlPJCtJuxudKi2N1uAJHQ1BcE/3gEBx/4BGVuADdFXDINT6PBB1ukNiau6bXEj8St
         tD9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873053; x=1772477853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EaRvenoBFxq8CO2WN89KyTWIKH09mSiamAMkec/+QY=;
        b=EDwr/PyU8yvQEZPeZD+4zwCoxvDZ9VSE2BgFXNrDXPyYkY/r/wUAXE9dXoRqI5nSYX
         +5zDePa6KeesFyK3hFrNC3ZppCLGEepepjp1mgw38Ls00de2xzBlJ1et5LiDyrMV6we2
         zYHNKFjq3z3wojQdg9JWNHGtv3Q+/Jgnk+8+ciLCsxLMyR6KoRZW2eluUNeiU6Ah6AS4
         KG0VqTCqSUdw7lezDXFoT6RZoh23y1GeE7vH3g+Nt83MUfUynbet9vnYnae4xilJNR9Q
         a0eWt9aLcSa2P8Cs5UNHf9TfsvZ+7qfZw23T7VtTyVxXeZjfxCC1RRKyQJsZnAhxEtke
         A1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873053; x=1772477853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4EaRvenoBFxq8CO2WN89KyTWIKH09mSiamAMkec/+QY=;
        b=Sx7uFuzAJUr0M9h3UCGR601MoUw7CA1PKdgsAdJj23KWV9JnnLxWK31imLCKYnzJoH
         vnAzzo/QkBj+Mvh7XgAVSlEe/myGCe2l/ubykOWh2WTEGvlpKbcCtf3N1DfRT719itgp
         HlH5kbUZ36KWdbekVNRwvYYZkYZxegW85BPmfwxGh2zgonsMXz6jwGnBGDlT6FeFd0LU
         og1JTpEa5y8YCMWFySLE1A0ysuE0nbQX5WM63ZpEbNA3KT+SWS6ObxCHeh2nb9oTW9Tq
         UZPdFd2maXYoJ+1tv6duXGjfUuBdzhSeUPr3Sov917s7AH2d5ozdG7JM+ZlUnD9hTcoi
         Y9gg==
X-Forwarded-Encrypted: i=1; AJvYcCW90Tjw9Nf+T/l3sc0QXsodM9W2iYunT+tAUfxZkfxZmLWqjlgwBeYLvEnq12/zTuoGZtM8958=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxeg36lMNdmD+E0UNiWenqcip0tvaNID+KtQztVWKoJ62+iW71
	GLELn+ROB0KnAMEMp5o5SDbl2RT+ZFtpOQOtcUCxXDzWWuEWcPLP2hpUiyVpVNQyrvK5qO90OEw
	p9ugf+rDsisMEGi5UchjKnv48fKmIl2NfdTfPVCZl
X-Gm-Gg: AZuq6aKNl56u33iNH6G2w53RZbsX/7qHD6qwCTVjGIsURc5D1pKzOpYm7v8PKcHW9xC
	IarH1pRTylTkCmahez+CbUzuk/9f6oCfjillDVdbPeksaoozadUptzQDEhep460KtEItZM5S+r4
	5LqHf6r44Ken6KUbTHqnX/m8BezjBV+Gz+xjIZsk+AHnir7/Idv1WcugWN8r3e47WEpeGJ9Wdny
	Mb5+MCbKnZPvsIbmmze+tI1+g/EbZXcE1Ae9BqqvvsuUCr8jHCEf8haQnqEUHnKbGFcjqFMPpK3
	XTWRpz6grEK67Q+EzynK7SuzqZq6P2H6ss6Z3O9gQP7f8kbE/bio507qeKIbk9uCQYZc99+Z
X-Received: by 2002:a05:7022:6199:b0:11b:9386:a387 with SMTP id
 a92af1059eb24-1276ad47c01mr4412653c88.42.1771873052091; Mon, 23 Feb 2026
 10:57:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223153047.886683-1-edumazet@google.com>
In-Reply-To: <20260223153047.886683-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:57:21 -0800
X-Gm-Features: AaiRm52DD0vqNMyDDUwNe3m0xN_PbIE7sbsJ3glga9bHMll7JVv9J-LZRu44fT8
Message-ID: <CAAVpQUCcTMFNqtNEh1rPTk2_pG8sBc=jM10A1Jk-KVNFsQ-9hw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move inet6_csk_update_pmtu() to tcp_ipv6.c
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260163-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C559917BE9B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 7:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This function is only called from tcp_v6_mtu_reduced() and can be
> (auto)inlined by the compiler.
>
> Note that inet6_csk_route_socket() is no longer (auto)inlined,
> which is a good thing as it is slow path.
>
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
>
> add/remove: 0/2 grow/shrink: 2/0 up/down: 93/-129 (-36)
> Function                                     old     new   delta
> tcp_v6_mtu_reduced                           139     228     +89
> inet6_csk_route_socket                       486     490      +4
> __pfx_inet6_csk_update_pmtu                   16       -     -16
> inet6_csk_update_pmtu                        113       -    -113
> Total: Before=3D25076512, After=3D25076476, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

