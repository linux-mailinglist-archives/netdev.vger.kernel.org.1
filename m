Return-Path: <netdev+bounces-292996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOYnE7cpGWp/rQgAu9opvQ
	(envelope-from <netdev+bounces-292996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0185FDA34
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0E9304455A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654CC3A16A0;
	Fri, 29 May 2026 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCBrdZaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1730EF77
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033642; cv=pass; b=mV1QElN8tVb+RK6m1PTVvjtMHJ37lKEpiHD06AkBxbWJWP/K1Cswk4QXUNFwI58SrxTwWaFDgmjNEcrLejGhO0AjUYMxOrgNRiaLjy78N+WUbNyoI9OI4gnIePpYDUdvRcVmvahw3TZAq3tNcbJi0NCC4NFL3Dojwre+FQRbVJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033642; c=relaxed/simple;
	bh=oSC++o71uLGG298SZXrHwmY7MgfyiLObopB3cbaS0qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHZY3eIqXVvbKs8eAX1LISZKeeMZTF9vz17zXSUhs1F7CROIF0TcDlhGH2bcXcDn5CCrSD7cFOecXbAct78Be8mAHHdfdgFtgIiKRn2XIY3BM4Hfducn167SGvhmgwNA/HP4N7W0PVANdTscv+Tt7ox5noOyjn05orWHUCjwJc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCBrdZaW; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so2562064a12.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780033639; cv=none;
        d=google.com; s=arc-20240605;
        b=KAJckgXMWhvuDlZU/nQBvhis4vglKk/8MvV8A7hQbRBiQtoxkTxkaqS2OZ0iSwRw6f
         iAF2656pVaa+PoXX6C3tSrKo6BtjiwcAsBo4l8EZUcvSPFH2KzNH+iddAjEHVwgDaHIK
         f4NGzxXYsUs/WDTTZTcIrs0o9/8TYtmC7CfkuEXYLHzn1R7XlpNEbJIU15MlpPFVpxyF
         GqvuTR2rOJUPVfGJte40zJrEzvR3ZH3hUJBzAtZL6bo9/Fz7dXZJ8jXi8EX/J1O5m9U5
         gVqsawU1oFxa5GCNUuYwntcFY3qgEtRc+3GKbYCtW0dDl7lbbqDI+8kes1P1ludoH2bM
         xsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oSC++o71uLGG298SZXrHwmY7MgfyiLObopB3cbaS0qk=;
        fh=xeZPtEtUcLY7diq7IFED4wyW65ITiME9YYiSdAclYLo=;
        b=Qhu3JRYLVDeRFFEtPPFeGBWl3Oo087h7SXOz+wjpNzJ6fmDj52fOjDuUK7Eqsonff7
         PXDjNXKQ7JkYpQiWGC+PNCahpAomFMBUj91PWZwLrz9dSctWw1J/bYXR5YWClgmX5I1e
         Sp2UvLImCiuisIOYZA0XCyTjs+hRo5gEidSSutMYBbQ+5YzZGkgCZ8+f89Lt76iqWpTG
         G4qE82u3angD34egysXqyHD3GBt9WrZ8kOHTFirC7EI422Mq7Jid9+Dr29E2BwwWXuzb
         WhORYQW7+l2Ahnzr6/z2JJ7zixFASQwGCc5Cj77SFseJwp0gatbZU2Hjhb0efsjZwKS1
         4iFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780033639; x=1780638439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSC++o71uLGG298SZXrHwmY7MgfyiLObopB3cbaS0qk=;
        b=mCBrdZaWaDLyKmZ54OWQi+YFHvEHGoiyAYe8TUUkFePVv3Tq1F7dJb+JZ/HF7rof6w
         3EV2jMKIrz6Ndqs2IsdZIdjcPjuMORW+GRHO6Syy4rofTrZUkQVN9BD+oVep4ZEI/8Uh
         nB1QaqOHLQBzSfaEazkSMqdgNBtfWI25C9MymyfdEtgrqE6GPcVYmyTkGbAGkxzEvC1O
         nBkNROdmiCthi4OsXeuGJb6TWx42omuP9Yv2iJMUBjBYTIese7S4Spm9V36zAdkErCbT
         suBLhaCJOw/ShVvjfli5KXdxSt047I5ggtbBBBVeOUvZICRGmFtX9R8Iamq3G7WVoNmo
         NWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033639; x=1780638439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSC++o71uLGG298SZXrHwmY7MgfyiLObopB3cbaS0qk=;
        b=af0fysZqcNQY5Orz8VcxfEflHbvrYH6aB+T6vXrtIlQU9b4uKYUt4yEmJZcL7NfUl3
         c4nXpmCYPPb+eJXTGDKMPgFg2VRX47kqOXwxj7ilrh01MnV9BNi63D7FLQH0Qhz2yB/5
         Zau6AB8LCUAo3lfK6d0nA3KukD01M54aquZ7nwujUJ0Rw5o89YPbWhZqihg6jkD+8fOf
         hAVdqPKMH+w08BZOqVGmKQHEbYRLJymrPE8igBTaImxA/8A+MYlD1MnE7FPjZJPXV/DN
         F0vXmzvd+502N2Wo6LeMSecZUJfYfKmuAqi+ijrHitD5QkcIQU6rJ62gjLq9TCMgJmHw
         qUlg==
X-Forwarded-Encrypted: i=1; AFNElJ+z354/ZGno7IUVAPWERXYfn9tiAYLtoOyf72lBRSdY9UnfGCo6TaSvPoim7IzUL2HEqJ5z01I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2uqOE5JVz6m7ZWH7rqyfSeTNN5kZdVe9wZ1BM5NJy7oQ9t0D
	N2sfY2XtrV8btOa1/t+KmfrOk/Ia5ZcAe8qUp5lNQkbeiTDYheyX/A6C4+z5ZkTbMu6zFp8DRcN
	wKxgww/w8zK/LcD6cDerIbvT+RixocU0=
X-Gm-Gg: Acq92OHbPqh9xETt2m7Py/xJaKBDVV9dmIVvQf6xz2lt04dUdWHOkPdyX4Uyr1sZXB1
	lnKgZNPjpbuLpVujmQCduM+6J5+1aNYC5deSQQjTvvJbMK9mXUOqK8WJOIjuxtQ2+0ES1k5kmzh
	37wmIYM5HiLRKYBNqZTvVvdeDiA/15OQ3bjsmP/3YF5wWu3s+Xs/kFIDTJBxBHOZKrShKVKPp1t
	MyubuUXJCwx+SS37QqUsHGWQ9VFKfxRbd3eUbcbBOMyyY4TO6dCbw6Vj6If/R5UegyqJyI2HODi
	knjBuSugVi0qTdoeAtLkGXj0VGGTFumgTCVENrjucUCkmhc3BQ==
X-Received: by 2002:a05:6402:1ec1:b0:688:12fd:789c with SMTP id
 4fb4d7f45d1cf-68c0fb94d2dmr620084a12.9.1780033639219; Thu, 28 May 2026
 22:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
 <20260525-realtek_forward-v8-5-5eb80a4675be@gmail.com> <20260527173610.5cd14e85@kernel.org>
In-Reply-To: <20260527173610.5cd14e85@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 29 May 2026 02:47:06 -0300
X-Gm-Features: AVHnY4KmAhKA51m65qrH3daiLdQsFFuGTIK6SkHu51MEtZvmDSxdw1Ebuw-tblY
Message-ID: <CAJq09z7BBkt2snuBs=CserLP4mE51p5M5Y6OEt2nkBPe-j5ijg@mail.gmail.com>
Subject: Re: [net-next PATCH v8 5/8] net: dsa: realtek: rtl8365mb: add VLAN support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292996-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com,yahoo.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD0185FDA34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, 25 May 2026 16:48:01 -0300 Luiz Angelo Daros de Luca wrote:
> > + * rtl8365mb_vlan_port_get_pvid - Retrieve the port PVID
> > + * @priv: realtek switch private structure
> > + * @port: port index
> > + * @pvid: pointer to store the retrieved VLAN ID
> > + *
> > + * Returns the port PVID if defined or 0 if not.
> > + *
> > + * Context: Can sleep. Takes and releases &priv->map_lock.
> > + * Returns 0 on success or a negative error code on failure.
> > + */
> > +int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, =
u16 *pvid)
>
> Warning: drivers/net/dsa/realtek/rtl8365mb_vlan.c:686 No description foun=
d for return value of 'rtl8365mb_vlan_port_get_pvid'
>
> Personal preference but IMHO use of kdoc on international driver
> functions is plenty pain for little gain. Maybe y'all use more advanced
> code editors or such that makes this useful? For me it's just lots of
> unnecessary metadata and kdoc warning risk, where a normal comment would
> do just fine to convey the information =F0=9F=A4=B7=EF=B8=8F


