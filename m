Return-Path: <netdev+bounces-268626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL84M0hluWkyDgIAu9opvQ
	(envelope-from <netdev+bounces-268626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F392ABF21
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA65B319F178
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00183E276D;
	Tue, 17 Mar 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUVYvlBn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0B3E1D0A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756713; cv=pass; b=JANRqebtrAsGHYa6PUpLDf3LiBBRrr7YRSnN2X0ch8oirvY+Avmjz4XTjX8biJqIr5iQqXTF3Xv9eg7Lo2pEYNq449xUqmtiycl/Dp+C8QkzDqpiIklTx0G5L8KNAFs3snrJXu2YHWMWLzn8wscCLy6P9uXBp0YPJU7cJ/wfvn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756713; c=relaxed/simple;
	bh=3fqfZwXf9Aj2qCe+qsorAonMcHwZObCbVK8j7y/7180=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s41t+tBdC99v7SG6DmKHamkRCioa22K22wcXmcIlxcc7rZbHcUKQQQh5FJplNO4HCMVNBC6v9RhMzmKNRqzc1nz+3QBE62N90Xvc4MR65kywcHtoJgwh80YySb7F64UCG+1l1V7BwzqiPHKQc7mAHq4kKXImwFUGM2jcTfDUn8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUVYvlBn; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso10875322a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756711; cv=none;
        d=google.com; s=arc-20240605;
        b=G5ItJR35gYS0uqAVPfXtR/5XUJt9i6FJ5qLSofPZb1izUEuXzEhGor/+JWoeJQZV/g
         hKY7RfFU/DyYTh5HI+gzHrKaQlh49iOHBlGJgZwc9aDZD+p8aAPnKkkorYaNlBz+q6L4
         AQXcA/NgizKFK3fhsnNYI3UOtLuVLZhv6Cisc0lxlzNVe4T5I4w+nfdserCkTDFrnhfc
         pSoSRdr/4Abe+HelHXrb87M0o1lAijEhDB02RuBjUxDDDovC+DMS3blQmOa9H9y2i5J7
         vpLTAsuK8OdLehbgbpNMDtbZupsU+DHxb2x1XDB4chgC+CcHSNcnoEkC/LIgL7CgHbqW
         OXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwxkZLM1knDAKvarBpWGnyxxYI7MVKfo3pZ8Fz/i2AU=;
        fh=CdzYJB2WzZ4Nw2A347DAmtGkGHhQZVMwHxrMbgN4yeg=;
        b=TC+BdKoBt+RVsfm444RXA8Eq4gEOWySaI9Ed/anX3fwiN0xoduvqw2IGeftHemzCUY
         2zb7iEmEyg7YLzbUG4P3NgvWXB68+8G4AJC7O8PASMHiDwlw5uAi2Eeou4LNYulKIIwJ
         O/1/Ug6PrdMzoObVOwgo+LiyQECFGQvXNu8kIqBvqH0AWOh2jJ7a7/FOdATjzl06hLT7
         Jpm7SNFX1twdh3cCydyBgZTIBL3ux/2QDdfulNon1qPOOF8Ju06K3kNriHOiDUq4zJYb
         Og3UUcAk+8EQHwDZP9FtOCd3bA+0srU9kzOjbe3yUr3YxESNwiLWUUpY1BP+3sTzjksV
         6NSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773756710; x=1774361510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwxkZLM1knDAKvarBpWGnyxxYI7MVKfo3pZ8Fz/i2AU=;
        b=RUVYvlBn4b/QocABKyyhoA+N8vgbHLyH5rLJGTo7Xa6kRiW79ucnL3OY6JQjM0KNYx
         hSjCkQ3C0IMYCXEf27a5SgKs9I6L3HI1egLZUL0J02RyWzw2RcQQ7RoQNcipZOZftCcG
         mQSUneIhXhpBfA9QwezJ7GVFK/FXfZObVcGwslxbAvQ9y9Yyu8XxAlDyhVwt6EEp39NP
         ON9x8VoVJAUX26O47Q8bAh5VVl0UGysIf5YjI3xDlXOWq4uGQSKvoLlZEYIjTgBBiPO4
         Lc051AhqZH8QuiPPbOsn8ZnF+zSBwo0Mx8O2YtgI1mNJKqagq/g/DZMQhj8kQpGgB4WF
         a1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756710; x=1774361510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwxkZLM1knDAKvarBpWGnyxxYI7MVKfo3pZ8Fz/i2AU=;
        b=TLEUEF+Jp4gryZmvBf4HoRvtira5kkxM1jouCdEFdCzJCCCe20dJD6XvK5hTS5q0oX
         06kH90CrQA37NGw5PRdfZSlU/TIf0Ts+ZaBPVxgYBcarIeF5z3M8SPeqYqFs3IXZQJJR
         Mdwam+iIC79LuGOl63ZJhvK+WZkJ1crbIfMForw9hFBkc1NvT/4orahPUh+d01mZ1/wP
         g29wRcb7hCV3VxhGWEWuxuqwAq8iK3kcGa7w+LZJsIzMurMxw+y9CYOi93q5w0Ajdo73
         EP7GcaMP2TIABTksPfaEPA5bfU5vvvv+nZlPonKmyirW0e6gfvflui0Ky3agQC+OwIve
         W0bA==
X-Forwarded-Encrypted: i=1; AJvYcCXSevv+KJNdNFO2/MsdGqwUP1nXv5oRPRbVdRwX1VAN4P8sUMGnHfWHRvBtxtBR4qDBdyal/P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVXtLxhiYCVLlU4XENsu+bt44F/ELLYQm+pGZhUn57zq+LUsh
	oXV5aRUTrLafhXCGIW/umT5UNABXh8bEjPPg/8n3k0YiCAxyc2zVfryqj8uapW4jKmnVAN+wZZR
	v4EgO4jL3uZ9QmFaWYzstv85G0LXQ7sY=
X-Gm-Gg: ATEYQzw158AZER3XDF4+kuNnkgYMcyHZYamXmdVnN3+RVyBvSr83Nhytl/HtHUQWDkE
	kHuhLIfhR6KynnwC5ytxqlQM4LWnted4gtFVW2opp7ybkTtBnsIww6DrdtbgUscON/8N5E2FRz2
	xXv4d0ZH8XG4t7mT0m76HgNBmJZmDz+U1eV0XSWsbFO4SDJK9eVH3L422tsq/+TlpugRMqjmRCL
	WMhuIclOlJeYX1GJDRfS0CUOdvvT98sPtsTYRbcef2SaqLYfgV4SFDdhaYP27pkxu7/u415FMBT
	IcYnSQ==
X-Received: by 2002:a17:907:3e06:b0:b93:3c03:706e with SMTP id
 a640c23a62f3a-b976543019cmr1017248366b.52.1773756710356; Tue, 17 Mar 2026
 07:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317061700.7734-1-linux.amoon@gmail.com> <c630aa45-0904-4b3c-a1f6-90b167741d27@gmail.com>
 <CANAwSgTG53wD+z8KBVs4e-n4za-f3xXZELRu6c61SV2Z+4dwMA@mail.gmail.com> <7e39eb0e-d4eb-451f-bdb2-206ddd0a0b35@gmail.com>
In-Reply-To: <7e39eb0e-d4eb-451f-bdb2-206ddd0a0b35@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 17 Mar 2026 19:41:33 +0530
X-Gm-Features: AaiRm53-QH0oR4QCrQfuE-hLHZOETyMAfQSxcB7TlPBX_DY-UE2t77iaq7hFswQ
Message-ID: <CANAwSgR6P0nZ1=FKFdp9S97v0SvbpOF-5Ysv4p80BxBhpNGYjg@mail.gmail.com>
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "maintainer:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>, 
	"open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268626-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org,arm.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48F392ABF21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Heiner,

On Tue, 17 Mar 2026 at 15:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 17.03.2026 08:59, Anand Moon wrote:
> > Hi Heiner,
> >
> > Thanks for your review comments.
> >
> > On Tue, 17 Mar 2026 at 12:21, Heiner Kallweit <hkallweit1@gmail.com> wr=
ote:
> >>
> >> On 17.03.2026 07:16, Anand Moon wrote:
> >>> The driver currently assumes the PHY is always at address 0. On some
> >>> hardware or buggy BIOS implementations, the PHY may reside at a
> >>> different address on the MDIO bus. Update r8169_mdio_register()
> >>> to scan the bus for the first available PHY instead of hardcoding
> >>> address 0.
> >>
> >> No. The PHY always shows up at (virtual) address 0, due to the
> >> MAC register based way of accessing the internal PHY.
> >> Do you have any concrete example of such a "hardware or buggy bios"?
> >>
> > Sorry about that, I didn't realize. Unfortunately, my testing shows
> > this still doesn't
> > fix the problem, but I still perceive. I modeled the change after some
> > other drivers,
> > but clearly, that approach isn't working in this case.
> >>>
> >>
> >> This check is needed. It's seems your actual intention is something co=
mpletely
> >> different from what you state in the commit message. You try to find a=
 workaround
> >> for the issues with request_module() from async contect, caused by the=
 referenced
> >> change to Rockchip PCI.
> > That makes sense, sorry for the noise.
> >
> > What are your thoughts on using dev_err_probe() for these registration =
failures?
> > I thought it might clean up the error path.
> >
> I'm not aware of any realistic scenario where these calls would fail (w/o=
 printing
> an error message before). So adding an error message wouldn't hurt, but i=
t also
> wouldn't be beneficial enough to justify a patch.
>
If we enable .probe_type =3D PROBE_PREFER_ASYNCHRONOUS in pcie-dw-rockchip.=
c,
The r8169 module probe will fail due to the module=E2=80=99s request for
synchronous probing.

[1] https://lore.kernel.org/all/87bc37ee-234c-4568-b72e-955c130a6838@arm.co=
m/

Some were in the module, but the probe failed to load the module or firmwar=
e.
I hope these changes will resolve the probe warning.

----->8-----
diff --git a/drivers/net/ethernet/realtek/r8169_main.c
b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..8b7858f6dc6d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5790,11 +5790,11 @@ static int rtl_init_one(struct pci_dev *pdev,
const struct pci_device_id *ent)

        rc =3D r8169_mdio_register(tp);
        if (rc)
-               return rc;
+               return dev_err_probe(&pdev->dev, rc, "mdio register failure=
\n");

        rc =3D register_netdev(dev);
        if (rc)
-               return rc;
+               return dev_err_probe(&pdev->dev, rc, "register newdev
failure\n");

        if (IS_ENABLED(CONFIG_R8169_LEDS)) {
                if (rtl_is_8125(tp))

Thanks
-Anand

