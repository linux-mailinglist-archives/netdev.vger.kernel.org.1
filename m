Return-Path: <netdev+bounces-283255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNh/Ovzj9Gl1FgIAu9opvQ
	(envelope-from <netdev+bounces-283255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AE4AE8D5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21A8E30071E4
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F44302163;
	Fri,  1 May 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba9VkRb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67872311C3E
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656799; cv=pass; b=Td1Ufn7dUMsGbrXUEjpgQMTBZU/KVRTkdRlBaJYzGVJ58AgdJyx2/7KaC9CpXE1HBoaI6J4OuRW4fJgLzsFWa8YfUsttWPIuT2KpMeb3fUc0vM7ajAMZ8x3i2xKts8eU44oOecFR75UAJmuimwo/Q0D+0YB4PpjrYZHsvtx4DKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656799; c=relaxed/simple;
	bh=MWljcHzd9A2vZ3zEdm4YKqTkPhIvwyTbh8JZ4E1v79g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7k0aaP64WTDD3/97dvsy4ZaeR5+8usvJSPNFhHgLRcJ1ZlP9NLRuOjz3jeB3jalCo3YgXyZbF5ATDF1r5jKmRjFiMFD/YFmDOsXS2yCMuyLBwTTBCnFxzv4N6/GCgQBzHjMdjbyYfoq4d1ajs9ZvfCg/lwuoxrOgT0H7Lt6VSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba9VkRb1; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso5320850a12.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777656797; cv=none;
        d=google.com; s=arc-20240605;
        b=ZdisWjrGRiuWVZbFKncuLU449yVJjNgyL9QvVJw6xbBoO3LQ3ND0HYeQQBjfBSQn1S
         jxoxW/5zyRbXO/6xRzyTC1WF9k9ro+Z/Ta5RS/3WOys7jKJJ/DJgieMxpPBBv1ul046n
         rZSI9prv14PAZ+0yVukO9CpgpJ/znncd1GWb6qugwS+X4pwFspPMA+NdiEn0r/PCEd6O
         IuRlJ5eYdeFf9p2AkL8VIEHTt4Ts/u2VryM3vENcVH/LGP2rIOS6JTn9hglGbzZswxI1
         POO6A61W9CYEee6qn+pFFKTZ3Qx7SKS7RpBBE4JnFGH9/OKvCPQualJWb+PnRUCF9Jfg
         xWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MWljcHzd9A2vZ3zEdm4YKqTkPhIvwyTbh8JZ4E1v79g=;
        fh=wukdOsh/VqwxVL1mDqKodFp6fhrTPBKN36xa7Hlh4tI=;
        b=ZdLZEp8HdgaCprFyZ52B4FUV8FRhuFWv6acD07hnAH5pnm9gySD4+tBi+nfGBehBRu
         kqVCdvTvrnNk1SoQREJy85JG7zM+PFQ9AviakD+O+skXJTyLn1kMwfLBmdLluQ8VRhgm
         DgWsU4TeteIhceX3n1Y9H50wDFOqt9pqAc8xszqZPH3x6C6Ekth8eFcpLb8E6gGJ5jmi
         JmU0gfW02pzBJzKky1EGg1OJd8cwPi3FA/p62jRhb06H9an4dLDLtJOv85ghPwfiMhNJ
         Ph/Wl4q2DJqhNXLlBmDdHnJMxj6fUOC69AJ/CO6AZ8L8yOsER6423Wk0IIjuOr0XRxW0
         dq4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656797; x=1778261597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWljcHzd9A2vZ3zEdm4YKqTkPhIvwyTbh8JZ4E1v79g=;
        b=ba9VkRb1uvKjoVm+RXF96fqDgLmq7SrpSrmhFwa3v6Ya/X+FxAWvzagalJ0zx8Wyhw
         zEhTPI/YyD+kwWbOikgrXUuYCywEC6zT405X0pfKbkbAHCgpV9D9aUfOIxFaQomm+nO+
         wAyaaFRQ6nkZupiDr8URJF5TnTwqYGCL9PkuBAuwyOOclC7MStrVDc0MOAR6JvZIL5NU
         lHCQF//mD1yHO85kqqnT9/wKgUwT6SkgI9HerrFkz5aJ8QWe1+lTPNJ6O5qfLHwkLLHA
         WgKluMwMQZBlzV0TZ8g6ti1vOBk5eQuezNOG7P3rqYPjtWx4SfbBu18+URmo35eK+0dD
         6CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656797; x=1778261597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWljcHzd9A2vZ3zEdm4YKqTkPhIvwyTbh8JZ4E1v79g=;
        b=OR2bj0sQ64x6vSNGh4eXU3OJmqSbsTyKZ1+Ez+jxNnaKjcLa0AQ1fiZVMI6Josvbpq
         ZJ1RsnX3W87LoIxNPH3B8Q4G1AY8DO07Eq/dR83Va8l6Yb41Od9YshSolzlUuMbrzAYA
         7sq+eK/3lIwlYUBCuZoC2yJqtTluYdzhAsgyj3zwVtxI5sy2cLaUNrn5f4J73jE5MDl3
         BBY/u3a9TCMteebcblxOShmD8QMI6369Srn+Z7Y5Xry1t6B/x3Sj42x3x1BsQDh7aoWW
         yfE90q5QMEOLYl7Rh+2+oue+dkJvLUcUnagMLcoTRBdcrqfosko9FAaggQbMtuyzq3iq
         ZKWw==
X-Forwarded-Encrypted: i=1; AFNElJ8p3Df8v2uLfhV7GVtyUwnD6tk6biPNKqXN4Ul1tfLIDjY1xmbFJVzhcBljMNOZ/Mo2x3MVFuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXa2YqdMEEf9U99wMpAyXLYpEO2syrkschvVcCSG3Ry9KNXVI
	Mf7qBSf9EPzABRDWRmc5GHPyXUO2mIadnBMUlamzBaeHrQ0pD1tklmV2LaLxLMQ80WRIOQ9K4ei
	LPiBRRjydyAWCGvJLrFpOlvIOUisAFQ==
X-Gm-Gg: AeBDiessevkN0a+ZKZwbdcj0wWyjIr3oWR/RkkG6Q0XVFqmEZH/TRuxhSzyqR/+1fEj
	wQkgVFETzilc7KSBS2KNK03uAontfQELMqiNSSZx4xf7NrRQc4Sa6e2FphC8O1A5QzkfFsKEbJC
	rydiOcTrWdGWvCLi6PBmzK24Z7Vlv7HrISyOD/mOGc+EG1DAVibEl4Y+Y6HfYsjAF1p+AvITkAJ
	PWkyR76qUR8bcjqBU471zsNfU0nqwyBeM6SJFIkBfIMUgYK0vzwxFYF72qPzeltjaek/Ug54Yi5
	mIblx3CuPiQBvv7gVNo=
X-Received: by 2002:a17:907:9448:b0:ba0:d5db:2421 with SMTP id
 a640c23a62f3a-bbb97f8203amr393702666b.15.1777656796574; Fri, 01 May 2026
 10:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com> <20260501153253.GJ15617@horms.kernel.org>
In-Reply-To: <20260501153253.GJ15617@horms.kernel.org>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Fri, 1 May 2026 10:32:40 -0700
X-Gm-Features: AVHnY4JQIfXv2yM2I2Si-opvIM-VAlFfocfR9YdRcGFeqGVNL_IWXGpTcV5cgKg
Message-ID: <CAAcybute8+JCdnT+s6UcD+NzrZLCxhHg8XHuT_5YPiTBXmM+vA@mail.gmail.com>
Subject: Re: [PATCH] amd-xgbe: fix PTP addend overflow causing frozen clock
To: Simon Horman <horms@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8A4AE4AE8D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283255-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gfuchedgi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Thanks for the review, Simon.

I don't know what frequency gets returned for v1 in practice. Maybe we coul=
d
increase v1 SSINC if the ptpclk_rate can be low (<=3D50MHz), but I don't ha=
ve
v1 hardware to experiment with.

On Fri, May 1, 2026 at 8:32=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Apr 29, 2026 at 02:54:14PM -0700, Gregory Fuchedgi via B4 Relay w=
rote:
> > From: Gregory Fuchedgi <gfuchedgi@gmail.com>
> >
> > XGBE_PTP_ACT_CLK_FREQ and XGBE_V2_PTP_ACT_CLK_FREQ were 10x too
> > large (500MHz/1GHz instead of 50MHz/100MHz), causing the computed
> > addend to overflow the 32-bit tstamp_addend. In the general case
> > this would result in the clock advancing at the wrong rate. For v2
> > (PCI), ptpclk_rate is hardcoded to 125MHz, so the addend formula
> > (ACT_CLK_FREQ << 32) / ptpclk_rate yields exactly 8 * 2^32, and
> > when stored to the 32-bit tstamp_addend the value is zero. With
> > addend =3D 0 the hardware accumulator never overflows and the PTP
> > clock is fully stopped. For v1 (platform), ptpclk_rate is read from
> > ACPI/DT so the exact overflow behavior depends on the
> > firmware-reported frequency.
> >
> > Define the constants as NSEC_PER_SEC / SSINC so the relationship is
> > explicit and cannot drift out of sync.
> >
> > Fixes: fbd47be098b5 ("amd-xgbe: add hardware PTP timestamping support")
> > Tested-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> > Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> There is an AI generated review of this patch available on sashiko.dev.
> While I do believe the issues flagged there warrant investigation
> as possible follow-up, I do not think they should delay progress
> of this patch.

