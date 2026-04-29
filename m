Return-Path: <netdev+bounces-282227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GjJArt88WnohAEAu9opvQ
	(envelope-from <netdev+bounces-282227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:36:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F3F48EAED
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 05:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B426F303CFB6
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B469388E60;
	Wed, 29 Apr 2026 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmyBpt83"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9035F5EC
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433779; cv=pass; b=tOq2g5WgTXmnsF6iKeZAPv+UpdWtVs45hgRMro1vNBIfpQeH3ilnwJRPPCmsYqidxvGbw0w1edF4y19mmCZLFRJBL3Qmf1AnDGlc3kPHckc5urZG3P0jUlE+y04wp2ml2dek7BVNDFlEa799TOgjrLqtAlfIkdAMDIqjBozrBOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433779; c=relaxed/simple;
	bh=YamCqSKIdjkALrVbNwW3l/AXx1C62WSSiRUdUJBLVq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFCVPlFBl0tpF7DS+96Q48pNMW3sCTRluQXGJ49J37mPqdU0P5cNALferVnLlGkskSaqbBddFePKnkXIi6Xp7f91fgaJFU8pWyBwxY+VdR17hEIBeF+MPA4O2dU7fFc2a/ZLQjHnZ1n6L8tU846n+BNhZyMDZvK7qyXFjqKZgxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmyBpt83; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso5214521a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777433776; cv=none;
        d=google.com; s=arc-20240605;
        b=URyLw+zxud3T0XaR11Dng6P5atp4LvQrdtxUJcSXQd7y9erjfCWIo9IL+Xs8IpnhG6
         22pXdPRLwoGrIhn+t/DDbf7o2zGloL3l/gpBxwcrZ42+zuGBEDb/po5l5EcRbnEmJOQY
         Vmu+u4BBa4GKWYpBNWRtM8alDIfCyaPzu9+M05zyjrio/YUWvQFI2odeONpMFYTy/MDK
         IFsGKC50iXoQNi4HM0qiCc0RCgPmUnSMXr5pjlJq5lVmOX58hq/KXYOXAN7jU3aSKMKm
         ZSKS6Bf1X5a4CtdRBwtUxQVUTRzscdNGyb1B9n9r8jfkeYP+bM/w9u9BMcFq7Gb8BMvy
         ISTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AU2UnXG3rfuiGVmMpgrkBvpYMS2eRzTOHC6WX9BNGfU=;
        fh=VtzY92b7NOzVwvVmCxI9n1s/ldfenFbXkJYQamZ0Hww=;
        b=gaeVXjbhubbn/HkcCbXyxV40t9gIRjdruYuSM5+7TxaGgckb2tidyBLbiZh3SjE2wR
         L/QcohFpPfK8ua08nxEWmqOIKGSDvhUVctUD2axd7lZgGFKgh8YNabDjxgvCJ6iua1Gw
         TXJJX0UnOay49madwp/w+n4KefIvRcbiLhSOb5pfBLrzW2tPkrBlSwPpE2s42Oj6HSW+
         zoVNaj4URnZo9UdBdXlK9TzPhz4WqTUjslAmVa9m+PHrPT47JAkkxcAHuxp9EWECT+Zc
         y+E+NSXVD5glV2jB0U4YNO9+LS+lmnvA0atZYOT3GUvejWAujWwRYp1/mhRGMCi9LwGs
         cW3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777433776; x=1778038576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU2UnXG3rfuiGVmMpgrkBvpYMS2eRzTOHC6WX9BNGfU=;
        b=nmyBpt83ZDIvilLI9HrrPmsHb84iyetW7V0G6ko5LfkO+UtuSmQ6eHLIPT8pGkkF7o
         wP6aQ3d7GIpBMiRhQ4ktaI600keUn6OHMcNKHLmnt8tsCW26nB6hboNBVNW5si+aLLuw
         XTzQYW/GVl8+5XVj36HKLzBJ/+d1zj3PyI9PvlSXHzXHsBuTOT4BU9sgEvdzvsDxf2Ww
         h5/PNAk/VPRB0Oad6TPZde7RAuweZt6lt0FneQUABl/q9tgbyCCz2hJXpCO5B+CCTdbq
         GFYVgv23/uuYDj0AuCq3nSXAf5Nxn6NGZfiHbSgIi9cZDUANbMxZK+hYfufU2xnWgHZM
         QWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777433776; x=1778038576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AU2UnXG3rfuiGVmMpgrkBvpYMS2eRzTOHC6WX9BNGfU=;
        b=CXwU9wd0DeaVV2LjRLlr/KoA0q3YnGTQLhUuNnnOLCC1c+krwFMym/GcR1qs+6SMxL
         HKBpP/orT43cw+PTOQPEGbTCp6rvUcTiTR3qUCGfm0kMKUhDAWdtMsEUBJN/iQ/mjvpW
         hNiPxTKlLzFj+S5GV7O6tnZO1YT/wf+d5l90WZthxOjCvsRZ0U+z36rIIiCN3LjCCkeN
         iJrj55mSBor/D3TLtRDFhIZ/nhjhg6iHkUuq9X1AwhT50+HOG1lBaDLfZUaJ2qLiMGGV
         CXp4bu6SmIuVVHEnzD10KFTbQcp46VDDpljwpt7+XgcbBytFKMPv/VcHt3rQCZwfklzI
         mVSQ==
X-Gm-Message-State: AOJu0YwnqAJ30CYBjEatZthpAFDLj9sPkwsyQGXtPP4Hla6CC4hrRBVU
	uzamgR6xJPswRewlGk+XXpJP/hv644TMaeUduMA5+QXBUO/PAc8+oyjdL0cCPGYXpEcyFwUHTvd
	NgjpTCKcp9LNR/0HZRM+VMFB1l7pSyns=
X-Gm-Gg: AeBDiesGlUq7x4vGeqTjFr6RM4dCW8+j5s8nfa7oktN9IuZzCStaFk6g1til7iN7tQ+
	3RguZBJ7v+TRqp4chlqtiqt/rgclNByVBjbKhniSDFUZCMgNScK2487js6m7P18gElk5IXDOyaQ
	SApj8I3ez+puCUtfb9H9VQvXAWHkDs4hexTKxC0KaztuLNAFp9xP8Ym6Cv4JfXDQcTR95spO843
	4ELUOWTAlhuGeNW+qITWUcm2hL49q4MSTkLW2OEmnY3BdeJW8BlY/+yJDZzTw/oLvr3wNMIO0Mk
	bxPU9Gz97SQ7D47wOEOWCEH/5AmO1CttzOUGwBC6mlWzVAGHVHCCBnuBxXu0rVx8clg4n5WE0mB
	paBrbwwn79ST/ZpSeINjqBXwPKNJeoFwrb8Z/RDCSEGZlfo3uErLeIllEqzg=
X-Received: by 2002:a05:6402:4544:b0:66d:d07c:a8ea with SMTP id
 4fb4d7f45d1cf-67b1fdd6a67mr839431a12.7.1777433775831; Tue, 28 Apr 2026
 20:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428014329.779779-1-rosenp@gmail.com> <df793a62-b0a6-4500-94e1-05ad54ba830f@broadcom.com>
In-Reply-To: <df793a62-b0a6-4500-94e1-05ad54ba830f@broadcom.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Apr 2026 20:36:04 -0700
X-Gm-Features: AVHnY4L4QVDIiENS5CHBwB26r1TARLAs0PiBpwOyYLoBOZjqa4vCW5l5LC_e7S0
Message-ID: <CAKxU2N8kZnLBKgatxc+rMF8_4sz8N6LnK_FFuAM+OhMg9BLLGw@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: bcmasp: handle EPROBE_DEFER for MAC retrieval
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:BROADCOM ASP 2.0 ETHERNET DRIVER" <bcm-kernel-feedback-list@broadcom.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 74F3F48EAED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282227-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email]

On Tue, Apr 28, 2026 at 10:43=E2=80=AFAM Justin Chen <justin.chen@broadcom.=
com> wrote:
>
>
>
> On 4/27/26 6:43 PM, Rosen Penev wrote:
> > of_get_ethdev_address can return EPROBE_DEFER when using nvmem. To
> > handle this, encode the error with ERR_PTR for minimal changes. Adjust
> > the only place using bcmasp_interface_create.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   v2: use dev_err_probe.
> >   drivers/net/ethernet/broadcom/asp2/bcmasp.c      | 6 +++---
> >   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++--
> >   2 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/=
ethernet/broadcom/asp2/bcmasp.c
> > index 972474893a6b..e9b11b956344 100644
> > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> > @@ -1333,10 +1333,10 @@ static int bcmasp_probe(struct platform_device =
*pdev)
> >       i =3D 0;
> >       for_each_available_child_of_node_scoped(ports_node, intf_node) {
> >               intf =3D bcmasp_interface_create(priv, intf_node, i);
> > -             if (!intf) {
> > -                     dev_err(dev, "Cannot create eth interface %d\n", =
i);
> > +             if (IS_ERR(intf)) {
> >                       of_node_put(ports_node);
> > -                     ret =3D -EINVAL;
> > +                     ret =3D dev_err_probe(dev, PTR_ERR(intf), "Cannot=
 create eth interface %d\n",
> > +                                         i);
> >                       goto err_cleanup;
> >               }
> >               list_add_tail(&intf->list, &priv->intfs);
> > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers=
/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > index ec63f50a849e..caf0e408e2f7 100644
> > --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> > @@ -1254,7 +1254,7 @@ struct bcmasp_intf *bcmasp_interface_create(struc=
t bcmasp_priv *priv,
> >       struct device *dev =3D &priv->pdev->dev;
> >       struct bcmasp_intf *intf;
> >       struct net_device *ndev;
> > -     int ch, port, ret;
> > +     int ch, port, ret =3D -EINVAL;
> >
> >       if (of_property_read_u32(ndev_dn, "reg", &port)) {
> >               dev_warn(dev, "%s: invalid port number\n", ndev_dn->name)=
;
> > @@ -1314,6 +1314,8 @@ struct bcmasp_intf *bcmasp_interface_create(struc=
t bcmasp_priv *priv,
> >       }
> >
> >       ret =3D of_get_ethdev_address(ndev_dn, ndev);
> > +     if (ret =3D=3D -EPROBE_DEFER)
> > +             return ERR_PTR(-EPROBE_DEFER);
>
> Do we need to hit unwind here? i.e. goto err_deregister_fixed_link.
Yes we do. In other news I just sent another v2 by accident. Guess
I'll wait to send a v4...
>
> Thanks,
> Justin
>
> >       if (ret) {
> >               netdev_warn(ndev, "using random Ethernet MAC\n");
> >               eth_hw_addr_random(ndev);
> > @@ -1340,7 +1342,7 @@ struct bcmasp_intf *bcmasp_interface_create(struc=
t bcmasp_priv *priv,
> >   err_free_netdev:
> >       free_netdev(ndev);
> >   err:
> > -     return NULL;
> > +     return ERR_PTR(ret);
> >   }
> >
> >   void bcmasp_interface_destroy(struct bcmasp_intf *intf)
>

