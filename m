Return-Path: <netdev+bounces-307002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aFyHJCNYVGqRkwMAu9opvQ
	(envelope-from <netdev+bounces-307002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF854746E06
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qk7XkgvT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307002-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307002-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C943007F5F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2F379EEF;
	Mon, 13 Jul 2026 03:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4013783C1
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 03:14:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912479; cv=pass; b=LY4TSK/+N0fExWddasCFygZhRr7bxZiuumLWo9c6/ts6zwNAWqqQ2iX+36pmgPU9qHkyMeLOiTKpZdeMu+gMQq62+6lbSSUg4O2dYAprqQbprJpZrSL3eOXVCHtGDy2DiEGP230LOQAL7dSs4skXOe8qGQ2bIkHf3+c+n+Pv6jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912479; c=relaxed/simple;
	bh=CPD/0XlyAARmraJmzg7jnRHlK3R3tszjtH+8RTpqJ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5leVKskdaTFCYq9wCxNsGrYx5hkRthZ1zUxULpc7EMGCuh/wlSXbIyRy2R9JroN36xZ/v+06//bkXYQCD236usv7Qk5o9in306iu55KYcHJQs+LEumgGISvWsLk/NTYDR8gQN3bZ7rLmfqRPpPQcrovdkL3FvbZx91KIc86HtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qk7XkgvT; arc=pass smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so255780666b.0
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783912474; cv=none;
        d=google.com; s=arc-20260327;
        b=Nrm1hgUwyGNPnKTELmpWPbsozVFMZj6QPxtBX65ihHBFCt8l63ipH/uhtWS6C7X2r4
         P3SsqkqKzOY/jbi9Nrm+atUb9nEmVRsvQjeow4LHyLoK3ngG9lWTiwsPXa/A96vqW4ok
         cD2jNKOAxvNk4w/a6CMA3rkPQU9b5W9AdxDSRr423aWbdT+506lJ7NghY1E82mKyxbiF
         YHSWfEdE63eDFeAEV5ofEIcdraZNjKTWQMeB8ezeKBwNL9VR1EkfsaEons46cyZKh6v9
         BRu3FBTqvyXHb7UzVS8cG5IlF4FpsGnFAGJLY5US0grLtKv6b/kbX9CIDdnG30R7wYcF
         Lwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CrZSorjwa2TS/XaHQL6b8DW5cquE7SdFPuFZ8FDE7Vw=;
        fh=h7zFk9h9o+ePDaDD4L4G8fDB0UB/kEMIGRqP/uzd+M8=;
        b=gT/nCU1Knla6abYjiI1g1bLabWomJkLFr0MnXHsfSfN3DBOwDKpRgFUY2srahtXzt7
         eB++SRHu6o6EI0Hx+R2ZBKGQczQiCSH1TAOeBWQSAmGLOkjDjVFWx3fzrC1y9jwYXT+j
         N6RUWvVs0sWgaQCgPJbbDd3m//lnUbBxKTULx59txUv2HAwLuuaZGUnEUlOXL6WPJi/l
         sGtkV00p0KVE1ux58fOo7xOoUCNfl75Z3NBb48BEHIMeymdpUoiZFDVtXjOwWV9TEhjb
         VQAV50j9B3L9/BqWkVer91DN768lt7uEHzQpZmIsLUi0LjnweadRgltm7KSMMNoZdI6r
         JjCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783912474; x=1784517274; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrZSorjwa2TS/XaHQL6b8DW5cquE7SdFPuFZ8FDE7Vw=;
        b=qk7XkgvTnMtUa91TBdo/NLATK/JWMYWwGgzss3qJzJ9hAROV8K6YbfCZrguUHYv2l+
         DkPzM4VAvS3MusyOozFILtRAjmwqpFqeGgdPVpYLo3eZeTUv1aBbtjmDd9V5nJDLr2ll
         J57n/vBRuwyBKzICMnb6oPeH4TFZFT0xl1fDEbQrc6IePRf8COY/FdP3huuzAitrM2XN
         TeW0p0JU2v46EKFepps2r02YwRJvwTQOZhweMB7deNsQNN4/1SC6O2SvBusCZSqWnQQd
         oQONsa9E4QWbK5S97l3Rvh5i/4dICoHI5FChjSvQjFF9qdogAJ/rcp55a9aSOf4WNkdF
         QYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912474; x=1784517274;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CrZSorjwa2TS/XaHQL6b8DW5cquE7SdFPuFZ8FDE7Vw=;
        b=qOQcqGSFDtF32dbdykkkiXPiX9XAunuThBNSZMBwrfHn2jYyzKJCLZlRjSs0BR46f7
         UUTMFx9oV6EQFwhUSJQjJx2SwH4bjghyQcjEnT9JQqr0XJ7dy8BPVIUOuYq9EsmO8rzr
         8tfGMcydm2JR9Vhv/xiG1V3dFn0JW7Vrz/36zf6Iy2owXibxiReboGbBHSsDg0atOWXC
         AbVcZnfYTBTL9bzxyii/qRit/TUuSoKAahlq05AB6Id8F8JJhDNZ8AekkIssxLkck/Xa
         9lyqCd5LTFvwlF+b+joMxTslIHOCARkHW+u1c+Y3Fju6V5+6cAptc/LYxvES/IdFF4i2
         XSTA==
X-Forwarded-Encrypted: i=1; AHgh+RrnVuVWRH/b+OXYi6HdYy342YPeLyl6aAhbpqoOUGa5emMnGM2WmzlfF8P5BNcgeDY6oJK1CMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrfnvD8T+YFFX4x5w4jU1DaNEpwk0X9m7xBOfb7IcgEvYutjF
	Ax2vO2nLqvE/oGKJ+jUrU0gWJ0I4HQA1qKldJJrcdRrZgXxwUzkCfGam6vD7ZTFov8i1+iVZuct
	Pjmy5WhUAxVHr/jtkuY+Aai/9QEn9E8c=
X-Gm-Gg: AfdE7cnQM+L9ywydDt/w5CjfW/4U6uhKQYn8IbsdxnjfYUdM8wN3KjX0rIsoAx9CwGO
	pH9kmB5h9cbXn4lUQHvhEJsjeNddfUKuRTPcHsYIqMdoZWdxShKz88AFuE7m3hREeCGYMgvnL0z
	kZP+Js9eo8SL4aYB+HENyj4G8o8pJk4OJZ32nS+Exz6T8l6LAYR0lSvdtZ0Ldx8yO4j7e1PPyJq
	a1gLzeEWaOvv9+CpeBF2nvJ56gTQf2dHirJqqkokH3716U8Lde/P2ijrXXqqwZtL1KQk7v2OA2a
	7k26BRXQV+U45XhDsCKjO/s8cLIEug==
X-Received: by 2002:a17:907:7201:b0:c16:e14:b8ec with SMTP id
 a640c23a62f3a-c161f44bb17mr300374866b.58.1783912474382; Sun, 12 Jul 2026
 20:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711-rtl8366rb-fixes-v1-1-12b9210b0cce@kernel.org>
 <CAJq09z5s39bg34cPZpheBQWyZHROR-ja1nvrD9E-w9Ya45t0vw@mail.gmail.com> <CAD++jLkS67rEytYFhb6057Q1QyKhaK+fU+iJ7cebRT7gHw=LKQ@mail.gmail.com>
In-Reply-To: <CAD++jLkS67rEytYFhb6057Q1QyKhaK+fU+iJ7cebRT7gHw=LKQ@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 13 Jul 2026 00:14:22 -0300
X-Gm-Features: AUfX_mxNEkBAgOHJ0e4msy5dnFMg8ImRM6B38dmiNn7DnpcOrNZotMYDQ-awSnk
Message-ID: <CAJq09z6kAM0uidC_cG6qJwQGF86Q6xtNG4Xi-BbyXDpmgB__1Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8366rb: Fix up port isolation
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF854746E06

> > > -               /* Start with all ports completely isolated */
> > > -               ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);
> > > -               if (ret)
> > > -                       return ret;
> >
> > If you don't isolate the ports, what is the default port status?
>
> Hm as I wrote in the commit message:
>
> "the next loop in the setup code, over the
> user ports, isolate all the ports from each other, so only the CPU
> port can see them."
>
> It looks like this:
>
>         /* Configure user ports */
>         dsa_switch_for_each_port(dp, ds) {
>                 if (!dsa_port_is_user(dp))
>                         continue;
>
>                 /* Forward only to the CPU, isolate from all other ports */
>                 ret = rtl8366rb_port_set_isolation(priv, dp->index,
> upports_mask);
>                 if (ret)
>                         return ret;
>
>                 /* If we support cascade switches, it should also include the
>                  * downstream DSA ports.
>                  */
>                 downports_mask |= BIT(dp->index);
>         }
>
> upports_mask is the bitmask for all CPU ports, so that should do what is
> expected?

