Return-Path: <netdev+bounces-294392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id axbnDF84H2qBiwAAu9opvQ
	(envelope-from <netdev+bounces-294392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1E631A6E
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Np7jfkAT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294392-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5D4E3008461
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6EF30676C;
	Tue,  2 Jun 2026 20:06:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88F2F12DA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:06:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430807; cv=pass; b=uYNn/3i6d2Z2/De6djF1wNLEhefSInEn7tLVjOlATCOYwfd4kEBM2aG+sxP8f/Itn4Ry8LAoPLpp9yTJvp4diU8XwWHYGXGKGiQt45i5XyhYto7kZth3qUSR4DhI/7ybkzd27s9hZqhQoX2iVLqlXbtong9ySijuVwZLcaQDNWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430807; c=relaxed/simple;
	bh=o6glQSSDOO722nG+tP6VFLNvn8Di71tCXdyy4TiaV/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWYpc4e/IK3QAFHm873t7DOBhgBJxd1HScpCAj15sAzwUj6FPntShxVsxK6QU6pAVCbb6pLmYjK6AffbV7C847kwsCp/KklGfmvVIumUja2p0ztIAZvr31GgcYtRcH1UrxruwLrET1q8kR7SqCmn0YRFbFyXewV4P0UlUkU/ngY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Np7jfkAT; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13721dfd471so11541973c88.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780430805; cv=none;
        d=google.com; s=arc-20240605;
        b=JPeeGSSvNiDNMZhR/zbpwxEhUWqTC8F6Iioo6UaWH7DwFmde6mJmiJu54Me2mxODft
         7JVeJWjkegYCnfXf+2utAOIxGVe8qdsm5KUBz1HaltUMS/F2/VLdDXXo9GL4NyGFMfpo
         13PrtcYk/emvr3N6fRZ2MWxq9FVGqcfD7io/2IDyRLp5cN/Df9OWyCgxtMnijk/ucRrt
         0KGKQzx9vDdrGC9mVSSucj+ofVAa5co/wxEqm2T0jBvPiSRnTays4bgENlWZHmONnXNt
         nOV2aMKzYICT9l4NwMFFM3AnBlXvmoiveZu+VWALG6zZO1z41TOVLQdzYGr2o7P8M1Om
         jODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kjNiWfY3K0FWWLPxuEGqLi07e+1bZMAFrZWIfKQKa8g=;
        fh=ftisUtbs2zC3yyQl6Tdl6GGCUp9OSygQnfqum638+p0=;
        b=jkk/1RxkapJBjg3zCciaiafuF+ewN9FU7oTm8ZPNlQpe7cqpgiiBGvyuLA7pCQqZi4
         JfBygMrknsFdUNBC2H5NYmpLYpW6IakIM1kafOzBt6ctJJzQL30fX8YHKl1r1Ci3V07A
         8HPOI89l+J/SUR6P7Ts7oWZ6+xaf59evxz020oUsBhXptwv8V26QPdniw3jS3kU9EIIh
         k63Td0r3kX4XA2HWPvQVqDiGXp7L5R30Os81hePlzJhtWQdQrMGnMHuCgFIdks9lbGlC
         vDVaPeAj4/l9EJUZvWwYJuZFO61HrdcnMKhkG21Qt1Q1W3E1V+USBXZwimM74h0nUv5D
         PURw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780430805; x=1781035605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjNiWfY3K0FWWLPxuEGqLi07e+1bZMAFrZWIfKQKa8g=;
        b=Np7jfkATOtOBYqzZvm50SkNSxiM1B1KZ0dsLtoOJlU8m+lyo1wg91xFfJAEmKLhuUY
         JCYv2B+SdcM4xmwmUOBv5tdgnnifPExJ9WyU5k6XlJzMO7idGtLAGFPzoGpJKJ3X6A8K
         f7T+pnCXjAangJYxNud4jGdZPb2wHM4EHDGFoQI0LorN65NtqBEDU4UHG4c1PgQDX9uM
         5rue4a56sA84oXwCYAb9rF8z+rh6D06t05zREvOSfd6lgylnoTQ2eilFxwowCzw8RqUl
         3SvHsqOGXJckyT6F1tyzu7On4OEINqBWTHpxICtDO7BwtGrqtPkTucf33lsemlnpGlEH
         /LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780430805; x=1781035605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjNiWfY3K0FWWLPxuEGqLi07e+1bZMAFrZWIfKQKa8g=;
        b=Vr1kt+gK4kMlp8rL2HwuZrz3qiMHkSMhq7gyln7pFmURKS+1qHffxJeLgjWO0U61ri
         YncbdsEKsgTZHm9H+bms8FBQHcWeeB12gifz+e2K7TTFvM/U7S6NDIixnWCMggEnV1Qy
         /L9I7K+rJrG7Ivj7rQz7tLdXExcCXA2TME9gsqf2rQPOY7ljdJ25fvvBJ9jGH69OLORL
         XySW5M47FDDFQbpzMtAJqu8nXuoPJ0XPfTVsDym+H/caAVvACQNWZ/XynV4ItZ7WCgNZ
         3OlmtRZiZY0jYsw4aH+DkEyhFC2zGHcgD1HJUwr8upQBzCylDxGZVI3ls4ksUVLsHfI6
         8Sqw==
X-Forwarded-Encrypted: i=1; AFNElJ/b4/U6Tx9jjyYAUoVj/2dQWgetyae5SC2CT3wupI8E1cKweugxOclnf5jQLUUTO4OInuV7t3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WdzYaaxmydS6/kqUkBrW5x6NJJqOd6c2eQOBBY0lOtCP1x8G
	/JpZNUO6GjvAVsVVeiFSi/vEkw81DK38EKnWf/EvAFpxNK7Xj4vv2DoI8x23xFEDIAFJOEFiqGV
	bMFJD/TTsYfEFycSSPFlC35xeiouiZuhTeVtoZZoP
X-Gm-Gg: Acq92OF5JNiz4kqN4FzMS7cXYvtfs+GgZjEXX2J05KISr3tRwUcwOFtqnP5s/KvktYo
	FPdheSoQVLYgKEvKj81l/+UYKFX1Hl8/GESsxDGHjeh0b17YSLXTC5b/LolVlhw9kGhx2uQOJgE
	MSg+NJkNIF9j2G4tW1BwawQ5jpMyTF9wjDIDz0O9EJNHwXrS6ErQeQYDH3mssXI0lrIgjQm93lq
	s9SKwRg8Scd0KvN+cx2jC6Qbxjj9tW8lh2VkJ7GbAlkrN+474qeAcSRMWtA/NTsARVq4wYfdEFG
	AG1ONXZkwdSL8BiUkISN0bpJUJ08l+JqTEbBVLv98QFswt+UCZhvttEx6rcN37XkaTifaX1ds5X
	ljUr72FIC/5ti+CVJ8nIeMEAtCfiB/q25Mi3MxRZ/jerGLn9Rb7cpkOc8shIP9LM=
X-Received: by 2002:a05:7022:6886:b0:137:ec47:8fef with SMTP id
 a92af1059eb24-137f6b8397bmr78678c88.14.1780430804786; Tue, 02 Jun 2026
 13:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523061102.2762452-1-kuniyu@google.com> <20260602125951.50492267@phoenix.local>
In-Reply-To: <20260602125951.50492267@phoenix.local>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Jun 2026 13:06:33 -0700
X-Gm-Features: AVHnY4IqjpQDxkH_Xtk01dGrNRDx0_vieuAceKF6kLPjKUfDg0-v9rHB8IukzXA
Message-ID: <CAAVpQUBAL_6A3MPcH8w7+EZyfOG9D0i2X3pu5Vhd+fz8Y0=QBA@mail.gmail.com>
Subject: Re: [PATCH v1 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21C1E631A6E

On Tue, Jun 2, 2026 at 12:59=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 23 May 2026 06:10:58 +0000
> Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> > +             } else if (!matches(*argv, "local")) {
> > +                     NEXT_ARG();
> > +                     check_duparg(&attrs, IFLA_GENEVE_LOCAL, "local",
> > +                                  *argv);
> > +                     get_addr(&saddr, *argv, AF_UNSPEC);
> > +                     if (!is_addrtype_inet_not_multi(&saddr))
> > +                             invarg("invalid local address", *argv);
>
> No new code can use matches(), it creates problems with conflicting
> short arguments.

TIL, so the recommendation is simply using !strcmp(*argv, "local")
or anything else ?

