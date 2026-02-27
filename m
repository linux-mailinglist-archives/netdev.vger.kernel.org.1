Return-Path: <netdev+bounces-261837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCrhHm2ZoWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:17:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87B1B785A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C2C3037416
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD31DB95E;
	Fri, 27 Feb 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wcEt44fN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDC1C7012
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198214; cv=pass; b=bfX8PqFjDVEwbApDoooVzhsgdHUR/tox+cyHnEF09u67QgIXTVlZU3mA2uEWCJC7674bEgqRaas4uvkK0qZkxhPox7Jrjw2ey7vlALupRXJoLWADVOJZcgTriE8x0RGuEHETskSG3BaaL1IiHJKVxJBIuXbGbyHBbSOrBFcQXgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198214; c=relaxed/simple;
	bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcBipR4oX1pbH3vof6T7lgG+oYbsbL3b+b9oAAsyB3rcmaS2X2S7HswghAM8SXuHMli+mcD/2mo0H6FVBz8IedIaPddM69x0SOQFP02Wsw7kOWYeB63UKDybWptbbFaU8MffOKk2HxFdREMbfZWhA2bpfjAqfvvEG5nDKTWFHas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wcEt44fN; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-358f5317857so718453a91.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:16:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198213; cv=none;
        d=google.com; s=arc-20240605;
        b=LU86SEJUqimB+pfB/+CcPQ2ZRJR8ZhyaWxJZornQTnZ0yUJquwy5JwIZJk1EXGubuY
         VIwbgkJhdkKa23aCv05sRfNFQ8hWptG6vn4ck5JY02EA0b7i9pEzkrqS3XITPTwA174T
         X+gOogDJLxLsLRmx4RTTzf8CVetM6lC+6GsKcIChv566MVZ93ktRvqWmEqcCH6+wdpBi
         gOPFeKpbpCe1R4B3xYxtht27jiz7vVUHYGx4Z2k0AgsINtg7cAUMO2WU75C8/TjeFGBq
         WRwUL6gt/BaN9P2huBJSOwrT5f1Z0/Px4yH0/upNNFW4w5JLMmoBsYnXHcb9YtyUE6CB
         Xbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        fh=xriQbQw0wwUuChtwUKAyWaW7LQWTQpJ8Uon8y/66FTY=;
        b=I4GwKnO4sQWE28ifcLJ/wtXk+l8OehVB9uUJwQbr7xmC+o8kxnw0cNEnFMC3vVOiuH
         04alKJkJcIoVLnslSrhas26CgXnyFGZGlno8SyiwiKx762MQZfmXE5wJxuXsCIDHC+Dc
         wb13nyluHPAj4NI3ToQTACOkAbDlGyUjq/vClEtJRs3iLQpQnhiU0EU/BGy8+ThYoRyb
         oFKMLiVpEb8oUPIYdx4p+7BfRBM4a5UWiF8x2J2kvxR/NS2z9VJnwnv3PXLmQwsIgMZk
         S1MywXjXCFFHsZoEJufNf+2olEITrxCzLD+iPTJNo8BZ2ETYyXbTTsp9/d42t6Y3aFIf
         N7Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772198213; x=1772803013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        b=wcEt44fNSYxHu4VEgpx6m7v0QIASghwvaT9qWQbowiOuywzOJKh3xLi94v1vhyzdpZ
         svL48MLuzhDCQVEo6qIKrMQNt3AskDm/Mj7/dub7xIiJU91Kpmp0fv5stFUVSwcbruV8
         EJzYVriccF3q5icnIoC2gLlRr0lw04VRK7DS8tPyVgZGIg1SWhM1UsWRuzLXSm3pT3qH
         kkPClft3zuP8EDWOSKes79GgHmYVoT01kPD1rSLKRAquq6L5xjlb3MADnjASIvqyLo2O
         aIYHL9HoFnZcGOy+RQHnHP5RqmjF1Is9GdxZcC5c04yckNLbLLcUNRzBnycW5Bn88oym
         3QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772198213; x=1772803013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDaA+XJaA19YoQAlSYfbtQ/U8ksfTNOAogcuVv/TBF4=;
        b=UwjaSXvyPRQNNIQ87BBkrLn7ialBaErE9B8FI4tmCaqt9aA34zhjp8exa3rmM2tBIs
         5L0+SCDdQ7+6fbphyDIF8UI3ZIfW9K5kQ89eZ3GsMGiL248juj/586g8y1zfvpUTC9vA
         lUrpgmySYlZ0v3VaETxbT93+Xrw0gV39qm5B7EdDQSZ4fQdE1K+9ev7zlEa19HGmWehm
         tKvS38HcO9VK9K+StrtNY8y2KoWuJb4MP14vem6BqsTyqe8Xup7glNKYQBExJsEKp+SG
         nynTtgBtNrPFhL+Rqsbftbkf3p0A2LI9IYNklzthUz7lG5u1gu6CEu82/kUAu1GBBYLz
         vvLg==
