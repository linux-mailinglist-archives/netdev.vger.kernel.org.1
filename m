Return-Path: <netdev+bounces-269649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOBYGaRivGmLxwIAu9opvQ
	(envelope-from <netdev+bounces-269649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:55:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354F2D26B3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4E63125865
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536E3F87EA;
	Thu, 19 Mar 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stz/sQzy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493D3ACF06
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953628; cv=pass; b=muPuIQdXW2LQ0a00O9XpNdhKn2yTliX9niQ02hOgmZTWSYbO9NQjXZ24djgieSXi18e68Ba4ZdRVkwEjPW5sbXlkyOS8qOKOTbs4QxWG9ifyLKSvOVwqI+EpSLgHCCT1Fm4ibgBBoxdfPeqbDkfmt8yP9ynlbIVNVYTM809p07A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953628; c=relaxed/simple;
	bh=Aa/68TobMq2WA7MnUgvvLadAtMm6UrCQIVjbgTR4Ayc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdqyIUQB7QyJl87npcAyNAEGpZGysZaoOESBMFJOZSvArMgc/MS/hXJojyZ7iBJDDmv7xTqiAM2PpWzmXNEc41b20F6jafumrfM5W6F+xZEEGvFptEzriRugerc+aCgxnaDyGqCsTU+loNRCsfgenFLEAK4Vg3FuFmgc/n3E3lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stz/sQzy; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so684759c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773953627; cv=none;
        d=google.com; s=arc-20240605;
        b=g/xhuDVhXauZBD/xWHoD/SB2l900yiuJefu41BWcsIV0rXSreKxlpCHbCWNY0Iuja+
         eDB26kr6u2+gneE78bUNYkt9pPN/CFOZMVX9CMWY9yxjz6RDfEnzaFf8D+djiXQvSNaZ
         eVP+NAtV1pxDxaUnQ5DX4IkEisuLrqUPpuoKiP+UmsafjsL25YQO/t9INbmUpVDOX3k2
         8OkbZadddOke9r6suazISqrxnw+E8Gzayg0/UIY4J8QE5k945JTI3qh/N/K4XjF1f5la
         7onqELen5IQd4yUB+HHIZgfTw5x2MQyB6B1HI/0mCS+TZjj3DWaX4b0pSsnrIIrCgiAi
         i5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Aa/68TobMq2WA7MnUgvvLadAtMm6UrCQIVjbgTR4Ayc=;
        fh=5nZgokyJ/IJeM7uNUaw2pe6wt9zOsqolU+vcKu9UYjs=;
        b=IIl3QiE0yoAjk/J6U1x94d6T61FvEO/I2sVUJyiHOxmlDsv9z6+StrZWTrHi09pOHt
         qmmsDUW0QANKKmFpsUpCVpc2rxaLhBzU3grwwTLTaBZQhfo/He+/cmiPWjh6etZD5UZ+
         TB2vDrPYyelQOsG5u+6Mfa+B3KTU6lbvp/9A+v8qmd07Q0C2OoX7gue/gfh6+PiKckRo
         IsHgQjMAspaGewK89OJIe4cE9MmQrJSVpGJbFZZ4oNrJfsH85OdqfmCuR/rhX48JmVhi
         vzJQyIios7kgIxu0dSizuxEpbxZJcgt+Ly1ggaZpbXAhDOirbOKjgUVxBGR8woo6fp/p
         rnQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773953627; x=1774558427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa/68TobMq2WA7MnUgvvLadAtMm6UrCQIVjbgTR4Ayc=;
        b=Stz/sQzyMZ/kJJjTPhp3BWS0U2Ya08l5PyJBuBtdcbg9sKql3eghZTlFKSmAov5LUo
         Nd94uiNXwqPJ3Ys/ciUHsKiDxrjv3vIZacMJPSwiHoiYUYtrAvsLkpmJxUEQWJuJJZHQ
         mhTVh3Tb7hVqD77nyclc2bjnuIa6XVGzWSc6RKP+TEPFF4718llWZTvTugY0nXAbeayh
         HDOPTRYhCwW3rkVvhAWC/AX3XUPdbBfWcZW14AOv/KrZE5HNR4sH1LbNRbufL822Lqu8
         6R9E+rV1BXzo8VuM8BgD5OeUt1XXnmACAwVjBZ6aWqEWhZfy9VCh1yunBnJnCAYcJlI2
         rvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773953627; x=1774558427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa/68TobMq2WA7MnUgvvLadAtMm6UrCQIVjbgTR4Ayc=;
        b=m0DJjrSwegk2F/ojjiz67rpCWO0WXNIw7V+HMbeCw/yvKGfHM8WnWTMAW2LiCrDtsP
         /FKGAMcNs5k7HrvPvcX69DufG7tZw4y83o17MKTlCL6Q8EdkKJ4sI8H16MF+x49geEMf
         tg8yJCMdZT2S227vfvt2udSjZurtRY9MnPle2ArdzEuyBvbiurpnds+D8roDbkrGsJm9
         akXmNgK+joP/0bHZ5uijw14eqL/QRjf7ASpaxk81XZMLV0ZL8Oq/k+LUE3Ye3taVYZ2Q
         AOvpUcx9PQQgCoznECB9wbWrk8gcev3y9ttD5m6wM5VYxcMC02EbZf1ltHL5aryIWS2P
         UxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4sCGUxe1zEdQhLkUYOia/tKuzYkyDz2Tw2PeWKORRZM6UsSsRbdEHYLdvPK5VlY7dcij6/S4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThXsS3/3kuc1mZ3wJStt30z++ylE1GOYjKphN+jW7hpzb+9z+
	4AV5b5lK8jGzofDPqcdls5RAgHvidvDoyJYcFumk1UMQG+HJs07EI7Hz2GkS6w8lvnZUciDOLon
	YjxaoKnm8sbqjqi+Z780QrZiKnxQr8A4=
X-Gm-Gg: ATEYQzxOcsmeSSasbl60HVpF9SV37G3ntPrkzT7nUH0k/9mvbWsX+fWck0ffjmyZ5xo
	R5rKBODpGBeDLH8drO8Kkspk5TY5msgXPHPtQu/eBJ5v6ywOBtJqGJwnLcdMQZ558Gg4ZAa3vHh
	T6BLy8rQ2kNSAD0QN/BTzZANrHj5ka4L8nznC1F4rxQbtIZU4euODsjBLX2Zy4B3dBUVUCO8tPy
	dzKP+3B4DwD4mh1NyeGQNWHYRpx5vHQzt8fqlaeyHZ1udyBe/l3thpv7elomvjggexzvVwzo/Cn
	WhRhj01sx5dRuX3YH35LluUzpfbye1fRuCEiO+ey
X-Received: by 2002:a05:7022:31a:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-12a726cf881mr297346c88.31.1773953626588; Thu, 19 Mar 2026
 13:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317065137.1533226-1-atwellwea@gmail.com> <20260317065137.1533226-2-atwellwea@gmail.com>
 <d0ab8cc8-f734-47d4-b402-9c62ae563b4a@redhat.com> <CADVnQy=raqQ2dKwJZh2U-9=c_AEwoCS3i61oL7gUSASxBC1QVg@mail.gmail.com>
In-Reply-To: <CADVnQy=raqQ2dKwJZh2U-9=c_AEwoCS3i61oL7gUSASxBC1QVg@mail.gmail.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Thu, 19 Mar 2026 14:53:35 -0600
X-Gm-Features: AaiRm53MHPLs7H-KjOdESA5PQ4FyJgygf7eKubpjzFr5N2ck-0wezWHyRIsyhlo
Message-ID: <CAN=sVvycH50ZOQDb=xeW3iWG7cWO02yvd-wJ4NhbaUFHnqJ0Ag@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
To: Neal Cardwell <ncardwell@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269649-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.902];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1354F2D26B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks,

Paolo and Neal. My intent here was just to keep the test focused
on OOO SACK state and `tcpi_rcv_mss`. I appreciate the feedback.

V/R,
Wesley Atwell

