Return-Path: <netdev+bounces-259922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMw4Go2vm2mi4gMAu9opvQ
	(envelope-from <netdev+bounces-259922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:38:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F3171588
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885A93007AF3
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE02D541B;
	Mon, 23 Feb 2026 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSScHZl6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B42C026C
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771810693; cv=pass; b=shSrYI/JD510HFj3l7e3ZoI42TNWIKybCnW+F4ab2+i/3cFc7Tb2tcDuL664UdFlW9s4pR/dIlWUVgE29GEHGCFfN98SUXgHHWYnDjfuHjcZa+7D0Yd82oVAxj1yf4JzhI2sWYQrlx3O7nclutlS8dNtIccRqWlx8g4iK5N5/Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771810693; c=relaxed/simple;
	bh=bp7H9nKwxhAflkm+9LXvmfRYR3ZpB8pH/DfQLJel0Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNDxj/76RFBzpu3baKl/W57ue7i9ZAfXpYRq3Nw6beK8aCrH9eyHz9jSCeD8QYLo8YzAbFIaq9nLAtcej8i8EdGc0ZrII6lJ4+WQ+phzNy2UmS8w/1W7Bnl4QYg650hvm2M+DK6yL171Bq2Zcpu0kQnOMRHYWdTBFhAbJ7zZuzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSScHZl6; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732e6a123so829063c88.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:38:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771810690; cv=none;
        d=google.com; s=arc-20240605;
        b=iw1bGozAsHX3dTrk8SnbIQbhId/WyRQVH3tyJaR7/TeGySt3605zIH64bTy4SFdkJU
         SAsCOs0N9/ZYgcw9TpU3ifvIYriaZb+iIxf6mB5qxT/y2ZReHSBNPgQhPC7p1JSv6W61
         Qids3+PI/0s17Z/KXBV63KiE5ltotMV/uXPFPgUtiBe2lQS88G63jLfIYQyKQQJONgNv
         2f5hh+Od1b2+M7HNGBbLWWZHkY4Izpz1/Uqx8G1wHQ59clsclIfIZ2CA0YhBAobSzTZv
         VVuRvDCwdfNlMYk+x8S9MV/RpAKiovKGHTM1rcQKSTaD6uIJNruvhSX1d8icNk4x55JB
         6K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5UnSQ5YtPl3nmLSpWU/CZ43YZ80mhY04Vyv8Ao8Lu/M=;
        fh=fyeCfd6sMmlfl/Sohu+hx5JpkK6IQfmyC7uFlCSLh4E=;
        b=Re15DBgz/ZNAhkh6x+bjRrMHMkk2I/LREUx1wyhCLD1n1wHaSaeLc7K0/Od7pZiuLq
         axKAWmg1Tm5q5HemYP+rscc8yTe1C8O4sTSJP9FpB1dTHgNA8CKY2gUW2S9wqIHdqat7
         vBAIrBgqN1NdRgo0Fe4YEN3mBOeslnpvCorz1oP2tnTl+8BSNljrwdum9XNYt2XmBXtQ
         mAFjRqxeay594c8gIn9RwgqeWKtIXF8difP2l7qgU5vdVj09g0y0krixqlwkZM+BxllW
         Vak+ETo4shRiqVuhCdKCZ7toWFKpnlE1Tb4E/H8atcBdFOI3s3ALmmu4TkKq/miAxG4v
         JL9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771810690; x=1772415490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UnSQ5YtPl3nmLSpWU/CZ43YZ80mhY04Vyv8Ao8Lu/M=;
        b=nSScHZl689o0ViIqpW80LXHPJgGYMv0nNPWG2Absgx+MAOI5w8zfYsrt7Q7HtyUhXv
         +krwvwfb19IFnNfE5/OYcnWAWKdV7I381ns2WG05dhGzIT5ZsAD6JoeUgPzemoLFHgJX
         QZPlxzp8PMnO1G/Ht3Ztl9RwubvFMfEQiXGhFFZdfqg54lWvExH8BRIUPZ/9Ovi+689w
         86n/aDu4qcR+yr5givDOZ/w1WwWg4EczgfPu0J7FxAKd71dLaSQg0X7HSf7eqOW9II9Z
         6r9Dry2ncqQOyY5en1cLX6NTrsbDK6Xtu9y+eN28DM/E3N1cv73iJ2nweq4zLHUihNeW
         WbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771810690; x=1772415490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5UnSQ5YtPl3nmLSpWU/CZ43YZ80mhY04Vyv8Ao8Lu/M=;
        b=ootsGjIeV99gziNsDQ4KgvroeHaOTGw4ya22YeaNfGvNniMG4c+DHP09xHq5FwmqQ+
         wjd1sqyXRg4NAUgXBecbnpTzsGLZZLPMIxYGejz4ILOPWKTw7oQLbvlb+lRbjHUpt3sU
         wYpUyKl+stWJPyoq4vCqVQeW3Pl6No/oLSuaCzaZzUDLi3BRjuHkk9pc1GpP+uOcDKLx
         PR/E7NXNJj8y9fGyrfEgPiFJcUNa9GBs4f3nHI9LT0T0lTm1VTmCc02tqbcZbjagSbMt
         JVHR1ewSuXQRznLygM9mS7lanoPl56h4pgbMgytGHsNII7NWH+yt6VO3FxTZdkUj2tFe
         WkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSjpsnOdbYxFRyCAA4gwxXFIEN6r+K6MEWJ+q276u3jD4LXwIimp9E0kv3Ho9/SACg9x7+WLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOSCf4DnnSgDQNCakHBITTnXFQXFM+iaIO4oc9sg3BK1JeA70
	eszgj4ou3Vd/TdEA1ekrpbBFjUn7ZbyyY45SlxgJvHyqh9v+jE8q4y9rW05gy8vUzmJ5ICQjdM3
	qcChv0COgM7Df3yiJXHkWgDK35Xkj/2JZRe/Fbx+p
X-Gm-Gg: AZuq6aLWZn8iVpnbgLD3q5uze6C0CVeKh9+pkfuXkOTdXsvJvvnA9MBlDKbPX0zfdaq
	6Sa+f0lKJVqMCekYbCsqpKxSFMfy/craL8R/i9ZIgcUbK34pAIqWtS95Mb7tVDr/LJPjxbe3Z0m
	NDInDGa4dAM69eDTQ0NR3LZLjj8jvP3kBYFP60JcbUyGJpG5RPD/cGBkPN5OOPkegR85XrB+7F2
	ONYTgnoE1LGNyYLckIOOYrfOeWlixC4pUI559b3CmFDo7pwWK197cQBM+LFQYtuUteOImCNOi6g
	ooUbDFx2wFwmxCC9raNZfiYqkmzyDKosYlr6mcKn+i8gXoep5sgWGhu8UHt7NpG3wEPPP1jd
X-Received: by 2002:a05:7022:1e05:b0:11b:c4ee:66b with SMTP id
 a92af1059eb24-1276ad7ef12mr3151433c88.37.1771810689462; Sun, 22 Feb 2026
 17:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com> <20260222-fix_zero_wnd_fin-v1-2-5f4034952f3c@gmail.com>
In-Reply-To: <20260222-fix_zero_wnd_fin-v1-2-5f4034952f3c@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 22 Feb 2026 17:37:58 -0800
X-Gm-Features: AaiRm50HO_GSDIAUH_Vpew7xa4MHSNlo62w8RJQJhlg389x64xz_C5iL-OU7G_M
Message-ID: <CAAVpQUBObJz75=_ozmVOnSZ-qsxpXzFKcea4Ntw2GqcdaU_yRA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/net: packetdrill: Verify acceptance of
 FIN packets when RWIN is 0
To: gmbnomis@gmail.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259922-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 137F3171588
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 4:35=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Add a packetdrill test that verifies we accept bare FIN packets when
> the advertised receive window is zero.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  .../net/packetdrill/tcp_rcv_zero_wnd_fin.pkt       | 27 ++++++++++++++++=
++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin=
.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt
> new file mode 100644
> index 0000000000000000000000000000000000000000..e245359a1a91d4b6d7ef64496=
681cea57792cb71
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Some TCP stacks send FINs even though the window is closed. We break
> +// a possible FIN/ACK loop by accepting the FIN.
> +
> +--mss=3D1000
> +
> +`./defaults.sh`
> +
> +// Establish a connection.
> +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) =3D 0
> +   +0 bind(3, ..., ...) =3D 0
> +   +0 listen(3, 1) =3D 0
> +
> +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> +   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
> +   +0 < . 1:1(0) ack 1 win 257
> +
> +   +0 accept(3, ..., ...) =3D 4
> +
> +   +0 < P. 1:60001(60000) ack 1 win 257
> +    * > .  1:1(0) ack 60001 win 0
> +
> +   +0 < F. 60001:60001(0) ack 1 win 257
> +   +0 > . 1:1(0) ack 60002 win 0
>
> --
> 2.53.0
>
>