> On Mon, 25 May 2026 16:48:01 -0300 Luiz Angelo Daros de Luca wrote:
> > + * rtl8365mb_vlan_port_get_pvid - Retrieve the port PVID
> > + * @priv: realtek switch private structure
> > + * @port: port index
> > + * @pvid: pointer to store the retrieved VLAN ID
> > + *
> > + * Returns the port PVID if defined or 0 if not.
> > + *
> > + * Context: Can sleep. Takes and releases &priv->map_lock.
> > + * Returns 0 on success or a negative error code on failure.
> > + */
> > +int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, =
u16 *pvid)
>
> Warning: drivers/net/dsa/realtek/rtl8365mb_vlan.c:686 No description foun=
d for return value of 'rtl8365mb_vlan_port_get_pvid'
>
> Personal preference but IMHO use of kdoc on international driver
> functions is plenty pain for little gain. Maybe y'all use more advanced
> code editors or such that makes this useful? For me it's just lots of
> unnecessary metadata and kdoc warning risk, where a normal comment would
> do just fine to convey the information =F0=9F=A4=B7=EF=B8=8F

Hello Jakub,

You are right. I'll convert them to normal comments. There is no need
for kdocs here.

It would be a nice addition to b4 to run kernel-doc checks on touched
files during b4 prep --check. I will use this b4 config from now on:

.b4-config:
[b4]
prep-perpatch-check-cmd =3D awk '/^\\+\\+\\+/ { system(\"[ -f \"
substr($0,7) \" ] && ./scripts/kernel-doc -none \" substr($0,7)) }'
prep-perpatch-check-cmd =3D ./scripts/checkpatch.pl --terse --no-summary
--mailback --showfile --max-line-length=3D80

It's a bit of an ugly hack since it always tests the HEAD file, but at
least it forces the check.

Regards,

Luiz

