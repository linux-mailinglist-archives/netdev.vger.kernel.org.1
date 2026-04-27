Return-Path: <netdev+bounces-281489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCElMS3J72knGAEAu9opvQ
	(envelope-from <netdev+bounces-281489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D83447A1BA
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E783016520
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 20:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4D37106A;
	Mon, 27 Apr 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvXwaBcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF6370D56
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322006; cv=pass; b=d/zeo/rOdWbl/hVn/nzOsHUascLC7EuLYshzsL/bMty6cGMwaMe3kgMEZkDWBX31be1mHDHDrfZsTCq+pUUviCB1oyqIaRK8t2g1lnEwhsw0Tu4jBmPrBO3zW8D7VcQ46D+WNwj10LnBL3+iPC2YuYhEEP/dBsd/TFjB8IlUeog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322006; c=relaxed/simple;
	bh=CobAvn/jQGALxkNFzKl9iXP6Ja55B83/PV3wYG+HxX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh0pVvsewHDu7wyYT6wXe7xnCTItI3gALpHFBC8yxm6BKijiyt1zwctFB8GrHfhEo38Bxncrf5UzRWBfP2PYTW5Us9oabyOGJ5cQoVW9+klBvpISPg1Z2PD2GH/9wIqnNbHf+fUTAwkwluuCVa3JaTKo5CxrnsqjgR6P4ZmmiV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvXwaBcV; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5673804da95so3423244e0c.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777322004; cv=none;
        d=google.com; s=arc-20240605;
        b=PHSeElmsnIZYFcqdLG6Pfkik//VYY4X0IwwzL6AC8sywX6CQyYa7kuklYLayzLv6xb
         QIzFDYQBMKFnrA+vodOpwenW+Juafk4ETBRisSip2KaWU6n0SOaVhIKce67F1A3AotXz
         vrdlisQVt1X3o01tsDFQ8sSXXhGTM3HIxkfm7mx5SxI0IOi15dBm7NPYqb5zO4KK37M8
         UrV9AqpZWrCVWRLZX5KB6ruzECNRttLhFaUBth934v+tMR/Y9fnshRNhnK/NhJ10+SMz
         vkfU37/oJVoKLkhHhZ5xoLHqACFCGehDLziFrfY3OdPU6M0EygaTbyrAmkUCaS5/9XkD
         2BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        fh=qtqsRlrOWpeKlb56AuyeLkeJLKMqQPRrK38puJF23Ko=;
        b=DzTIZIMoFD4ZGg39w5kmQE8h7NyGfiASmA7f8bEal8Qs5yRlJzpv2/enI9xCnQKDza
         kmt+a+o8uBW98ddDpVRayt4J+YBM3XTQpqK+QdMgSoR19P6+tneG0hAFWLixjhQHqPgT
         OcjJ0rP8dtDRgWTAjDTFwlFefWV3jbjGfg5KJUQ64DJzMGHOctbHjFtXMjWE29dXl0G8
         3KbWUmvqDwYtw+zVZBeMfsyj+IHsu4ZHqXsywUWLHmce3Zj7rCtJXLrTHGle04Xz32Rh
         cjvIhNQzBxsuuCR1QP0j6xXC4Mqu8HT/gk+s1bURUCJO/duGmwOWX97B0RGlCFk3jfyO
         1/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777322004; x=1777926804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        b=mvXwaBcVA5ri3TfJ7h76fNKEW+drwO5JQTG6EsZv5VFkAfRwV4slUjCdhIvR2CLfa9
         ZeIvHd7vKHRCBN9FGkMfnybFo7mkpJHJwQWnGi1kjnytp30jUdE9Cm13WiIvYmt6QDQx
         NvBNhxiZQUbqAzGZOeSG4sUuURku9RVJbOwiQwbSCB6RlIzEShfOju6QHqA/o0I8X00x
         whjwmjxQTE7Gmh1JTOrRTh/hOMQO2LY7yBemo42gwpQL8SFRQM05M+pgLUVN2LwdVj6A
         c1KAAvzD7uy66P13HgG2c3vfeMb5wD8dlbfWGCuCUfLdyA8xfmuVTFdEdm+uSVWeCcoT
         YKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777322004; x=1777926804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SstvA5AW/BxiN8uTf52BL5YEBmf06jlLuYINdEdE6c=;
        b=E29PrBFodyQf9NJTyAJOzarxKAR2I7ieAspnU521fujLDMWhHd1vZXnEUjd1KsTAIr
         1JPwfq5DSFGg1h1e7EtEHDbpVDrgcSaJmy5+4A0K6WxbU0lzDFGcpULJWVTz4yQn/um/
         4uc0metMY5/lRL3DSoWoamMeK20818SiE6sc7kGhdwEta4nRmU9KA7L0LhObKHWUUg6Q
         mVclRMz2UFoBOd/GSurMMb2QbftLVJvjxsvmh/xygwP8H63k+F3fg5n5GBsKekUn08rK
         IRkFM2jVERtOMfFwd5hrtNHYrl/TPDMwJFGCiBPgc5f4roL3L/NNdPbymrM+yNIYzGdz
         hHJA==
X-Gm-Message-State: AOJu0YyL70MznGQkq9Pu0/piaWwIDp3U/iC4gpWwE6UXsSbMl6lcNvSV
	wvmJEKLzB+y63gRx3bDgxDYWpTRa0aCsf3lnrP9lC2z0Y+tamNFkA+l0Or01alfAqjAVJOfiRi8
	uo9/J+ZNszi0lPv1o4RmdhvlurL2NHH8UW+oskSxjzL6gEQWgoIigIgRasHH6jQ==
X-Gm-Gg: AeBDievpBiqywhn4/PpbiAeKaQovY4uPDLllY/kTtVvLkpdNBPDzzKjgFhOaLJSmHZb
	WYH95JS0UlSW6iQYPUQXuUK3xooySyDUhIESPJzACHvjwb5W3t6i6EOFwx99qBPUhVx3Fy0EfoL
	Bj3s2P3TGg4gHPFty5Ml2CW3v2Y4lrQD9ZFfR2G5+jgkQZIAIvPqIQ/OFU2WsDHl9Ao8TiFqwVn
	l87DgXqrHarXNX/aY3q9P+IQvEhAzI1d07lU25in5PooDc3jA5mEkKb8ETDCNeN+cpMIFWK/dL4
	mLfvuQf1m+gbJn6npmtnMcn8qAbW9moFtbI49XB2gvu77y9kYagXSD4aeuQ=
X-Received: by 2002:a05:6122:8cb:b0:56b:5e7e:d3fa with SMTP id
 71dfb90a1353d-573a55dc4e6mr142397e0c.7.1777322003187; Mon, 27 Apr 2026
 13:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com> <20260425002450.163421-4-hramamurthy@google.com>
In-Reply-To: <20260425002450.163421-4-hramamurthy@google.com>
From: Pin-yen Lin <treapking@google.com>
Date: Mon, 27 Apr 2026 13:33:10 -0700
X-Gm-Features: AVHnY4IQZITODK5ibGdvChpzY0Tg9aR1g0ToRx_WbNw1myIw4KniYkh88AsedOM
Message-ID: <CAHwYsir6s21mHkR1wvsk1d0q68=oBB461MTncKFK97txH3Au0w@mail.gmail.com>
Subject: Re: [PATCH net v2 3/4] gve: Use default min ring size when device
 option values are 0
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D83447A1BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[treapking@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Fri, Apr 24, 2026 at 5:25=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> From: Pin-yen Lin <treapking@google.com>
>
> On gvnic devices that support reporting minimum ring sizes, the device
> option always includes the min_(rx|tx)_ring_size fields, and the values
> will be 0 if they are not configured to be exposed. This makes the
> driver allow unexpected small ring size configurations from the
> userspace.
>
> Use the default ring size in the driver if the min ring sizes from the
> device option are 0.
>
> This was discovered by drivers/net/ring_reconfig.py selftest.
>
> Cc: stable@vger.kernel.org
> Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the =
device")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf40ed4..2cd0dd6ced94 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
>                 *dev_op_modify_ring =3D (void *)(option + 1);
>
>                 /* device has not provided min ring size */
> -               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE)
> +               if (option_length =3D=3D GVE_DEVICE_OPTION_NO_MIN_RING_SI=
ZE ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) =
=3D=3D 0 ||
> +                   be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) =
=3D=3D 0)

