Return-Path: <netdev+bounces-259914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDQAGnydm2kk3gMAu9opvQ
	(envelope-from <netdev+bounces-259914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:21:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB14170EBD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621843017F97
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76719CC14;
	Mon, 23 Feb 2026 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5464s8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BC154425
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771806072; cv=pass; b=p52Ih37IMqTo/RNVA1GPNfd8xyzFfw+shHNqvE90H7kGwjCNIiWYJLqWKmBrwO2qxyHC6S36d75Ooa8SnbVwannSDTvASK130d58yjjaTM4zsxvj2vRRr6Z2jXksGFltZp6phgLUSP1wh7O4Hs622UCxsMlDkCay+3xWay3tnyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771806072; c=relaxed/simple;
	bh=IEOvYvGfZB3CDi2VByNJaYsAm02nat9TSRVG27Tm96Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6phvETZZdkD4WAByazR7mXTp0PoatqoehbvaZwTM8tlQBwhoDJ7SyXlCuHI5DpZAzol28HgTs2tvZsNoS8e8HLDz88Cvo1hKyYDCGTtGKXT1ljMimGYztQ8E1poV4Y7UxlKwK2TztZx0OcpsrklDPaiDp5VFdGLqPpu0sSH+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5464s8+; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e4993e00aso3907363e87.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 16:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771806068; cv=none;
        d=google.com; s=arc-20240605;
        b=AfDEiaDUsNvCYUYhRSv6h2tR7JEW4kJY2xJThArR3nJmres0v2lN3VMM9aRsgaPnDo
         22BbPwrFkh3FO9/C1k96+rl4v9bAD8fABfYN/7om3RZMT593yWhkWtlC/vHr6kwRxQqW
         Hpz1PcfIg2m5qa4BdQQZ4GuSowQaG/xuNDsfp9tOxw5+OwrrPWbAG7pLC7btMPzZBX10
         DpHonpMbNPjFL8rryKux5yvi6UgjeUnusWlBKCxMbsTl7vcy5QWaWXDG3TsVeia2ZSje
         bQZtLn0Q2/IxLic3OS1Im8SzV3+bg07h8wpWNW/rVg/dLmX4GpRTHQAwY/KEltPRsHeJ
         R77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oxA4T3zQI9a8QxuaiFhMP5c4MzyWzmqGAzfqJe57/ac=;
        fh=JMB8IKbAFaonXyxNJj4R1l6G9j8SsDOe4nbhhObNHGk=;
        b=gBWg64HZlab6DdGAXWEqjQRxqjuSOEeJK0A/tmUDKJvKqoSG9c6glD8T2nxKA9yQui
         L2kGX94VZijOtTQfKliMxb/MjjvjfLOKjfp8Mj/yWo14pf5XL66Xm1Xj4LS/02k+ue5H
         GUEtvoGmxkBf8DSsIWjZeYnBr2Hq5CL7R28h8+l51zM7Rdrao2IK9nv/WtXq62ZOFTTO
         F/EP0KDOgB+QDS1rSKKIcKVX57TJmdtNGMklreHVZvnZbAylwomlaQgd4ywzpXDbOJeJ
         m+eo+P3Nfvn2o5R5bcQzERa/RMaHQpF0Q0W0oU+Qhc0VUjaFf4bUn1Kr5COPdvZOvabs
         8RWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771806068; x=1772410868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxA4T3zQI9a8QxuaiFhMP5c4MzyWzmqGAzfqJe57/ac=;
        b=e5464s8+8DDYLVjOjIsCu/WOmZYslX/akyhOmTiy0n/DY76UzsqQ6OkN6nWLWkaqZO
         HPytvDST0A0/zY1po8jroOebxuRejwTDBwTwubH/ySGU8D7yaXwKQGxtG4b2xKo8lN6V
         wQn3igZmJfgw9a1vJHXsHB7rfS8pgiyGAsoAEBE8hLxphFEyWJIlIVDN+jimZyizyeJo
         Hsu9e8jl444n8w+7+vMB4zLWkYUj+e0gNEssqeKDVt5pkyQ19zWoeWn7lUhIP/c/TVPO
         AH1CwpnbRa/uRk2OJOxV4qxNob5xG3D6MQviI8GKehcI+5Z0hXhzghQvYZTdxgelbT3w
         8JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771806068; x=1772410868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oxA4T3zQI9a8QxuaiFhMP5c4MzyWzmqGAzfqJe57/ac=;
        b=bELnnzi3XphaAgjhyYQuWkilAQwdAPDV0DSAYcqlMY06pjitaeXMg+m/ZDU1gKvsoJ
         Wb6kR+4a+32TJ/XgJYwfrhpnhpaoPvm4ale1/VyvHvrDlvpRVGPu66esFQOPPO1zoQrx
         zTZwMfSEEI02HmXX5Gc+NJ+WuvQ4d9jL+rDR55Ow2jmviC05y4xCMjrIItSiKr4TDmMP
         +B8dTespTFj3I3mYG9FTH+ASs8dupjB/c7tV2dZIDoKfvght2G2YJV1MvIB60tGc0gbE
         Dv2Z73KJWl5PY+J7u6LW64J9oqAxDo4Fao8z2iOd/MPH0qEH2+/bvPRYLBdwSuz9fyCw
         60Eg==
X-Gm-Message-State: AOJu0Yzg+LW1Szql3itv4651JQLaNzedvb58TuthtUectPNPsBYCrUKj
	zEIzhxSyaHbOkX/njyEHapS9qng4PxXzntyTSnbBL7M4hBCh36VMOmzPpYYEPUp20+lcwy+eG4K
	TASHjs4wknwLXlwGlftZLltIRHa2kevk=
X-Gm-Gg: AZuq6aLWiDyo52KPLxLPQ3L0hudR9GMIbfg1gSWbu+PrC8RnRABPrZ3ayCd+yv2n980
	mp4nuwjcTgeU0saQmXTjrzj/jzad9asVf7HwTlREXMwV1Cmx9oacltVmTf9VwR7SvpS3yziGYFE
	crAGj4rhrtHCzX9hiLWltkmujjJJyu5PHS3uxkqmEGQdHL7ku8yUce+WREEqWn03JsH1VYYTuOG
	m70fcZIuPxDILevB9qO2r/13gTPxy17QUY0mv6yXBIqL3IwcJEA1qZ0z5LtEbpuUq98O2MJvg0y
	rTge7vm2hsNQFFPF6g==
X-Received: by 2002:a05:6512:2204:b0:59f:907b:bb72 with SMTP id
 2adb3069b0e04-5a0ed88d707mr1976425e87.6.1771806068236; Sun, 22 Feb 2026
 16:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
In-Reply-To: <e8355c0d7fd48981ba505e455387971f91210fa8.1771734206.git.tonghao@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 23 Feb 2026 08:20:31 +0800
X-Gm-Features: AaiRm50f0li1H_FUx1dTwKYmmiNdtBAMT0ayoWHRiYS1m3C3UGC6PcXZ5u67XN0
Message-ID: <CAL+tcoDR2-WTmhBakWcvEuLCwAU7RGRA8syfor-+RJJq7_ZOKw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: introduce the netdev_fetch_core_stats()
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259914-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 9CB14170EBD
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 12:38=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.=
com> wrote:
>
> Network device statistics retrieved via procfs, sysfs, and netlink
> represent the combined total of core_stats + driver, hardware statistics.
>
> However, in some scenarios, when monitoring netdev metrics, it is valuabl=
e
> to clearly distinguish whether the values originate from the networking
> stack's core statistics or from the driver, hardware layer. This helps
> improve debugging and addressing issues.
>
> Approaches were considered:
> - commit 5247dbf16cee ("net/core: Introduce netdev_core_stats_inc()").
>   This allows tracking increments to core_stats and helps identify specif=
ic
>   causes of changes, but not provide the total counters.
> - extending rtnl_link_stats64 with new core_xxx fields.
>   This would likely confuse or break existing userspace applications rely=
ing
>   on this struct.
> - adding a tracepoint inside dev_get_stats().
>   This implementation is not simple or straightforward enough.
>
> The solution in this patch is therefore to introduce a new dedicated func=
tion
> for collecting core statistics and mark it noinline. This approach is sim=
ple,
> clean, and maintainable to obtain driver, hardware statistics separately =
when needed.
>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Samiullah Khawaja <skhawaja@google.com>
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>

It's a simple refactor patch that only moves that logic to a new
helper. I don't see any new possible callers right now so could you
provide more straightward/clear use cases and intentions behind this
patch? For example, give us what kind of dumping stats you want to
tweak and your next movements.

Usually, a refactor patch comes with a bunch of patches that are going
to use this helper.

Thanks,
Jason

