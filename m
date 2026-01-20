Return-Path: <netdev+bounces-251582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMWdOdLbb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:47:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD34AB24
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD6DA82916E
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EA6450906;
	Tue, 20 Jan 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJhVMBgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25844E050
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933412; cv=pass; b=Yzi3Zo6NovQMgjWLa2yQGEieKZEnIAILyT+fJYQ4fFkKBSXU0CPHie9w7lBpHyOF85Arm/vfv2JBnxzIxonSbr/eckbG+3g+Tu1fCnUw3/St0uJAQrj21NPUliKmdz9jU9YwXvqhDcrrZJLNiPGZkb6kvaGc0tZOqamvLVHW3vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933412; c=relaxed/simple;
	bh=CcADnyRFnU++x3R5kiEKGPcdROmeTw+r4IKZa2npiYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlS5HY2nEoJFe/pZ+lBDu23g2ZPB6/4K7/l5tl8zcxVgmFfWWVdv2JSf+nuyxDb2Lu70PNZPVciblxDTRSG7LB9TsFPTwt8wpbceiJ2bPONqYi05Knyj6XdDAP8MFxf39PcUklV2v+NyOvo4OfL4n0+t460pQjXZagOllBKLzQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJhVMBgi; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12331482b8fso10820084c88.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:23:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933409; cv=none;
        d=google.com; s=arc-20240605;
        b=ZnLpBhkMV22HiMDCWkojlkQjm0ynPVVNH8akzhOUdUGUhS/vDBtokG5g/rZsBAeR63
         JyOKhJgSe/uaUfgx4Z7dOvO7nUkbZTqMMPR7XQKa/nyBKFpLPRzeyq2tfnWqAiDrmM1+
         A+C084CSwGqHWaSfJv2AeWJVI7y4oMHk797dAfabE8FRzWaGPHN7xUoGKi6txoin/0Wo
         mKLMXOM0G3mwsOUpenEiTGvOdgb0Foy1dbN88dQTRSd/UYQw2hk2z4PAIUQRdknWID7n
         aAmJRIdL6qIBhTrCZG1sFuDM5ucJkn9FbYKbIZ4iEG2DE1Sel6Aj7lV1rHdu1BPQXy6q
         WZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXpG5taqZ1/mc9PrJC3Sa6aARgC6s5L2EiY9h+EdOO8=;
        fh=8u7KFwbxrKCqvWSWx8Vx3pElV2H0v4uBQMB9NeWqtto=;
        b=EaBfPC7BgN5/oQ0b8HQG0RVv4K1NNbiNcfxcSZY+Jm3BPRBSxerHimEkUsTaivUkfR
         AectsDydDCdHYuwxBz33PIepX0EIQQ7vAcFb+P7QLZNbJYQhBlSIpAJ3guOYhvUuPYSm
         ATyliWSQgkIYP8DjftbLz/qPdvnUcA3rAEnAxdEqdP7jxQAM3HCb7N6U1+DScoG6gOFq
         1RCng3awVaSC/fVY65D65IJc79UpNCeRlpbBvtH6sHOsOuYTyn2uQcKjQKuQ0/Np3gHv
         q3vgB548LV+7APKEB3vfxFCGBcxN1+iwWxrf+51X/8rzN5dZDp05M7UnDJLNW4q5VTFG
         corQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933409; x=1769538209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXpG5taqZ1/mc9PrJC3Sa6aARgC6s5L2EiY9h+EdOO8=;
        b=qJhVMBgiaZX0m1S0xI9b0rW0m7UPYxVT6MBXF81g9BxQCkvzWSip7m36r18PhWDNY4
         iMpMhSlfsPqb3AQCufxRWH8u9HfkEEKv5vFS6/JzjhpCDQ4U8I4n2xv9nZMey1P70XoK
         Dc3SMJxj0R06/Zp36jwqUrP4jIpw509i+2Amh7I5XdjpOOsdMyCmnTVmlAt8zaFKImDC
         IaVQqkycDIqSinTndrJjG4pu8TZUlvpOd66v5SrbkWrQPj0BNTvNqEiQmu6B+xtaN/7b
         Zn4/SlDL7hThUdp+QePw0hIjINqjpIV7OqVXInxyztQzbMqHweWruqcvAFzYPNur4BF/
         dQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933409; x=1769538209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PXpG5taqZ1/mc9PrJC3Sa6aARgC6s5L2EiY9h+EdOO8=;
        b=IiRKBNsg5CcKLHUBPZzFVpwQc6HZDjUnAssOzK8LHSLVvSCXQ5hzLHTHhy0iPAjB9g
         ROBNeM/7b4DkiJqAeG9WogXj+w6QJCqkA1bYpaOclruoG6xn5w1ApFhWaS242tf4PzYi
         F0W+9meyzYD8QqYRCJnnsOv9xDOFUgMFhSHXhF3vVnHn6VH6jkmY5C+IWGhDQ/bBtODf
         GzeiLLWhaQ5lGj/Ck+WbNCPkYFEv5hot5z8tGHt/kGSjBf/MEsW1uv8OjbnfbApkUr1y
         E3gWIPYpbGaJPoJzs2aIT8zC87w6blGbmL1dOzRTu9AqabPx2JwcKJ6gxKz9eO+EeXVf
         F20Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPNw6R/cCF+/9xg3exryxDjd/HKfBv+yLFNoopfUkO3z7uXEc1ZZBr8JSeD6jV8SCkfbkyrJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNh3Ck5ByJgbearWlDsTO9uofRZa0ViL6iq3DuAa2ZvyxSdaw5
	qig1n6dZeKtkdf2kP0Wv/2mOEgc5G7ZaA1Hk5YE++kBqM5sDDGrCs5q6V3ZykYbLG2kbW/4rqvg
	lzMcNmDznaN1NP6WwfC1ZnK5xUoWxDNKlAlRBbeA0
