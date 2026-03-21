Return-Path: <netdev+bounces-270238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kiTqHCrlvmmciQMAu9opvQ
	(envelope-from <netdev+bounces-270238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:36:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103812E6CE5
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A9C73007483
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABA33BBA7;
	Sat, 21 Mar 2026 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1x1Youb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9925CC74
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118181; cv=pass; b=PpHYayKiX2CQX6Jonn5O+PTZ+YGMkjsPOxCn/KFCWELvIpPe/HsbyMtWjWIFQrYrUf6x6+boWZ400IK+/8wSfOIVBAaPVY5rZO04Ek5mSJ2Ozx7rdyHaHZ4eMr0BJ5tfcvSSZwDAX/fB0Wvgc2+3FGKwT3ohlndRnhOKBLxgTCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118181; c=relaxed/simple;
	bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzOock6r1XfMc2Z/dPacBmIpZpdgAm9b4Ylzj7yOTOm35NRQfzTZbgqU1zBYOyh3WoKbF6O1MYZEwquW2MWg1oimbDW2GeySTQJaDc+b03joK9cqGYWPAc1hA71uQ1qbvETU5j0x2LotZyuwUsbBK2s4Tfl6WEcAWW+DB9Qx58g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1x1Youb; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64e9f9226a7so2507010d50.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 11:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774118179; cv=none;
        d=google.com; s=arc-20240605;
        b=Hz4gghpRxeoM9THIoW2CGfG/qJnOkgEbYXh3Pr0IxCsbNJizy09mjbBu4gNX7vVbHE
         sgh8Agw8fOpwR+heBbf3AD5ble5MNF5emEHY5yc+yvjldZnrUsG7Jull9CCeouWBpQuq
         zGVHsKL3l/mSpLbSsWDkjLQCZtN3jyrPXW+1EK0PIdY3YxmJJgVvTWRR6NEMYCOPLvt3
         LwWCcM8SjwcDGErFA/RcO5uIq0lkcYyylK3hoR27/AucdOrcgRBOljCwrK4dVay+v7xa
         X60oB+0lhagcXZQY8pGYzddJ2IGCtIdzOlneyFGr2AB7bAx6X35ceX9iRVl4Dj9kC5U6
         TFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        fh=weaC6FihwEfIliAQzy0rq1iSHJ8m3f25eXNyMD+HZwg=;
        b=IOZz1/aN7nl/WCmArhFHNO4mdOF9T679phrk70PDx61b6OzPJcYqgJBWNn5v+9v+Jv
         V7RK62qOV3B/DUHqotaZO1ZPMYMlEgGdEZXOUlbK9Y6QuG76eB37xSAJ0QZI/HbtjpCU
         bMY2g5+2Y8ddNIzIcnPnbMMpPYfEzzliaYiG80O42fYShgms8cowjwsNBEsFR3G3f+An
         jdo2vzJmUWzJrougrTPsfLzQXkBBpGKcB5H16BDIHj6F6j7fbQJ3ok1vJ6t0OUQOgEFp
         QDgRtut4ELH2UxCz9gZsXTdgcE59N23GopHllHQbSDCbJaN+PfZp8gwopeBpsiQ/new6
         B9LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774118179; x=1774722979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        b=a1x1YouboCSOvm/kS8mbf/ihOBW0gbIJuaLoU8POQYEMT9VdQIompT5NnPxpNLVm+M
         k3R8Z+DJxv0Nw8sxuPp6Gjlka/Y4Msu86f3OejokTfKTOmkHl7ZGDUpUMZlR2Avb5PTr
         Q0xUyAgqAhlRXYBIz5fkgCuafPXuSZjPuvEkAr6kHHT7gNQsCjY5exyGbD4a4oz8g/3a
         FFOLy0ZSZxvbtnpmAvXffi4RjRV3SHjq8AyzN4ZQzY5WaE0hUrJvdm1EbB9zu3QXuO4G
         8FpHIVuQshgUzAYSlGxUA6+ornAkGkFtEYlwPMNkp3KpwFdvvkw5udmjoABY86ngsrRN
         Tw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774118179; x=1774722979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E73mJLbVj0JbkSUviEdOjxdJyafwNzdmTlBRvW6WZ14=;
        b=rRu+xLsxh6EsFgTRL2cRXR+zhB2CBkOoe7ZS4ExlHzFcbl5kuRBeFMViOdPmn85VVx
         T/sv4No0a9kxiulw2WNCs/Lru/bEpyu8l5RMULXeiDNeoBL2T5ebgTad/fQJlEFK5EZ+
         s5/6ZK98/bKMjcL4jl8dEO0lzspAV/tq/EKn2JEwMXbu3SlNtbxtXfEOaUyRb3Whz9k8
         PuQlWqKWHLv7KoGP7ZE8lc2Fp4c6zZAP1FDFfT+06bqK4VwOreSvwyyy9KRmlT8H44Xi
         5757mepyPO0QmOezhYmqAEQlLXzNq3emyncXwhb5Hg7s3w7GseCNoG8wnL5EBWt53n5m
         w29w==
X-Forwarded-Encrypted: i=1; AJvYcCVvxbyEWYnIbA9u1muVYNxE4LZxjdKfIn6Hhf6CKtt2wMiA51C9XIO7incXPeJ5XKiYtgxVk+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySi8ql+zXwXtd33Ff7PXKQ2QJ3ESFfSFDcx3s7qi7PJC/5luFI
	8hpNdKOhLcNhcGRmVwNcIfJJSqML+qkuSERkrIKWvO036VOFWeBfubUqjU2wuN9dqLd4PcJLNJR
	DYeLLV7XGMot/UpxS1E3aglhzahX1OzE=
X-Gm-Gg: ATEYQzxkMW+Mh6R1A2J7BXYMJV+AUW2iYbNNxBKf/r+eSuq3p4Yqo9sUhYiAvEKRXSb
	JuUvhrVqDQmFxclE9SMNp/zS+7ppZ2Va7LJUcVhC8w2ffxMjvOBlmj9ihvH96vickjQrFGEOlaL
	vQfylwcFsCjneNptcE2UBtNJNsgL37Xisg8oRGeBDzC+VthzYVJrpP7Qc8A9q6xB8c6SQcI5hvZ
	rR/MW86+Umf8YHDaNjUIlZX5I2DT1H/ivKdLYdaFa9ZhfAiPov3TSo9ePo8Wgj8DA298+cRk8WC
	VAo1PUcVL5ES/rahYF8KMCpNUMmpwVmFqJDoJ2r/ILHdrijUt+EnCMbB0GDldViVzogn/g==
X-Received: by 2002:a05:690e:e17:b0:649:e501:21af with SMTP id
 956f58d0204a3-64eaa6a23e8mr5995453d50.14.1774118179320; Sat, 21 Mar 2026
 11:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <20260320175220.47147285@kernel.org>
In-Reply-To: <20260320175220.47147285@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 21 Mar 2026 14:36:07 -0400
X-Gm-Features: AaiRm50g7uMS86-n9jkJ6Q519tiQJjDz5q1yhkXXjsoHNxncFtVOJQmEad9viRw
Message-ID: <CABBYNZ+Tk+in8tLVQ7qXQXZjVYLRt3bstvSLPHh6Y9bBb2Dg-w@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270238-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 103812E6CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On Fri, Mar 20, 2026 at 8:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 20 Mar 2026 14:02:34 -0400 Luiz Augusto von Dentz wrote:
> > Afaik, it was tagged as regression on March 1st afaik, according to
> > [2]; traces were only provided on March 15th, so yeah it was fixed
> > within a week once the necessary traces were supplied.
>
> Hi Luiz, I don't really care about the complaint, just wanted to check
> whether you know that we always send the PR on Thu (either AM or PM
> depending on which maintainer is handling it)? If you do then nothing
> to see here, we are all doing our best. But if it's not crystal clear
> I should probably ping all sub-trees to remind folks.

Sure thing, normally I would have send it sooner but I did want to
make sure the regression fix was included, I will put a reminder to
send the PR by Wednesday to make sure that git to you ahead of time.

--=20
Luiz Augusto von Dentz

