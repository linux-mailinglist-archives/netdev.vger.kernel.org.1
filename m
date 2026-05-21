Return-Path: <netdev+bounces-290633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAeTOTmYD2r5NgYAu9opvQ
	(envelope-from <netdev+bounces-290633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325CD5ACEF7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 01:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A0B6300FB09
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE53431E7;
	Thu, 21 May 2026 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuibmWH5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377533F8A6
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406373; cv=pass; b=iqx5tRq46byvv1bdVcbRX3+tnggVbaLPI8u3I4IIitoYcM0LXS/BTKKgXsdILu0QDTKaHEDoBWRAEh58HDXnQ5i9IdB62rYCd89nXZnZDtcloTRpjVleJoCYjE/BRntxItq9ht+rj+DsfMQcxvL+AFf/61rt7xJIKXncQSxCna0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406373; c=relaxed/simple;
	bh=DuLgLK6LxN/BaTVUbI7ZtKOlZ97j/KwP+aPI08Sik24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpMvLlml18b1YyuPlQeZqRWYayjcVB0Njrm3NmGmbBuiQdVMgEvwrb6BpjTitg9uIv6mgNEnuA6vWHRlDFVkpjDmu3AUYYWnCFHPMyEWtU7nxMenKgkW1T/rG0un+tABfhRZd5bfW0hHrEM5JCb2S9vtUk0+Ok9qgpU5ElGx4DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuibmWH5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so2962310a12.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406370; cv=none;
        d=google.com; s=arc-20240605;
        b=Le+ipLQ77QifNkKUwNIkalN1fUHabpoyWpSqhMRDecH+hT4F+X3CZB47xI6o/tlhz1
         9ruNCrn8r6Akc6xnhDD4UNQXXmVs/oxravhS7w9EgyGxPCXVmAMKYHy+l6Qq2y6aBEte
         46ZiFDzeMhIg8+zoZh8/Ya+VttYjnvtUUm5nIQ1nuGHMb7Pa8DqwACEKoZ88ns1uQQjG
         G0j9jgmT8DNas9dp7ebxsgRcnMd8JjysTS0CVd2PjawrUz0ijC/+IhzDpqM5E+3PyRYV
         xpQQAVwb+UHciIVP8MjZcYNO3FCXHD7z5BdDcE5tpnz+Yti4ajQpToN37z02hpCFJGYS
         AGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DuLgLK6LxN/BaTVUbI7ZtKOlZ97j/KwP+aPI08Sik24=;
        fh=uKT1ATlUfBZCT26CrIgQAp85eqypbboqvsLKFXK0K+U=;
        b=QXYMR5V1zhESxNRs78x11tP135sETErcdyPxjTuUQHM8kvdLmJZa4dNSm5/LPZJHjI
         UIdWKNnjLyFw09I7JvJVBbLPx1SCIc7qo1SccaZSFgAMFoUqI4KB5uU1jdiU2wwVTmSg
         1M9+Iyh9EzCXi41WToc/D9QP3eCHGzWi3bRgZrbVrT8m3RPEYBds2W/cemCueNG7kIO1
         aHDTd4czBusIA8rbrzOdAdIO6BigrU2BjtQVUL3GoRLj5hengQ2UbUTjAnLTvMC50KaY
         beSwHi2AQ/DxsckpaZGtZi8oR8bAkx1Yftn25Kp5RJ8Je4ruH7QxRT7TkFTl6ZwnoaE1
         cAuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779406370; x=1780011170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuLgLK6LxN/BaTVUbI7ZtKOlZ97j/KwP+aPI08Sik24=;
        b=VuibmWH5jT4l+QIP7cdWFbisrzA1Kx7ZqbwGC2JPWTzESQXHZ3WCGFAW4G9m5zZ0lP
         PG/vFie5cpLmgpWev3MD2xiTd/Sf7ujoMSa57ZdAYNqTjjFUJCY2lU+WAXy8IagjfVt9
         kLWB4nAFPKBNLSH/vKfIm7o7HoH8aWWVfd+MqONAISOBRKGCkeZFcFjyv457sMN5eaep
         N0LOhsR+tsCydA9toROygpmUPkyuEAHqMWxh1S5ATO0H2vDD+2Nk5gpRQGjdNWGGZw2L
         UKR4Xv8KZu516u5tyiVYN/pUxqt6BdnOkfcj4xBmmm1jMBCBvbxnPv3FJ4KXIm41V3hU
         kW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406370; x=1780011170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuLgLK6LxN/BaTVUbI7ZtKOlZ97j/KwP+aPI08Sik24=;
        b=BIfCuUO1nAX/UcBNP3PrAPvizDf5bU+QRpHUDr8EOi31a7Y8T6VOsXsFg62RhkqHOF
         ipsUyfdxI6zLfB/ZC98zKYu6Db3qsl6EFaDgr/3eMi0GtgXtZQ71NT0xYSnsQf9o4Mgs
         smN6Qu4dVAo1LUtUiUwukiydrNOsRxor5nDLmNdAkDzHMp6ascxU5V7o1FaXRmMVYZod
         6n2UaQk4DF+UuGPMqI06BB7TgM8tWKA2puIJ85PDhyEvkpjf/0wgrFmP3beYdhpFGuLU
         s+njqE/k61vT+KM5KkEDItc2EggjT+oYkurQYj0jSH1j0LaLrVF8of4TUCDV0fkBpv2I
         nJZA==
X-Forwarded-Encrypted: i=1; AFNElJ+FTD6xtVQZsNkXtJPqOIOE3jTPubZxV0EAEttAPTBtyuHmQJzUBgq5C0VUlZCO44JN7HRsLkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwW7sTun6MHvrJHoLPDmKb10zSBlHMrR8XEULHNJuw1kUil+Wf
	njexv5vXkcSsyf1t5ws0TS95YfG0boPWN+NydMr4t26NG9iVxaqIBROzgcaEjNeojNfve8sA7rS
	Tl5p/4XO7QRNLTgm0YNjJj4dCUwr8jQ==
X-Gm-Gg: Acq92OEn/VLnXk7ANQhFOyhCP4Y6AQdquZl+e6AyjW7F2E3YCBAN+zfsd0mb5+89RSQ
	qvrKunf8H6BkCsDzaLmXCRJMoTPX7rXOmXmH/1XHZwFeXbVPLf8oxAtk70XvKP88XsD51yjnPi2
	+yr9uMPdJwq3XqjxY0heZYjC1CF8LbCqa1105PRvqBVwGvoB+Skeri0AuK45OTGAafoaeCUI8id
	UyfGl7GkmdcN1SNc3GBldug24Qp9PN+VftJ+GVU9JtZ/k6hY3ZN/MhgaQQz3iLEjqgCHTAU+CI2
	nqI=
X-Received: by 2002:a17:906:ba8b:b0:bd8:e680:1aef with SMTP id
 a640c23a62f3a-bdd1fe94617mr92158566b.0.1779406370449; Thu, 21 May 2026
 16:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520191943.73938-1-arouhi@sitime.com> <20260520191943.73938-2-arouhi@sitime.com>
 <20260521-happy-celadon-hamster-94802c@quoll> <CALFSGuoWkHYmtrouvLk2M7bWS1=qTSPUn5GuabFvK92cPBfuZA@mail.gmail.com>
 <fa73a8fd-ee73-4a7b-b6c3-1d2edd73b45d@kernel.org>
In-Reply-To: <fa73a8fd-ee73-4a7b-b6c3-1d2edd73b45d@kernel.org>
From: Ali Rouhi <rouhi.ali@gmail.com>
Date: Thu, 21 May 2026 16:32:38 -0700
X-Gm-Features: AVHnY4JQDoN-cEKJ2IStW43hgsf5_SfhbkC65BCc6BKE_2udJvR8TOkbocEmIPo
Message-ID: <CALFSGurSUdpe_KPOkt1deWtVhu16bQkmhz69NLmbf6PSbPcd6w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime Corporation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290633-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 325CD5ACEF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 2:12=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Do not top post.
>

Apologies, will inline-reply going forward.

Best regards,
Ali

