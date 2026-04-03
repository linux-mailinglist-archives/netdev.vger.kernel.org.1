Return-Path: <netdev+bounces-274813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGcUBEIRz2lysgYAu9opvQ
	(envelope-from <netdev+bounces-274813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169338FC86
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABDF3015C80
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A225A2A4;
	Fri,  3 Apr 2026 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrQ5SGe2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8B257824
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177863; cv=pass; b=t4dDkuBctYF7pQ/+f7IuIta4WdGEmpOJWL8A6vg/pj7AZ3ZxFJISt8nllRUg7GQNlsCN/e3qjqrmUlbuuqvlPbVxmL5RJ26S29KxhjSwTr4CJ7xr7ZNoGNDMg/IERcLse7RYz1h7nm6S8j/9E0FsO9z825wb8v64ZQQAWsXmJ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177863; c=relaxed/simple;
	bh=qYt+t65x90ErSnYRZu/5EfemICzEhTAvx6B/DjOpUfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZCzoyrMiS1Qb9hR4lTEY3HVH8KTZCScIWyAHjoYtuVQtKMqReKOBwjXkDG5S01jZVP9tVPCUhFnyD4IHOYOacjrKcI9sZSCoiYWSH9NximXarS5gE0MwPVp+h27JMMQCo3kEaHQn8fbCx570oIOssFh5mfkoc0Jz2zA7Xc1j94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrQ5SGe2; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7e9b97a73so1615414a34.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775177862; cv=none;
        d=google.com; s=arc-20240605;
        b=AmOmItrb/EiYKoTX2qhTOjGwjfLNhp/FyUN+gLLwUPhAecbSZppFOw81bO9lMWjXGx
         9mKAJL6gcFTAMO5hhBluchohWtI0rBeQ2+rHvfnSKw7zRMfzCMbokKlq50FxzM7MyS5A
         Z6dpHL7jOmUaBiz0XovkqLD6CeyXjUZVBiQMzuU+u802jAzLJWTAe1Kd9XvmmYZq+iXi
         VxiQGuZGfGlNbODyqZPlv0opkDce68KwaorfqrC1jLWe4PULuqZu/k7/26qGrxsTQ2pG
         34iTGPtYas1xS0ubl0wIzc4lbHR+ANVrVXoCj8cWzBuXKT4EK+BCrHnWdbZ0WlL9vyrQ
         xz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHPWw/Iod0y2N0sY5X7DxlpwShrqQZSMrc0StjMv9Kc=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=NXiiLxmBH7ZoArVXZcNhJA3uUaiqySPLwdcR0QX/WHU2mIk2uBc8rmiMJPKp8+oQY1
         p4QGhqcX8HdVHJCJikFNkK96FwA+17jVWp1H8IwWGcOIznLAZszxOVC5igUVNehoKMC1
         48WqqymD4pY4eWSiudJxPgiQfg6xBuyCtTnTDidnJSSNtUoCD+OCh6YHXtHnByNam+q4
         KDmLM+YG7jKVXpha4ykyah9Mb+lcmCr1Zx1MvCw/tqlCi6dKys8lnImfuTWCVaqQW5KU
         /vZw7yBgs/aNfh1wa3zQ4uJfaLmA+u+b8kTGA8mljl/JZzSg6tlpzOnAZHJwfFkRgeIX
         pQHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775177862; x=1775782662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHPWw/Iod0y2N0sY5X7DxlpwShrqQZSMrc0StjMv9Kc=;
        b=CrQ5SGe2j/O279XVMNDsyxfgRoO2VaPXYM1qNroPzhPMeMTPbRDDtUGg6DJkdurJDa
         tochF0sZzE/7yvhyM8xNjub6z6RolwARiGo0dYpUM1Kkg4xd98vavrMyT8MNu3QjxgL9
         UfgpgcfjEUQ3y2Nu7yWkC080mv+0p1tn5Gl7zZEn7fdiPx4yV+T0jhmYirdhE491KcxU
         9B7PLQwVYQrxStVqlcOABF47RMGk9LISlNLRxXJwK23z1ov07LW6pYeH1wAtC9cXBhkv
         XGT7McgZ7RjB/OGcs+tu+a0jf+LtD0OqtNgku+w+VZ3erk9Hm1yVyMt9mOx2+m2yUMNL
         riWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177862; x=1775782662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WHPWw/Iod0y2N0sY5X7DxlpwShrqQZSMrc0StjMv9Kc=;
        b=RvJgiz0XM5SAFXn6cJiRO9XfafBCRslWjvaH+s0KEGxLWwDAdLnCpe3BMs9GdHb68s
         tvw5OM3EOBq5Neb5d0RQc+dtk1yY5hGmK04rHAYWOn4MjQQTfyjQLmu/pvCE+wAGlhVn
         cizPepwDBIWKGXHwMXOsuUEc1i3ehuPXhowlljGBMaH2c70dqTepy1q0Se3SZFfyu+ED
         gfHn3CSOdUzrUGeIPimi7Nn274l/4td9JW2Sul2V3tdhjXo/GNm979i1TsBM+gd7sjbp
         j6Qc4pDJe0gJELwwrJtafXScJ4x++LQaz2gSbZ58RtNAs/s/WNTDMBp5BKYZtVRM/ksA
         yA0g==
X-Gm-Message-State: AOJu0YzvsjZT7SZ1pWotWQIwhk+5AnqEYpy6811Q1pbTiVSFDgNZyS0z
	uUN/JA29rE3SIcGxH8lb3d9QoELwWhZpMX/xfeCwNA7v+J95Zdv4s/R+t/PuCmknU8FBpfpOuNS
	GwV03YQFg8qMniFTEF6BViJ9xxTzZ1Zk=
X-Gm-Gg: ATEYQzyCM3QYzlaFnSdblKUUSG1xXm9Gm+OaZzPQ71AFCIHEICY2ifMWRzBPToFUiSl
	BcyanbluCz32hSVrp7bbG9dB67P1tJDBFpPGud6F1o/V1OagW7kyln+NCz355Yn3J66V/naw36R
	OPuGAN9+bRbMSYLTok8np6U2n1wSlR9tixjwHEl1/pVQR2FsgZG5cQ384pyqidyKFQUzLDHzsmJ
	btwcQYjn+dAmEJ9Vn8U3RE0Tqqi2z/FqCFRD0zwWho6vG8n8SojAeVwd+XM7bwZKL7kfcnFqgHn
	aPlnYrnZh4rVI35NnubfOkpvPl+RoHK4bg8tGtHbKQ==
X-Received: by 2002:a4a:e1c7:0:b0:67e:9cb:9b43 with SMTP id
 006d021491bc7-680f8386b64mr1778667eaf.10.1775177861682; Thu, 02 Apr 2026
 17:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402223437.109097-1-mmyangfl@gmail.com> <20260402223437.109097-4-mmyangfl@gmail.com>
 <654b51cd-fc06-4dd2-9a6e-421d7333f905@lunn.ch>
In-Reply-To: <654b51cd-fc06-4dd2-9a6e-421d7333f905@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 3 Apr 2026 08:57:05 +0800
X-Gm-Features: AQROBzAZUwyr1z5x5yMJVSFUY5NaKSt7CA96Ot4lwWMQOD4Rd6GntnoAr8LCVCE
Message-ID: <CAAXyoMP=o7P0-o6HOKi8dho8iLLV4LJT=YHae5Gj13xJ2ph4og@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net: dsa: yt921x: Add port police support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274813-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6169338FC86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 8:41=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static void update_ctrls_unaligned(u32 *ctrls, u64 mask, u64 val)
> > +{
> > +     ctrls[0] &=3D ~((u32)mask);
> > +     ctrls[1] &=3D ~((u32)(mask >> 32));
> > +     ctrls[0] |=3D (u32)val;
> > +     ctrls[1] |=3D (u32)(val >> 32);
>
> Please use the macros upper_32_bits() and lower_32_bits().
>
> > +     update_ctrls_unaligned(&ctrls[0], YT921X_METER_CTRLab_EBS_M,
> > +                            YT921X_METER_CTRLab_EBS(meter.ebs));
> > +     update_ctrls_unaligned(&ctrls[1], YT921X_METER_CTRLbc_CBS_M,
> > +                            YT921X_METER_CTRLbc_CBS(meter.cbs));
>
> That looks odd. The first call to update_ctrls_unaligned() writes to
> ctrls[0] and ctrl[1]. The second call ORs into ctrls[1] and writes
> to ctrls[2]?
>
> When you look at the masks:
>
> > +#define  YT921X_METER_CTRLbc_CBS_M           GENMASK_ULL(35, 20)
> > +#define  YT921X_METER_CTRLab_EBS_M           GENMASK_ULL(33, 18)
>
> They cross the 32 bit boundary. I think it would be cleaner to deal
> with these using GENMASK_U128 and construct the value in a u128. Pass
> the u128 to a reg96_write() and let it discard the upper 32 bits?
>
>     Andrew

Does it unnecessarily depend on __int128? Otherwise it's good.

