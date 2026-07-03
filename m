Return-Path: <netdev+bounces-304548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r8YOD4u4R2qGeAAAu9opvQ
	(envelope-from <netdev+bounces-304548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:26:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD7702D70
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:26:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PDdU0grJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304548-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304548-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70DBB306FDEA
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EF53C4565;
	Fri,  3 Jul 2026 13:15:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCC20297C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 13:15:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084532; cv=pass; b=Em7wC5RafKj5nYIAaxX8xvciEmI8zWEanGeFgvmfwdyf3pi5WcKKvo3p0ARYlxDHpCN6Ph6ye7mE4L+/XQFs7Hd0Gkn2E4h7zw0UxcEpaaS6eDVvryBCwE9YbgN29rM5GfNRgTEodXVzPuGgrWIhK+YOQvoSdVW906uwBRHWDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084532; c=relaxed/simple;
	bh=ePhHzvtr+26Qn/U0vq35tVU5S8xKcQ1Ei4vSKNuAQ7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnqPAVI8qdQAD43/9xIjWQWQCdP4RresFeVEAnyYYQO3CAl/x70byoiXyjg9MQoZ3et79n+rSJ2+d6Qin7Gp7sq6cYh5r5Wn4qWJW7TRl/798SsPvyoDV8MUGKt7YJLasrRpZ6K06ggyjRvlU1tfXLwlCGLGVkFs3khFcGisrEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDdU0grJ; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso2674880a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 06:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783084530; cv=none;
        d=google.com; s=arc-20260327;
        b=PN+1GUhJdKkDU0v7pVi5ACCuiy9D5oELVNHI6HxQJ86TNtYhFJUmp+vsB8IJJxaIq2
         jCvIcG6LJLNURLfQPNpKtBE+XeSErJ8LClBfdla9ehWUMR2Z6WPAOj8SyY//VMRtcA++
         OU2Q3TXesmpUBR0dWck2s4wWrA7HQ6PLUm/O5JO+EmliJR1ivRH+cLR9ijNyPjiuD7cM
         rJhySSfcFSQViILRImE4Js8FWgIXmpAaXdAhBKWdAlt5ro5RONg54BylXYYvBwyV+dwK
         Y5gznHg9yrRRXMtlY+dqEu94zNDzjDn+0nQ+y7mMKKeAaOUUvwU05DGuOmOtOrxZO4NX
         yucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ePhHzvtr+26Qn/U0vq35tVU5S8xKcQ1Ei4vSKNuAQ7A=;
        fh=TRNmO6Xtb24TfuaeNHfoiqifKN0dudYe/BEWRQy4rvc=;
        b=QnHuxUwYLeIahi1CmbdSkP7P41SEYme3nNlR8pn3Z+d9o/c0d8TZxRU925UtvTrZiV
         ZsfvBk08UrwYhQF+Sszu2VfcFk7IOwigFfzNJDEm4gwl3oQZk+49ZVA0YjtN9d7DNWuX
         CNvS4xR4vaQQrk3OoYDGGg769UpDDUHQc+VfLPYktl1ldNvuPN1LRd34ZBlRREX+PCKm
         kHLZBerXewJLOi6e1aJyZDirWKNjLcgO9uSjajRLgukZ4lZisttcuytSkGFXvb0qhelJ
         QT2dFEKisp6t/A5SKCOJmwA8xsfPH6agP/+rwKcl9BoeTsTNYqD7SiSX8nLaaR7rY52B
         Y92w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783084530; x=1783689330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePhHzvtr+26Qn/U0vq35tVU5S8xKcQ1Ei4vSKNuAQ7A=;
        b=PDdU0grJyRzduvVEy5v+4+97hvCchxufyMkl+LmnzO1q4Kap9pd6bmHyvpIPANyLfU
         MToeLl14geTtvgQkrXdIIxVPE1z3k9qwOuZoEgFlq/riRUxSNajfcKxtDXGawvt+JHOT
         vJETlHzgEQtR0SEiHpPvqxuaRZw6dO9aZkRB/WP0aD7D9jkPQx9gw3dvTvcNJk7rLTnM
         2fGuJNd67eBbHePwkZHnJEcCurzExfhToOEoowtdMOkM5M27k3mTSkd/zmzSMaPFRp54
         Qf29bs1wFH4MBS8FdpEO7uqofGI6gE1+IxXF7ce8QKurrTGnQr8uHYqI9I4od8jgy1x0
         Lo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783084530; x=1783689330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePhHzvtr+26Qn/U0vq35tVU5S8xKcQ1Ei4vSKNuAQ7A=;
        b=cDir7DXDEEXXAXmI4HWT9G3Nk7R52Uj+cIoTyn0OXZQdwWUC+Wr+LmI6Y+IM2w2U4V
         gKDD/4ZMX0Lt9uGFeNi4XprwyFy5H6uct63d9jBWjqWNmU3vU6fIKgyeKUkNnCwZOXfs
         76JXd2M5l36nbc/unA9u0NzshgSJVP8bRnlZwT5rU7mKVBImGaAGEjGXB71RJTi2f6r/
         aD0R70NGqZ9QL9ZDzGx5IOX2GPxLykDIqXuPFoC0fmaMBJFhBGhZ6DQcLTo0scvFIeFi
         GRNmiWNsNI8lvdvhxRYbDHehjpuDAqmvEv7WvN/cMZJ+s3Da5RYuehH+jF3uo6azX/pE
         ws0g==
X-Forwarded-Encrypted: i=1; AHgh+RqFP/updQbfVV8if5lLe4M36PMPTEHpxl9B+eChzH4forwPpOJC3/Bj4TCw1J1KG/9mtj2dKSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCk6KYbTv5lsYE5NQeKV/5jTwrs2KDMD/mfenRrzgIzSLuGgs6
	EpbUxC/2Jy8HicRYYt/AhUx67WowumyE2qDFAIiJlBYgp58rZW8Cr9mxs282nKuTk/tXEqyabE/
	ftV4b0aaojzkiZd6e/CZMmcjysMXGw2E=
X-Gm-Gg: AfdE7cm/vEsOBTchVE0fmLWFKQGPtM1I4O8ObNioIRqP6j9svO08xj2DqAny7DaPjRr
	sJk2zkQ9lx41aZoQYmNgZXSDKp9RAUr2uizVyvwLnQZNSA7boIFIgO8F8ZdCBxLMifAQt/3Nil7
	UMAc5dAmxcjrlaaN9wBX96EmWV6TWfLR+9h9sOP/SAShES657OGAiq1LxxfWROFQjxvcmnsRwtj
	F71BmkAQQXS+f1JDVfm55WmlhrFolhjORVqHkKaLEVmj5RszKZukPAqMAHo3T1pQrk/dPZzyQ==
X-Received: by 2002:a17:907:6088:b0:c12:677c:795f with SMTP id
 a640c23a62f3a-c12c9de19damr186677966b.7.1783084529870; Fri, 03 Jul 2026
 06:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org> <20260630-rtl8366rb-improvements-v2-2-05eb9d6a37f5@kernel.org>
In-Reply-To: <20260630-rtl8366rb-improvements-v2-2-05eb9d6a37f5@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 3 Jul 2026 10:15:16 -0300
X-Gm-Features: AVVi8Ccroi8HEyCi-iCl3DEMcU2CXFnmTgfwSxwIKlWpKgvb4OJye7YFTsTtIHc
Message-ID: <CAJq09z48KRQt1GzXhY-ExRLSF2EonB=LEHATUYBA_1cxut_50A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/5] net: dsa: realtek: rtl8366rb: Switch to
 generic port_bridge* handlers
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95CD7702D70

Em ter., 30 de jun. de 2026 =C3=A0s 08:19, Linus Walleij
<linusw@kernel.org> escreveu:
>
> The RTL8366RB is using its own sub-standard port isolation code.
>
> Implement the required isolation helpers, use these directly in
> the port setup callback, and switch over to the standard port
> isolation code.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

