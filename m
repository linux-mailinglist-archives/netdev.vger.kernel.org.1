Return-Path: <netdev+bounces-253116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EI7D5VWdWm1EAEAu9opvQ
	(envelope-from <netdev+bounces-253116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:32:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6597F42C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00A583001FE9
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691D27A907;
	Sat, 24 Jan 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaszhpSV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CC233723
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769297553; cv=pass; b=GLMvV3LXkddz/n1Dg0S4IyAx/BzlpZvSzxv7smelbqgP4UfHHNTnlc9Hi7t5LrJjbZb97FTxQ4+9TO1I90vsJ22yIns6iLq7Kn0GuI8/cGrk/R0M4PTh7BgwNYnpSU2tc17cl7cfn0WgXnBMG6GDu78zNlIKv6AzNLxjzqvvEL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769297553; c=relaxed/simple;
	bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XMHKdyijbDlPnJmlQKLT3LzXkK7rgamAFL/I3Dp52bqrpDBhCBv8EP/7v6f5YJdF2HNFChUyh/9OuBtSna8ZE/cwq7W9sfK57aS0Yd7ER0V/wkDrWfVEotKRF6V9Fn9wNtQvuQaTqAjhz7kGDHrNPhlrXPgNsuUeNAJoUbK1Vnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaszhpSV; arc=pass smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014db8e268so55659901cf.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769297549; cv=none;
        d=google.com; s=arc-20240605;
        b=N4tdogcyg86Q31hpCijKy9uF1bdCn8N6VNyBtvjXBfw9rdiEa9VB/hWv7q0D8I9eSM
         XiSD+z2LTYqcHbp0+Fm3wGRtd9p+1N3GXIY1kugN8CeGAZY6QzWvlOBUaLrUrQyfB4Oo
         UkW6p5uOOOhs0cfgoVYWn3rLBPziL00kNLjBHsfMG305SeLM7BTRogjmAFGUaWBsn+HQ
         YR7QdkDqcW+vZsh1OOxK8swKKoWzos/Dmm431g7xSf+LKdbgQD1OpzT2Gl93MIJSLdEi
         oNLh7yYdDKhzewt2r+B3SYdD3DmKCXL+kmzHHkActqDsdD/+wVkjrTnAv8hvg3Fi4RPi
         /BEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        fh=/nQQ0H0OblMyz4VuEo721IHrsMYNSB7Bg2PaUICEZuI=;
        b=Y+kWcaQzp6BYWmz+lJpP71F3QsqMt0/GPuTVv2EUF+E/WScODxZv7JavtdziyOEjap
         Q+tUVOBPAGctKCTO82r7dUgoy6cPvW+LRTQPu4H1bQA6wVsK9NJ5mvy0zlYq7tiB2L5w
         NmBGRC2X2gPYQ4kO5W8631uzDtG81oTHsABJtKF46gGZYpEsYNIY4wVUHfIx4uGrrUZW
         StgBzc5qaFkE/NNxC6p32vxI0/xwnMaVnkJqMvjma8cALPHEdl4GmxCNy7mH/XCg45HI
         i2WEj3Rzr3bxgujDX4nDX6GZjOmxu8gAsFM/pO7eXmCzG9zeL8D6MDZq+Nroq2OF9RWk
         4qIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769297549; x=1769902349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=CaszhpSVDhvXzlO7i5v7MZuDpk3LEVYj90HYC5ggSo+i0hWCkXMXeL2ps/7SGClU0a
         oagfcI+67P9PYN50vUA1FDHzyLylIVj//6r7kPr33pdWNZG7OetHNJmVqH+RLue2f4Ti
         RyASq2nBsmRb82ZFGibxAdGiuiuySBj06PDEupDqzEYB0rBAYozg7/aJhtBCt3tt6xzL
         65TaECbGBd8wY8fCaLeVtZ6Vi86EIj8CBo5Wd1ntGwAZjFi+XN1qJ13vy8y6CTYTO0X8
         aN/lXBDHBZVyGzzEWqy6gkKrqikTEWYj1sr6AkDSoEB+QLGF5lPbzUj3fJXyyGRwSGcE
         xU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769297549; x=1769902349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62AUfn3TepYhzwErRqoDeLZjyZJQUDkNhXA5ssHqF2g=;
        b=wucPaoJmhIUsZ/iTBoOkXlWU73c1ohSkOqwtmp4zJR2x05zp+bevyfO59SIW2b73Tv
         nJYpJOvyKX8dNmb8xObEg9h3ggEoddr+33psmOlLuMiCGYP2GmNx+MSlMXMeiiGAv1xF
         db6dcvW84aJrOJ2tVLY83qsCJY+KDdej5WObqEjCveqwBBEey3KExhe6o0SwAf3cdnOg
         fWVuJrAxjxYJkx2hKgWpXHzFX3D4sbPzghA2mEA8flVpGa23+JBBWh+S/lPumbDVkqMZ
         o0y89f6jlef7cHjbiSqXsRtFi27wFFTPSh1J1EZnPN0/WgK23/iQMYuaDV/wfKBF5Eoq
         xHhw==
X-Forwarded-Encrypted: i=1; AJvYcCXTiSwcj85jEyKpCN0Goe+inOY4L36WLsz8jNFiZBoV8CyHvULBh1j74omCz5FGnDlw7KUN5Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLPmmn9QyHjzGAwNSGpMNC6l5VwPVEr0CBzO1uyrfomgdUfzt
	/Rw1e755HWsA+9NtwAcwEMUhGJxgWfDSDnZ/l5WrWzG9d8vOZ/ejQ0DpARlbJzcG8TMBbpyHawN
	/NY9kKkIOxSizpWfTefBXy41zMM7ASNg=
X-Gm-Gg: AZuq6aJ0jnUocJHV2hE1mpqxWh6s6taMD0trnG0pekjCTMdsess4sDRPbnMPj9KdWRD
	4t9ZvwEwHCXfKMtEEU1dCX64emSJ+c1RF8Ztb5cyEOrhEtzLsZ4ckbOzH1zsBLbWXxBeyL7ilJd
	6VAW9KAkKAZu0NThPWD2Q3qYiBBoAqzTbSlu68pgrZEYvWK89c7aTRwlryIRgIKKkf2vcdS6DLL
	Z3iBrCjeAAV9JyE7ENRQMkoCoN3Pr2/8yTBR0xWAWD8TaCRq21dUjoucvs76syustdtYylwpm2Z
	Drc/No+/a7CQfhKaUuBdKeI+k4mWUPFTePGYBbevrD8M3WsxeFu0VVMVZU2GC/EDpBRqJI/2pcb
	ShB2U60qIHhtH0qY=
X-Received: by 2002:a05:622a:55:b0:502:6312:8d6 with SMTP id
 d75a77b69052e-50314b7a6e1mr2969171cf.12.1769297549164; Sat, 24 Jan 2026
 15:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123033233.16906-1-enelsonmoore@gmail.com>
 <20260123181156.GA84531@bhelgaas> <CADkSEUg5EqpKg2_X3LRc1CaQ2RVFNucJbuxDcHQxvjdLq1Qg1A@mail.gmail.com>
 <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
In-Reply-To: <8477da83-2441-440c-80f1-66dac9700523@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 15:32:17 -0800
X-Gm-Features: AZwV_QgT7HJ5RzGZbmSKdUH5ZCEsN2PptDSPTNTy9vD6bN7Rq-MPZtQjsOmB-V8
Message-ID: <CADkSEUjyXH74izTrsfhdAjh=n-jnGx=tXbqPx86M9OYqjXj0PA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kudzu.us,lwn.net,gmail.com,linux.ibm.com,google.com,davemloft.net,redhat.com,alpha.franken.de,ellerman.id.au,lunn.ch,garyguo.net,protonmail.com,umich.edu,linux-foundation.org,posteo.de,ucw.cz,ti.com,net-swift.com,netfilter.org,mit.edu,suse.de,oracle.com,gondor.apana.org.au,linux.dev,mucse.com,iscas.ac.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: DB6597F42C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:25=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Yes and that's exactly the reason why removing unused IDs will be a probl=
em.
>
> Let's take an exemple: some patch adds PCI_DEVICE_ID_ARECA_1682 after
> PCI_DEVICE_ID_ARECA_1681 in pci_ids.h in the mainline. That patch needs
> to be backported and it conflicts with PCI_VENDOR_ID_S2IO which is not
> anymore in the mainline but is still in stable.

Hi, Christophe,

I understand your reasoning now. Thanks for clarifying. In my opinion,
changes to pci_ids.h don't happen often enough for that to be a
problem. Unused IDs have been removed from it before.

Sincerely,
Ethan

