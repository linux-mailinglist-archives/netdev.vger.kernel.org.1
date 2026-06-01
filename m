Return-Path: <netdev+bounces-293605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J4mF+I9HWq8XgkAu9opvQ
	(envelope-from <netdev+bounces-293605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E767161B427
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DD403006815
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B73890E4;
	Mon,  1 Jun 2026 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmI3DtlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076638655E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301279; cv=pass; b=RzinRbV4oAwYCk0XK2MuwOZAWr6hyJlyGYX9o9IDo9ucxVVF6ypqV5agqGlCf8UYVo6tlkOOQhgdK1L2hT2mxbySLWboPM2Xvoi9b/vyPKShAVSO39UpI0Lxrbo+KOtwIMhx9EnGOhJWpYKwmJnPAOSHYRTFD5QlsoQrGVS8LbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301279; c=relaxed/simple;
	bh=N7lwhPibxuWVuj3AtNLXVqehrE4SECuyhOAiObEImMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at6BZsIuRW44C6lnUdaDZDlAjliAIL9YvFSYQNzFns9bONydMCgXf9Co+anFYON97V6Z1gxb3LrEPGBC43jMpU3sY5QyyEUuUTvDm0mq2iwbWVghpe0NUDJh+xyxruWRajuClzGcfYofvghNqkvCiY30gfLlpq4f5/WeIHWTQ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmI3DtlO; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5174a133bc3so14187371cf.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780301277; cv=none;
        d=google.com; s=arc-20240605;
        b=Dwtib424XWEE8WzjHTG8ZJnwRqXgnHWAfan/7SRVuYTO+0AwlhQ5uW8XG/YOEM0iNm
         xiUjCmq7AljUsfpqpmjDKu5jup0ZPEAUIqPeKyj0hXT7r5IEQgLyuMXiSkj+o5+hSirK
         FFvFMPYOlXfwkvY14QdKXi+yx7Jz+nVdSeev28HeVo4KLCPz1U+5MK/SKkgdmd7Tc5O0
         iQ23M2c+DJhLigjhmpCANIa7fLUd8MAsOFI4NEdaUVS8Aonvgmm9O1hjshe5wPcKUvWI
         X+m7P25vd1j39GxlIl8UzjJV692/8JynFYvqfqiRP6dYlf93o7yGcUtnYPquqlYzEDMk
         FZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zo3rEI4Lq3oEKN+pEd3L3cA/VgI4r+LRVjyWTWXdmkA=;
        fh=7xSXOSnqeV7L9MShPDa5v1pGPLkc5hd+nahFgTIck+o=;
        b=Yyc2TarSo4XFSeWxpb/GsezlpVNiKozRedvQG6kf5cCJU3VsqcfKj6bX72WyPWY3OB
         0aiAzzkSy5h2iYDgb/WZkcEAduBND8pa2HNV+690LzrZFOefvAlAGgIgCsFhS5AVTJ2U
         Tv+4Vmv/m/AkZV1zTDjpxrux7txKhN8Ssifhho6P8imFI5Q7zgX6SGpyZ2vtc4ie9Oo+
         R23BxPBMoOvjJg3t+NcgSOGcwHTal2sZQRttbjws42VM7rev/39jQbw13KjlTo3hLfMU
         +J0Mg8DNrkhsj2s9qlJ9FUclKBBCwvfJAQ6bfHI09OlFQasRSFKBhI1Mi0gVzuWRrNu1
         I9+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780301277; x=1780906077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo3rEI4Lq3oEKN+pEd3L3cA/VgI4r+LRVjyWTWXdmkA=;
        b=WmI3DtlOHVUFIu4NNMM/hChbtxkU6vkmYS7Q7+qyXsOp0xM3bQm4887xHXCn8cJqB/
         47ft3U808hB8y9NJ71zxpyVCQ+q/1gnzX1oMTEnMKCZjbq6vQ8KnVR4TSvqBHHKKTSTg
         xas+pXQuD/SmQpmWvYrCQtQ75rv2QErvXuuZNR7jRisNlB7T8b+Lh9uOCNRjXZ2aYLiy
         iOvWkYmSYinpgwGFBtFrSLnrVkiY5KWexYLYSkL7ZQpWZ6AHriQAR9Xcyf3Clr8RMFTp
         GrL/sDI4/uDTvR3A7sthfxKi1mgfzv3wyIZI0b0F11nOBUzoT1XfR8ruAgT5sIZKv5Xo
         dOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301277; x=1780906077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zo3rEI4Lq3oEKN+pEd3L3cA/VgI4r+LRVjyWTWXdmkA=;
        b=RlOdVFhQkHke1N8/o7aOhbUpEwc1f5D4yVfuhixVOqL990rpdWrupLn4NgtabnVa0M
         IwSYu4ZkfzRREAMIoW/kagPMnfeHisxVubDw2cMjIPv1dDoYhqwM0NwEHt8Yj4FUBHqA
         fAuNK51G1iBfNft1AhNM5Z9hp99VG2N/WgLuzuQnmdmU7ClP2zp1P8OLAOkLvR/74VtY
         8Z62TLEEum8jY6oT6/Gk1jcdDQD8/2/5CaXbSLjpPFqwHC+4DhtgG1QzvoEoaLKF088c
         GAOzbvg+xFHa1OFxin6wVyu8tcMoEbvCjGmcyK6XO4YeC+HcI5GkkyoDYtoyBENCaYO6
         kSzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/paif6HVcZvrJ4XLcs/OE6lj/UBS7LwyDcaj/IXSIfgXjWK4D8mVStwD/fZLNPkwM8hiBE10Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfJwrWelmXJs/DmKWSLKeMzuqnCmQiq8XnaMR2SY2gTXolOoS
	Nvjp6ZWCsYRZNiIHct5Y5kLIUn2lQojAgb2ZI/L7Bjmjq+xOXDGy7eLRdB7e6HXIboUtHylL4pf
	OIcKTOvVNY3iyJeBFdl+rLE4rYJwayn42uVruwMfyBnL8ERsPbrCqFwlK
X-Gm-Gg: Acq92OEGT5MreDsa8/TZ4l6jHabs+jEKDupPPmRmyFsyISizUBfw6KFQz9/9ENvzytY
	v9ZBIx7IR4y5T7wZHATlnZ2xueFEXl5Vq6kg6XjfVF3lhOmF39Rij6zLt3h+9/mMDyOucVBIP0j
	4UR4ssn0hdGspeY5WaCFfiK45vSOL6D6NABjodGTc9HrKIqgaxLrOWgP3eZ6vX7D4T+AiH47BYa
	HXkQDv86scMXMktUCWTOFjxP0AM7yMvvBM3JTrPkMMO+hvu2WHbUpkxTCmM7c6yPwLKKnX4Jzgt
	LxeuDS0qu2kpp9YmmerW036u3SgvNEP8vx7aQHbvNtOgyK1SoKeoNa3cOTIFNLwDXuuITXwx7+r
	fMWYxfIV2O7wdzGK9wMFyHsetWQfY
X-Received: by 2002:ac8:578d:0:b0:516:e665:93e4 with SMTP id
 d75a77b69052e-5173a766194mr148219181cf.25.1780301276873; Mon, 01 Jun 2026
 01:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601073937.1137673-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260601073937.1137673-1-runyu.xiao@seu.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 01:07:46 -0700
X-Gm-Features: AVHnY4LxE2QpcnHf_GvluaVxBWTr238a888IDgaQHsxOQ7H05fIq0KBJo9dihrY
Message-ID: <CANn89iKVkrsM4HU+_=VF6xfnimv7YW9uhaBrqn8o6Pei4-HUKw@mail.gmail.com>
Subject: Re: [PATCH net] raw: annotate data-races in raw_v4_match()
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293605-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E767161B427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 12:39=E2=80=AFAM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> raw_v4_match() is a lockless match helper under sk_for_each_rcu()
> and still reads inet->inet_num, inet->inet_rcv_saddr and
> sk->sk_bound_dev_if with plain loads.
>

Are you sure these fields are updated with appropriate WRITE_ONCE()?

If so, please mention this in the changelog.

> Add READ_ONCE() annotations for these fields.
>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/ipv4/raw.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 5aaf9c62c8e1..faa49f3d239a 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -120,11 +120,14 @@ bool raw_v4_match(struct net *net, const struct soc=
k *sk, unsigned short num,
>                   __be32 raddr, __be32 laddr, int dif, int sdif)
>  {
>         const struct inet_sock *inet =3D inet_sk(sk);
> +       unsigned short match_num =3D READ_ONCE(inet->inet_num);
> +       __be32 match_rcv_saddr =3D READ_ONCE(inet->inet_rcv_saddr);
> +       int match_bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
>
> -       if (net_eq(sock_net(sk), net) && inet->inet_num =3D=3D num  &&
> +       if (net_eq(sock_net(sk), net) && match_num =3D=3D num &&
>             !(inet->inet_daddr && inet->inet_daddr !=3D raddr)    &&
> -           !(inet->inet_rcv_saddr && inet->inet_rcv_saddr !=3D laddr) &&
> -           raw_sk_bound_dev_eq(net, sk->sk_bound_dev_if, dif, sdif))
> +           !(match_rcv_saddr && match_rcv_saddr !=3D laddr) &&
> +           raw_sk_bound_dev_eq(net, match_bound_dev_if, dif, sdif))
>                 return true;
>         return false;
>  }
> --
> 2.34.1

