Return-Path: <netdev+bounces-258699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCQdNDRskGmoZQEAu9opvQ
	(envelope-from <netdev+bounces-258699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:36:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13613BE20
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D2F3015860
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE032DCF72;
	Sat, 14 Feb 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na2ORBhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA1176ADE
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072561; cv=pass; b=IKNL+ZA8hFV6kzyZDFSjOimQC+PMbaP/DNx/kjHJdYelPzi5F0LEgj1m9wJo1tLB22K1sIk6mApq4/jStkSbXWlingJOdXNIM0uZCDwY3VuV6/OKO2t3oz2WS3UcnCbDk+JsSb2u8WCGUbRVbKqOet/129pTdTLsus+y05kSk+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072561; c=relaxed/simple;
	bh=jEeKaTLbxT1bb+gRF67wi0Ob6AYdKG8G4jnZZZJLyBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyEw5kcpD+VPjbJeu1GBg+6iJ59rv5jec7FCuoexOQ90Egvcg8E9TY7I5QGlYCP0prj2kJyeHp+Zk0nUhSbXh71XmGy4A46jH/w7EgRueoSpqaDZA/K4McBo9iKX0T9dVIQGvfACRPVwYN0MUPZrnW/Ul+XTdrDUqJlrgTkfoJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=na2ORBhh; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894674a4c4aso31535006d6.3
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 04:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771072557; cv=none;
        d=google.com; s=arc-20240605;
        b=P4rGWKhV/jQmPsblnsVivUzYusk2WYfXtKdnNdiADLopgCTMUMLoZvsY438rY/zxrF
         n2OPJEkpgRQMLiMnVzzD93HEH3LssDOYvRgRXyICZJiB5YFJM3hhdGL/zD2uky3FGgoS
         BO0OzLMylzLYvK+N+YPtH2Ryqgfw91xxhXS8KfIZzUUdQpoENaABzO61x4q1F1sLsSVz
         9O2cGdRrVUTozkW/ko5d1WNF8YmprYZjo2JKx1sfCYv1nVJbBFaZq0Cq9jitKhry+ikn
         oBmJM4jhLUd+bi0jcCcn+eParHzzaeXb2MgQaIqssissk3PZ+OV8cL2OdsogpyBZmgcI
         T9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/EKN8aSZNE8bGwyTTFisTDCe8sJWGxFmfrURkkD1To=;
        fh=4Rnu5A0Apj+kX8ts6oaknnCYsUzR7ODJB5q73yQjUiA=;
        b=GeKbqpyJTTNbPVx3xhOvtMYJtngTO/i6ITakNga20lgAEGRnVRUgXcYj3RDNRhS04u
         vGzH1/GeHEIjaC0Nm0jkVwHztJuFXeOMRQxjqtkb5gsIMUxM4jNHPLUJhldqNQqgS34O
         Cgk0e1LhrRRDZYwnBOtSp5CAa189mXDIrRN9pYQUGGy19+EUxb1ua5A1m5kBLchUBnZK
         Bu0pEwZhoXr2Jfx2L8neUFEgJTCInIIA8rWVxr2ic+HEWDh+u46suNn47QSHzTpP4xbQ
         YOYCHysxeKZumxwbzfdu6U2edP9VAyCUlDrHeLEJD66ydFb6OoGeVyxVLYdRJAer3oJb
         h8lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771072557; x=1771677357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/EKN8aSZNE8bGwyTTFisTDCe8sJWGxFmfrURkkD1To=;
        b=na2ORBhh7oJjFFTBqk0tcXYwkNLv6DMB4BkyBjM0oSeF4kv7BIPcRq/bsQqmCJaLyX
         44f5VYHcG6LQVE46Ch5g/6E6IcU0Bf6xE0Yb37iMlaW2cBVzb3+wgllYhxYqnXoPN/Fj
         CXEdvEgZokYQlCE1kgmoN+EZk1a5mZ8YuSZ+eLPX7lxDDnfMQpqPG0Kp9aLAWkgFNpPn
         nHGzQFoggtRkaU5sUevVNNYqarUSUlRyMdJoETNLyZHkgdZjtWM+hW0AADNmDcpjNIiL
         2CVYlRBhgrKxBAXLVM7p/y5MKSDCJhYfJemgRf33HUdFw+j5IByEw3PdvveP9YOWwtKr
         22Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072557; x=1771677357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/EKN8aSZNE8bGwyTTFisTDCe8sJWGxFmfrURkkD1To=;
        b=MHGSITWmLHcGNs8sJIeudJnAE5o2lhWxdbMxHKEkmfA8iLanApGttWSzRJU4BITS5n
         4e8ZFaFr89YXNIgXFpPeRP71yoLfOl3USQcOBlPIwBI+jZr2AAkwWMVuGiF6VtlA9kKO
         P1qwCyQS6LhSzDw08w0dMEil9Q8Ggf3oVv3mGLqY9Hie8vTnc57cMd9h7dG5ZJY8hQ9h
         n9XXy88taxSehT/AdIqbSP7gUfxU8BgiljCffJIk2X/8+x5pH6ngQdtrCxVmANo7SDNE
         mlaxn7fxHHInHemJX411bI8qf/Wjc8bdQf0a6gSz7Wjs1kVw0m/yqe17+eGBPG3guiFL
         bQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaVmGM9A/G37IKRFsQlNbJ3REk/GN1/1RuhEf04gbO6Biql0e/gW3LI4erfNDL4Sx6bJ8Lues=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUQmbVu46S5ffss/SlgCVN0fcVcOd3WpLfkGlGKRqT6ClBh9q
	824h/mgBiQE0qE7yrVek4ArY5kue4bhFutss0DPjBWDqsbnWJXtKErZyPpD2iUL1ZMKtT2mc7Wg
	vHXsyhpVN/fynJdHXEWvvT0Cj2sB3hSTgB07UWKpm
X-Gm-Gg: AZuq6aJTW/IsYBIY/ktUuZ9rDdGsOdT+l/PaiCUbPAyUtk/KXO7cggspmKpPASkn+u0
	UAUw5uqK1e2G9cf2mlJOESzLhrQCDZ5v6xdST06tmkeTUU7oChfEA/V2Ah6EkQowwIjAHgHhpvU
	ctMTLeBBJGnm3Cdn2/WcZbCHu7hPYFZp3kKfNCnLDAVkuAHG9ypyFRZWgEvEbnp/SlXKaJXkKay
	GP+OJ/4+diVbxZYUoRCdkWwycr+aMu72NypCtS2Ikbixp7GvTQWrG0HFpc5U210XnoHGp6L0ZVY
	ak6GZC4=
X-Received: by 2002:a05:622a:180b:b0:501:4b96:466d with SMTP id
 d75a77b69052e-506b3fffc94mr36165961cf.50.1771072556809; Sat, 14 Feb 2026
 04:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5E937E37585390AB0DB7DEE4@qq.com>
In-Reply-To: <tencent_5E937E37585390AB0DB7DEE4@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Feb 2026 13:35:45 +0100
X-Gm-Features: AZwV_Qgjlsc6AwYH8L45h-DGguh8OoeG0-MB0fZz7dQvd_V1pF8osProxr9JyJM
Message-ID: <CANn89iKWn9i5TJNEiU1e1X4km-aK-J1dAvJSLbw5YOD-5EvY9g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258699-lists,netdev=lfdr.de];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fudan.edu.cn:email,mail.gmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 4B13613BE20
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 1:17=E2=80=AFPM =E5=86=AF=E5=98=89=E4=BB=AA <232102=
40148@m.fudan.edu.cn> wrote:
>
> Dear Maintainer,
>
> Our team recently developed a null-pointer-dereference (NPD) vulnerabilit=
y detection tool, and we used it to scan the Linux Kernel (version 6.9.6). =
After manual review, we identified a potentially vulnerable code snippet th=
at could lead to a null-pointer dereference bug. We would appreciate your e=
xpert insight to confirm whether this vulnerability could indeed pose a ris=
k to the system.
>
> Vulnerability Description:
> File:  net/ipv4/nexthop.c
> In the function nexthop_create_group, we found the following line of code=
:
>
> if (!nexthop_get(nhe)) {
>
> The issue arises because the nhe pointer may be passed as NULL in certain=
 situations. The statement passes the nhe pointer to nexthop_get without an=
y check, but nexthop_get might contain a dereference operation on the nhe p=
ointer, which could result in a null-pointer dereference.
>
> Proposed Fix:
> To prevent the potential null-pointer dereference, we suggest adding a NU=
LL check for the nhe pointer before attempting to pass the pointer to nexth=
op_get.
>
> Request for Review:
> We would appreciate your expert insight to confirm whether this vulnerabi=
lity indeed poses a risk to the system, and if the proposed fix is appropri=
ate. If there are reasons why this issue does not present a real risk (e.g.=
, the NULL check is redundant or unnecessary), we would be grateful for cla=
rification.
>
> Thank you for your time and consideration.

This seems legit, I am not sure why syzbot did not find it yet.

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7b9d70f9b31c7ae6b2039cb321845b852bc81a33..1e77c241e8e1d111c75f3b12e33=
ea41088780fd5
100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2742,7 +2742,7 @@ static struct nexthop
*nexthop_create_group(struct net *net,
                struct nh_info *nhi;

                nhe =3D nexthop_find_by_id(net, entry[i].id);
-               if (!nexthop_get(nhe)) {
+               if (!nh || !nexthop_get(nhe)) {
                        err =3D -ENOENT;
                        goto out_no_nh;
                }

