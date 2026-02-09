Return-Path: <netdev+bounces-257991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E6ocEJ9YimnOJgAAu9opvQ
	(envelope-from <netdev+bounces-257991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:58:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C9114F2E
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 22:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C48A301BCCE
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907230FC03;
	Mon,  9 Feb 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6V4iDXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B242049
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674332; cv=pass; b=h2LTETIi/jnSkH8iGy5xOikYgzR4Cc+AmQUspLwCYGEEsDYDTGXykoiyw5sRWxh+09LWLSj+Q7+1Naddz4I3pAythGeIdOnplw/vodselqzcSQXfGPwvFlkX+v/yuUjtds0dnMQ5L0kBqfxlW/xjrrpB82jK9pA3d+LUHPrJ+zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674332; c=relaxed/simple;
	bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR7nsyHcNfx7YdM0kz+Q8/IhzGyb1JdqkrZmYffjeo5O09yHUocCj4ZtVuzPfZqTal+tLfBFToIQMc8Hjgl9E07vGevecWvfX/xF8AEDCfCEdmxIjERZiS/3qHwaTHLR/VI0KhYCq3arO5qpXdcGSWfgwW4NWthCU5kqNIzZlt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6V4iDXs; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8946e0884afso66862676d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 13:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674330; cv=none;
        d=google.com; s=arc-20240605;
        b=bp98Mjbc5YUJ6/N6S/VvIp9fkFhOAPtYOSqYfUk5sbJRTn8ubOxl0G1hIt9bY7vgtw
         6ybOzL5hwzk3+x5iS9evgZBq8xBwTWNbNitTrk4D2YFOSQJToMYj9L6wHjNE99Crfh65
         fCXHArMxeBkqZg9mtXKfGWKWUdoDWnAhc5Rs6586ft8onGBruA9CMuQYC3swwE4ARU9o
         UiMkeshoqDCxeYoowCit8SOkSyLy+V3+1w/E+rt/IHBEnugZwITqkhspBWEPXxh2LQ0i
         0tjvYhqo4wc4Oeufp2rZDTyCtDcDNRwCwn9XECclKo67Frceaphz8v6AWZS8D9ZbWlcF
         T+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        fh=s5v+tTq/hueHEp3FjEPUDkwECPNTSZ+KR1uaxexPYQA=;
        b=TYJUfPe0sewooS0pzdPPUiF4fhaY1dzlVZDb2sqS8ShO7LOaNKAd/fr5buLMLAyH0w
         ci37WKDIcDv/Uqvu1Tr+/FvmiqZ8EXYCBleZGBW/Um4YQ/vxyfeas1QbbVR03im4XnVT
         /5HN/O3xKThgAKbg464y2WI1jpLlq8c2A47q9hHEvhtATMz0IdsLzmsoOZ+dcOna7BEx
         SJNCNDkUqgdnOivCPeW4057LucEe2VKHL3u5pPrC9URpZN7v8JLdsJ8oOvma5/ChguAh
         BAxPS5ODn4mmb/fVOsf6XxMglBnX9Db5Ew2tFB1KCOLPe/CFeVW1yP2ZP+UNFmz5Wa92
         5pFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674330; x=1771279130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        b=g6V4iDXsZam03WDP8BQ01jUGJk2AdBi8il+C/636aX9CDdF5I5N5v+jeZQnMKSPtMI
         b/j160ZVNApawaOP/nL7Oy05RR4psQ2Cm7G471utVtyfe1UosFP/3xT9u3gR3P2mKryh
         Ln+BPPOMBE/OVDljqSAFulPZjpiS4Fl3T0RF6ce+MnHHdWXazjZ3jIWVhvX2/vRk4aLQ
         PHNQLEdpD4+i2JwdGAgK5+0X2F9kdD7jEApd9adkVzfpphV2MhGYPcjMtIK5k+Fu6530
         ZywtiKKkJMm4UF2oKBzODvEWTaTmUMGMHYUJ8f9KQIyoSVRfBmzBfppldwzkI7KR+V1+
         LW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674330; x=1771279130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPYUCSOAu7i52K1ewBTraLyuOA9MZ6Hs6QSKzwuBAcI=;
        b=RCyXcy04Be4uAcId+PTecRbVj7l7q+FO7aNl1NPJNXkI0XNSXzf2vWvxp4kEa6gj3P
         rfOK9TlqfwmPJfjw3mUREUYdmyqoZjh2onB3dr2JWsxeUfasUsoGSCefTqFBVTo5gX6B
         WDKdXZZfO9OzRkC+Y450meUpomniLP+iRmGylSufeO5ciTTL6uQXNf9xSIoKFESh22wY
         lqySkYZUXwSuJ34tTO7cU9/TLqt3Nz2IBj0Wm6Ly6x/itWkj2WEEL/h+yhW4ezX8iprf
         zd9y968gpPdAiYr80YZFoiomFdM5RYnp2EnbKim92xlp/O17mUYo6eC/fg0CpNCFAYS9
         QTEA==
X-Gm-Message-State: AOJu0YyFTRcP2ekNJPLAlL4xMNnYO3wluKpKfLZ2XvNysC6yttBCAQiv
	BJwX03IM+z4cySH5kZ7UEXIQtKYyQRTd0p0RdrKJeoTjPJELpAFxo0crMSRhWR63RmnAO369QuR
	DeG9HLM/8qP3vsz7EtZVCniKTb/NDZ8QRnEgS
X-Gm-Gg: AZuq6aKmX2XjjbXWJ6EcRuCmW6hkG5mR5dpNauv9rEiPCpKvqZcy4dkxoaNWjAvaAaH
	XVNtyX/o2K/bznr1gJy7ZlHOzyOJZmPzXQaNBTpu55f9NfQ6IaFR1A2j3G+//sK4pnpa29C2gqf
	BmCYUlOLiua98I68HgbDanYtu/IRuf4Fv4m9Oo0y4GiL7ttIE2NeFe/SU7zRxMEd7GouswE1jck
	fBUDx9WoepWRVPeSUqfwx0i4rTcMFBtd0wWtF/lOTIVBIXRPvQKPcKoyr1q47oe6rcBZg8XQ4Rr
	SKyZLbCPHwiyEOYSp7X2Yf6b/i2CuAtxXla8CUNRpKGd1463TUHcpX5G
X-Received: by 2002:a05:6214:21ec:b0:894:6ef5:9f06 with SMTP id
 6a1803df08f44-8953c82a798mr185381636d6.28.1770674330414; Mon, 09 Feb 2026
 13:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205065113.33547-1-enelsonmoore@gmail.com> <aYoAMrEVDNydXQdq@horms.kernel.org>
In-Reply-To: <aYoAMrEVDNydXQdq@horms.kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 9 Feb 2026 13:58:38 -0800
X-Gm-Features: AZwV_Qg03CbUZfZQjzZ0-zOyRKuF0TjPFhmb2Cnrm6DwBNFa_9HnPyaKTfrBqKo
Message-ID: <CADkSEUjdGka7vpZEKrF0a0R1S=S+bzjCpDRidF5d93_H7b2qtw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: fix support for
 2.5Mbit cards
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257991-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E3C9114F2E
X-Rspamd-Action: no action

Hi, Simon,

On Mon, Feb 9, 2026 at 7:41=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
> I do wonder if this should be targeted at net rather than net-next.
Should I send a new version redone against net, or will this be taken
care of by a maintainer?

Ethan

