Return-Path: <netdev+bounces-258700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKiHNYpskGmoZQEAu9opvQ
	(envelope-from <netdev+bounces-258700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:37:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB313BE3B
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35348301D691
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB95263C8C;
	Sat, 14 Feb 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zsb41fvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8C1DB95E
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072646; cv=pass; b=E1PozLOB/eRU7grxSMOSGGs80iSwMJQ03WUQUO7NkZ9kzZbVZdihx3rB1NPy+iQ77DAXvhqNGADRhIq0jwJy7MIZyHpDk4S0XnsCCaazTNDpVkQFeVkk0/8JqEwzQnUiBbvxGXucGkh/Wy8n21eHh503ruPubXS0n4z3Hz9Uk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072646; c=relaxed/simple;
	bh=i0VhnISC3lNV0OvJ4pPoUPvGh7VaYc5c+9iucFsi7D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ4h+MILjw2498PL0NOUn4Cd5su86Hz0ysRFcvQhg+vU1sii5I9F26bt3c+bX2X6/JCglXkJmzFVovZo6Xxkwxg0AEQc/uPM8EaLk4Rf2+RaGfFchkPM1JwmwubQ49jnE1k8e4EkrgxBuiY5rURsqmN2Iohhn2zaOeg1TA1lrvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zsb41fvW; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8954a050c19so21852066d6.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 04:37:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771072644; cv=none;
        d=google.com; s=arc-20240605;
        b=KN4x2zFrEMh1VoW73vV2lbCYjAZjiCrV+NiN2ZnaR/aG0qv+6GbeI7Q8UuZquwRnir
         bL+LShsOmcej3pyPplTiAliL5IQPu15F+C5kItDLDgRdPe+kI/hXOnwrJaVG3rss0YNL
         JebHekO98pgI01BUpepNx4RpVIaEjkQ44zU4TpzsVy3tQqk3QdD9RaZdUTJ5Ayar7paS
         OHlNz8ojqowel9IbvZZd5CRmMqc9yBDN2Uv6V6SIgUovFzMQHPw3VQVVGfnCgLCC6mhC
         2O0NFzrBRH8OUXsraSNPwJ2MSc0w5RZMptoh/hqEIRn8KigYPM2wa4h5tUseOjkJfMSX
         RAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uG6I5gikyLFVYSOuPgYNTKiFjNKjj326HCn9/URW30=;
        fh=K1jWG3SvigbpGhgqVK1pYj9u6P7ZbVuF4Q0i5SCd3eg=;
        b=hjsJ+HHd0HJjX2cNbYZkk4UuRe2ViWiH8W5+kxchoQtmx5/vWXVRWwDSflPvNm2TcW
         09IJayNSeXmodrmVwIyAeUaJLWbe2yFe08Wq9tb+prFPeRyvFLbDBRUxU57Oyme5C/V5
         Z/7o0nX4lqvkFxPQnunuSAz5zqUZ1rjn5RfwFQu85XZiBG/4L4NDBjItCj/whtMPiQXF
         TAiFE0+FYx0KkXkTrV2ehxFkO0Jc0PGadlPYssF/aOXCScTZYqmRMQOMdXKeK45A1ES6
         ev7JX7LRLs+dtgGhxPx2TT8vNvOrxBnjbX7bSsWMZFTYUf+sGTsZPDZMiSGJaaJm5d63
         m0jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771072644; x=1771677444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uG6I5gikyLFVYSOuPgYNTKiFjNKjj326HCn9/URW30=;
        b=Zsb41fvWgUk3Fa1dJv8AAkqZsab3SUH7CzBB6LmeUpckXzytG6+ye2ZnuZGZjC4fwa
         N+tcvU3weQai4GVaA86rtouH/aS+KBA0GhkkJXP7GBd5oHt6uiDABAtW5n50pnCORp4W
         MW8s6nqg2KG2ON6wBRMg3mnK6sZ2dToOhGT1+/TIhh/7s1tiMYz++q+zDV6rxoXWqJJz
         JCofUEO1hPB9uvCvqfWCyLl8vGXcLLcE8C4SUqB2KH9p9ZJNXunOxDI69t7UptMhQnPD
         yWyS+yP0+JTtuR8PC+rGbcEHRUnK3W998WOQafxguG4tCRPCkYidRjzJhf9BmMaameT+
         njnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072644; x=1771677444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uG6I5gikyLFVYSOuPgYNTKiFjNKjj326HCn9/URW30=;
        b=FYhvcDsiexUKmpLocp8y2Un2LuHp1s+ldMs9iZrFjnDjC4TmGgSzRyT/3CKM2VKYXR
         KfpdXQN1FXDJ3Zg6z8HOZSiHwddPx2MMr19tKHpJ+by8MOIxhd0K+k1xCpfESuoL/04G
         yp3fkYCqLtZ2UMrLeRGrkkmdKi8gfTxo0r+sLgZ6WCWpVaIacuWbF1/LhgvY4jZbsmF7
         Xz0sgeiwXmWUEMvI1htewwWJz3P3UA7+7qx6eD1d4sfYevg1gjYIkJUwJDLLUA0QTW3T
         guiakZVbkPfpSuXM4xw2bXNA245KsYA4wlAOzKepUK5ZKDRjOobjkX6LXAkbNvZplwyh
         LVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZbSBULPhqehNKdrDqLA+m1gU05ZFHyQLdZ2jR2yVcxS0eakC17TaqvhSrhCqMQPI5c2hX6gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4lsRosKBSEcCijsg4lTxqz/nNLSHHftP1jc2haxQCcgfqMLb
	lajQWMijGeN/KZE0vv7RAVRZLKPx7UnZBTLpe4qwrOhMRXjwR75iWezKc2CJgtBEwzDtg1icz3W
	OD49FfDex+ojXV2eKv7TI5Wf+2glPm53JmZOA34xh
X-Gm-Gg: AZuq6aK4GW/mYgOVvi3zg6DlnuuUxurZXq/8YvDHFWKyTGeK0oLSzmF1EsFg1S2ccBt
	X4U8VDu6TGo8cs9IQ/LiMF58cFRuL3be/7LzzqrTre5k2MvwwmNudP3ztgbMAHOoLCAws/L3CIa
	ea8GSuuaKEP62Rsl+zkTy9OFBirm5jBW2NlRXmL27KKF3Wq4kV29g+t4LVNE0u1jFNzdZxnc4/8
	7gPjszPND/iZgSk+jD6SPgBTXeAwp0D/jm9RIwEx0c+hPyFL1Yvi4cv5I3VGbf37vicZKiD3Icw
	0h6EWb7VmQL+H1dSVg==
X-Received: by 2002:ad4:5745:0:b0:7e9:2697:dc63 with SMTP id
 6a1803df08f44-89734943619mr79619056d6.48.1771072643295; Sat, 14 Feb 2026
 04:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5E937E37585390AB0DB7DEE4@qq.com> <CANn89iKWn9i5TJNEiU1e1X4km-aK-J1dAvJSLbw5YOD-5EvY9g@mail.gmail.com>
In-Reply-To: <CANn89iKWn9i5TJNEiU1e1X4km-aK-J1dAvJSLbw5YOD-5EvY9g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Feb 2026 13:37:12 +0100
X-Gm-Features: AZwV_Qi8W8Co8NgmRvCkexUR_zVw_irCEzl7mBraZGQwDeOYhuxOhtxBx46ifsM
Message-ID: <CANn89iJvjpBNOjV6cv08bE+uBgur-5AHpyhB5P-s3Jzr3+SLWQ@mail.gmail.com>
Subject: Re: [BUG] Potential Null Pointer Dereference in nexthop_create_group Function
To: =?UTF-8?B?5Yav5ZiJ5Luq?= <23210240148@m.fudan.edu.cn>
Cc: dsahern <dsahern@kernel.org>, davem <davem@davemloft.net>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258700-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fudan.edu.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 3CFB313BE3B
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 1:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Feb 14, 2026 at 1:17=E2=80=AFPM =E5=86=AF=E5=98=89=E4=BB=AA <2321=
0240148@m.fudan.edu.cn> wrote:
> >
> > Dear Maintainer,
> >
> > Our team recently developed a null-pointer-dereference (NPD) vulnerabil=
ity detection tool, and we used it to scan the Linux Kernel (version 6.9.6)=
. After manual review, we identified a potentially vulnerable code snippet =
that could lead to a null-pointer dereference bug. We would appreciate your=
 expert insight to confirm whether this vulnerability could indeed pose a r=
isk to the system.
> >
> > Vulnerability Description:
> > File:  net/ipv4/nexthop.c
> > In the function nexthop_create_group, we found the following line of co=
de:
> >
> > if (!nexthop_get(nhe)) {
> >
> > The issue arises because the nhe pointer may be passed as NULL in certa=
in situations. The statement passes the nhe pointer to nexthop_get without =
any check, but nexthop_get might contain a dereference operation on the nhe=
 pointer, which could result in a null-pointer dereference.
> >
> > Proposed Fix:
> > To prevent the potential null-pointer dereference, we suggest adding a =
NULL check for the nhe pointer before attempting to pass the pointer to nex=
thop_get.
> >
> > Request for Review:
> > We would appreciate your expert insight to confirm whether this vulnera=
bility indeed poses a risk to the system, and if the proposed fix is approp=
riate. If there are reasons why this issue does not present a real risk (e.=
g., the NULL check is redundant or unnecessary), we would be grateful for c=
larification.
> >
> > Thank you for your time and consideration.
>
> This seems legit, I am not sure why syzbot did not find it yet.
>

typo  in @nhe. Should have been

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7b9d70f9b31c7ae6b2039cb321845b852bc81a33..36c58e4d5f0044e43498ea915ee=
2079864fab1e2
100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2742,7 +2742,7 @@ static struct nexthop
*nexthop_create_group(struct net *net,
                struct nh_info *nhi;

                nhe =3D nexthop_find_by_id(net, entry[i].id);
-               if (!nexthop_get(nhe)) {
+               if (!nhe || !nexthop_get(nhe)) {
                        err =3D -ENOENT;
                        goto out_no_nh;
                }

