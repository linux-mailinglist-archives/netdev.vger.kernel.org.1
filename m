Return-Path: <netdev+bounces-268374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIfMM3upuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:08:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CE2A274B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2315430037D0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982901D9A66;
	Tue, 17 Mar 2026 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hCXSNvSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886015E5DC
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709493; cv=pass; b=rgVbFIyXv8NUnBk/1wRBencLAnDqgpqdTt+waYgp51G+b/NDHG2Jd6w2k1+aqNHsG9Lv/FOeFnWt21vnpbIT8szqLwfhIEObhz62bbNlFUiAHvpNpxLZplMqGecakyh6RbBhxDRq/0PhAGTQUSNtp/MkzOGMonSzRjjZ1mRBQEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709493; c=relaxed/simple;
	bh=3QQuriUMKOFZiTZ7e1TDuPKgexyOHoEzA7Pf6tSKsLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDPtF83gjXA7BB+p4lbeR82uO74kiThmo3Qsu9ixNtTqqXsV1r94aPQZzR3bbW10+m749C7Z0qh2Ez9ukSaYFmlj3F8A8+g7aIWTpGwc+kmm58LP+3uuyj7+YnAY86VCzv3CsAm3Xo0cN8Jl8ur2xIp+HEZNLAdLw/lO+3llcQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hCXSNvSK; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2795570a91.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773709492; cv=none;
        d=google.com; s=arc-20240605;
        b=csVIo0J/Uj+6rhLwZSWogY48+09YqT14VKGFaQ3VUBtn8P+5kEqot17/y7m7in5nTj
         o1h/m7MgEbLNAN5HpgxyWsEL3oyAqz6LkcJK0gj10MI1U1aIkPLH//HzaYnj8Hgy4uXY
         NCcgUGoPye1AWOV46UFlSqGtzIiiBQS/AV2tiVew3dXghLHAY4xFxxW5pt2wC467NBuZ
         4/+5T7Vt81J/pwjCyRPIYThkWCvbY/Yv1QX1XpDz/9wJYqY2p6YAJ9wWdYK/5CpesCO6
         QHsEpa4Jbyspmprg1O42L8fY0GQ1zH97irF0YUwEDSZifrDsX8t04oDIMnioRMa9FqWt
         0ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b418JXdHc8qVVvSpHio26SJxrGpNKFVSesBBMraaWqY=;
        fh=AId4PelU5MjJJdrMez/eTWorM3OWrvPnv6MjfEWKW14=;
        b=Y0/Za+UJc8QZhq+8nmsZ9EgR63jFUiHr906WIXcpg7ksOGC5Yl6Py7xg4LU+lChLOF
         zY9NGf78J89Fac9cOf6+lrld1pNzNhOgG53dmXwqbt0Z72jl7RJ6millR6m0OF+a67jv
         rwdX/B1rIZXN/TzTjDNTG8EQabSmFa/xiJjd2qYGgAq9NJMZ04oIryoesiynkR2CSz2z
         EgD/Ub3jVHGJEzS3w5o/3aJLw3ra3Mcxpvje3VebCTXXZ1Pyu2puM0GGfVAhBS9wDeV3
         z0/3O62+NCE9kIsgsh30KNPA7jOSELaJ7AQIjb0//zqjfY3xl3CwXSfSe6SaLqTQEvjN
         HSKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1773709492; x=1774314292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b418JXdHc8qVVvSpHio26SJxrGpNKFVSesBBMraaWqY=;
        b=hCXSNvSKJ6nUL9tAA+ecO3ybWqxqQnXwneB5gP4JHDeBPXa6Xk3a3skrMt+NQ0TBv6
         eTN8C2z7LqQ9pNSgjEdN4lpYcLkzw3FUu8D6hv4SdYmtW2f2JXp8tA946rEjia+OIKT0
         pGDAcmijNmdO3vRvDNUr5lpm9q6Ij6Al27O1l3aiq1yjUW3gB7fGyxD8/ABlhCs3tVq1
         hRBmH1hR5jj1Pm9vpZI2njLAlLeeyGANVu1UZnC2y1C5l5MhvEbDXOQQpbM8x3+yn4B2
         kfrHsDneg4qszr35ywp9wWlw+ys1oHHvZooSSUwudLRzxYF/RrrstcibyXEto5rNB0zE
         VUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709492; x=1774314292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b418JXdHc8qVVvSpHio26SJxrGpNKFVSesBBMraaWqY=;
        b=SJwFCuBb8gD368KjR+U7xaPHn3tQadU7dO62/RrdopdqPWpTtQsfMdyjcCgfOdZw5O
         IbKZTUpao1smeHIW2BN+U59nEC5gbhn9H0uc8SWAt4yQunnkc1iOw+y+y4fPUZGWMJpT
         YEvdQmOZtqTvnNNnL6dUQEmOLYZ6t5AadNbHCgh3WHHWHPjFAQjYj7V4Wp4GaOKC4oeZ
         TJDLrlgriROmVzdw2u26Yqb+HB8IdFaadWhQfDKeJKgACpeXfEtXLZ6et8uXprST69K0
         7wphYxFHMoWTahyC9xAH5ji6C4UFZys3SHKcJXHW8Gh7wr3OIo1CMsQoEiisZ6bpllwJ
         iATA==
