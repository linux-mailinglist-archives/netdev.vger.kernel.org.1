Return-Path: <netdev+bounces-303313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cniYNxj/Q2ohnAoAu9opvQ
	(envelope-from <netdev+bounces-303313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:38:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EA6E6F6F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ULVIdvBq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303313-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303313-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 569963039A12
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C663DDDD9;
	Tue, 30 Jun 2026 17:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120803DE429
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:38:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841107; cv=pass; b=cQFlNynO0Yjvrlg/0/MVNnTuQ4X4ofI7hEdKBeiv3CJbtGnVTGstOIiAwpK0Vrcgvy5ccEZ+izCl9siuwCYpU8L0DRLQK7cbclqrWvSroS6F6hjJ+kgV9j2zLyfWbfXteBX7Ah1QBAbzjDmuTXKhydysOocw0jsIINNEuSNrgQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841107; c=relaxed/simple;
	bh=eIHErhMYQFL0B7YbkMxX5g2Vzr8d25EAgGgSdmM/U7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmwfkJLBSvDPBIVnxkqw73N0rofy0p1rqTZiE8K3bxj2Od/EvM30rlBJii1wy285HQlktceMp/o8SNAOxcBkoaBHnb0VTKpI+pbQt63gSnZZYVreoRl5BApqjU+wH5jUug8Iw7U1tsZqRPIgfjNihcWXxtSBFDnG/JQWd8MZRRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULVIdvBq; arc=pass smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso3235ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782841104; cv=none;
        d=google.com; s=arc-20260327;
        b=q4QFBo1L0wnWDYP5Z8afrxuKPrp9DTk6gk6h76XmxnegVBBaGTTD1WwlIHDvTsUcdS
         vcp6a6ozXFLDJwjqpeSCvyHHHt4fgmAVXiWsf0XU3xOjzgbG7BTgsk6Xe8GuyPlytHWI
         rJUSfX0fe1N/YeZYw76Oe9Rb2KMvvn5rdezKwnJLrHF0ZUzMU3CMNTzJrRL2a8vR1B+q
         cUS07S0qpEtQqvxkOOHxcLouWOO8W5p5Uo5d9KkHIxY5/d5UOrfzNHi14S+JmLILBr+B
         ASHnQKbSDxTaxiMY1x3bDAU9yT/8dGqVEtywUg3Kzo05BH9jHHKBZWEs6NNV2HXZGd3e
         urtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xvhn4dXUWxUVWf7UvjrsOYZ0ZQQrdCYE7C0z/HL34c=;
        fh=C38NiLBmKty8N8HcaYkoW6+y3PMS2R9/aELC+jg/9lw=;
        b=WftJXnGEmcvmN9dqpvMIdW/bUGojMeeBTnmzcztmDSd7CUMAx2l0hKToomgIiKT55m
         ZN48SOzOCmOy0q1VJVcaXAwagqIO9jh4DnQyvzXW1wKKoXpdgX5eywDGklZ1EfANovVi
         vLH9Khr+qbRZWi1DiMCXqdu/lof6gTiwIemwGJZZ8BNeybgc8uCSsvVz7+4um8JGm92S
         2ods1+qMQ0rFVbBsQabS2FKp9dRl39p0eadyaRTtq4H0kQv0gH2QLsCgo5mwjcvvqo+8
         URoEzT5MbNwsjnGhy/zNqBnRaF6ShqZ4RDrph5gubIurlapRpRO31ExzlOJLEJtuBX43
         JuLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782841104; x=1783445904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6xvhn4dXUWxUVWf7UvjrsOYZ0ZQQrdCYE7C0z/HL34c=;
        b=ULVIdvBqx8lG0U/wPvVzEvBy/N5wOCcMHcKHAWJTG2gLnB/gOKUnRYcNIn8XDD0LxB
         ku7+GZYlGQDb/LIjy60YhCAoyKP6IkljGbYDAUxcVegxdQsvOezDKcljBNyq+6wHgb8L
         tamhQrPGOAaX7S9PO5jA/pwEWUZxE6qikB+eiL2eEOujg/M6RoDVOg33KK/12/XX+H8K
         MyAJR+89RIV56yjV8PnClr0m1JuSPu7F9iNrAAoCoGly/Eb+gRHXB4d1uuhMVGIBVfxY
         SB/0CS7JkJ97QVbpOTh1XLVg+o0dGZq3O5g8FXwUBKTsHvQfPI11AubGo15+2MnHTo3U
         rJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841104; x=1783445904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xvhn4dXUWxUVWf7UvjrsOYZ0ZQQrdCYE7C0z/HL34c=;
        b=oMp2CWKO2rW2B2f2pRZ5BEKn/kE0Z6RwkyonOI9P+imMPumWWK2i7eW7YBjRojp7AX
         1JBhs1leZTSlWwmXjJ8eyBkc7+rkyIDqw/YrzyT9JH/iPoW9iKnFtH+y2+t13FypcWMJ
         w7gbHzi7p70ZnW/NlLvm+g26xjPwFyz9QFT9WIThYxLy6HopJeIwusSxTyE41He4yVF9
         wZuRoeFEu44G7PmNCPJMbmjjIF1Nt2bUpNNWvNZojTofpZYMO8Xfi50Zo9KgO/EyTA4b
         ebJGWmFm+UHW/DOdRA5fLDNCw3yl6eZfGnqpLJQQB/hdDUmGWhodUj8XbqRzE5ozwdyZ
         526g==
X-Gm-Message-State: AOJu0Ywt4+uqnOKI7dSgThgN1TlHuB4evFnpbql2PYDpjSewI7QlyfyP
	UD3VPwyGF9cCEDndt2jrkffmP2Y1snEyqg+G7Y/fPQbrsdS0BfhkilWB7ej9nmi75infG0xT5ih
	UDs4HlKA/OVaOzE0JCeP62PBnqZ4ne5tQkpVBdseC
X-Gm-Gg: AfdE7cl+6VuB+IMXHZHw2fan9njHxkZGFXjAOtjD0VeryO+VL5smosH7h6+sZ0OjwXU
	af1M1gjt9gsyqmpsAN37VQovwmjFeeknoXtz5ox3x/t90jWxC8VkXg2KwNN4vCpBEf4whvmMBEp
	Hwkncc5i0mES09Y7OhfQ8e8+c9sqPbBWDYvKBn+sX8PfJwdFlIdySd1lrFBSvWM59YRnbCGdfO/
	aWV13CjytUUSbavdbQEP8dNxYhhnPGCg7aXKDHKEW274WWCQqjmkMZS+eX8hyOwzy5uPWu40fxc
	5MZmSGHXMeNllKmhxyy1fe2PlYMFZ/Kti7+fNFogzG10eDYlcI1vJsHwZMM8ItqQQZEQKu4=
X-Received: by 2002:a17:902:e5d2:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2ca68a101d9mr188615ad.10.1782841103452; Tue, 30 Jun 2026
 10:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630162622.2667086-1-nshettyj@marvell.com>
In-Reply-To: <20260630162622.2667086-1-nshettyj@marvell.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 30 Jun 2026 10:38:11 -0700
X-Gm-Features: AVVi8CcAs9srRcQWupEsdwoSR1XEs7xbWr7DnyNaGulL_KAiBtIRAQH7ppp4IqQ
Message-ID: <CAEAWyHdiHuSq-49YjtB2YUxageMYnTacVKY0Ye-km-07YMh19A@mail.gmail.com>
Subject: Re: [PATCH net v3] octeontx2-pf: check DMAC extraction support before filtering
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, naveenm@marvell.com, 
	tduszynski@marvell.com, sumang@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303313-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:tduszynski@marvell.com,m:sumang@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 528EA6E6F6F

On Tue, Jun 30, 2026 at 9:26=E2=80=AFAM <nshettyj@marvell.com> wrote:
>
> From: Suman Ghosh <sumang@marvell.com>
>
> Currently, configuring a VF MAC address via the PF (e.g., 'ip link
> set <pf> vf 0 mac <mac>') blindly attempts to install a DMAC-based
> hardware filter. However, the hardware parser profile might not
> support DMAC extraction.
>
> Check if the hardware parsing profile supports DMAC extraction
> before adding the filter. Additionally, emit a warning message
> to inform the operator if the MAC filter installation fails due
> to missing DMAC extraction support.
>
> Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management fun=
ctions")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
>
> ---
> v3:
>  - Update config->mac only after hardware programming succeeds in
>    otx2_set_vf_mac().
> v2:
>  - Move the DMAC extraction check from otx2_set_vf_mac() into
>    otx2_do_set_vf_mac() which already holds pf->mbox.lock, so all
>    mbox operations are under a single lock/unlock pair. All error
>    paths now use the existing goto-out pattern, eliminating the
>    scattered mutex_unlock() + return calls from v1.
>  - Return -EOPNOTSUPP instead of 0 when DMAC extraction is not
>    supported, so the caller gets an explicit error rather than a
>    silent success.
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 44 ++++++++++++++++---
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index b63df5737ff2..697570765957 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2517,10 +2517,43 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
>
>  static int otx2_do_set_vf_mac(struct otx2_nic *pf, int vf, const u8 *mac=
)
>  {
> +       struct npc_get_field_status_req *freq;
> +       struct npc_get_field_status_rsp *frsp;
>         struct npc_install_flow_req *req;
>         int err;
>
>         mutex_lock(&pf->mbox.lock);
> +
> +       /* Skip installing the DMAC filter if the hardware parser profile
> +        * does not support DMAC extraction.
> +        */
> +       freq =3D otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
> +       if (!freq) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       freq->field =3D NPC_DMAC;
> +       if (otx2_sync_mbox_msg(&pf->mbox)) {
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       frsp =3D (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
> +              (&pf->mbox.mbox, 0, &freq->hdr);
> +       if (IS_ERR(frsp)) {
> +               err =3D PTR_ERR(frsp);
> +               goto out;
> +       }
> +
> +       if (!frsp->enable) {
> +               netdev_warn(pf->netdev,
> +                           "VF %d MAC filter not installed: DMAC extract=
ion not supported by parser profile\n",
> +                           vf);
> +               err =3D -EOPNOTSUPP;
> +               goto out;
> +       }
> +
>         req =3D otx2_mbox_alloc_msg_npc_install_flow(&pf->mbox);
>         if (!req) {
>                 err =3D -ENOMEM;
> @@ -2559,13 +2592,12 @@ static int otx2_set_vf_mac(struct net_device *net=
dev, int vf, u8 *mac)
>         if (!is_valid_ether_addr(mac))
>                 return -EINVAL;
>
> -       config =3D &pf->vf_configs[vf];
> -       ether_addr_copy(config->mac, mac);
> -
>         ret =3D otx2_do_set_vf_mac(pf, vf, mac);
> -       if (ret =3D=3D 0)
> -               dev_info(&pdev->dev,
> -                        "Load/Reload VF driver\n");
> +       if (ret =3D=3D 0) {
> +               config =3D &pf->vf_configs[vf];
> +               ether_addr_copy(config->mac, mac);
> +               dev_info(&pdev->dev, "Load/Reload VF driver\n");
> +       }

This is a valid change and would have been nice to mention it in the
commit message. Either way:

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
>         return ret;
>  }
> --
> 2.48.1
>

