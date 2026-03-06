Return-Path: <netdev+bounces-264727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MjGEJ2rqmnjVAEAu9opvQ
	(envelope-from <netdev+bounces-264727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:25:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7121EA67
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14BF301DAE0
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ADF37BE62;
	Fri,  6 Mar 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuXpLV3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148F35B12B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792668; cv=pass; b=DIMMyny3WkOSjQP7xwqEINMuK1G5DO7igrnglKe/POEDNudMMhdTKfWeLvc1f5iWUNqJDmFs5y6Xu5dQrVoFqOahXvGq799hoUBh9QHgWcz76Yw4ARDsK3GuTVXDF099CR/+xT62S7+086OqVRL+Vvli6z951+dYH+qiYamdQhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792668; c=relaxed/simple;
	bh=0wk6iCr5EaYiZxaoSWctKK9Pe6jDUKrn/INjTL+9B0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMx1L08IbsWoNy1oEv2BwopYBYomCEvmCSG9Gv54ysbNwVl7QDz9JN3Nnb40gzT5SkezZRUc08M8oUIl1vuc+9EYNDc2YUBQooaq9e4Ux2YuaHN5C1NU3TKMb3eX1F0xH/78vrczMPsTQBnYx32zKMoC9XprywlVB2iN5G1qor8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuXpLV3H; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8299c75f730so530438b3a.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 02:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772792667; cv=none;
        d=google.com; s=arc-20240605;
        b=gR+pdu2tdKbbaSH4l8kVS3OKpjhhu44NKHBCpCYnMvxXRG6qYDNWffBOTzcWxMDgs5
         gxz5IB5Q52GX9AK4Y6JoCWftx5erxnJuVO7qTerGhubv4dxdoirnOHVRm4vqyrjClGMf
         E2oLsrb/pW4/yGEzbT2RUbye5dKE+JNV2fNQZ0tVzAcpNb/PUEwVPdmLxtiy4YtB9O3O
         8PxzGGXr7tRKvu1hmG4ZKcM94nxn2X5uXaZdkyTZ6IlbXsQqYZcXFL5RZ7BpM98sUmQy
         nQlvR9HlpZgTmawhYpM7jsC33YRLtQY0JZ4QZKbWmwJL6j+mAGEDxOMFGLgdDPaaxg7/
         /4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXQMvVvwyS8dhOOhz2eq74XepIf3KJp1D30kWK6N2kM=;
        fh=CH2zXG15BbA/2lNFWuuEGZcxhnjZ+hv18fkDrYyO8iQ=;
        b=ZEu4SYPVZxu/3FATPxnsvSpWS/Lq8TEndg7pfAejFgckEkFPJr+wkBay5m6K1dvNqK
         yj5JGtfaDxxqtdeeE9668tD8pRkJUktAa1pVIFM/EaIzKRjXggn279qjuQXACi7ZPpBS
         wIDgxOq5dZ9GYSuAsAqiD1VQX5ast0tlN7KY5ScTu1AX5/r5eROCgdvCgY3iHrVhSn4/
         Kr22YqYGbeVB0LyuMp3LAzjmpSrS+XKCBa+SCdID+RzI5iH92GoFya8+5Mk2XPuxJZob
         4Wze5GHLrV8UzdIz4vDEF97I7mmeIZwOsb9JratimLnnW4xzL19hGVIELYJ7dfcINBr/
         q1Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772792667; x=1773397467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXQMvVvwyS8dhOOhz2eq74XepIf3KJp1D30kWK6N2kM=;
        b=DuXpLV3Hm08uxMT53bKv2C7+4bOZ/CoZdNtPJHkho04cOuz/8doQ5fRS4RvZ9LPKyJ
         4nYHSGqKFaeNia47RnjJJ8dOwMvMqNnxG2wAxwvGeeCL5r+PwAuR2UoPWlGD3Z38zpM8
         QyfOpaqDHOpuna8ydpV2PBJjqYAlqP7e5Sa0wUy3bsirVdtst0CUQ2MKEcMELGg1QXmd
         nvZWThj22Qr11+6eTB912cw0wBsZ1wguki5DD8pGcEY5hz0x96LJ4uT/j0uy0Wz6R20r
         G7vOAchfDiTtYxncBsGxX7EkaA1nT76Sbuxw5aTee1l3jKCGKrAv5gl2/d1rPydqFVbk
         xbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792667; x=1773397467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXQMvVvwyS8dhOOhz2eq74XepIf3KJp1D30kWK6N2kM=;
        b=WmHsfI8FODqyS/F/1Q0N/7GqHZsiKkLQI+tjDU+IUUqVQqNT7CBxT9YSW+/szHqIOG
         67l4OVcGii99AUEN630/W+IKSf2CyVIPdlZ5sF6HFDTCdTpEGFQzJVJ+7fumoAcGZERN
         wD7kc2BeN3sJnwwaoAnMG/qxAujtA1fnQMvW3Up2MjMgpWRfJZOyIOSJfDdBj1NKeURh
         tJ/FwYHoFcdYKwAeTffoA06iuzTALcENuZTDysZhKmKjG7L5cLKNvKxAA1ki1vHLSdjR
         fX/siP4GoVLm6COCXQAGqNPUGzL5YOlypkn9ne/hICfQueEAdKs+maGmy7FMHWSeHcJu
         sS5g==
X-Forwarded-Encrypted: i=1; AJvYcCXx/EmySd6P8VIl8D7MGKPOzdg3t7ua6MrVmP4+mmPhvAvMaddfpJcHPokgd2GGa/z8Qvo76S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzM6PpPDt+Z/OLk4Agd6KL48/rmONJFr+D0AGnng/8Xbbzac8
	Ptz6TsAmr/GLXpsXpHSPdWq1ZtkiKnupQQ3AQE5JEnzBcrYfG5gWzy+QdKWhYZ01jjKIviklG1L
	skz0U2pHebXfrFQYQS9BHxktm2Eq7Zak=
X-Gm-Gg: ATEYQzyWu4PIahdUKl2WHtlU0jVMpKg5aWUC54V75aBw+A8ySWwk9m0z3WHzMGaZkHX
	H3iGbVAME4m4guEEyRCq1wBNEu+4Z8G32PZs3sJMd/0RucdIm46FtzuI5b/QNjL5bkI2BwPjuj3
	rvDYUdsOxg+mNbNdmCtNRX/MMMALQvyKM1GKnL+BtChTn8FQ9xQay4hKPn3gD/1oEfNP7uolS+b
	6E2gFmdvLD+8ngPPdpO6TDir7WayG5MN3hqwJbckDfxmec7DvT62N+hL86tix2NDoYw3lgmBpzU
	XzU1Xn8cL/IgPD+1u01VML2RQIeBLq+CzuYIk6jaGg==
X-Received: by 2002:a05:6a00:1ace:b0:824:3d5b:3cd3 with SMTP id
 d2e1a72fcca58-829a27ef442mr1679390b3a.0.1772792666769; Fri, 06 Mar 2026
 02:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305125235.51286-1-noltari@gmail.com> <20260305072147.102d9d43@kernel.org>
In-Reply-To: <20260305072147.102d9d43@kernel.org>
From: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date: Fri, 6 Mar 2026 11:23:53 +0100
X-Gm-Features: AaiRm52Bu0bd10ocJOrNGYZIDvojMf2JJHCQJzjfMREo1LzbT1rapnheuOy-ENY
Message-ID: <CAKR-sGcPKzSj8a9p4smsRLTuOO9zAm2TdFUrFEGS3UVOoGP4sw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sfp: improve Huawei MA5671a fixup
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	mnhagan88@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B2F7121EA67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264727-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[noltari@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

El jue, 5 mar 2026 a las 16:21, Jakub Kicinski (<kuba@kernel.org>) escribi=
=C3=B3:
>
> On Thu,  5 Mar 2026 13:50:32 +0100 =C3=81lvaro Fern=C3=A1ndez Rojas wrote=
:
> > With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAU=
LT
> > signal, but we also need to apply sfp_fixup_ignore_los() in order to be
> > able to communicate with the module even if the fiber isn't connected f=
or
> > configuration purposes.
> > This is needed for all the MA5671a firmwares, excluding the FS modded
> > firmware.
>
> Also please don't repost things more than once in a 24h period per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
> Andrew could have given you the same feedback on v1 :/

I'm really sorry for the trouble.

