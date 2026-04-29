Return-Path: <netdev+bounces-282411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKsUMPkT8mningEAu9opvQ
	(envelope-from <netdev+bounces-282411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E549598C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2582D30DA3FD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1E298CA5;
	Wed, 29 Apr 2026 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uS1oyU8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D723183B
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472138; cv=pass; b=MOWVuxtFvJkJKE3hvMWfvH9CzaPxt2vi5kUUU1stlKPtnGlqsOzXCnJ37G141PbthwEMKNJyej+b/NBLVhlvYjB1nT/QZD/0FHwplAm5+jTL7AMhRxgcRNrvBi8Q3juixDQ3T3Hl2Kmwi/cfsbUktZJ2w+bo9VlFNGWf4NJ40X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472138; c=relaxed/simple;
	bh=eQdDILVnxt6eljG9QpdbZr5Q4nrCKUJi0Znb05c5K5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zcqu6beHM5yJIyAXilDAGgG00Mlk4dfQCepm5Rp5BJAjUzbmiimMcxFZjlN1guZubrIl8UuRRm4xJId/+g8Dqc99R8YxLfeoHgNlWpCtx/joy1e9zuKL3OlvbxcK/wJrZnX+j3jmZFL2bjM0B7miql8rV642LNx/jyVsfHFxZkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uS1oyU8Z; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d864c23bdso639671cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 07:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472136; cv=none;
        d=google.com; s=arc-20240605;
        b=RErFqvqnRvB3jGtPOgcFuyvU2tscitFF5qPejf+KC70dTf74YUR85oP2Ix4VsimVR3
         oJkj+NRMU7ezBWktparL8L+1LHI4bF82Q+XJ4IxLaR0s//5oqPDcJbewVvLu4VVT1j1o
         W6fR7iwrOlvblpfY6E47YGMOiFzD5OpX27f8zR1Mi4aG7Dn0CZ9OBvn4XsiSGquCOmNN
         udGhQ5l8+pvavXPl9J2kNrV4A8rtZXwAgoNHuSS+gRxlIXkfIM4X2/IDz8D0HPVkJoNy
         IdLUkZpa24z2TtTBW+2ZHPHh5CO+EfHQXcw9bWfp5WV4o6Zzy2FvvwyUZmujL8BkCmZO
         lUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKy79h8/lS7OXaczTXyML5A0FLU9vqWIMGURkyLKDt0=;
        fh=WyCqkZT41/K4apM8zVf9pdS1/JUMnzESQyIMWcOwcKo=;
        b=XrPe8rQHYd/CnE9e1pwoDklga2en8oNmSSZq15EwOdTqyja9tnE57mfLE0uAHC5vXa
         DHLUpBivo8FK0iur79XjGFpreA20N9n9/k1vEV0YZEIkoOcGWBdehLyW06b752DPbEeA
         4SYlBZQTU3sXnI/HAA1fNtpAGWB6Ci1PwMuVT+OnAuGQvkQEEUIQ6x/T3X5FJOCe+3Hc
         wq9X+k4mCREENTdvCp5aRAs2oKKRmxdZJ3g46GUm8Y0YYWd1r/YVyxC/25wSp3U63/Go
         SK8s31j3+Btlgali2PF31MIdYnkdc/uXNi3dNQw7iywZw3psuaixq9HUoTKceilWWBA2
         oX4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777472136; x=1778076936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKy79h8/lS7OXaczTXyML5A0FLU9vqWIMGURkyLKDt0=;
        b=uS1oyU8ZxNXL3o+k4O3sU9MG3j137QYj9IxmPy/KYStvZ8Y4nDTG8QyhuWZmkfWTPb
         W0wpE9RrRR7VfcGWQFp4R0sFkuRwHN3Hu5NyAh1s8dQlUuo+108WfFcQ3fsgeAH7gvFh
         P8zlouiGN/DSexiBBEg7tYHE4o5yXWv0pehbjdSqzxZDOWjb7AVQxBcMDRpTqeeimChd
         PMDkt4RDnK5Ld5IG1XgKcECAf+iQeusTA3WB36Eus6XiujW56XCjPhB9gYJ3IxeOTgBp
         7ANZ2TSirMOEBZoLu+aSexz9B/FSbSfSergEYDHV32jIERQ3yO8q5wlkxoLxcx7jzzWT
         eG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472136; x=1778076936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKy79h8/lS7OXaczTXyML5A0FLU9vqWIMGURkyLKDt0=;
        b=l9xilfMs1SkQcFf092Ew9vGMQefhxqKPJV9UJirpNIHdLGmFvJjfscAtj9S7N5zc/o
         RtBZmhiWtMtSCsqQDK8r4xNwy1PDnvnYoxRKZXesI2mNwtzSkNM+98X5sPdxYgM7Wcdf
         y2m9huRaak7vkuEi7cIK1MggkD7Js5Y7f2J4DNOAPO11iUZhA5WnAsk7MtFhf/Eyu7/w
         7HEmyph/ffx2yYuTww6uaeB1gKvSqUJH1JbGZD1xW95EQ0/eNPNAKWu9N6p9wTsG3PMD
         nYQnAEv6bjSTEzNygf7xFrgzAz6A3sFQYfBQovb/mZF7lq7Gee03XE3guU3AULwe+6RU
         CEYA==
X-Forwarded-Encrypted: i=1; AFNElJ86tGSLtFZIUqtNxNmz4Ecejm/T4/iqTeKNKRBbQaEwQ0VR9HWS5VXoiekjL1zpSOv9n+uzTFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsaNsi3D7TBZvFq6kPTw9n19Pgpo35eyrc3nF25xgJnzDMkOo
	o3M+UM1W049CPggIBktFUWjKxkaV133PE8xLzg9HkUk7amXW1Aw6hSLOVq3LqA6IeB4dmHwbOXd
	oERwS/xZ+dZJ2NDNe/cdlX2CHU3CPoZeI6dOwoeob
X-Gm-Gg: AeBDietjafil8kiZVcq4rU610eX+9OpxqVPm/rAT9nnaipHQaXEtKEqkCbP5CMZvUek
	7NVrRGK7OLetBTVt+IIi7TvmELKaRxsV6ytdLqV4cm0VCi5w30L+hzW5HL9Bh1wl/dXki0Rq4zb
	bNnlEkwj1RfY7sgNb5ITC0l1fhyuHlk3lqvHaPYRlIKeA4ggzwcQRCCkNR5m421mIxwx8D/0UAz
	krYfdxpN+PQm0CcR9oD/ktTWitCrwwQMYf9AdbhTzeyslyVq31nPuX8wLzEqBQIJgK//zyXSry+
	icp+9bHBuCxfzCg4OEl4sy3AYIc0SKk+Cc9T5I1G4+FmfiGDatWxtAjp8oOMbgUrhPKBbitIJbT
	bFTaIAR1s3YXAPqMGzA==
X-Received: by 2002:a05:622a:aa52:10b0:50e:38f8:9885 with SMTP id
 d75a77b69052e-51019494941mr2466591cf.12.1777472134981; Wed, 29 Apr 2026
 07:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com>
In-Reply-To: <20260429080036.1528533-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Apr 2026 10:15:18 -0400
X-Gm-Features: AVHnY4KzWYpM5tQNmk9z9HmZeQaYnBJzZ6eRvxpk0w4-lJTJh7vUnSxxzia_Yrg
Message-ID: <CADVnQynDD_6B894PqVuSqqz24hmYhyQKov7zDvnYJoKZU0TXZw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F2E549598C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282411-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This test checks syncookie mode is able to reconstruct some
> client options when TCP TS are used:
>
> - wscale option.
> - sackOK.
> - MSS (in a limited way).
> - ECN (not tested, because of limited value).
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../net/packetdrill/tcp_syncookies_ip6_9k.pkt | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_syncookie=
s_ip6_9k.pkt
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9=
k.pkt b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
> new file mode 100644
> index 0000000000000000000000000000000000000000..15d03992a99140ecc4241edae=
58693dc5098fece
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_syncookies_ip6_9k.pkt
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Check syncookies.
> +//
> +// Check we are able to rebuild client sack, wscale and mss options.
> +// IPv6 msstab[4] =3D { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }
> +
> +--ip_version=3Dipv6
> +
> +`./defaults.sh
> +sysctl -q net.ipv4.tcp_syncookies=3D2
> +ip link set dev tun0 mtu 9000
> +`
> +
> +    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> +   +0 bind(3, ..., ...) =3D 0
> +   +0 listen(3, 10) =3D 0
> +
> +   +0 < S 0:0(0) win 32792 <mss 8940,sackOK,TS val 100 ecr 0,nop,wscale =
10>
> +   +0 > S. 0:0(0) ack 1 <mss 8940,sackOK,TS val 4000 ecr 100,nop,wscale =
8>
> + +.01 < . 1:1(0) ack 1 win 1024 <nop,nop,TS val 110 ecr 4000>
> +
> +   +0 accept(3, ..., ...) =3D 4
> +
> +// Check we properly infer from the final packet the other peer wanted 8=
940 mss, wscale 10 and sackOK
> +   +0 %{ assert tcpi_snd_mss =3D=3D 8928, tcpi_snd_mss }%
> +   +0 %{ assert tcpi_snd_wscale =3D 10, tcpi_snd_wscale }%
> +   +0 %{ assert (tcpi_options & TCPI_OPT_WSCALE) !=3D 0, tcpi_options }%

The comment mentions checking sackOK but the script does not seem to
do that? Probably want to check the TCPI_OPT_SACK bit as well? Maybe
TCPI_OPT_TIMESTAMPS as well, for completeness?

Thanks for the test!

neal

