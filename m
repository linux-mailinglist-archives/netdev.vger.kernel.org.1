Return-Path: <netdev+bounces-302286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8tw5J24eP2roOwkAu9opvQ
	(envelope-from <netdev+bounces-302286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:50:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73F6D0A5F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZJvq22QA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302286-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302286-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E87B1301389C
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643051A08AF;
	Sat, 27 Jun 2026 00:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459281ACD
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 00:50:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521452; cv=pass; b=fgonPEP9sZQj2S0qyuPFlb+C/6Wk4UqmtSuM6Sx3JKFIMMYrJLYHbQj4WSTzxbtfJfiqxx4X22hoCRJI71xJkI6Niwjvhs6NFQDCgveZaAmIyYlB1zJCuvgSv0lc893fDCmEkuNkJrrtjewAQVDH1hIQsuxEZ3LXjBxBudUMYbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521452; c=relaxed/simple;
	bh=dyYFJDCgaSk7eapP/C9+oIGcGao/hkh7t2b9xftR+i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYn1TL/PSS681P79mJ2oShQ5XXMXAU+tUlOUH6cq4TCb77cvuPUfaktWMtxIuma2VVuN6QSjBIJRIkCJW0RRJgNQsvkCFCxtOg40e8glYpArLJ73va/uvUOHPp8w0oAP1TMeI0lqBn6FM4iKXtTZFS6CjRi5uuBcT0mHivQaMLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJvq22QA; arc=pass smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b1db4964so2495ad.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782521450; cv=none;
        d=google.com; s=arc-20260327;
        b=pFnPuzBel6kWp6utU9RGZNB810cvm7KqbYNgtI0XzXPsTekYOwHD9Hrm9q6lPmU+xo
         rYZJobuyz5rgf5Qt4Y2WWdWOFkk3paLh24C90zsOuZJcWkTUDLDX+rXQzlVRLxLvqQrd
         6U+dYgy3dWfEC/StTFz5kocxeYgt89/OofyS/MBFS4IUOHIw0vyfENGr8xs413BSYaCV
         S6YFi5gp58OvIQ9sdIF7s0Zs3irWxugLWf5S9Pc6IYUHjoT9FJkMqzBXp9s/HtTivnK2
         onBejqtdvkf0IYtcrm3+pybk50FrzHUNAapGo//h/yTmQ8vs/digODE+h85in2uM5+0V
         r7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5iJHXBCty3afTluExoEsGbj8XtCBYBexHvE+K2fdDRA=;
        fh=C38NiLBmKty8N8HcaYkoW6+y3PMS2R9/aELC+jg/9lw=;
        b=DcJ3qQ5seBM7zOwXirRVP1zeUQ9Pba+ek+lIeh+QIfAJGVxQuMsy/bwLkvzw7dtgkP
         a0B1JMjRaQQtdvCZjEqb7apr/b/aLbQqwv/oZFz75uDImHwizgevV+Im/Te1JZki8dif
         yQBXj5+rYKDYeNa+6cN7VY1gzbmr4EVeX2Sk/o/6UqVP5rrO/HfXqoV/+hkcEM31l6Xh
         gsxCGRCGWXJ97RT7Vij+FdzgK4vqhvuVZjHAQcU10P1TZUBE5+rTUKZiVn4cWTEpS154
         D10YKepdXTdjkM/+9Xtfrfv7ZMS5oMhySrYNkhXkh5B1oORfXlYXMYk+NMom1wq9yCod
         3wdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782521450; x=1783126250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5iJHXBCty3afTluExoEsGbj8XtCBYBexHvE+K2fdDRA=;
        b=ZJvq22QAIMEO2LNRSgXH4SVI2RuuxUmqewaqLt3IYLQn6xdaNo1gBraWtNuTmozcCD
         KWwpxRPTiQN8X86nCLIQc8iBDkIFQGsIC2c3WsQ00uQkbG8xTwTrd8OtxgGKmOwgjX3W
         7cpKznfTnB60475e7wYg/Qp8/BhsH4flvSWU4d54Qdv2Bn1730cRVuChh/eWbw53AdPI
         zr1G+8YL0X8Rd/7tP+j2n8uwOg+KRqUf6/HiLQzOS0yRRzez9UXFxKt50yRc717CYwe1
         0jKjKO0c8YrDoXCVHoR5IvZBDTklPvTatset9QwoT9WKCR7H55ILSIII76hpyykY69Kr
         HLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521450; x=1783126250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5iJHXBCty3afTluExoEsGbj8XtCBYBexHvE+K2fdDRA=;
        b=BdAUiT2K8h6HLwusIuOuyBR6Sysa3ZxdiooK00fujghI/B4/wX7233x3aE10rVxboN
         Ro0kjsZ94FaPlJ69esNXb/LT64n44Q6vvO4JhAixvy95NVpaKidvo7jkHJqKBlJOcxsU
         P7aiVm/iLaJoDyG4hqCG+0bbeSTbQ1zJqqozzwvA4qnurVQOTnCPK6IsI6wgLjwsU5gd
         0WGEErq5AkCfsdDLu8sPw2H4VTphov+gyTYX4M7I7KxexvIhjASoJcVjx7inz2edxnHm
         TITmqWAifiqEaeaQKZl3uixdRtGwu5A+xRTNVkoDLLTPrt/oUu429AlMUVmih7s3OlYe
         pHQg==
X-Gm-Message-State: AOJu0YywmzN6WCdm3o5k4p/Qb097bI9gEcPlf++6G/3erbcZab/cBnG2
	Y0DNtglreGhbN4TdSDIMD/85Lfi1g1zsIPEigbdWomgAhmFliEsvkLReqCsHmYv8iyt6o0rCwal
	WuNRDYpDrw0nujL+aOHc3zXMLN0ulRyn9p+r4LJmtLmZRTk9Pge8yOnKtowo=
X-Gm-Gg: AfdE7ck+XRZXkaQ+H55KT8xvOiTUZf6dJwYBrVXFbAno5d0FTO1LuokRVSR1H9GH3dB
	Sv/XX+2QvcTG4euvZ7N10qolpd38UqNy8bc4rCdPAdwBzSjnXnpIe+06yRrMqMNfwxfmjU2JiiR
	LNRm/Wq6KKKdpF8QOtU3qbx2RQqjBJBOqh3B5XhoscqwfXnv3kmYTAkkqtdPXxoAs/dKJlY1pC5
	R0miGk42MVfhY2EjTzkYsgq7hko0i+cU8y66VjbpJX7iLaHx+UlwdrCWs6rmTBn++rtuoRGxFHq
	ZpqmN1fyMHQixmZPTX1+P2q9XCM6C67iyUt2AD/MjPrtjSjGffpePtN+EyzvQZgxNQG2zQ==
X-Received: by 2002:a17:902:e844:b0:2c7:e8ed:e934 with SMTP id
 d9443c01a7336-2c9ae795a9emr461785ad.21.1782521449738; Fri, 26 Jun 2026
 17:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625172552.258631-1-nshettyj@marvell.com> <20260626062329.871990-1-nshettyj@marvell.com>
In-Reply-To: <20260626062329.871990-1-nshettyj@marvell.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 26 Jun 2026 17:50:38 -0700
X-Gm-Features: AVVi8CcnVxRK7qYxXJsQQMU-_GuOnz85tDr0MMmzeggQPDCd-iD-qzxOuh8vKBU
Message-ID: <CAEAWyHeTAHTHkpQoSfiGXzBv7BUx+0FeaCnsT+VhE+u_4Ohsrg@mail.gmail.com>
Subject: Re: [PATCH net v2] octeontx2-pf: check DMAC extraction support before filtering
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
	TAGGED_FROM(0.00)[bounces-302286-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E73F6D0A5F

On Thu, Jun 25, 2026 at 11:24=E2=80=AFPM <nshettyj@marvell.com> wrote:
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
> v2:
>  - Move the DMAC extraction check from otx2_set_vf_mac() into
>    otx2_do_set_vf_mac() which already holds pf->mbox.lock, so all
>    mbox operations are under a single lock/unlock pair. All error
>    paths now use the existing goto-out pattern, eliminating the
>    scattered mutex_unlock() + return calls from v1.
>  - Return -EOPNOTSUPP instead of 0 when DMAC extraction is not
>    supported, so the caller gets an explicit error rather than a
>    silent success.

Please ensure a minimum of 24 hr gap before posting a new revision and
also don't post patches in reply to a previous posting as documented
in:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index b63df5737ff2..dc7e4a225dd0 100644
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

I noticed that otx2_set_vf_mac() copies the MAC address into the vf
config structure before the programming is successful. Is that
intended?

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

Would a netdev_warn_ratelimited() be better here to avoid spamming the log?

> +               err =3D -EOPNOTSUPP;
> +               goto out;
> +       }
> +
>         req =3D otx2_mbox_alloc_msg_npc_install_flow(&pf->mbox);
>         if (!req) {
>                 err =3D -ENOMEM;
> --
> 2.48.1
>
>

