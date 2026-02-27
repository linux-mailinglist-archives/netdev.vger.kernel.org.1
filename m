Return-Path: <netdev+bounces-261735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EyNOwxEoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:13:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A461B3AC4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D42B3027DAC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A137106D;
	Fri, 27 Feb 2026 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFSHwMG1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6D334C14
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176392; cv=pass; b=klI5LlbfnSmwHOOBmy8KA7jvzGKZ8BLzi6Kri+jB9zn4/InUt5+GEYsOCw0vLujDcnNiCmB4XfwFP3t/Yt7lRkSVx/nwwqh7MvTPOVYw6+oO7zO0mxpA3bU2ccNbJE7/Y/fHIrn3RkvuZ4iB4EEUsg3Xv9KyX8MlY4DuIOfMJHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176392; c=relaxed/simple;
	bh=SR/JluC8J7ZCDXxmWSfd3WPNhXumoMmMVukvPS59SxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8Xaqy34ZmAeNB6L3vLeI8mfjVhcm8ZzvASIhbbMtZ/FEa0z2RtpQBo5HoAeWG5fkSiX1FccQwkhkW0oVZsApWEK9plWqic0hgLKVh89Zyn2DEFhMEfqO/nKSutqR6LwP85a2YI/V19Cn2vxVV7x9Z/t1uAvkVnrKoJ3Uw9rdVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFSHwMG1; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-389ff3f41f8so7728771fa.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:13:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772176390; cv=none;
        d=google.com; s=arc-20240605;
        b=cOBxVFzcnNICj20TE2vcQnR4r93y9gTdXLsEGKcNEU7h29lHvwSI/ET71lM8647c7D
         xHS9flV588asCjFiuagLWmZFuGB3ST93UzRIajGY/OGd+XO/I5/9wtCCnr/IO0bXMn1h
         LFXimE94+JC4UyuZn/iMpt2I+UeeHx3WU0S9+9Ous9SI2d4nIkk2QZxniPeN7Vl769b2
         OdmurMNaoBnCLdBUyIguba2zGLGElsQYHmrCm5uA6e+sV/nkRNDZFnuFX/5Im7vL6xQy
         4peLRqEsklNJq1B1l8/0acYIfxUBzNFA9R9YJWIFKegoC0yAyxmCEpXvdc8VOOh4N0lH
         03PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SR/JluC8J7ZCDXxmWSfd3WPNhXumoMmMVukvPS59SxI=;
        fh=V4XDuqj/LgU+a79IClfMnstR0DaHQPZcFsNgx+j7u2o=;
        b=MZg4UGFvNhftlplEcsU+hfd26WWmYKv5rGRq3/Lu0jNZ+iNCExKNtRkbnha+LVsAiR
         atRy2pWF0A0jVhKmB9wBbEhaFMhGYiikje4jEnJnnaOvrAZT6WdqILKm68njmzatxIxB
         1W+OvIzm3Wi8JMFUrtKQ5Z6ILIrBuvGyW21XiLNu+xBm5sqC/zEGHf4/nyAOUr+OMi+U
         SWwkbSuDTuj/zpH6uyNELfZJdZUQVnpDLtkehayclmzapu77MC0XGGl2DcxJ5bVF8LmD
         JsliXTWbCwa4dQeYavrME1+LHEQobfoxgQqZM3c9HaPO9ti20Kdx49R3AY+7urRssbw6
         xAAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772176390; x=1772781190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR/JluC8J7ZCDXxmWSfd3WPNhXumoMmMVukvPS59SxI=;
        b=bFSHwMG1KK2nofyGw5JNGQxxQ/G6TN8eKXDju5Ou14TYD6vZRQ6LHDBxVc9Cv+OWel
         D+bC1HgisGcjwH6wuSZM6FgHuKQUvnZJECrD1iY8IHjtNAep+d4/Bqt420EZ/VCES1kg
         amGshGWWCZrNOI77TEuIkKrEHext4ZJhyc04+rW/JVVLo2TTWi4Mj9tYiYElJXeNYXDH
         dTqOz6AUaauhmDNHRPtbYc6+GBN6vPN+BaODdzDabZU7KNwhLlvGuUoohx36OcaQObav
         G/dtZJzc3OJSDRRv500euoJHAyygSVx60jZ/Re0zQOpJHmqOyXdjNxUiHsP9f7f+hNpS
         fNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176390; x=1772781190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR/JluC8J7ZCDXxmWSfd3WPNhXumoMmMVukvPS59SxI=;
        b=bn7elVBikvPMrxXBeYcMdshFF6kDthbkOk9X8ZxSwNroaHlduWllrZUSyC8bl94UyA
         QruJ4zLIN2A83uaGtRmgCgNEOYCUhrdLR7+/c4QTf+6zZyWIzGQbSj9rwgQhMxYgW0Uw
         JUovG2nQ4FZe3GCHB0hDbZph2fHsPCStQJOzuCtiIReWXNEl20nVbMoKKDo+wwVZqIju
         /ZZIokXP+CfVA1u9vHUAcDPfOjkFM6UbckhtsyGY+BZVB806wXzCpkUlmp9g44Jfuxfx
         gJtCn8Q9+YHmhtAdlHM7Sbtks1yJ1DC2cQ8YUzHDJuksDTbwsP4OlwW2t44HppE4FN5t
         FFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQl3YKh0FuhdwE0xyf33aQXZHfbV8rofuzVt5r7snIyZotCgcHBBrjvGsP5/ZRHFCXFXjbG3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wWkVbpmEeXrIzXeqZOB7C1mPtxz/+5qav8C3+3oqA/UWHx0Q
	W41gFZV9SveXpcRxOMnfY7dOZsL/9H6W36JvkGL0zkmewH7pMnq8P2IyrU7d1hk+M/C8Y4/J8dY
	zX/qvyedYQQMKkHXHfqmGMAdPMPGUkdk=
