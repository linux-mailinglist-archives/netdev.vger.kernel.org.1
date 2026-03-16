Return-Path: <netdev+bounces-268172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNjMNPYMuGkWYQEAu9opvQ
	(envelope-from <netdev+bounces-268172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:00:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F829AE79
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFB12300C54B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCF397E62;
	Mon, 16 Mar 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSWyc+nO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5852DBA21
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669551; cv=pass; b=nsv5AOFFgOkCBnFhlB/VUWAAQC5ZfRyk3a838Sl484Xev7CIjOCjvhbjFR/vynKNIRYixPsHBisL6obavu5J27UpIxkD/bs1vLidkkkgUIhk3Kuzm6mGLw0dAxW9iqffmsxDoy67TszLvPXOGNg1M5UjizKvTiNCENLVQAvRGiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669551; c=relaxed/simple;
	bh=qJaVFT62+tBBOzQgsyNPP7uEOQRNK9OA9/3qUcgCp48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqAvLUp0Tk5mwxAOVI5vHTSgzIQIGrx8vk1Ahaka0ZLL3WsFUjOybLhuzjm4YW7lIfitYx32YWWh3SVI/unXhwbvLYt7rgS7tMuk6ennugDwkKMyCisGxR44A2PmVVmRnMvQk5w7sbTWBTwjkwrQM5t30DjJlPPlPNT7vEvcqqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSWyc+nO; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso5598689d50.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773669548; cv=none;
        d=google.com; s=arc-20240605;
        b=NUSR976WJR+0PMR6cVU7sfLw1rlPdiqSOTXr3PNlRkUQ1j3aMMzHzI65Q+5jImsIqw
         lFNt68M0vbKgwAsrgBe+rky8vyQr/E7ZEGATslKvjSlpep6AAtdgTpY/xSpH5612mB8M
         G0OwJ+qBd3FBVzqq+OUlLCPRZo4pZhmcsg9W859sLpN1bAnY7OzOLs45K0QOx3/7Sbq9
         x7Mcfnd0Brq3ZalJaXgC18UkVUTuVcS7uMayWwlctj5TlewVlICvCeofHTdBZqSCOuQs
         xutLKQr9WS84Xfgh7Cw+1C0B0MlNeWH36f+TYHW1fe6iI7xUp0A+N0KdHpRRvex/wvo1
         Gggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AY6kgzk4e9IK4GcBnwZqqNR61VYtzIvaJyfFO9rm9c=;
        fh=1wJM+rBr2l/qXlz3ECHrLxRH9CpP1GkqvwOqikX5I4I=;
        b=fwpl8YIpc2Bzxs8vyM3FLd5JA05pEmjBTae1My+bqWa3bDdil8dbBhYi5z2rH6TUR1
         gkLfByXhUPhjlhN8I5Sojq2g55++Ntrz5Up3JI3r2sip6kUUewtlf2SYabG570D1kCpG
         MErOW8tKyUXeyCdArXKPpyXBGwV6MiKDKaREez1wD5d68Raej/3f/F6qlwLnId3Y7te6
         y9q46FVfMAgLG4ofeW6H7wF9kTBVu6sS3eqlOzU42skLzNHfy64MQiKg4ZwXKHN3E//n
         Ud4tsktKfJ3xf8KjdAEMOja2A/oYv2CAhmqllcZjQ44FR1hxLbc/ahxz302HBCzQ1Oe4
         c3qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669548; x=1774274348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AY6kgzk4e9IK4GcBnwZqqNR61VYtzIvaJyfFO9rm9c=;
        b=QSWyc+nOVVlU72Iswi8Dau1aR3Idbks/iyxgwC7o6E/MeoHX7LTswMufTgR8hBHWfA
         lYMu09uRV7riX3WfQHhuvSH0pG1GphQMN83WG1opt4Wqn9Yj5JSMTp9C2sch/emzcoY5
         IYax/GBZUgntD3QbvC0jpWghG12+1BvbboLMDLie361rNfDmjl/jORjqtSAKRqPFebL2
         N8yahYuteMpvlXTHZWp3woBz4TMZi24n3mpYw9m7SuyzT9mRaRz1wvPLtlH6ElpO0Cfw
         rss67prRL+D+Y6F3whw94PXTM0VgEKmhKqP3BB/K4gzEys4U8n4aaiulNbHyEmQD+ESV
         Zg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669548; x=1774274348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AY6kgzk4e9IK4GcBnwZqqNR61VYtzIvaJyfFO9rm9c=;
        b=aaBMsiCsj02JOTKHS1eXIl2V/QhIonU836RoJwPiadF7qw88OGazESVvsBmX1k/Dii
         MdrNQMtJCu4qcdBhowN4ObxHdDs6yY46EDcPgnzOHPc1kp1UJSLGqF8uq1gTeoTr0lfO
         Q3eDTytE3aZyiFfbvKXpx2ih3EFxi1Ymxp5w3SKxBSVbXDtp/CxexpSiKd7OhscrRg+T
         PFZ5aE+TlLZTYgtBVdatm39hV9oxZeHzJ6KKW8RTHy3ZUZd8oAEWF+2PCnqD33YJerP6
         3w16k76RNH5UmqxpOkK1Z4EQNe959zoBGes41vvpoI0UkvkfjpswAWAke4tWGBmInO+d
         dOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUA/nlqlU2Zmv7WfuMANi8hlhGcoW5FgNOeM1JUrBUHr5Q9NGNa7bD1nxzwa2hAEmGErQtzSfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDk5LbxYsC5t0y8ByH1ZjaoqI/r0jCFVliI65glb99GY8Qiug
	xt7RnP6gINGLVi2G202B6kwJRSZtlgbx1XDO/9C5TcsE/fb8ty5FDysOYbNyi/FDvmVVuM7u050
	SXoqMUC6maXPluM/JFRbULIVMbQqNFv0=
X-Gm-Gg: ATEYQzy1vzt69gpga93nDcGoGrufqmIS7NQK1wF3r/uBjBidSpZM+Zr4HacOTIlGRLP
	Jb88OYrNhaS6jHjUhNiUiN2yFAEuhRg1sS7qwsRnm2wH5Tq1ytWQyYbKY3HveL5h8zJrBjZt4wH
	wUWMtbaAapYrQUMHV9wqR9325Cd9XNveQJToghwB3W/p+yVrFBlbkYvsSM82hYbr/uC8Aq5jwsQ
	dPx15RGvfWoxkuhWu+TonyhG9oDjgC7QduSyiIOpQynVxXUdKDb+J4cvbLoQNKXqTXWvmY2UMQf
	sGd2tyoUGkwxLe34xghFZxbGC93RWHIP6nYxqzOlxEGZVaUN96TMKkTkgDW7vPDFVnc=
X-Received: by 2002:a05:690e:1485:b0:64c:e7b1:3577 with SMTP id
 956f58d0204a3-64dc7177dc8mr14854186d50.32.1773669548064; Mon, 16 Mar 2026
 06:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312200655.1215688-1-luiz.dentz@gmail.com> <20260314094707.105683b1@kernel.org>
In-Reply-To: <20260314094707.105683b1@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Mar 2026 09:58:56 -0400
X-Gm-Features: AaiRm537gYEA9yHSwpLsp_BA9z0HPXM0g1EUHZuGPNbC8aufZ3RpT97WaGxJl6M
Message-ID: <CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-03-12
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,syzkaller.appspot.com:url,huawei.com:email,intel.com:email,arri.de:email,vjti.ac.in:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 773F829AE79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On Sat, Mar 14, 2026 at 12:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 12 Mar 2026 16:06:54 -0400 Luiz Augusto von Dentz wrote:
> >  - hci_sync: Fix hci_le_create_conn_sync
> >  - MGMT: Fix list corruption and UAF in command complete handlers
> >  - L2CAP: Disconnect if received packet's SDU exceeds IMTU
> >  - L2CAP: Disconnect if sum of payload sizes exceed SDU
> >  - L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
> >  - L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
> >  - L2CAP: Validate L2CAP_INFO_RSP payload length before access
> >  - L2CAP: Fix use-after-free in l2cap_unregister_user
> >  - ISO: Fix defer tests being unstable
> >  - HIDP: Fix possible UAF
> >  - SMP: make SM/PER/KDU/BI-04-C happy
> >  - qca: fix ROM version reading on WCN3998 chips
>
> FWIW this is what our AI had to say about the series, mostly nit picks
> but not all (LMK if you want me to hook the AI reviewer up to your
> patchwork):

Sure, I like to receive reviews of that, note though that
linux-bluetooth and patchwork are for both kernel and userspace, so we
may need so quirks for detecting if a set is for kernel or userspace.

>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 1/12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> commit e1d9a66889867c232657a9b6f25d451d7c3ab96f
> Author: Christian Eggers <ceggers@arri.de>
>
> Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
>
> This commit adds proper validation and disconnect handling when received
> L2CAP SDU length exceeds the receiver's MTU, fixing compliance test
> L2CAP/LE/CFC/BV-26-C.
>
> > Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
>
> The Fixes: tag points to commit aac23bf63659 ("Bluetooth: Implement LE
> L2CAP reassembly"), but the function being fixed, l2cap_ecred_data_rcv(),
> was created in commit 15f02b910562 ("Bluetooth: L2CAP: Add initial code
> for Enhanced Credit Based Mode"). While aac23bf63659 introduced a similar
> bug in the older l2cap_le_data_rcv() function, shouldn't the Fixes: tag
> point to the commit that introduced the specific function being fixed?
>
> Suggested: Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for
> Enhanced Credit Based Mode")
>
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ad98db9632fd..3056dcd5fa2f 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
>
> [ ... ]
>
> > @@ -6689,7 +6691,9 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan=
 *chan, struct sk_buff *skb)
> >                      sdu_len, skb->len, chan->imtu);
> >
> >               if (sdu_len > chan->imtu) {
> > -                     BT_ERR("Too big LE L2CAP SDU length received");
> > +                     BT_ERR("Too big LE L2CAP SDU length: len %u > %u"=
,
> > +                            skb->len, sdu_len);
> > +                     l2cap_send_disconn_req(chan, ECONNRESET);
> >                       err =3D -EMSGSIZE;
> >                       goto failed;
> >               }
>
> The error message prints skb->len and sdu_len, but the condition checks
> sdu_len > chan->imtu. This is inconsistent with the first hunk of this
> patch, which correctly prints the two values being compared:
>
> net/bluetooth/l2cap_core.c:l2cap_ecred_data_rcv() {
>     if (skb->len > chan->imtu) {
>         BT_ERR("Too big LE L2CAP PDU: len %u > %u", skb->len,
>                chan->imtu);
>         ...
>     }
> }
>
> Shouldn't the second error message follow the same pattern and print
> sdu_len and chan->imtu instead?

Not sure I follow this one, both changes actually do print in similar style=
:

@@ -6689,7 +6691,9 @@ static int l2cap_ecred_data_rcv(struct
l2cap_chan *chan, struct sk_buff *skb)
                       sdu_len, skb->len, chan->imtu);

                if (sdu_len > chan->imtu) {
-                       BT_ERR("Too big LE L2CAP SDU length received");
+                       BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
+                              skb->len, sdu_len);
+                       l2cap_send_disconn_req(chan, ECONNRESET);
                        err =3D -EMSGSIZE;
                        goto failed;
                }