X-Forwarded-Encrypted: i=1; AJvYcCXncE9LrrckIbejstNcVUo7MFVV1+9M6z4NlH9RwtHpNnSlVtceWi+rDZzpRip4GG33VOnQL0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YytDujUHuiB0oxH0W7UB96ZNg4AC/kczar/DPmUAlalWlpZ2DXb
	wnlKYKMdAYRQijSepGyqsrhZp0nAm/shSLf/ake4dS+igJwUGpnBtPQI+xk+XoT//4Ktuzoxqxr
	84iRCSt5iWAQGlXeoJgWnr7CYWz40WtMQNcECu9pMPUgfCi2DwWk=
X-Gm-Gg: ATEYQzwL6i8Jp+/PDoNLgy7ogwh3rvaUX4NWizXX5Sh6gTEaozFmhQtLNlXsJPzghKV
	w2m+w+8HKj6oIDtLMLltIkTtc2pTci2xKHgEuSQI8nF3jGjZA8AHWSVsEZt0ITg5D+Tc2MD2uKS
	syTc3nD9RaG0IYMihaRfh0jTcwgUMiBqO/fMf1DiADzms+isaHEGuC+BS5U3TLvqiyPmzgObap8
	ToYIQX7PdUG/Xpj9z922yBNfDUl43y+h1s9rn6aMdkcbKf/gfV2g0ExAQ9WjB3KvILzytk+v1uW
	O3F04TW5iI87ETg=
X-Received: by 2002:a17:90b:38cf:b0:356:2bda:a857 with SMTP id
 98e67ed59e1d1-35965c9d127mr3060071a91.18.1772198213005; Fri, 27 Feb 2026
 05:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org>
 <CAM0EoMmr0SUf7U3CTqd=MSYX=D60zYOfBS-L=GJOsWB-cxZHcg@mail.gmail.com>
 <20260227013151.qaw4hvb4fyt5roeq@skbuf> <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
In-Reply-To: <px_b8_2gC-ZLFXok9C1Cjh3OAR-3fh7q3tMvB6ddv9V_IR2UOe0ANtPfCbh_s3xFARel2DT6Yg5cVJe3LPmgLpgDgGfqTrJuPa0OADyxdts=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Feb 2026 08:16:41 -0500
X-Gm-Features: AaiRm501mvb8cKgXrBcKkwVqLRI4xO1kMuzIWg1rjrI6m_S9GMPSEI5hVakE9Uk
Message-ID: <CAM0EoM=jY=w7Chj1=oecLfEkyXgbydX63ykywbXoYHrCLafRoQ@mail.gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Victor Nogueira <victor@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261837-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: CF87B1B785A
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 7:07=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> > The ocelot/felix driver doesn't offload standalone actions (TC_SETUP_AC=
T) so it
> > doesn't notice changes made to the action using the "tc action" command=
.
> >
> > If I make changes to the "tc gate" action parameters using "tc filter r=
eplace ...",
> > then I trigger the "The stream is added on this port" extack error in t=
he offload
> > driver, which seems to not have been written to handle parameter change=
s very well.
>
> Thanks for testing. Just to confirm: unpatched kernel returns the same er=
ror?
>

Yes, it just means that Vladmir's hardware doesnt like replacement of
an existing rule, therefore it gets rejected with that message (error
code -EEXIST). Yes, the message is not the best it can be but could be
fixed later.
Thanks Vladmir for spending the time.

And for this patch....

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

