Return-Path: <netdev+bounces-268247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EveI1FKuGlTbgEAu9opvQ
	(envelope-from <netdev+bounces-268247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A622429EF8C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D32143050A29
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8B3DA7C4;
	Mon, 16 Mar 2026 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgxaMzVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C73DA5CA
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685276; cv=pass; b=VHyzyvnUlZU4lcpvQR7ZE8cmZROhYeSz2IAYYU/N5jxqhMEcHqMpvMBG+mqjghC2sW+V9iOPpyT0hTY9k6ybNXJhQwGROG4OYrlpwH28t6VaIjR5uzoaPN4UZVrqWd55Bd5bXEBZhlzP+0p4T+8AMLebxwzlaOYI2e4Zd80p0/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685276; c=relaxed/simple;
	bh=1WGZaRegkTbu0RNsDZ9nemDUYNIx1H8x+OQUag52hqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYu4W9L56Qd2yaLrJtjSom3i2pqEs3Z6o6p161v3VeVYALu6w9YZwkvcqpFbM01Vz4ysxyNuULo1LQbeuRRyi2VA9/yfIWQNyERw6B3vWvCTSme0G33XHE1La0GzkAPJPJbNVmrgHc6zyfNxPAMAPomo96U4ESW+vGI/cBMPeiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgxaMzVl; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-67baea690b3so657087eaf.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773685265; cv=none;
        d=google.com; s=arc-20240605;
        b=AOKXPUHM6nSA8GEoJtw7oRCA0AvLiQkJJOJeZGkudd2jkBs7//kYTjJpgvIVK4p9/b
         y2pCrIxNGXGSQWSETFxfrkqO4Hu+0kdKM+m16Aq7/2VOvEmM8W1F4RoF1/7cSC8TtbtG
         2xrLqCXiILif3lSrUXfGgsipAOW60ugQXFJNEtyITgOjr6GT+l7qkfsBah+hAyD9AG9j
         YNiuPqKEkctt62jYA9CxvmpB4/9cev0RAUA2Ej+ueLasXGPFUA5ANECeM1b4i1CB3Kzk
         OmUyombPFD00oQnhPPk//QAb4Y3QaBHw5lYmXi+WHBw+GzXXHju4jO1p422BtZCQqGiB
         THuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrRqGFR7LSpD3RcUmAhH7YzL19Oke7FUmWQwnuf/vmo=;
        fh=m+MlybpBgAvXRatjRUI4/rwZ0BxaHes2eWqCG1qWzds=;
        b=N/xKRsq28cXIMC+f7/zTNawiRPLAJdtwN5QOPnIAp0MTouV4icbRDNxxttUaRbX5Kf
         qdAxq+JAmS+9JsxzAEpGE8UnH8eI7V1L6YcFbIOwcPjED314aBHUnUCyKcSO6DK8QAmV
         ysTyfaClaB91NUjd/tu6MdhS8LQzUFzwVeOU1Nd4OM7oO3frRwvk7sTBLoW+uaam5aIF
         l+/lyY/O/DoqluNFLT0cOtc6XuMyvSJISx627RP17nlqD1jqFgy6VnMi2Ip1gM3PGrlE
         uJUSVrKiYm9QoNb7NhaUmnEYnvVRIh+ts2yJE0R3fuCna1h2xFP2/KNma3uhEo95vcZ9
         adrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773685265; x=1774290065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrRqGFR7LSpD3RcUmAhH7YzL19Oke7FUmWQwnuf/vmo=;
        b=VgxaMzVljNeDei9cy80ktZaIxif82GlLAzAXHqIKsN3pTjORSXf1GblEfulB91B7+V
         bhUsDV1v6ETZuON+OM2NW/xSm9stHSxCL11EiIFhDabEP+ia78oYoHRyBEQZGlkgmxje
         DcLzqmktglXOhfRuXS71pCdzoazLcJXetL0MDF+o2mG5ClU3aVcmvo2SbXlN4wQ+2/lY
         s5UTZQk1Fddp1apaCICI6aKFT4KwlNfICKyeaKtndnYDqS7C6YTfHO+PKF3C4P4xOm+2
         nZzkH2ojc02mdQWEmuDOgq6XiDx2ItLuuaT6H/JIxyER9QVkIUp3U9WwBNW3s0Duzyhm
         azNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685265; x=1774290065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrRqGFR7LSpD3RcUmAhH7YzL19Oke7FUmWQwnuf/vmo=;
        b=oUF8ykmXAfuWdGqVT5MpmMnH5hYN7fff9NLXdvCFCMZeVeVIzBKkaLZbQhaAFQ95O/
         JxN9LZlhfd2b6IBQIApPjGObjyEcaM9jx9cuqyV6GGijgRl0e9kIZZvFl1LImpUpE8b7
         dAzgbYMyYNvUVyHFLu2cMvlxXbKk1rdWW/wQaDbkeOID5ehOdhzKUj4zdpIsD86hs3+Z
         62P/bKryFKN+SnUinR9xnejNQZ/87DY43iDqa3PqT5nSn3vQZq6ywuY3F+QG67J0JEPK
         +fLcKiW/Ityc4XzrYXE6VV6iFi7MkUsHfa2OIN8U6jzny14Hf2ojUmaZHgeyy1PQURKS
         7WTw==
X-Gm-Message-State: AOJu0YzN+I2ygWuukSsKJ71wveAClIn8z475zYgzg5mJwdBA+O/fBWuy
	OjjEnZ4gZNaKC0Z8Jqs5Q0DCTSjit5UkO1UgA0f6sJxJKQP4mXEWvKZqvaGVM397o5A6ZXS8DTE
	Nh5GHtjzYhuk8Ehfukl4hN+r6e5xF82U=
X-Gm-Gg: ATEYQzybiyfCHPmJt3IvrFubsYF0fyzbOoWRjmd4WEEX+WJuS54fgX8IK6bWcDaPaWP
	gxBdsuleIBQUwyGtcp1Vn/1Js83VyAocYVpdL7Ni6DvSsVOl/5QPRw0/27xKYM9F9tek2P1C/Kl
	xQhZC+qcxirb7XGvVp5BjkthudpqnfP9yQOxXfPQ/R2757viSFMVvEcDFLPAOltnnVU6HsadD26
	AB3fa42ztzygjiLsxorJb60tBHn9qRb3MoWCYeLV5tQD7d9JX1wG//C/a4hf0DhI0Yq1o1hs8fm
	H7y29KM41Y7DbaHgLNebjpo=
X-Received: by 2002:a05:6820:4df7:b0:67b:d8ff:1ac7 with SMTP id
 006d021491bc7-67bda97c830mr6666894eaf.1.1773685264651; Mon, 16 Mar 2026
 11:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313182804.696100-1-weibunny.kernel@gmail.com>
 <20260313182804.696100-4-weibunny.kernel@gmail.com> <258780b6-f0d1-4a96-87a8-f26cd4fe595d@gmail.com>
In-Reply-To: <258780b6-f0d1-4a96-87a8-f26cd4fe595d@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Mon, 16 Mar 2026 11:20:53 -0700
X-Gm-Features: AaiRm53X23O5KZet3VNvz5WWmBK5macK_KZv_M_Tg09AkLEEwR4dEggMtUIl-M4
Message-ID: <CAGqc4nVUXqp_GOaE9SEpZC9XrXGvr6Q6GMdaK_9QVj=9Djbc9g@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 3/5] psp: add a new netdev event for dev unregister
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268247-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A622429EF8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 8:58=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 3/13/26 2:28 PM, Wei Wang wrote:
> > +
> > +static void __exit psp_exit(void)
> > +{
> > +     genl_unregister_family(&psp_nl_family);
> > +     if (psp_notifier_registered)
> > +             unregister_netdevice_notifier(&psp_netdev_notifier);
> > +}
> > +
> >   subsys_initcall(psp_init);
> > +module_exit(psp_exit);
>
> INET_PSP is a bool Kconfig option, so psp_exit() is dead code.

Oh good point. Let me remove this. I will just not take the unregister
action given it is only registered upon first assoc-dev operation. Let
me know if you think otherwise.

