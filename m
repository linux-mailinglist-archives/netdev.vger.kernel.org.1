Return-Path: <netdev+bounces-253609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM/2F7ztd2kVmgEAu9opvQ
	(envelope-from <netdev+bounces-253609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:42:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB1C8DFE6
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6578E300CC1B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E693016E0;
	Mon, 26 Jan 2026 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HdKejOaw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6C2EAB82
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467319; cv=pass; b=r/lJQSZrfcrFXUV+k8zeFrRQalon0ZwTb/pVTfUHgJQbyFrOlj2LUET8Ad9yhiNXItvoI5nt9ypG8IJhKbihak7EFt7Bcyb8y0j+icZ+2cZ/9X4+5JyIqMwTx7G0OP1Lo2WVArYVPDGeVBve4HaOPKd+dsFWksXtkSwgBJFGdMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467319; c=relaxed/simple;
	bh=Q3G4ARwrh5Qce1UUq5S3zP0x4wInYa/dVEYHDQCXtfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf0yGIK221qkQhYv7T/A/Ucaghj7reJt1HKKlcmcdpUvhqu2UUdlQgMrWZ7tqrD2Vng+/lmkxoepDz2y/ZdU8QoQDkhssrEjweXs2PDUE2K8IpGw4WZs8ymDszDm1XT9kjkSigRLlJpdYN82eTbnLNbXyQOeO1Yb10yBFvlkOqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HdKejOaw; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso3257880a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 14:41:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467317; cv=none;
        d=google.com; s=arc-20240605;
        b=fW8zfG//gE+X74N/+ObcdvHEzTgNahAEBPzVQCktWEK0OglC+SWDqKy/od+rg7V+2n
         fHXNOkFFOhq+bRCd2ATxkgVyMfh+kl6fKLxUgV6lcmu4qYGPhbpLcVNzvSWl9ysyWwfA
         6MNBGChZtJNjnDMNobrd+TTXaZq+YGJ4t5BlEqltfV3oMnFjKmc8rJOaleYY0XI44yTa
         +feOTvRlKLVFtgjxgpCtXm1lMph9Q3ZdSVyybfzEex+/R5LLVWUYr+iiQFUz+4aFw0h1
         N4iYn4HnWdmH7y6mU/ufJzTXVJ3Jq9iFs1y4BRF4VzN7HBU/Judgwgiw7OaZOFPmUdnW
         2tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        fh=HurcY3gLk2i3/Qu9ntzB7nKcNrkOkyhdjwunJKkSJZ8=;
        b=DtWxqWuYnlK7UgrrYfP8aWtBcTWdHH7KL3CQyzGWB8j+NQjoAM7b+2X7FbVmwdlbn3
         646qGO9MUTgPwQc1MHME9cv/7Tzu8qgp4ywCXR8mRQTm9ojBNwK2JU783M51NmhbDXqm
         4acywFlIzdpU50tw4FIazu5EMccXBfCegm+jcfBxVXBuosLVsrc8nlxp0yLYFUnqyaWI
         iFmtVDC7gTRLKVttatN8BRNhveIT5/cTp7JM2e8Zt2sECi4DGvs7dpXsEf6IYjzuvc6H
         r/qFYLQCriM0Jq1xeuUw8wm2UlYrosOH1Zhb9Zwsn6B5rY4FkdDwlNE1nIgCtDqoJjRS
         cc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467317; x=1770072117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        b=HdKejOawXQz3LplRfJtM5nFR/KK20vbUZauCUkj2rPWboQGv5B1JNpzwD/74fNjam0
         aNpvleslja1QE2ju57WXKFpFg/I8rqTnyqc0kK0jimCsz5e5QdWC2xzIn3zpcbAd2nvx
         UxL1WkU+Wl3XiTrE/0GxhsWuHXSvsGXpp7fo0LAuR2TlDJgPXfj3tYVuo4nMk9xOd1v1
         p/4M6rYSs6mgL5CwLx4UJm2Ls0VEMBzWmAXxcC1pQ6jkO2DMtoMLoUYz9g1quv8RlT4V
         ohFQOaDKVPB+Es9seG6HB8JHkFuKyCk8b4t+eUKcBLW7qeYYRJB19pr1nWVsKU0w3GH+
         0LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467317; x=1770072117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7jnwBcO9kfWrOClkw45F/yzW2eGiLRsPFFOYC93unk=;
        b=lYqjyufyvvXCBz5P3oPViB4XkcWpj8ch8NklxuoRNPl3KNKX6RgLPjpUSMne2glrQn
         jrWg0kgvoEKBc+d4sLVubJevm51WbeTlqa9+P9gmuqEmWOyCP20sE1sfX6wQmjD5YWbq
         RMRA6tezC0SOFe9r9LLxjA8qaUKkGooUQzEVRW8H5n/ojSRWV5pWLVBR7NYxgErLT0Ww
         ir76U/oIoPhcHDER35HVqVG9PZVrQCFE3T4lVW5hYpGgMW2QO7cpoLgOGv+aiquK0Ek8
         ++49TrL7z2VCbrBtPflHMph71kQh4PsYvkZJJ44v77Q26DWtp1fChN6YMW2xBVTYqf9w
         c2dg==
X-Forwarded-Encrypted: i=1; AJvYcCXvV0j1B6Kn4aCfDYEIxwP21cP7WzWmoPaBz2yTgnB6+YD5v3Gq6B/09a2TpLDmKF9puqC2Od0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuD9d6JfsQqriTKnSH2BHCV+8LEJeBIgMqz6R3Hbu3NdcVbzwP
	H09LhmSZ+w3HN4UHK8Z+AUc0VKVHmuNhI/j/sfBC8dcwcg/2fzyGNuSeGqS+oqbLo8WWL0bP8Yr
	10u14yiJ2jkn6AjPTaHwUMkJriG0Rt7yOXC+fxjun
X-Gm-Gg: AZuq6aJ+YVymPpXEVor/pXVOCwn4HYCi0J12fViAtEJTNveW7aHCzfP1kvzHgP2unBr
	O8ONRhhstEFoB1qGSH+bqQK2f0wAIBIAg1sbD9udeA7FanOS9/ZAmkLI4xG0qJ3FbCisxK7Xg8h
	luhbWIL5m4qDpif1vC6VLvcrmun/cYkXY3ENGUX6htDDiXOHMRd/0FCvhXHkCiDMkn+OXzxBTmU
	o275j3h3XFHl+c/CkYM4PFJz8Kq9UmDMZ3hGmFjqyzzhnEK/2mVJfVefg3vK7ENUlH5LBA=
X-Received: by 2002:a17:90b:3b4a:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-353c4625b54mr4450699a91.12.1769467317586; Mon, 26 Jan 2026
 14:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp> <aXIGxmCB2QU86-iA@secunet.com>
In-Reply-To: <aXIGxmCB2QU86-iA@secunet.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:41:46 -0500
X-Gm-Features: AZwV_QgYmUrGPybMCCDRtzN_TKJkWDkwDRu5nDZr9abvGoEUZ-CUdGucaUzu1nA
Message-ID: <CAHC9VhQ54LRD7k_x6tUju2kPVBEHcdgBh46_hBN8btG0vhfy_w@mail.gmail.com>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Aviad Yehezkel <aviadye@mellnaox.com>, Aviv Heller <avivh@mellanox.com>, 
	Boris Pismenny <borisp@mellanox.com>, "David S. Miller" <davem@davemloft.net>, 
	Florian Westphal <fw@strlen.de>, Guy Shapiro <guysh@mellanox.com>, Ilan Tayari <ilant@mellanox.com>, 
	Kristian Evensen <kristian.evensen@gmail.com>, Leon Romanovsky <leon@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>, 
	Saeed Mahameed <saeedm@mellanox.com>, Yossi Kuperman <yossiku@mellanox.com>, 
	Network Development <netdev@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-253609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[i-love.sakura.ne.jp,mellnaox.com,mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:url,paul-moore.com:dkim]
X-Rspamd-Queue-Id: ADB1C8DFE6
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 7:00=E2=80=AFAM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
> On Thu, Jan 22, 2026 at 05:24:22PM +0900, Tetsuo Handa wrote:

...

> > Therefore, I wonder what are security_xfrm_state_delete() and security_=
xfrm_policy_delete()
> > for. Can I kill xfrm_dev_state_flush_secctx_check() and xfrm_dev_policy=
_flush_secctx_check() ?
>
> This might violate a LSM policy then.

Exactly.  SELinux is currently the only LSM that enforces any access
controls on the XFRM/IPsec code, but it does use both of these LSM
hooks to authorize deletion of SPD/SA objects.

--=20
paul-moore.com

