Return-Path: <netdev+bounces-288630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNXUKHBnCGq4nAMAu9opvQ
	(envelope-from <netdev+bounces-288630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 14:47:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6055BD66
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 14:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C23730117AD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AFC3D410B;
	Sat, 16 May 2026 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMZu5L9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC230F7F2
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935662; cv=pass; b=kItvsK1mOmu5uTaQjS3EaaC7QU/de8vDWMWAyMWQH23TGuec9o5qmiAhs+0zDx8K2BqTaFiEKsa0W5jMOXSEC7HtZ4gE37pB0I/EfvjSHTQwwDqWBvQbCzvZ3Jsln/BmrEM4ylzHTAS45Nhs62YWuR5kw3JpEK7Yg+npCyxZVJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935662; c=relaxed/simple;
	bh=vMPlvorn1HtxYqLUuznrUwLlm0842t+E5HBaDvN+XH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEI1e/0xraoBzo987ykOARJRmAoLRu4ek4FgkzQ3E9l0p04mQmOaSYZydv5+TZylEBHWCBbtrsfhbUSSLUlnJIq3Gd8doN06BhXpOTYd+FoQ/FGcm4DwPccGHGeVy6dS0J/OIrFsCDsuNRFJwX0/7s5WJ4ZENrqc86s/5u9fB+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMZu5L9E; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-682714e8f9eso2219053a12.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 05:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778935659; cv=none;
        d=google.com; s=arc-20240605;
        b=c/DORt9qve+XruJa3c6lDTKigQ6C1o52TV2xoYtOg2ylf00AsIp8DXwLrVLjAPk4ln
         bai97OKBXii5eLrAn1gyxGbX6QLWfJWHOBTqpDIP54Y/gcecbKHsq2EheDKJ8Yn8lp2N
         ZA0rTM+Hn/kkksuSTfbpZrao3jnH0kdlzbU/OnHHqFe/MDlJJhzeYLgmn6djISPVM5B1
         ZOYwupqoMVtd2gFWROAX8wwluK7/J7kqA4Rs5B9n7RXWPXkRWKGF60opXimklFbx798c
         Zbt7kCpaZ5fKnRLLjwyxwWeJ1u7ScTVy8Dr26VEgFf5Wq5UZ4fswQtXfQWE6JZs06+/E
         +/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHP+gdj6ew124yA2Uuan9/e4XYPvNxYsrO3nP5ipKs8=;
        fh=bVO5jSvQM6G0sU9zbdZrzzCfbDPC+lgx9DXX43cw3IY=;
        b=gsVaWCiaRPAX9pY8Obskn8bXzZkaF6R1+sDXQW3JokIi/iROEvbOp4cMdtjAioVedA
         k3Kdttgqmaxoo9lGhLdTurYM+8nrYlIsoAMQdJt/T6jPq0Y4Xal+cmDvaIQ/DTIW3XFF
         PpRBc2WcC8CD5A0Lz0L1ZtKbRAPd/NhEAotTfPpV3+fBH/nz47+wsIjFfFdkDa0WpMWw
         8yBhjPsNwgzITB0SKuL/Z3OKd8OphPDMPswhgCBYVLl7al6nQDwwWh1/cDVY5azQGTZE
         5k8MnCUJd+mg+kTgE1UwvMF1xpRFtgPG6P0OMytx5L5GJY+9z1W84EDtL7SQfm1/0rVl
         A0Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935659; x=1779540459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHP+gdj6ew124yA2Uuan9/e4XYPvNxYsrO3nP5ipKs8=;
        b=KMZu5L9EKuFIRIOLV24dHChrjKMA3Hx5JuNjFbK9uiSO65BhyvWr7l5rghS5JtBSUG
         OIj/Yp2nS4IGPo0CApAuNc2o8WD613eSwP70iaksdjOUaXCQxLSQRFPlpd0IYUfS5S1N
         +NLDSEyRHJEbjOUbRiHvZb5UlTBbutWcQ3it9yWmXKkP5LdBqfE5dQHtphqARl6uoB8m
         nF+vxNUIbGgSB061lAtRiF5RH3jBhQgH4KUHCmNftLRmjAD/yS/cxe+VqTK7CIS4UX+y
         Rr03KZWtUSNaiPiLoVi/leqxzlnj/6Tb3Um44v2U+A5Sg0AcwKn49qu2vBHdZBg6ad05
         Zd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935659; x=1779540459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHP+gdj6ew124yA2Uuan9/e4XYPvNxYsrO3nP5ipKs8=;
        b=cta31M5gn0B4A+bF+OFLqef6sRQBV0w3EQmePR5HfbzsWZqfCsOC0Cye8XKDw0Bx0X
         wJKK+XaLGK1m3LTooVz4+/X4X1wSGrv2U+UhJplvlXpNJD9o2ToQjZVcoCqWmjsUK1a9
         rPSRjf5KJFa0wFR0faA76ZcFXF0QnZAxwdn3PY/Tfx3GJopDpGqrasTM/pZCZHFd9poC
         qquCgw7PMOzC4+7pwpEd3CDM7iXLaCvgYpyitxM0KlWV//A0pJVb2wFAsYaBInWZL7Ur
         wNeT+yeXbA67wRHraBxjNZbdu4gYo5GAGb8w0COvHcLAqDPNYFBjNfFaBpiJAosD6LjM
         Q3pg==
X-Forwarded-Encrypted: i=1; AFNElJ840ZddSy4NzdQ9B/v2cyM05QSjSyD3COARJ7uP08DjhChEcZS0xPB5/8W8Ri2HgJRp+VLCRXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYRHYzdR65rDdJf1aHUoQ4rP61bkmcP+BuBs21KzTLZc8rgkR
	puozmmlLZv5eC5zsFiUyiXe+q2QG9u0EinP+nCLp22o+PUfXyGbtBz5Y8wNgvXBQfqGJUgxO+Qu
	ziaMCvhfmwabSlRrFZ6CNU382Bgok5qc=
X-Gm-Gg: Acq92OGh+NdmLkUlRStv/f0fevCys+FHZFfcqzbuYnfgjJz/Ucc/8StYnavswV2Wr6B
	a+0wDWKeB/4NAt9E7V2rh12kc/FryggVX2by9ZMDfoX/dZ1tSD1Ps5djcvcd7DRzNUQv5nhqaJj
	5+M2cEzdqajNfHOGThcDI6wFL6MAnC/1dGW8zRVosIG0rVjVOuIoarWJ4qYArcYsF6LYgGZ9LQZ
	+97VRzBsBkY8668o2hevdfYeOsyDWxLmyrQLUiXf8+A6XvWspcCY+M1pvoRADM3PI8HQMW9cAJv
	QshQCVCWkGeFFemv7U0uECRLYBR9Lvx6UdiC0X6d
X-Received: by 2002:a05:6402:2807:b0:67e:9cd6:c68f with SMTP id
 4fb4d7f45d1cf-683b41cbf3dmr3641121a12.7.1778935659119; Sat, 16 May 2026
 05:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-7-8b6d6a1eefdc@gmail.com> <03d0fc52-108a-44de-b22a-6bf4a2d9da90@yahoo.com>
In-Reply-To: <03d0fc52-108a-44de-b22a-6bf4a2d9da90@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 May 2026 09:47:27 -0300
X-Gm-Features: AVHnY4JsF6aJuu2j4fntj32Ri4y2LXF9j7Adh31t8SH9YRoi40BNyPDb3mvjd7Q
Message-ID: <CAJq09z4nEe7sLeSqOYjq=B=mMjja-W9=99+O6wHwQ6an91wNJw@mail.gmail.com>
Subject: Re: [net-next PATCH v4 7/8] net: dsa: realtek: rtl8365mb: add FDB support
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 21F6055BD66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288630-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> > +
> > +struct rtl8365mb_l2_mc_key {
> > +     u8 mac_addr[ETH_ALEN];
> > +     union {
> > +             u16 vid; /* IVL */
> > +             u16 fid; /* SVL */
> > +     };
> > +     bool ivl;
> > +};
> > +
> > +struct rtl8365mb_l2_mc {
> > +     struct rtl8365mb_l2_mc_key key;
> > +     u16 member;
> > +     u8 priority;
> > +     u8 igmpidx;
> > +
> > +     bool is_static;
> > +     bool fwd_pri;
> > +     bool igmp_asic;
> > +};
> > +
> > +static void rtl8365mb_l2_data_to_uc(const u16 *data, struct rtl8365mb_=
l2_uc *uc)
> > +{
> > +     u32 val;
> > +
> > +     uc->key.mac_addr[5] =3D FIELD_GET(RTL8365MB_L2_UC_D0_MAC5_MSK, da=
ta[0]);
> > +     uc->key.mac_addr[4] =3D FIELD_GET(RTL8365MB_L2_UC_D0_MAC4_MSK, da=
ta[0]);
> > +     uc->key.mac_addr[3] =3D FIELD_GET(RTL8365MB_L2_UC_D1_MAC3_MSK, da=
ta[1]);
> > +     uc->key.mac_addr[2] =3D FIELD_GET(RTL8365MB_L2_UC_D1_MAC2_MSK, da=
ta[1]);
> > +     uc->key.mac_addr[1] =3D FIELD_GET(RTL8365MB_L2_UC_D2_MAC1_MSK, da=
ta[2]);
> > +     uc->key.mac_addr[0] =3D FIELD_GET(RTL8365MB_L2_UC_D2_MAC0_MSK, da=
ta[2]);
> > +     uc->key.efid =3D FIELD_GET(RTL8365MB_L2_UC_D4_EFID_MSK, data[4]);
> > +     uc->key.vid =3D FIELD_GET(RTL8365MB_L2_UC_D3_VID_MSK, data[3]);
> > +     uc->key.ivl =3D FIELD_GET(RTL8365MB_L2_UC_D3_IVL_MSK, data[3]);
> > +     uc->key.fid =3D FIELD_GET(RTL8365MB_L2_UC_D4_FID_MSK, data[4]);
> > +     uc->age =3D FIELD_GET(RTL8365MB_L2_UC_D4_AGE_MSK, data[4]);
> > +     uc->auth =3D FIELD_GET(RTL8365MB_L2_UC_D4_AUTH_MSK, data[4]);
> > +
>
> The problem with overwriting uc->key.fid and uc->key.vid values in the un=
ion still exists.

Hello Mieczys=C5=82aw,

Thanks for the review. Please note that rtl8365mb_l2_data_to_uc
operates on the unicast structure (struct rtl8365mb_l2_uc), rather
than the multicast structure (struct rtl8365mb_l2_mc) quoted in your
comment.

For reference, here is the definition of rtl8365mb_l2_uc and its key:

+struct rtl8365mb_l2_uc_key {
+       u8 mac_addr[ETH_ALEN];
+       u16 vid;
+       u16 fid;
+       bool ivl;
+       u16 efid;
+};
+
+struct rtl8365mb_l2_uc {
+       struct rtl8365mb_l2_uc_key key;
+       u8 port;
+       u8 age;
+       u8 priority;
+
+       bool sa_block;
+       bool da_block;
+       bool auth;
+       bool is_static;
+       bool sa_pri;
+       bool fwd_pri;
+};

As you can see, there is no union in the unicast key. The hardware
table entry has independent fields for efid, fid, and vid (though in
practice, vendor examples always show one of fid or vid set to 0).

The multicast entry (struct rtl8365mb_l2_mc) is the only one that uses
a union for the dual-purpose field, which is interpreted as either fid
or vid depending on the ivl value.

Regards,

Luiz

