Return-Path: <netdev+bounces-256317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPi5JvoIgmmCOQMAu9opvQ
	(envelope-from <netdev+bounces-256317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:40:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BBDAB63
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D02E93014650
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D323AA1A7;
	Tue,  3 Feb 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmp/FL4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774F3A63F3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129399; cv=pass; b=Y+axsVB6NHg+qY0hSh56xFOacPRhAeEz5DZGRwqmMupUb8ublZUhTq4SYa0g144zw1S8hXwdqdHQGOJtnS0+2rucp9Sb706H6dgRD/GEzb3YsoyXnl0+aaKtr4mPbih+ea9ng1rQDuUnRDNWLss3aJL6o12i2tbHSXufqj1R7WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129399; c=relaxed/simple;
	bh=odADWoVpnh46kioRwm0TBjdpIHbkpoy15QMEVhLMOw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuWoXqgjSlHtOurcWY4FSpTQV2NYMbEWJV9JvcIB2g7ryyuuaPgxzp6zvW0iY+YUPdjLqABMONS4xBQ0zu+KUZr3vcomm11iSttmT9mxhnjUjizLzMEkcJkaGl2uN8+fCu7C95nvEjzYHHMxo9m1eKIy+VZ/Ik24HGHAyPJDLFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmp/FL4Y; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649605d3664so6364677d50.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 06:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770129397; cv=none;
        d=google.com; s=arc-20240605;
        b=UHRgZrn7n9BJtb9KKyLxk+YyjcO8djaUxl6wj0ZTmdUmH2YlZ72uls24bCjfxXnj5z
         TdSwLB1ITW48ohuZILJuFvpbXGRIcuZaKxxQA9cyZHfLAdLUlF4uwHDMlFGrJwpONvo8
         0g99KSs1sFF6+z6AR+77tz6HiVZMj+29wfZ4vlhMtiDYAQNt/BXFwBeRYaENTu2waulz
         8SjXMkAO6zLSFcfQRLAt10xwTazhQHPKWQvXryxN6v/sqw9vm21zZb62T+tKAsOFdv3s
         6vwcEeXxzDdGmz2FFf/tfvx/OCW0lwKszQ37jnk9s2Hvw7BIo6CsaEIdOQ70vlDgJZEr
         vGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBcbxMUtF8xNaMRTkP3Y2ohb5ZiU9Nml+ZgLyhJTzwU=;
        fh=U4nGv7X5Z1MCoHRDA3fhEwYyGDeZ1GE7dty+zM+jA/w=;
        b=Jm9jnBcCCrK5F/mA2zRunFXCdzj0HIMj3Baxxu8vRVrYuZtZkQEjK3fgr0CFMk3tgp
         8KINwg6cNQ9jCXL3Nqi9//m/z/629REMNpahTkovAT9bD7rWzE3WTyy+eph0Zgsg/ZWU
         ohnLr+ow2saW0gageCwsNjomos3PTGE/29Fo6IH2tJg1Y1qS7yn0hf0yQtqoc8mcPGaR
         6HEGhECgwF3SfyQ/4lIofyoS6THzA+Gl1SunuPn9g/0SSF99oI453ER6AQc15eTAypsm
         wCGmp9kMAJWMe+zkI1h2W5/wYdxPCuXVDXglJ3Ntyzu9qn17oA5JBXYAAJKTdDpjFtsx
         0grg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129397; x=1770734197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBcbxMUtF8xNaMRTkP3Y2ohb5ZiU9Nml+ZgLyhJTzwU=;
        b=Cmp/FL4YFtBZN07PeAUHkxVnGGG1q0XZVAmX8rpzYTtqYbjoDqm2RQZmmwsO6GOkHi
         vrdmILcl+1ZHN+X3Km2mis4XOcUSFWYItmLy0Q2d2qE3Z6xZ7RLKzZUjt9Gei1kOA/he
         zmh4igqkr9gqC7NVnm8ylL0FnK49YFJESW4hgZBSE/ZDlcjpIsY4aGDZKdhirRZAo4oG
         rj2FcV+CjPgCkSpev9D9h/4imXw1C/twUu5Nk2yaIIM88GIw4TYmIGAIS82b6im8eMhj
         eTAloBLMeCWf4eIiLEoBrxAvmfcDsecgsy4a0WsLkwSnp4MStcPS7jhYz0yZEnO0bULr
         nsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129397; x=1770734197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBcbxMUtF8xNaMRTkP3Y2ohb5ZiU9Nml+ZgLyhJTzwU=;
        b=Z6OscUqc68eTYpmMpfU+CA+AkGyu6nzJet5S1BWjpqNFLuw8Q3LdRmzRYyBi6YaY8Z
         VWklQxW7dfGwsNo6MfU0MNhrrZkO5fEcNuDe2pKoR+BfBix4plAY21Z0fmeOXz7kmBF5
         NGAbHiwDkDfLvN+Sv4eaTHEg0CLdts+a1iNePRvDg6jjghSf4W5Or1aEVlrg2GcwLhxZ
         j7wLFJaQDGuWlrv4y7i5XeudtlOOxPRcTmwb1eOj9qRtj30WNVruTIGdU/0QADoGz5a5
         DyNIGCKsuPda2rEF/fs/cGG/QrbCY+9uayCiWO/8c5bm3AxJouESRPN+4afMZ2sNtQkK
         KhpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyl52TulSvIlTs3nYRu4Xwiy9Ry4OBMa/2ao1ePj2ZvnRK+OREKqXJ7zmqibf8AyRn3QNJ3u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBQyGMVMWFWbB01XgM0dRFOecxNnb6xi9ZddMvVcq8I2T/2N7
	BrlQU/k6Uz/gVeG6MwLMCrIA3MFk22/Fjw1t5pza5SanAN5K4DI0XNWpbb7W6NTCSXRMNzgu/jo
	Sm9TjgSFSjS7Kt1gTR9/znNX+gG0Kvpo=
X-Gm-Gg: AZuq6aKl+K9l/V1IvrSFca5e8zz+X2lyDmt8nhgARSaH2SZJPG3rkDMjlfIvTcQtrXR
	rKY7Y7llyaJWdM35uGeutjenKH1uJDOkZQVsprLldQAGbBK58TTA/LasqBD+VBlfFhgSpKfotOC
	UgV2U4Q6laO7If4fVcT0un1NC6psKYYwLmy6FInCSuJEHSTaCJffo5tpct4bwVDIFOtiAb0eF+8
	j1PHRolxFOwkyBP/+UKEVupwysatbrTUM6J+6FDhF9R8IfHtzepN59dWBE8xqEfQwF/G1mdyAQM
	xJgipQ==
X-Received: by 2002:a05:690e:408e:b0:644:71f7:a9ee with SMTP id
 956f58d0204a3-649a8599a11mr11595318d50.97.1770129397430; Tue, 03 Feb 2026
 06:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com> <aYH9FwwOTD28Gn04@strlen.de>
In-Reply-To: <aYH9FwwOTD28Gn04@strlen.de>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 3 Feb 2026 22:36:25 +0800
X-Gm-Features: AZwV_Qimr3FJERvaY9Qr_TnLC5dLIZu4J9bhQ8-QxUcUvNCIWNYgNPDFrut0uIo
Message-ID: <CABFUUZG87ia6AXbA=EWZb9uN=AzbBeH+gb_PDDOonJk-pyTPcQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: amanda: fix RCU pointer typing for nf_nat_amanda_hook
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1B1BBDAB63
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 9:50=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Sun Jian <sun.jian.kdev@gmail.com> wrote:

> > 4. Using rcu_dereference_raw() to fetch the hook address, which
> >    satisfies sparse's type checking for function pointers.
>
> This doesn't look right, esp. step 4.  Why not:
>
> diff --git a/include/linux/netfilter/nf_conntrack_amanda.h b/include/linu=
x/netfilter/nf_conntrack_amanda.h
> --- a/include/linux/netfilter/nf_conntrack_amanda.h
> +++ b/include/linux/netfilter/nf_conntrack_amanda.h
> @@ -7,7 +7,7 @@
>  #include <linux/skbuff.h>
>  #include <net/netfilter/nf_conntrack_expect.h>
>
> -extern unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
> +extern unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
>                                           enum ip_conntrack_info ctinfo,
>                                           unsigned int protoff,
>                                           unsigned int matchoff,
> diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_connt=
rack_amanda.c
> --- a/net/netfilter/nf_conntrack_amanda.c
> +++ b/net/netfilter/nf_conntrack_amanda.c
> @@ -37,7 +37,7 @@ MODULE_PARM_DESC(master_timeout, "timeout for the maste=
r connection");
>  module_param(ts_algo, charp, 0400);
>  MODULE_PARM_DESC(ts_algo, "textsearch algorithm to use (default kmp)");
>
> -unsigned int (*nf_nat_amanda_hook)(struct sk_buff *skb,
> +unsigned int (__rcu *nf_nat_amanda_hook)(struct sk_buff *skb,
>                                    enum ip_conntrack_info ctinfo,
>                                    unsigned int protoff,
>                                    unsigned int matchoff,
> ?
Ack, I'll follow your suggestions and send a V2 shortly.
Thanks for the correction!

Regards,

Sun

