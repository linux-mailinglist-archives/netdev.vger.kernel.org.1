Return-Path: <netdev+bounces-302073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E+pJI6SdPWpk4wgAu9opvQ
	(envelope-from <netdev+bounces-302073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E56C8C15
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FTnxzVL6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302073-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF2D23015CAA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1836F916;
	Thu, 25 Jun 2026 21:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F636C9D9
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 21:29:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422942; cv=pass; b=C3oTC2SiwVGu7nhcbqsEXDBYjVATViUxm1QKv6a6smT1i0Jyy6Xz+j1V9qNIwrsZK3RGOEmwwaNlcinFxDqqUfK3fEK6YlAzm5Sq1Q2gYVO/+X74zwvCbh1R6Rwpg7H/W2pmvCCx+spxqMc/oHK/UmbXYvhykpDdWfh5vTMMKaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422942; c=relaxed/simple;
	bh=1Xyx8W0Z+JIOWqgLlicHnvUh6a9r/45uuHSZaEVor34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iejNmymmZ1T17tYEXZH9IS0N9GdKRj3MDIVR8aEe4aNlkEMzc/16tJKzWaFzqNhr95B534OKlW42vjdDnA7Ea0Ro1jvt4u0ZHDMsMMzx0CXug9J1hM4YuSsYgQ4EC3NX8a6ZNGgxHqD/ih1+VAD96kHIYzeBCSiNeHO0RiwucbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTnxzVL6; arc=pass smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c813a45a65so5255ad.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782422940; cv=none;
        d=google.com; s=arc-20260327;
        b=aLsHJ9XzedV/scjLKXU4m03djnoURTCeh2DAJFeYjRlARKwGxk3eFqTZiO/Pwrd1lS
         fCqKNX6ZARjxG9tZcqyREu4zWFRQO4avX25fVGkqyIIdJ2jSHhIHxQHbk4gEdRH0levO
         Uf4XNeJmZ3a3f/w5BwQFd4ROgviQ3AnixINR2kbJBMgYzpKmHi2gNdLn9U3pRvz0DBMI
         CvycccmomNZOpaj2ZyokEH9TEkwfqXwKw9CDnMZ4Gpx3bvKKk9MAKe8H7/aYXKfwZYEZ
         asOZnh0DtxhdFtjhBheH+Snn+g19gOnlF/E3nY+HJ2GdHnSBLGMnOH6A8TVqa4AjYLlP
         Ppdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/K6FS8OHtfPW4sc0GOPpS1fFZMsSDr7GHXpqE3znQA=;
        fh=C38NiLBmKty8N8HcaYkoW6+y3PMS2R9/aELC+jg/9lw=;
        b=JuH7d4VbN/OHf26vOCKfYLMcCd4r1GoJfyrFvfvZbxWDl7wuceBYbfKFhYlXyOchoZ
         8K9yH4hvyRJbOv6Pk+sEOLAePGbz5Kn7LNFOuipSGAqdVF7zWVSrPJzruhz+LJeL4CJX
         htKAsOpVfeiQw+Yyv2LG0z3XTp6wic/OL4B6qYSVZaQQbrSlcLogbB4xx7cBym8RQk9V
         bNO2WYY4l2ZEExDWIN0MXhcrKQrJfTY2CakkS2L86RYIRWCQ3UrAooRMwvcIStXD7kMY
         0L6w5bHhcapCgRXefFM8N1Oqo4ui1TBSVocvzX0QL8wIa2gvC81Ua57ZloQ/1vdpMMAK
         W0Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782422940; x=1783027740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/K6FS8OHtfPW4sc0GOPpS1fFZMsSDr7GHXpqE3znQA=;
        b=FTnxzVL6MVL4HmtwwFdLJXEF8DLL8C1z6E40nMHDJlU0IzpV7eFiqUBOwgBinKH4oj
         UxhoXKo0LqQ+/iPezR3kQ73gXVAELN/U5rEN7KaqWqdyugvPKtdRbcc1FzRpdfDRH2/l
         eRH4KSnKipvAyk0YEGT1+j8XQFuYCG/GiNIoWgoHiFRsHq4Fel/C1LHD3NYvDWhmoVnt
         EzSWCtxFwkcat+WjP0xKCjyxG/X9RVnwV+Mn/FaaacVUm0RIKc3jExlNp5yvoJTXZFBC
         2h5I+X8VclFVkQ0lfi0ZbYBS2RMitqU9xvoepsUAX2GMpSJBoID7tuHINdspjO+qEGva
         omFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782422940; x=1783027740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/K6FS8OHtfPW4sc0GOPpS1fFZMsSDr7GHXpqE3znQA=;
        b=rT82IydQ3Oe0Evg0rJifuaygGc7RknqtJOrNhwkbH9wtcutXjnfiFl+qs+Hjtijfam
         YTkyDLIcSbwHlY+/nol3FYcV1Fsc+bj6fnzkSiCJwokTpxn2Qwf5wD0zbwjVrcuHfeL+
         gg8OH2bZZuEFTFKdS1RBZQb9Ic6A3hUKDV4Dengxydej3cGzBRh/xMm7WE21BSkIz8yX
         Q7oYYJjIrcT47/VsBUNAKhzoZDRdo6cqjouOyEJ28BKnCUm3N/DyulBxqw8m0UXCoddr
         bsEn3sfWHaFynfM2YRKv7hHtCE9sKGEOITIidv6ltdawnfdL9Zc9i5ZG3mToq9CaSYox
         BiwA==
X-Gm-Message-State: AOJu0YyRi4+Hp81FEnNG4vU/VHMPSL9bIH2dI7Kwab/6+b72futScsGz
	3arnCcfEANnhgKsEksA0IYvOWZT40msrBzBBYn3volmpn/n+1NPVsHYY+jRnGCEFNJcPkmf6CHH
	U4RFL4pnNQirMWO0p+7Tx3CuIrJsAvEFspr3Sng//
X-Gm-Gg: AfdE7cnYUnKMDG/tVK+/hnTwTAit8go8UO3JFetP5Ahh+7JL62wW8gSsPePagGZ1j3h
	NNP0CgnQnhPd6MsWLhQln9zxomjyO52H7vgOT3LAskqwdnq6YOBEWuoQrBP68P8D5xFdKuEtv/O
	kDvwvX+F0GJ8MI9b6Bl2+tJ10jGSJsf2fgx5Og/0olppDc95kirLxLv+ihV7Ubwkst7dlr6U3eU
	/xT1JVygHS3HJT4tjUcD7B80J5hjWeGbErxuPEJ65re8IO84M04l6TRx/JbZr6fTBFswA0mpkmF
	KrOpEMhQ63CfwyafT55AdUz8m0OVcFRm5bFhYdxH+CcGS0osvMOKdMLrtddVn/e5t8w43cw=
X-Received: by 2002:a17:903:3c45:b0:2c0:c14c:bf37 with SMTP id
 d9443c01a7336-2c813c7686emr894545ad.16.1782422939567; Thu, 25 Jun 2026
 14:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625172552.258631-1-nshettyj@marvell.com>
In-Reply-To: <20260625172552.258631-1-nshettyj@marvell.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 25 Jun 2026 14:28:48 -0700
X-Gm-Features: AVVi8Cc1oHG5aBBKsCSvhPO2YVe5u8bV1RFsWlCAToR1pRVw4gxUugJl1duSTgs
Message-ID: <CAEAWyHckcaun+DBH4ExSBOEXSDD4YfoaNEdtA+f7RXne9ic4-g@mail.gmail.com>
Subject: Re: [PATCH net] octeontx2-pf: check DMAC extraction support before filtering
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302073-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C5E56C8C15

On Thu, Jun 25, 2026 at 10:30=E2=80=AFAM <nshettyj@marvell.com> wrote:
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
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index b63df5737ff2..8e4435d9e520 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2546,6 +2546,8 @@ static int otx2_do_set_vf_mac(struct otx2_nic *pf, =
int vf, const u8 *mac)
>  static int otx2_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
>  {
>         struct otx2_nic *pf =3D netdev_priv(netdev);
> +       struct npc_get_field_status_req *req;
> +       struct npc_get_field_status_rsp *rsp;
>         struct pci_dev *pdev =3D pf->pdev;
>         struct otx2_vf_config *config;
>         int ret;
> @@ -2559,6 +2561,38 @@ static int otx2_set_vf_mac(struct net_device *netd=
ev, int vf, u8 *mac)
>         if (!is_valid_ether_addr(mac))
>                 return -EINVAL;
>
> +       /* Skip installing the DMAC filter if the hardware parser profile
> +        * does not support DMAC extraction.
> +        */
> +       mutex_lock(&pf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_npc_get_field_status(&pf->mbox);
> +       if (!req) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       req->field =3D NPC_DMAC;
> +       if (otx2_sync_mbox_msg(&pf->mbox)) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return -EINVAL;
> +       }
> +
> +       rsp =3D (struct npc_get_field_status_rsp *)otx2_mbox_get_rsp
> +              (&pf->mbox.mbox, 0, &req->hdr);
> +       if (IS_ERR(rsp)) {
> +               mutex_unlock(&pf->mbox.lock);
> +               return PTR_ERR(rsp);
> +       }
> +
> +       if (!rsp->enable) {
> +               mutex_unlock(&pf->mbox.lock);
> +               netdev_warn(netdev, "VF %d MAC filter not installed: DMAC=
 extraction not supported by parser profile\n",
> +                           vf);
> +               return 0;

Is the intent to return success here even though the MAC address was
not programmed?

> +       }
> +
> +       mutex_unlock(&pf->mbox.lock);
> +

Why not move all these checks into the otx2_do_set_vf_mac() since that
anyway acquires the pf->mbox.lock? That way you could also fold all
the mutex_unlock() calls introduced in the error paths in this patch
into the existing goto-out in that function.

>         config =3D &pf->vf_configs[vf];
>         ether_addr_copy(config->mac, mac);
>
> --
> 2.48.1
>
>

