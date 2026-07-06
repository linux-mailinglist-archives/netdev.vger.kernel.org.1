Return-Path: <netdev+bounces-305141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0O8KG3rfS2pVbwEAu9opvQ
	(envelope-from <netdev+bounces-305141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:01:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9F713A16
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:01:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cTjr7uPW;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305141-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66212305322E
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EFA433BC6;
	Mon,  6 Jul 2026 16:28:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E7433BA4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:28:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355322; cv=pass; b=e1Knz6syJyUC2P5HNzg10OfKQ7pgNsibKHclSZ0R878y00nsUAFpzsYZW8GffxKPzNYW64gTJknSP2jc3QzRkToitpiIopwKtYLOrVqFZpVKwdQYSTKrilWxadIHrgKTNcCGQOJcb3ztD1o9WKE1ljzXjh7hOQmzv9Mr7omXmKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355322; c=relaxed/simple;
	bh=7QY+KBMUKYnOqtZljO5Wr2/t9YJZL4Hk7DOpJsS8eUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVDVFa7nltyCGkYcue8JGAPjdhAAGvh5fgkU6kWKCF9JMoNR/wGyAWEjvzhhpEwmvMR62Do4J7RgXF4Ko6qGwKdn+nNBJqCr7Vf6lvP6HWpVfukvyg/L6fIy8l9JFBd3C9MWlijr5LhL9GCIkqrytAcSgkjsJutqJFfTArdSRe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTjr7uPW; arc=pass smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c81db32393so10535ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783355320; cv=none;
        d=google.com; s=arc-20260327;
        b=VPBs+r44dAmpsE4liyZYgtLmDiG8wyMbfkGXPifrfyiCCARDk+Ch1C7tXvUyi3++kr
         3EcV9hQEWJaNKGgjV/LhaofKJSHwCERloULLP7czMg+opEX8mIOBoxaapjiXhPZH9B90
         spVF278AFzXaeZi2WL37KRueKLFBq9c7WwjzV36TCtUnwnEwc+ZCJsdaa5YcUqE7FbKq
         oOyQgbwiJFDm/+2Yj6I4aKMSmB6Pa9jsUA91O5rQIlwDq6bwj76V94z0qMfvkZ/kbsT9
         t1FFL4dtsl5wToE+iwr3C69U1mPqwSxlxPINV0lxBUd6JfMWRCU3No7dOSRjveo8in9m
         AyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bl3BaNm26B5ENMjpP6EG9wB9Al78OALQ+7to5fddMAc=;
        fh=GUymXD5kQnZpz94E55ucTtQ6pyPnJBfrbPEOfao9ggs=;
        b=nUSDq/6mU5GmYHd3PiZ7yB38ZHQfuWYpBDPP00NaxaPhHsbvaQthL4o3VtaWBzT7KD
         FOy1/PTL4Q4Jh17E5NwzJs3nVn2X1QLDzr4wmcwCxSXFHfL5tNWNtpTyX9mzkKK26Kus
         POsKWNkfYKTHQlEcRnKcRRa2Qc8QDIH77GWOteskQCEfXL9mACGwl+/QjOjd3l+kn0ck
         wRSKYzueN7PpB9yYCFwsCvK1fFI5Re3q5endA8gJf6AOFnG8SHYXwTHtgq0yWG6nSkoA
         2Fjs03ZF/NjwQkgsfnjXbe0z2exNT5nVrV+hdJ41IAaWL25pOXJcHV2aHDVkOb4Ydykn
         7tHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783355320; x=1783960120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bl3BaNm26B5ENMjpP6EG9wB9Al78OALQ+7to5fddMAc=;
        b=cTjr7uPWuPcQqjyiTvdKrosH5wlzW+RkuHeZ0BhTg5FxYglVfxVETeFEZ+b2tIDBai
         3GKUY6hBuMkPHWROu2LQIok/7mOJQhcGcltgqv+i+fS/v5obm9+sbX2bN3iSqtDRPMKg
         35j4gAWjE+RkkGd3Al36I7mfmu4BKqMlKGI51L0klPnjzhmeep4gkk1vykUa8FEr8/DW
         rTctamP2Xi/w/8wKUcaTveSJL7LAIOohF5EIYraSG49LfsXEME+A1MRbvinDp3L08AhN
         ukxiJF4W8hFueMbm3x4D/u0MV6OLVacAcfLkbrS+xFw+GmF2HJ6UxZikQuXn19NdEvLV
         ZO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355320; x=1783960120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bl3BaNm26B5ENMjpP6EG9wB9Al78OALQ+7to5fddMAc=;
        b=HSFOzj6VIuG22qEf0mRmi5oP0GPsK1F2eweQFTx0T/s5R1mlO8i5+Wn+NttRKfnOh4
         Ixw2p0OhKRKwBWHgwOaMpY0m1Wm4FbNB64eu19sx9opO5c/V3MvpADE9GoRifUpqrZXD
         eWE06GRGfwC+nmKO/SnD9nFhkthgwjj+iWYUhQ3CmpDcJ1EWKS554a9iTkrNM/W1uuA8
         +1n57NMx8rR9Gc9uHGSpvI1r1aP7/mbcz5wOKnr0l3j91ZytIVxcs4LybHAmkAJqpJq8
         W4TwWrxBXjXXyk9DXpmkO3bcAT8XxKZ00SJtTByDHX4E6uDbS21xWphLbkYqtk7/f66t
         85LQ==
X-Gm-Message-State: AOJu0YwQHytEWSPRM+2v75uLiiJ83bAR+BS6euxA1ec3wlrr7p0BnL7T
	IFeZvs+woV3DqbOrAZ9BZJrxwp1UMX1EHKBrLo+uAMGeymLonrBH+AAb79qb+eWDQ07nK0jLtEO
	NfacKasw/u7jWsvTq0oTeit2dVzzq4Xij1bkqFk6/
X-Gm-Gg: AfdE7ckAmWBf1jxlkTMIhNxEBaICD0DpWZuknGg0rwoUcHQtUUDkX+M4Ucoojla9edI
	Ld2XEQEvF2Mm2JF7PKs+SE7BLZ+Im0uopVG3YJcMnxdY5ZtnglJ6AyySmQfh8HzkDS1oJENbK+8
	loxxFZFEh8a3IQy/IFbMX+VsY3mKL6eGrgAc9tmvvU/uhybxofR5rTomgWFIxZVlKtrJGRvGICv
	5BdFjgPK6XYuyguWV563RjAatsAwVcx9AXXqHRj+JUy/wTwOeoZKJM/Acufi5w0RVLi7kyKl/vV
	lxTcA/kZmD1F3oEgnbSJgYXYSso/vL+d2kyBSa15dDmaprW0DRA+9oF+hGQL7CYQZx0cWNc=
X-Received: by 2002:a17:902:ce8e:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2ccc4671ee5mr134235ad.7.1783355319913; Mon, 06 Jul 2026
 09:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702033451.2969880-1-nshettyj@marvell.com>
In-Reply-To: <20260702033451.2969880-1-nshettyj@marvell.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 6 Jul 2026 09:28:28 -0700
X-Gm-Features: AVVi8Cf96krcUpfFFlhMUNGB7Witt2Fc3MgfEJecmBH93ROIPct6ao8O7qJBaPM
Message-ID: <CAEAWyHfMSoYEJC9k3zZ0mBQgcfVSvxJaf5bHqunrHb4MYXFhPg@mail.gmail.com>
Subject: Re: [PATCH net v4] octeontx2-pf: check DMAC extraction support before filtering
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sgoutham@marvell.com, 
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com, 
	bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, naveenm@marvell.com, 
	tduszynski@marvell.com, sumang@marvell.com, rkannoth@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nshettyj@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:naveenm@marvell.com,m:tduszynski@marvell.com,m:sumang@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72B9F713A16

On Wed, Jul 1, 2026 at 8:35=E2=80=AFPM <nshettyj@marvell.com> wrote:
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
> to missing DMAC extraction support. Update config->mac only
> after hardware programming succeeds in otx2_set_vf_mac().
>
> Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management fun=
ctions")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

>
> ---
> v4:
>  - Return the real mailbox error from the NPC_DMAC support query instead
>    of masking it as -EINVAL.
>  - Updated commit message.
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
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 43 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index b63df5737ff2..888ebd6cef39 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2517,10 +2517,42 @@ EXPORT_SYMBOL(otx2_config_hwtstamp_set);
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
> +       err =3D otx2_sync_mbox_msg(&pf->mbox);
> +       if (err)
> +               goto out;
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
> @@ -2559,13 +2591,12 @@ static int otx2_set_vf_mac(struct net_device *net=
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
>
>         return ret;
>  }
> --
> 2.48.1
>