X-Gm-Gg: AY/fxX6mLE37fcQwhbPaKaNwmk+WYuX5sNsr/IVzlp+tDdqtNZKzubfUykhYTvg4tQk
	pMUvdEi9j1ewEQ7K18UlyzbUPnVuJ52diaMQ19PlYzIP+4Jx/HWyxqbDv1WVFsk1jnUasAAnmhi
	HRX/0w8ul/zGX/3xRCq4YjrnHCi3vVWVhsM7aoJ8pF5RW5jt7CplBCWZvYzAkRCOJnjYzriSboC
	4VF/eZPLfljtaznJlQBfwVGwZggggYL5lwm0kBdwtIwUit6P63bUQMBstKoqQj+FqX+8XI=
X-Received: by 2002:a05:7022:6086:b0:119:e56b:957b with SMTP id
 a92af1059eb24-1244a68ea84mr14043246c88.0.1768933408976; Tue, 20 Jan 2026
 10:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115222300.1116386-1-yyd@google.com> <20260119115710.6fdde8c0@kernel.org>
In-Reply-To: <20260119115710.6fdde8c0@kernel.org>
From: Kevin Yang <yyd@google.com>
Date: Tue, 20 Jan 2026 13:23:17 -0500
X-Gm-Features: AZwV_QgKiwhJPPUJjGgnqezL2Fp3SxdL_xrD-rlNa89oXWuU_K0tsb1xT0a3BY0
Message-ID: <CAPREpbaova8T=E1jiyhMZugiw0ooTLD7EE147NKxHAMSbVkA9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: extend ndo_get_tstamp for other
 timestamp types
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,redhat.com,engleder-embedded.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251582-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyd@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BDDD34AB24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just to clarify your suggestion is that drivers should expose their interna=
l
time/cyclecounter (along with necessary locking)? And then have a
core kernel helper performs the common conversion from the timestamp
to REALTIME(or MONOTONIC)?

If that is the case, looking at gve_get_tstamp in this series, there is
little code to de-duplicate: just a lock and timecounter_cyc2time.
Exposing those internals would likely be more complex.

Also some NICs/drivers might already provide skb_hwtstamps() in REALTIME.
Only the driver knows the device clock's details and whether
conversion is needed.
ndo_get_tstamp can help hide these details.

On Mon, Jan 19, 2026 at 2:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Jan 2026 22:22:59 +0000 Kevin Yang wrote:
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> Other than expediency why implementing this in drivers makes sense?
> There will be very little driver specific logic here.
>
> After thinking about it for 1 minute my intuition would be for drivers
> to just expose necessary information, in-kernel consumers should
> "enable" the sync for all netdevs during init, and then convert
> the timestamps into REALTIME / MONOTONIC by calling some helper?
>
> Also AI code review says:
>
> > +             mult =3D mult_frac(GVE_HWTS_REAL_CC_NOMINAL,
> > +                              real_ns - priv->ts_real.last_sync_ns,
> > +                              priv->last_sync_nic_counter - prev_nic);
>
> Can this divide by zero?
Will fix this in v2.
> --
> pw-bot: cr

