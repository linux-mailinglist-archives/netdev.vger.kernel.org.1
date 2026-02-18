Return-Path: <netdev+bounces-259204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHaFMOZBlWkYNwIAu9opvQ
	(envelope-from <netdev+bounces-259204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FC153026
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4150B3004F13
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 04:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D22E8DEB;
	Wed, 18 Feb 2026 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AC680nWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD72E1722
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389410; cv=pass; b=dOhZkkEzK1IRAIGnfFUDO05UmQQDB5Lgn5sndqJtU27b1E43AE2HCgnc+j2z7qSMZESX1fDqeWHu2SXyrtGJZsM3JydjnQ7w8iUUIZ6KVHvF2msl0P9zfvhZg/d6v3QxEzxd8Jwj/m2e1iJFb89bC8/eSPJDeecbaOs4qNPGe38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389410; c=relaxed/simple;
	bh=EVf+59LvM6RSXSdvjhh+Xoy31f844vWb8BM5tMJdHBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHU6ZfF4odbZ6ltC3eVmiu1XPsZKI3RdYJlA9c0nRsb62uk3C43ysnENiATSY/lfT79yS/MDfXamUMxFWJQu3UEZFzKGq8Qa8fzn1/1mE+PLfG2xl4sE0Vl0XRAhoUpsqbifxQppvmdkqpJxhSb7Y0iPIZ9ogmHwwNUEK6vOqcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AC680nWv; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505d3baf1a7so226961cf.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 20:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771389408; cv=none;
        d=google.com; s=arc-20240605;
        b=DJlBfucujLNHP5YQoMfWBNS32lnfuIzX7hnTgu6aDlu4tRr9mfqsQnhqZa6wXHglON
         9AP7DBCQ1vQ5m2a98+JPwx8EZHDvDICnivDkLXzTJMJBjb6NRWg8Nba8gq4zH2asno9X
         0fP6j31K5Olv68B0X1AZEJbbou/nDwb+vQtVXhf5Kpiu51qg6fcyEw0mSiQlSQwtNSEY
         VXHD09zAp8ulfxNzBGxpSlQSHILrdx4sD0ltLL+LZDq8UIv5mEkrlVJjVrOJwp9dwmC6
         evRUrWSb9auhnsSIf+jICc2OEx4LQ0rIo4y2QInObh4le6i5nRjFxL9Sy4ErZs4TnOa8
         zyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QpkPN+45q/6VfsYD8O7RJeE/bikxZQlghBv/BYo7Xsk=;
        fh=GsrSZAPnHmH0bAZk+huZwg4wxuEOxig5UNIC9zo1odA=;
        b=V/2QIvx5K6USE1mPTDJ/jWxUzYIwImSubwOC2DUWVMOH2Yqupw0lEEiJMaUmHS5Eqn
         +IR3BPblqeEj/ZqfpKeoumoGMq2kP9CZqtb5SvBLqvnURwbV2yPImTsyQ12AE0bcvU38
         Y9lG96elasXSD0FrkQ+XovPaMq9gGSL3g/P0uUqkEm7PbwivIV+b3IVffbZcteepd0YY
         owVOVDKj0bLVYDkmv45aF0THiCATLmJcyA+b7yoESoho53hz/BFhvm7oh1CNzg1o/a5o
         rW7xDKmPLtZR3VL98C7kn0ZWZgfZ8L3liAjw888iK4/bWmBm1CNUJH7VZcpEWwn98+Qq
         9b0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771389408; x=1771994208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpkPN+45q/6VfsYD8O7RJeE/bikxZQlghBv/BYo7Xsk=;
        b=AC680nWvz/PCK6CC/XxXI8Gkx8ztF/jPDdl7zuSL7v5TJ/2no+fPwmEa4TVU/Gn2AJ
         Vn9vRn2ZKyfiBEalLPiYQ7kYZH38Axp7QjSJykeLigzN5Um6Ojl/LFuPSW+s705O/T/1
         NdxyqffF+OGBT86u+gThMgihUNzjC1xm1iq94XTRmMupiV5UcSKshL6PCoH/ndhL0A09
         uYgGcEndMr9L0JjAXPUhMiV5EP7C76CRiJmTz/YhPumIu5oj/lyCzLHQVYYwFfrmfPrf
         ub7cwamUuffSPPu2c2BvI4jKfrcluJ2BMuiV3/ktYyR0+ENw1Y1RXhKBMQiRlHUpWLw0
         vFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389408; x=1771994208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QpkPN+45q/6VfsYD8O7RJeE/bikxZQlghBv/BYo7Xsk=;
        b=bLyqD/ZdKeHuL7mQdpW//PRJ8oq0xJmyBOmYSe1usnKzzJqeIcflVKF0lD3rx0w7tM
         8FwuXQ0hGlaOUb/9lcCMZdnOUHb+/KhOMIFs20kBgzvC0tSnA8G+v+tphb9U/zhW3Dxx
         ksCMidl1kcITpSPxRfueOVTxupUyDUnT2CBDM2qnrwOPRE1o+m3r98064JDNPt6Uf1Ov
         1dEjuamc90I2ZWJWLLdGk73ECjears67ohiuu2D9QXGg+J1EGg2TJ1qk+a6rCNtjbDq6
         uyzldPDP2APvh16tYwWOHxiFafa66waMwCoHzgGmoCUtNM6Od+i37AqvwI7NxosWQfvf
         FRHg==
X-Forwarded-Encrypted: i=1; AJvYcCUnbDwNemUHc0aCsNni6/rJ5/Bl/PPWxcsv/loqHIctncJ4jaykB/hff+Ic5K884MOqtpprK6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdd0h6FoH5jLr6MLsiRq4OUrcytfcYz4lcs6va44NbEmcMJ4yW
	9z/Dw2aBSi9ilCHgYlzkW74UdAXV1UVfl/XUPGKoKPv3dHwyV0g9DHDaoDqLreaaOYjRxCIfA12
	DJwIhWFQd/X6V1emDXMQdgbkf0jzRug/zm1vEPa/l
X-Gm-Gg: AZuq6aLNBpXzbS0BI+lZMvxnTTuQGjJRIRiDXLNBFqJLXDNVIxORjBW8+NphCfkFuxb
	9fg4E2GEvgL8E6nacphITw2FnrDvMqNg4IdXfvfxPvGpy07E4E2/6lqpX6417WbklpnSK6Wr20v
	Oh6NMaXAUWeLpQhAyspThenwjVfOWy3kmLX5b2VNRPo8cwyArGS4czk5rKtte9AjX+842sYIeNV
	Ar1ocG4y5vdRMqe5NQRwxv8MoxXGMVjpVYutzFIvcM5+WmcT4GigjEwDAkJYr0sZOPKiQdJSarj
	WQdB7UjVxEoYwDvZo6urspy81E7A00m00M0=
X-Received: by 2002:a05:622a:352:b0:506:9852:75ec with SMTP id
 d75a77b69052e-506ead4244amr734641cf.9.1771389407954; Tue, 17 Feb 2026
 20:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de> <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
 <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org>
In-Reply-To: <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org>
From: Yan Yan <evitayan@google.com>
Date: Wed, 18 Feb 2026 12:36:36 +0800
X-Gm-Features: AaiRm53NLdR4N5eb1XSojjT2wkeDATvu2iTDILIUtUSeVNcZvyeG4P_EM5r7Zb4
Message-ID: <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
To: Tobias Brunner <tobias@strongswan.org>
Cc: antony.antony@secunet.com, Steffen Klassert <steffen.klassert@secunet.com>, paul@nohats.ca, 
	netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, horms@kernel.org, 
	saakashkumar@marvell.com, akamluddin@marvell.com, 
	Nathan Harold <nharold@google.com>, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evitayan@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-259204-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strongswan.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 402FC153026
X-Rspamd-Action: no action

Hi Tobias,

Regarding your questions:

For every inbound SA, we allocate SPIs before negotiation. For
outbound SAs, we allocate SPIs once requested by the peer. We only
require the (SPI, destination address) combo to be unique. Thus, we
may have an inbound and outbound SA sharing an SPI with different
destinations, or multiple outbound SAs to different peers sharing an
SPI.

> If so, why would you use ALLOCSPI and not just install the outbound SA? I=
s it to avoid differences for in- and outbound SAs (ALLOCSPI+UPDSA vs. NEWS=
A)?"

Exactly=E2=80=94it is primarily for code symmetry. By using ALLOCSPI + UPDS=
A
for both directions, we maintain a consistent larval lifecycle and
make it easier to maintain.


On Tue, Feb 10, 2026 at 6:17=E2=80=AFPM Tobias Brunner <tobias@strongswan.o=
rg> wrote:
>
> Hi Yan,
>
> >> To clarify, how are larval outbound SAs created in Android?
> >> Are they created with zero or non-zero SPIs? Multiple zero SPIs (acqui=
re states) are allowed.
> >
> > In Android, larval outbound SAs are created with non-zero SPIs because
> > Android userspace uses XFRM_MSG_ALLOCSPI to manually reserve a unique
> > value before the SA is fully finalized. These are not kernel-generated
> > "acquire" states.
>
> Could you clarify what exactly the reasoning is behind this?  Do you use
> this for every outbound SA or just for special use cases?  Do you set
> the same SPI for in- and outbound SA?  (If so, what happens later when
> the SPI of the outbound SA is received from the peer?)  Or do you use
> ALLOCSPI once you already know the peer's SPI?  (And only run into the
> issue if both allocate the same SPI by chance.)  If so, why would you
> use ALLOCSPI and not just install the outbound SA?  Is it to avoid
> differences for in- and outbound SAs (ALLOCSPI+UPDSA vs. NEWSA)?
>
> Regards,
> Tobias
>


--=20
--
Best,
Yan

