Return-Path: <netdev+bounces-258944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bf/TDH5xk2lq5AEAu9opvQ
	(envelope-from <netdev+bounces-258944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 20:35:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843061474ED
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 20:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6531E3019FD1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAD2D8379;
	Mon, 16 Feb 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RL9nbzCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB34236A73
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270523; cv=pass; b=DEHi7ewvCjrp0ZXXR/eg1/QdtGFXeNxopGbgPnyKJuY7YwxBYaP6jC9uUt/frLpsB80zQQ0AZbJfq79qadfgjjjbKEP7QVPd9SEGHWxSIlDVM3W2kAfmJYe3crOe3lalQDFxLPbE3VrVT1bquUMOBJ+IwU1sRpYsVKGAqfJGJ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270523; c=relaxed/simple;
	bh=lO+bK9Mu7MYuKeo9UdHDyn6ieBIT5VFZ66T2AkNb8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMQNNtJtOWhN50oiN3KdDFm/5PvMNlSodMl08NZdIBED0kFKwM7FDQrJ9Whc3hTSX5crh+PIbRIUG/wdCQLOnBZdvA5/1TCkW3oEGuCWe0eoSEyY5HsR74+vX4eyO/89poNoPxSBMCRDvvV5bIwWRmVcbGLHMW3vfjKI4jmr4HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RL9nbzCx; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb38e86cf2so380028085a.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 11:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771270521; cv=none;
        d=google.com; s=arc-20240605;
        b=QSOHHlT4Vlh+JxVSiip1TTMAI7B/66Fi8RNdfzPkBFMtRAJZq1jDm77D6tsDZJHqVi
         9Q8lVwkFRMuMd4wvsrVgEddKW26+DCgRNRS/XaWLY9gF5OfQqUj8xadpcoUXKCopdG6u
         bOQpMBvRGpUJWUjxx1P9Z35z2FrFr2x0Qoj+jriAw7hQouofPVWB4yFW5zX9Vg8F0bD2
         XfrK5AXCEL2iz6r3jSwnVMMcIHph+Rovy4uC0V4qjDJyH/YzL8TdoMKbMgVo+GJIY6MO
         n7XmogUgLEAaZ/pxHOvlabqTabVzeQcyjbU3IDnpc5Egtr2DPjBuWhKfxEfbLgDz3H6g
         0Uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        fh=SDzt7XJv3GcFhDk0naxa3GUWVT/0GhtH/DsHtQvyYUw=;
        b=B0wXxh992TetHhp0AhtkivEAKPCBlSqvCDvMifE9UOkS3xH0zqnSUHQHtHHfTsZfqJ
         U058JFOXh1J/M8+vZMpZqZfXcTksZI7X23yp15c4hS1FWOps0Nf+ANm1Zh/8ur49B3Cb
         qUIs7b+6Bb/eG7yZ22EV4n7eBVHL9fzDOGaBeDpMMS5r0cC4rpu7l91FXJi6r2d7LsRb
         29yoOoS8Jm/oQdgqgHdNilfO0SeR6Hc+cOjWJOevRUU6v0BZW0XdG14YvaEwccn0PkQr
         Y+tM45mzI+WGCZ4K4vANAkE5YjkRNCwZSTP2AzgYxj++gi2uzMuzwpzSyWBZXBgf4UhX
         W+UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771270521; x=1771875321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        b=RL9nbzCxpckOmaXJU34+goDhAB9nggj1tRXpxQQtk1psdXfMp16xwf3m2j8UFjnwNn
         VdmJksaK2fm2ogsN9/6hINwMEbQ7EO1JaAus670ADy+RfdHGppvfgfhdJDs4iJ2marwp
         i4l7sm4hyZi4vfSLlEoms1dAvE/D2YFrXFQrLVqUUpuE+aTCzxZYZY2pxhdeByGNPg9q
         Ksm1y471nwSX42ABq0VScqAb9V6FpvZ3gSwvpORv+/G66ONiXo+7Y3iyxpbJazlZC3yO
         YBIOHyo5Zz5Ap2afiwD998QpUhukNlvmqgWuV6kCmO1et8lF+piv5wtYR52mPQ8zPKMw
         +qJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771270521; x=1771875321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        b=LdoJBNfqV+K/81iPPQqZoUWpPGmv9DEA7ueNmZtlB9C+d4EaKRwUA+O32gbctxX7x2
         O8JfK7nlYoQ6IDyi/xl9y1IYiUSWhH9bDa2MEoepmpMaxtr7v+rsfIuyg0xsNSm/c+3v
         nc8CALr1i+/UWhxUrQepxD8oiJTlQ5c7JFdB5iwF/yl7iJ7cnQzmqSuiYLCWezvGXbvS
         Z/muGRnmXLKH5Yr+ShGoKlaMuqPpangQNff3ZcHKlLGDvbCEcnyysdJSxfGckpSxzD8g
         bnJt3ClOLfAqHNgp4VeyJZLEz/srw5PhE0sPkfIqxmMK7axbKJUiG0b9sLnnpF6D3uFx
         ST2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr4KrrBa8v0WfQzUDmvovfr7LwOmzZzLVsoYuZ1STvFmjmOESmZ/4B7h4mGxKGx4mj2d6O7fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEwG3Qn0sRVsPPBEGJpenB/O8fVKHEd57ftkMF6xZZwEGYS7z
	EVq685ETrW4Au3+qzOCfoDmHYMNhXPTUIXiWNbbh8VJidt26d4CxY/C4Yl5V3lBsSvsKVBkZDYN
	jPtsyz+x0c6cREVQj1Z5DBp7ss704IPSNUiF40mYh
X-Gm-Gg: AZuq6aLpt2AIB0gKCpbIMuwOGpsuIegghN1ySfE+4fsYfvZr2UyA5bu7J0rc5TFdb8c
	Pqsk/Rb/WX05/PrjSQOMJWGF3kCQN9nlNEnZzoI39AZ0IpQlyuUDSKFzecSxe9o0Kj2x4jrbJ3z
	nmlhKvOkj6Zx7CDCsvffo4D79TT+l2KI5gNT5pxXf1BCjZBOJ0qUhsKhzrn/Hl1Cb2W/YzdBjwD
	ajH2Q+K6B2ypbHX06cwafXbZqb9ULMWll3wHADD/eWZxEjNuWKAMJMJTL+67S3PdPIXhkAzOhHZ
	WlVIcg==
X-Received: by 2002:a05:622a:452:b0:4f1:b6bc:5833 with SMTP id
 d75a77b69052e-506a8339f20mr138771171cf.54.1771270520092; Mon, 16 Feb 2026
 11:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216185245.182450-1-fabian@druschke.network>
In-Reply-To: <20260216185245.182450-1-fabian@druschke.network>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 20:35:09 +0100
X-Gm-Features: AaiRm527v4bN50uqJaTKPZnLghfuSIQLXbcR_aKPBlVFvua47bkhjT9D0EIuN2E
Message-ID: <CANn89iKemBSmj=e4Zi5Otitop+kYYBNfGzVDRPk1jv8rJxsbtA@mail.gmail.com>
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
To: Fabian Druschke <fabian@druschke.network>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Fabian Druschke <fdruschke@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258944-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 843061474ED
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 7:53=E2=80=AFPM Fabian Druschke <fabian@druschke.ne=
twork> wrote:
>
> From: Fabian Druschke <fdruschke@outlook.com>
>
> r8169 allocates order-2 pages for RX buffers during rtl_open(). Under hea=
vy
> memory fragmentation this allocation may trigger the global OOM killer,
> causing unrelated user processes to be killed.
>
> Use a GFP mask that avoids OOM killer invocation so the allocation can fa=
il
> gracefully and rtl_open() returns -ENOMEM instead.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabian Druschke <fdruschke@outlook.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 3507c2e28110..3525e889ec1c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3952,7 +3952,8 @@ static struct page *rtl8169_alloc_rx_data(struct rt=
l8169_private *tp,
>         dma_addr_t mapping;
>         struct page *data;
>
> -       data =3D alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BU=
F_SIZE));
> +       gfp_t gfp =3D GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +       data =3D alloc_pages_node(node, gfp, get_order(R8169_RX_BUF_SIZE)=
);
>         if (!data)
>                 return NULL;

Control path prefers to wait a bit so that the NIC can be setup, this
could be used for instance to enable swaping over the network.

Note that this is GFP_KERNEL here, not GFP_KERNEL_ACCOUNT , OOM seems
reasonable here.

