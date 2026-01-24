Return-Path: <netdev+bounces-253003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG2UCBEodGmA2gAAu9opvQ
	(envelope-from <netdev+bounces-253003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C97C27C
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEE1C3006027
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7D1AF0BB;
	Sat, 24 Jan 2026 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG0rLPz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CF84A35
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220100; cv=pass; b=DA3AVj3JRTF52w2I+43aWIfVvPzHQgQ4LvDc2uhpMhOfDjh5iz5lfTrToEveclj/xGtl/rEjvOeELg+pOorM099VSrvKpn2h1t5SmdknU/X0lcUCl+YXq1Tn9SpV4DI7vMWmqd2L3sv6RXoD0PbdwQeeXhDbswGlK6fYu3UZnBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220100; c=relaxed/simple;
	bh=jLt0PwGKxUNFP/UMurV5/9hmISNtz6t9H2HpKnVOTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1/leD+4H+CmuR37ad9M2yiKczI9K0T4B0j5praKfGjfVoM93Asajn+zx9CO3ESun+/itkxiYeoZELjWImXK7FV+ErjkUGpdWhTmOccTAaYu6XylZSp8D5vDgudVKIwt0L/AiMVL7VLOaPbVa52Ei34TkvyXIQv6/XPjEEbJj3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG0rLPz+; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8946e32e534so37979626d6.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 18:01:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769220098; cv=none;
        d=google.com; s=arc-20240605;
        b=RZT9llokOanWujFcTHJITXX+U1tUujeUPwAbtTWqxR+RC8XzgDiWVZhLCySxpSAfl4
         sxOWbX+e1swQs/2cLoOuhujn7JRzCUXVSOikwqFc0F/OiIKzz7ILF7WXR1Euti/SweJu
         1BNi+Pios/eCbzIBY+CQ052O6fUIT/JPDiONa36gKx030fMH53kCIogSC2oUFmOOcPjK
         x5TQ7bmNpTKu5WV6kPHotYg/S75kUaXwGAigcBz1yMnspaI50GZ0cb1vJ2z64y4sDKfT
         qb5oy6tPT7CIPe1N7EkW/ZAB6TGGUw8n40NEODsJ+SswFR2Nv1Ktbz8jDvH1MhpqA4QT
         VpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        fh=iuHV4//cYYMqD0mUjUWZBveBCXjJhayZCrjRgm02jMg=;
        b=PDfsqY5pQ/l1aoGQEDSt21G1y8b3DzRpgvwthZf06jQgOavHn+5QBTH1sXDAwCw0OF
         VT8L7tYPFpvyszsTaBZA/3qwgf9GwZE8zsC3xkcM2lpMHbcKGCsvFsrTtqYB4BI6IZtw
         v4R0e4yyLtd4A5kNC5knUG8VDQnaNSE3bhS+rhzzUGCQs28cjeW3eRidzqKfBkzm91SU
         Osv79G51MYBElE/7huRtU1sahyXwYJpOrTuPQxtUtVxRLOn0kdQ8Xj6IDGBdVU3gkbPL
         I1j/S/6eA51Its4VilP9Jwuf+9sW3ZeuSqka7ZONi/+HkWzOpUBxsQrpeszrcBakz6G0
         snxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769220098; x=1769824898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=EG0rLPz+LZN8S8D6S6REH6p4GoDCsfaAUR85NwCduukox1DCZ+HEfuuqNbAfCJ+QDe
         CiYBXDaUGCkhddGQY0oRjA8Yym/iOdaly45K4bTE81xE8mj4rPZ8KSsN9IvbteJ+o6mv
         SRSW4SUKEhVPNKImR0azPDgFpprYsjACfbKwuA23XqfZRFcZyXY8d4fkzmcFd7AypE/w
         vfIa8phAFBy8QGBeN/AHASmAGZO50Q9k+c/9EYFCNgx/9P0z4CK7Jd3RbJKTjpuK7oW4
         xCOxlaygZtnPFg0hH+v6f8jU6Av/ONIJ5n5MccnaZOYDLc7JnzuPMl4OKQxlsc4H4PJb
         lnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769220098; x=1769824898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcF2ydOy+nfomakh5Blwon1hHz6tHyuDcePaQDWXLgo=;
        b=LvVSJNNO6yfju/qLLvr7PD2CIpBisWClT6ii7JLBbuKjUM1v2xBZZBjVGYfEllc6gR
         xvUry/R1Xs+qvYFVI8lqE7wqip310mH4/1ee3y1M1KJSqaR/WgbjIYbmlVC22SBSKZBf
         JUIELkONbNShQjmuH17yqKTSN3hzRq4X97ZhvUcBFazPyIvZslnfXy2w/Qy8JI6f28Xz
         qXZpUUEGVl2ocFcX0LIN5A+oKVYos1CcRLl6DteZmU8t1+RnUB1dP7ZDN4ZtFAieUYYd
         PqJtt6VVzvVXEyNcftMh+AVPN1kuSSW6Rh6ndy3h1CDkeqBNk4jUURjxgjiU/4ocT2tn
         E92Q==
X-Gm-Message-State: AOJu0Yx4u0RhEzkkXzJQwvqraQ8gGbr3bQvCyeu2U7vasXuWacJZyl5w
	KrB7Xcye14M9w3xrMW9/6/3PkBdLTOV5sGwC22Myx2yguVN7p4RaF11O4mVs/TnhSg6hxyrjiN5
	o5n/K+Uwk/QbQ3/DeVB4wk0+ySt8D/I8=
X-Gm-Gg: AZuq6aKUnojmpp8DKfCr08iHE3ipEVdT/ZfIv014YfOoEdFXksy1Qgigr77X82xzLzb
	BuXW3jNLs/wzckyGiySeF+zhc1UUzDeTdm/6sVoy7ivL1xKKsdNpxV5JElg/z0xOX3YuYb2AmsR
	zwUJb7MSgfwl2jlj7Y+mUmFDahMhbLNWuVHhnJGVkeGcDHMpT+45RbUWZvqVv78Anjy9fTJl4Me
	wsv8Cw+bY8wXDq9d5XScn7eZCnLd+2Ill232f1an5N0dnXzayMVj6Kv2MBAajdR7JZNGIJmBxM+
	5sO1BfkkOesqEzaTm4UsViSPV4oM2ryDt/OKUJAhNe6vfygl7ftJPocI
X-Received: by 2002:a05:6214:20ab:b0:890:5973:a567 with SMTP id
 6a1803df08f44-894901b45f3mr66553036d6.12.1769220097575; Fri, 23 Jan 2026
 18:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com> <20260123181156.GA84531@bhelgaas>
In-Reply-To: <20260123181156.GA84531@bhelgaas>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 23 Jan 2026 18:01:26 -0800
X-Gm-Features: AZwV_Qihtc5vhyYPwevTdmoQ3m_JYluy6sboC_AzdDpVbJp4Phlr8m3XaH144WU
Message-ID: <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Danilo Krummrich <dakr@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>, MD Danish Anwar <danishanwar@ti.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Huacai Chen <chenhuacai@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Takashi Iwai <tiwai@suse.de>, 
	Eric Biggers <ebiggers@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Dong Yibo <dong100@mucse.com>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kudzu.us,lwn.net,gmail.com,linux.ibm.com,google.com,davemloft.net,kernel.org,redhat.com,alpha.franken.de,ellerman.id.au,lunn.ch,garyguo.net,protonmail.com,umich.edu,linux-foundation.org,posteo.de,ucw.cz,ti.com,net-swift.com,netfilter.org,mit.edu,suse.de,oracle.com,gondor.apana.org.au,linux.dev,mucse.com,iscas.ac.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[62];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 355C97C27C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> Not sure there's value in removing the IDs from pci_ids.h.  It may
> lead to unnecessary conflicts later for stable and other backports.

Patches to remove drivers are generally not backported to stable
versions, even if the driver is broken, so I don't think this will be
an issue. There is no point in keeping unused IDs around.