Oh, wait a minute, it is printing skb->len rather than sdu_len and the
second portion is also wrong, it should have been imtu.

>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 2/12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> commit b6a2bf43aa37670432843bc73ae2a6288ba4d6f8
> Author: Christian Eggers <ceggers@arri.de>
>
> Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
>
> This commit adds a disconnect call when the sum of payload sizes for
> K-frames exceeds the specified SDU length, addressing test case
> L2CAP/LE/CFC/BV-27-C as specified in Core 6.0, Vol 3, Part A, 3.4.3.
>
> > Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
>
> Does the Fixes: tag point to the correct commit? The current fix modifies
> l2cap_ecred_data_rcv(), which was introduced in commit 15f02b910562
> ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode"),
> not in aac23bf63659.
>
> Should the Fixes: tag be: Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add
> initial code for Enhanced Credit Based Mode")?

False positive, this only really apply after aac23bf63659.

>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 3/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 4/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 5/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 6/12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> commit 17f89341cb4281d1da0e2fb0de5406ab7c4e25ef
> Author: Wang Tao <wangtao554@huawei.com>
>
> Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers
>
> This commit addresses two issues from the 302a1f674c00 rework that
> changed mgmt_pending_valid() semantics: fixing double list_del() in
> mgmt_add_adv_patterns_monitor_complete() and removing incorrect
> mgmt_pending_foreach() usage in set_mesh_complete().
>
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index a7238fd3b03b..d52238ce6a9a 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
>
> [ ... ]
>
> > @@ -5377,7 +5374,7 @@ static void mgmt_add_adv_patterns_monitor_complet=
e(struct hci_dev *hdev,
> >
> >       mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode,
> >                         mgmt_status(status), &rp, sizeof(rp));
> > -     mgmt_pending_remove(cmd);
> > +     mgmt_pending_free(cmd);
> >
> >       hci_dev_unlock(hdev);
> >       bt_dev_dbg(hdev, "add monitor %d complete, status %d",
>
> Is this change actually correct? Looking at the function entry condition:
>
>     if (status =3D=3D -ECANCELED && !mgmt_pending_valid(hdev, cmd))
>         return;
>
> Due to short-circuit evaluation of '&&', mgmt_pending_valid() is only
> called when status =3D=3D -ECANCELED. On the normal completion path (stat=
us !=3D
> -ECANCELED), mgmt_pending_valid() is never executed, so cmd remains linke=
d
> in hdev->mgmt_pending.
>
> Calling mgmt_pending_free(cmd) here would kfree(cmd) without unlinking it
> from the list first, leaving a dangling pointer. Any subsequent list
> traversal (e.g., mgmt_pending_foreach during __mgmt_power_off, or another
> mgmt_pending_valid call) would dereference freed memory.
>
> Compare this to other MGMT completion handlers which use '||' instead:
>
>     if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
>         return;
>
> With '||', mgmt_pending_valid() always executes on the normal path and
> unlinks cmd from the list, making mgmt_pending_free(cmd) safe. Should thi=
s
> function's early return condition be changed to use '||' to match the oth=
er
> handlers?

That is an issue indeed, ack.

>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 7/12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> commit dbf666e4fc9bdd975a61bf682b3f75cb0145eedd
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Bluetooth: HIDP: Fix possible UAF
>
> This fixes the use-after-free caused by not dropping the l2cap_conn
> reference when the user->remove callback is called. The patch drops the
> l2cap_conn reference in hidp_session_remove() and adds NULL checks in
> both session_free() and hidp_session_thread().
>
> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index 6fe815241b01..7bcf8c5ceaee 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
>
> [ ... ]
>
> > @@ -1164,6 +1165,15 @@ static void hidp_session_remove(struct l2cap_con=
n *conn,
> >
> >       down_write(&hidp_session_sem);
> >
> > +     /* Drop L2CAP reference immediately to indicate that
> > +      * l2cap_unregister_user() shall not be called as it is already
> > +      * considered removed.
> > +      */
> > +     if (session->conn) {
> > +             l2cap_conn_put(session->conn);
> > +             session->conn =3D NULL;
> > +     }
> > +
> >       hidp_session_terminate(session);
> >
> >       cancel_work_sync(&session->dev_init);
>
> Does setting session->conn =3D NULL in hidp_session_remove() create a
> race with hidp_connection_del()?
>
> Before this patch, session->conn was always a valid pointer (initialized
> in hidp_session_new() and only released in session_free()). After this
> patch, hidp_session_remove() sets session->conn =3D NULL.
>
> Looking at hidp_connection_del():
>
> int hidp_connection_del(struct hidp_conndel_req *req)
> {
>         ...
>         session =3D hidp_session_find(&req->bdaddr);
>         if (!session)
>                 return -ENOENT;
>
>         if (req->flags & BIT(HIDP_VIRTUAL_CABLE_UNPLUG))
>                 hidp_send_ctrl_message(session, ...);
>         else
>                 l2cap_unregister_user(session->conn, &session->user);
>
>         hidp_session_put(session);
>         return 0;
> }
>
> After hidp_session_find() releases hidp_session_sem, there's no
> protection preventing hidp_session_remove() from running concurrently and
> setting session->conn =3D NULL.
>
> If hidp_session_remove() runs between the hidp_session_find() return and
> the l2cap_unregister_user() call, then l2cap_unregister_user() receives a
> NULL conn pointer and immediately dereferences it in its first line:
>
>         struct hci_dev *hdev =3D conn->hcon->hdev;
>
> causing a NULL pointer dereference.
>
> > @@ -1301,7 +1311,9 @@ static int hidp_session_thread(void *arg)
> >        * Instead, this call has the same semantics as if user-space tri=
ed to
> >        * delete the session.
> >        */
> > -     l2cap_unregister_user(session->conn, &session->user);
> > +     if (session->conn)
> > +             l2cap_unregister_user(session->conn, &session->user);
> > +
> >       hidp_session_put(session);
> >
> >       module_put_and_kthread_exit(0);

Ok, this shouldn't have been merged, the follow up patch fixes the
same issue, although perhaps having them both sort of garantee
hidp_session_remove and hidp_connection_del cannot run concurrently.

>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 8/12
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> commit 752a6c9596dd25efd6978a73ff21f3b592668f4a
> Author: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>
> Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
>
> This patch addresses a use-after-free bug reported by syzbot where
> l2cap_unregister_user() dereferences conn->hcon->hdev after the hci_dev
> structure has been freed. The fix switches from hci_dev_lock to conn->loc=
k
> in both l2cap_register_user() and l2cap_unregister_user().
>
> Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
>
> > Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
> >
> > After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> > hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
> > conn->users. However, l2cap_register_user() and l2cap_unregister_user()
> > don't use conn->lock, creating a race condition where these functions c=
an
> > access conn->users and conn->hchan concurrently with l2cap_conn_del().
> >
> > This can lead to use-after-free and list corruption bugs, as reported
> > by syzbot.
>
> Does the commit message accurately describe the syzbot-reported bug?
>
> The syzbot report (syzbot+14b6d57fb728e27ce23c) shows a use-after-free in
> l2cap_unregister_user at the mutex_lock_nested call. The actual crash
> happens because the hci_dev structure (accessed via conn->hcon->hdev)
> was already freed when l2cap_unregister_user tried to lock it with
> hci_dev_lock(hdev):
>
> Crash site:
>   l2cap_unregister_user -> hci_dev_lock(hdev)
>   where hdev =3D conn->hcon->hdev
>
> Freed by:
>   hci_release_dev -> kfree()
>   via vhci_release -> hci_free_dev -> kobject_put -> hci_release_dev
>
> The freed object is an 8192-byte kmalloc slab (hci_dev), and the crash
> task is khidpd_* (hidp_session_thread).
>
> The commit message states "This can lead to use-after-free and list
> corruption bugs, as reported by syzbot." While the theoretical race on
> conn->users IS possible, the actual syzbot-reported crash is about
> accessing freed hdev memory when trying to acquire hci_dev_lock, not
> about conn->users list corruption or conn->hchan use-after-free.
>
> >
> > Fix this by changing l2cap_register_user() and l2cap_unregister_user()
> > to use conn->lock instead of hci_dev_lock(), ensuring consistent lockin=
g
> > for the l2cap_conn structure.
> >
> > Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
> > Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_=
del")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 0f400051f093..780136e18aae 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_stru=
ct *work)
> >
> >  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *us=
er)
> >  {
> > -     struct hci_dev *hdev =3D conn->hcon->hdev;
> >       int ret;
> >
> >       /* We need to check whether l2cap_conn is registered. If it is no=
t, we
> > -      * must not register the l2cap_user. l2cap_conn_del() is unregist=
ers
> > -      * l2cap_conn objects, but doesn't provide its own locking. Inste=
ad, it
> > -      * relies on the parent hci_conn object to be locked. This itself=
 relies
> > -      * on the hci_dev object to be locked. So we must lock the hci de=
vice
> > -      * here, too. */
> > +      * must not register the l2cap_user. l2cap_conn_del() unregisters
> > +      * l2cap_conn objects under conn->lock, and we use the same lock =
here
> > +      * to protect access to conn->users and conn->hchan.
> > +      */
>
> Does the new comment fully explain the reason for the change?
>
> The comment states that l2cap_conn_del() unregisters l2cap_conn objects
> under conn->lock, and we use the same lock to protect conn->users and
> conn->hchan. This is factually correct.
>
> However, the comment omits the actual reason for changing the locking:
> the old code dereferenced conn->hcon->hdev to acquire hci_dev_lock,
> but hci_dev can be freed before this point, causing the use-after-free
> crash that syzbot reported.
>
> The comment describes a secondary benefit (consistent locking for
> conn->users and conn->hchan) rather than the primary bug being fixed
> (accessing a freed hci_dev structure through conn->hcon->hdev).

Might need to update the docunentation, but it is not incorrect.

> >
> > -     hci_dev_lock(hdev);
> > +     mutex_lock(&conn->lock);
> >
> >       if (!list_empty(&user->list)) {
> >               ret =3D -EINVAL;
>
> [ ... ]
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 9/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 10/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 11/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> PATCH 12/12 - No review comments
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D



--=20
Luiz Augusto von Dentz