X-Gm-Message-State: AOJu0YwxkmzpZ9+M3BpDYdUA6Kh0LXCb+a4fOFfoKtSmGHl4OkjrBzid
	yAw55MnHALc9A+G0HMUBn9MDk/SdXdFNdG8T8w2EKdgCAxBM+TU230A0voWK2uxC8Px8EiAlMIi
	hte5AocL7giZr+XpSZwVcbaMzD5FzGDo6nDx7uMb1
X-Gm-Gg: ATEYQzwliwMCeckcBbR+ujTJv+bkFYNqO7FRldflAYD5ORYu84KoifC/gzbIf6VV5mK
	YC0wqO6r4PvhT/IiEIMgaY9Hj8/KNSmSoMDmCGClWv27AkmM5JgHOEGs2rTpViupVxRF0UqftbW
	7HxViDIPGgw7HSjDNGWBW3OlM/7V/YuUCMFHyTdLWfYdOGBvRoyd0LSzrWDRmbKQgu+x2GE1ymz
	HcX6EOfi6trLg1hkfWAz8vOBoA1V2XFP1CChm5fnplapDNQNd2giNZhWO43s/xy5wvEwChT+Frt
	QpcYcC04Ej1wt+p3AS0=
X-Received: by 2002:a17:90b:5390:b0:35b:9777:8bb1 with SMTP id
 98e67ed59e1d1-35b97778e2cmr6160603a91.19.1773709491701; Mon, 16 Mar 2026
 18:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316005337.1147633-1-xmei5@asu.edu> <20260316170609.6636d621@kernel.org>
In-Reply-To: <20260316170609.6636d621@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 16 Mar 2026 18:04:39 -0700
X-Gm-Features: AaiRm53HUSfx_kbwBByrBwqllJ4HKO-cw5g8iKZ-oa-2AJVxEd3cNUrY7CwGVGY
Message-ID: <CAPpSM+TbW4S7ZGoiXAb6tbunPm3QDmiM7ZmDp7vV_BAP9xZOzg@mail.gmail.com>
Subject: Re: [PATCH net] udp_tunnel: fix NULL deref caused by udp_sock_create6
 when CONFIG_IPV6=n
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268374-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url]
X-Rspamd-Queue-Id: 317CE2A274B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the tips. V2 was sent with a better crash dump.


On Mon, Mar 16, 2026 at 5:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 15 Mar 2026 17:53:37 -0700 Xiang Mei wrote:
> > When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
> > (success) without actually creating a socket. Callers such as
> > fou_create() then proceed to dereference the uninitialized socket
> > pointer, resulting in a NULL pointer dereference.
> >
> > Return -EPFNOSUPPORT instead, so callers correctly take their error
> > paths. There is only one caller of the vulnerable function and only
> > privileged users can trigger it.
> >
> > The captured NULL deref crash:
> > [    0.489638] BUG: kernel NULL pointer dereference, address: 000000000=
0000018
> > [    0.489962] #PF: supervisor read access in kernel mode
> > [    0.490193] #PF: error_code(0x0000) - not-present page
> > [    0.490435] PGD 102a11067 P4D 102a11067 PUD 102a12067 PMD 0
> > [    0.490706] Oops: Oops: 0000 [#1] SMP NOPTI
> > [    0.490905] CPU: 0 UID: 0 PID: 140 Comm: exploit Not tainted 7.0.0-r=
c3+ #2 PREEMPTLAZY
> > [    0.491266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > [    0.491786] RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/i=
pv4/fou_core.c:764)
> > [    0.492009] Code: c5 48 85 c0 0f 84 04 02 00 00 48 8b 34 24 0f b7 44=
 24 1c 4c 8d 44 24 30 b9 07 00 00 00 0f b7 54 24 0c 4c 89 c7 48 89 6c 24 28=
 <4c> 8b 6e 18 66 89 45 0a 0f b6 44 24 10 66 89 55 0e 48 89 75 00 88
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
>
> Please trim the crash dump to what is relevant.
> --
> pw-bot: cr

