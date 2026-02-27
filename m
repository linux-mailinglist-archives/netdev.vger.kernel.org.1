Return-Path: <netdev+bounces-261786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFpnFntloWkCsgQAu9opvQ
	(envelope-from <netdev+bounces-261786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:35:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D21B56C4
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3A02300B455
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C03624A4;
	Fri, 27 Feb 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Mjq9Uh9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F7331A73
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184949; cv=pass; b=r4PaRIgVkkjPsq6+bE/I5lGP4lyIJ7uZsSzxvdNIfOiIoe7kPut29wpkji4SNyCZuTOnOXED+WOZ5cJHwYOxbrIBmJQ4nRfktr4y/prgjjYxBfa/eHtVzHg3ndiAz5ppiPqx0HT6Squb9/2/Rrkj2rDO80Cue3c2p7KViBy8ang=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184949; c=relaxed/simple;
	bh=WC3wDxJ81RQFU7tnMmVyLM7AnrdfwAVGOYwWBGio0U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovuZ0+BobkFwaG54jOdTgBeKi8OFHbkJD+tOeuXTyoSZITPdq5/qvCqIy69zBE1BudXR7emZ6xxfEgj0cgmmjumsoAFvMfuLnDpbZTg1pA3oIEABDLWhSg8G3LqApJ2GRp2CAsug+q5l8JlFeSd7ZzFVm2C4hSUVEsdrlk+Uspk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Mjq9Uh9o; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4b77adso2448051c88.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 01:35:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772184947; cv=none;
        d=google.com; s=arc-20240605;
        b=OddiQBVUvTlChvAjcpcvBydq4m7WS8uHp7ypAHatNGyrOMeFJ2QK/j9pNjsJk8ebrF
         Nc1InlWMz/a/bg7/IhVpX2nOOV29wAgT2qoizveJd5+xs+c3tFsckdapCDoWOpFF1c6u
         Qt24MnCJZoAnsuggsNqoHPC3c1CUPQtWM1qZTfHItP6ru2EilCl/8a9k/sJ+PXXSgQHJ
         xj6kniV/dL5qnBU0E01I0kSNoCNbU0cw2NhIcjNCgjmQPvyzKyXpPpUeOyZ0yZT4oBO1
         MNb0ey6uAV7VpkVX2Hs0uoSIrpd8bAoglMi4779uu3ZudyRrFcJH6f41f56aTcFjAaWW
         gS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sglaDak+3pSbarmpz4tMjRMwMVnzGXxG34vRHXgczxc=;
        fh=XLKz1DUt3vYsbHkcwGkmOVYl31rH/Udlqypb4W8ulTQ=;
        b=d7SLbbPwdFFXmlr4S+4+3C187DaxCM6pwCBdIfcyzNWJtMACl0hxpU5I0Qm3a1+1PG
         GzilUN65GEQzxZVhaa671rMU/nKD8kGAR5fNie17eUgeKDerq1XbO3okbKt20OX3yCgY
         p3TzGFYE3wdKzxY5ucGr/Ji/nmh+FKGk9K3lL82G0auVEM7qe6zSkhwKenLEvluWc7oX
         n2jdgzL+fPgU7iaE/wQeFRfHxZo6i67FCLDrncOakR0J+30fpEvteGxicigZBDeAJpuX
         AVMSj9xG0RCJZh8gzizat3GoI+D6rZTo61FSu5pQhLTjPqOhHcMtlEqRKvnDxtMj+vUk
         XrLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1772184947; x=1772789747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sglaDak+3pSbarmpz4tMjRMwMVnzGXxG34vRHXgczxc=;
        b=Mjq9Uh9o7vmLc+tCnCsDYVuGkSxtzRkfwgiYZ1SUArfcWh26b+edmJy3oUbIUXfVC/
         GqMPhK+XPKS5B9RxVN2bzxBf5a9A1AHojBVSUBC0jBg2Dc5Qy9hZO0qrnDrdmSvRGXLb
         4wvJsQ8rg4AsP68f4DeY349Tb7u8ppLUMK3Goda36L33eh7hArFQcsLPDeCAbDYL9h5f
         +fTk+q5aIZ0ISUk4xl9XPizUV0eVeKVIwK/npxHspNTe82aIU3068HPuRL2iyQ3s1OQK
         jzXUDoryEciOBx5uW/fjQ6fiB49sVcPaWxjlBjRgTKTlDp0P514Zr9WuGyIOAvYPK7wA
         GXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772184947; x=1772789747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sglaDak+3pSbarmpz4tMjRMwMVnzGXxG34vRHXgczxc=;
        b=klj7rXfCF8iGEBcGm8XfltN0uXHmH56RDD5D1oqKSb7Z8dmo8xIP4XdANa7EbVEfJI
         a7EnLtVi6fnpOVHcqk/5Lq+7CZVX9wA9I3VXrNKZpCHmZHzDp8bMxBXT/5kB+fXE4Kn7
         XmxFqxkwxDy4kaCTj3dEAqChwIvh8fPRwS26Ynr4jPRvOlUfhU/XSheRpGQjWi7AX7Pf
         UQghXIrCn/JeEGAzTLdC/f5CRAIsSA5xoAuIV/j2Ing+ni4+D7O7a42zPIBXClzCUScK
         RhyA2t7vcZmo7zt4hLVK3s/EIcoaXL/3AJ2/8P344/iQm1hXnlVQCescNg64wKWmmH00
         8/eg==
X-Forwarded-Encrypted: i=1; AJvYcCXTp9lFTuS5qZnt6jKoZLdiJHe5cLd0EXeeNMHZHPKh9XrslmmQvCsRzpjY4JTlb+ngR3VRfd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORdjl7R8gpbQOy1mUBUchUoN6eJ0qaV7naxJkYKkHNxTZwWzi
	Xtw9WRafmXS41Y+JNT3234GxI9xZlhFW0hKNOLqXA1/VdUkPHaCNk6XQNqYT65/OX5W4IITC1WI
	wSz4gyrcwsght1QxQRzqsuSfZDSlo6kJaZRp3uyWKRg==
X-Gm-Gg: ATEYQzy83NH+sLytNiBroIyMOxvZcuiuAeKAx77xdpcdWAj93xf1JHzNFYAA1k3cUAp
	Xa02nvhdPEXDnKxvW7XOrG/F+aXciyb9LkmAWITEJT30L8u/ljHi/y9+n/ty1NSFdVvw7dyj81o
	vqrwM+0uOto8SV3r1XWKQ8TNCTApDHZFp9G00iTugAgpEsxCfHCN6i1fJUT2jsp8KtBWVkDBDb4
	rAIUOpMG8kvr6/k/pLfniq6JN5pU2sWHd7Oay6L0YQ1GrEx0mPaN/WYkfzvoQz4d6J4twBEPOu4
	24aFKmtmdDokx/qbZdwWWIQqaWzXLchOIkb8jZiVusM8by9kbtVEqIQx+pgwGTGVEPEzDTateOD
	zn11LDmqhsdLgjr4Ennp4WpBA
X-Received: by 2002:a05:7022:e16:b0:11b:82b8:40ae with SMTP id
 a92af1059eb24-1278fb9c7a4mr944729c88.18.1772184947030; Fri, 27 Feb 2026
 01:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226201600.222044-1-alice.kernel@fastmail.im>
 <20260226201600.222044-13-alice.kernel@fastmail.im> <20260226173036.56efc7ef@kernel.org>
In-Reply-To: <20260226173036.56efc7ef@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Fri, 27 Feb 2026 11:35:30 +0200
X-Gm-Features: AaiRm521pSWk4eS_rZ6V3ttARBUnb5uGRXMUuQiAo1mnNnIbHAtntIyYL3-TwYY
Message-ID: <CAD0BsJUVtPyRj=Zv3___cs6hh9G_A0q3bLHGMJ+hU8FZc9b8ww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] selftests: net: Add a test for BIG TCP
 in UDP tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261786-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,isovalent.com:dkim]
X-Rspamd-Queue-Id: 7F9D21B56C4
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 at 03:30, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 26 Feb 2026 22:16:00 +0200 Alice Mikityanska wrote:
> > +     ip netns exec "$SERVER_NS" netserver 2>&1 >/dev/null
>
> I'm assuming you want to suppress both stdout and stderr?

I think I only wanted to suppress stdout (speed stats, etc.), but
still see any possible errors from stderr. To be honest, I don't
remember why I had the stderr>stdout redirect then (I see I don't have
it with the netperf client). Thanks for pointing it out, let's
probably keep `> /dev/null` and drop `2>&1`.

> shellcheck points out this won't work, then. 2>&1 has to be last
> --
> pw-bot: cr