The first loop originally acted as a catch-all to isolate all ports
upfront (whether unused, dsa, cpu, or user). The second and third
loops then explicitly opened the forwarding paths for user and CPU
ports.
If you exclude the isolation step from the initial loop, unused ports
isolation won't be touched by the subsequent configuration loops
either. As a result, those unused ports will remain in their hardware
default isolation state.

If the hardware default is to allow forwarding (which is common for
unconfigured ports), those unused ports could potentially forward
traffic between themselves, or even leak to active ports (user or
CPU). Even if the DSA core currently disables unused ports at the
MAC/PHY level, relying on that as the sole layer of defense is risky
if that behavior ever changes or if a port is briefly enabled during
setup.

We shouldn't leave the hardware forwarding matrix in an unknown or
default state for unused ports. It should explicitly disable
forwarding by setting a 0 mask for ports that are unused (or all of
them as intended).

Looking at the current implementation,
rtl8366rb_port_set_isolation(priv, port, mask) should not use mask ==
0 as a way to disable isolation. It breaks the expected semantics and
completely prevents a caller from isolating a port entirely. This also
causes a collision of meaning, where passing a mask of 0 is equivalent
as if you passed a mask of ALL_PORTS.

The function is currently trying to do two things at once:
1) Enable or disable the hardware isolation feature itself.
2) Set the isolation destination bitmask.

We should either remove the feature's enable/disable logic from this
function entirely, or expand its signature to include an explicit
boolean argument, like: rtl8366rb_port_set_isolation(priv, port, bool
enable, u32 mask)

For the newer RTL8367C family (and some other variants), Realtek
actually dropped this dedicated "enable" bit entirely, allowing
isolation to be controlled purely by setting all target port bits to 0
or 1. However, for this specific older hardware where the explicit bit
exists, we shouldn't mash both concepts into a single mask parameter.

Regards,

Luiz