X-Gm-Gg: ATEYQzwK7rheQdT4/jb2NIBhpIb3V1kATKSpv3xMnhEJmTAQaxQhcVS/aMuf87URjn0
	w9Gsa46Jeqo8RF+ocikuLeqL0KOu0U4CTyuU2U0ZnnJBYws1HzhtyR2ZcQjGj1sfm+HT1vbBooM
	ra47H0blz633iDHQaFA6Big3F9dzvSd/mBdYOzMnBwKuz6HrfkamC1N401iJ0tHCcISy74OsF3Q
	/tw1IDfauWI+JeuTQgu1XQjXNqTFZc6FW/hz0lTtcaauhSYmh2BGZ/Z15IoME1vvdEL0WFSaFpS
	JVFHXtyRe0HAwvEwsR/CKsw6TpDAGp0S556iWU1KG0Ngw9j9tDe5Uh5eRnl6IYWuElHzOwTcARH
	U46HJNZzDiNvx0aHKkrh5CmIKQizLnqhNI8WSrw==
X-Received: by 2002:a05:651c:4108:b0:387:6d8:8d61 with SMTP id
 38308e7fff4ca-389ff136a1emr7706981fa.10.1772176389390; Thu, 26 Feb 2026
 23:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226111721.25454-1-yuuchihsu@gmail.com> <20260226171401.7461b9da@kernel.org>
In-Reply-To: <20260226171401.7461b9da@kernel.org>
From: Sam Su <yuuchihsu@gmail.com>
Date: Fri, 27 Feb 2026 15:12:58 +0800
X-Gm-Features: AaiRm51KmbDywbvnGCMuI-OEwTFm7sEujKELuXZNIkIKm0lI0JiZrT3nt3bzA3I
Message-ID: <CAPAzCqE3k9PehK9gec7pcfq-Tnjsx-reD63GUaO+MEnP8LZ0Vg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuuchihsu@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 69A461B3AC4
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> =E6=96=BC 2026=E5=B9=B42=E6=9C=8827=E6=97=
=A5=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=889:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 26 Feb 2026 19:17:21 +0800 Yung Chih Su wrote:
> > Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a sy=
sctl to set multipath hash seed")
>
> Please use the traditional abbreviated format of the Fixes tag

Hi Jakub,

Got it, my apologies for the formatting mistake.
I will format it strictly as 12-char abbreviated without brackets in
the upcoming v2 patch:
Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash seed")

I am currently preparing the v2 patch which will also include Eric
Dumazet's suggestion regarding the WRITE_ONCE() and READ_ONCE() on the
sysctl read/write side.
 I will send out the v2 after my local testing is done.

Thanks for the review!

Best regards,
Yung Chih