Sashiko says:

Could this cause an out-of-bounds memory read when processing malformed
device option lengths?
Looking at the earlier validation in gve_parse_device_option() for
GVE_DEV_OPT_ID_MODIFY_RING, the length is only verified to be at least
GVE_DEVICE_OPTION_NO_MIN_RING_SIZE (8 bytes), while the full
struct gve_device_option_modify_ring is 12 bytes:
    if (option_length < GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
        req_feat_mask !=3D GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING) {
If the device provides an option_length of 9, 10, or 11, the initial
option_length =3D=3D 8 check will evaluate to false. The code will then
evaluate the next conditions and read min_rx_ring_size and
min_tx_ring_size.
Since these fields are located at offsets 8-11, this reads past the end
of the provided option payload.
Because the descriptor buffer is allocated via a page-aligned dma_pool_allo=
c
of exactly GVE_ADMINQ_BUFFER_SIZE, if the malformed option ends exactly at
the page boundary, could this read cross into adjacent, potentially unmappe=
d
memory and result in a page fault?
Would it be safer to verify that option_length is large enough to contain
the minimum ring size fields before dereferencing them?

GVNIC will never return an option length of 9, 10, or 11, so this
shouldn't be an issue.
>                         priv->default_min_ring_size =3D true;
>                 break;
>         case GVE_DEV_OPT_ID_FLOW_STEERING:
> --
> 2.54.0.545.g6539524ca2-goog
>

Regards,
Pin-yen

