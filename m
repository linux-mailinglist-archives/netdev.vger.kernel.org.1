Return-Path: <netdev+bounces-270003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NUzILmHvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8902DEDE2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DDC31193EC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2244C3D4110;
	Fri, 20 Mar 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zw8ytkj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F03D1710
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028417; cv=pass; b=iI50BSlK/beJnFmCx0ip0ULJsWyRVNqhKz/1ZhpGBNkON/AbOj3LG7bh63AzCubNspUQ3LwPT3QwvGBHmSKhTpWjj7KmiWZjMra2BViszZuc/4zW2sRhL5t/KFu5RhCWdkXxsYR8UJ8R+1fb42TO3Q/IniXInnWoRx0ICu7LZ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028417; c=relaxed/simple;
	bh=JiqUj3BdXtoqsMJzPtg5kdmSdYochHTyoDbzChIhCB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFMyNyMcezf370KCV2D4Pmaka3/+gbJCJws3Df5QZoCpNooL0qa6h4TRzaGhvPbHa+z9Zed+FwIUQTR8aQMXej7UNCY175VS9j7oOx8qTCjjjF2KVEOohD7EFUmJBN28imPks6yTiGvzNWv7tSHOgAYRGU2jFm9LlfTx1TXV4dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zw8ytkj1; arc=pass smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-506aa685d62so14095981cf.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028415; x=1774633215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3wDYqRK62/punnoqNUCv1C3/jsF7Rw780BqS2N92L8=;
        b=D5hJrf68AIJKrmRaX5nDFTT59nJ0l6nouc1UTjVDi9qZdqVRxRdVAcsu/HwLIegJS8
         PhHN/DayoK9uH6uETZF4nSYEJxV+QKDlhCECUHPOXBlhMAZ6AGxvNeSjtZ4CX93vbHxR
         IVo4cqoNQ9WRyD0hcLDEVQJ6GM0MOcivLBSeJ1q5HuyKJWos6KGqpTJsRfFUH/KloLNg
         2ih8Ggr86wTWmX/94VZidHwOrJ6gpTsTtLU5G2azYDZbn7sSq/4Rrt09Y1R1Qsj8LlyX
         8rpYnPTrsuQWKYePFK/V8ThMYtvtuE7KpPB18vAndWWNVlIMd0MOUSETzA42rSMsuPRY
         N7CA==
X-Gm-Message-State: AOJu0Yx83rXwqnisFJhZUpeYgZPMpcMzSMnfmZA29MVbSDWOPq6psDVM
	ijz26qh2l8715NYOPBfCslUrlJ3m/J6lGsXj7Dr1pSKiOGtSMI9WhhoSIHqj6fyMAyHtJdIJcK1
	PWJ5FXMJb/rGfmQYzTN0+G+Jy2Wj8nxybD+nKEORzb8o5mPS67j5fP5JWtKM6mcHgVIZiyhHxJF
	OBhJBybmwsv2Oz5+JvWiar9nWo/OMrhh9H0j3gmRm7WFL8AmwRio3dvdLl5ZXv5jpHOVLLHhYtk
	lpwo1ANEIqDZCom8A==
X-Gm-Gg: ATEYQzxfvjbd0iyQPRSRb3dvyq1HKtnoG0OZu576uo/2F5UeuChK8gKetK7vAm0jMge
	F/Eb5y8tzli7FdwyZrBf3aeLRJM1/Z+rV9FqIdbJVNLPY5U7PBiKBV9hI5dOREHwHoN8gJDZ/0y
	Qc97275CElUKL2cSTRwhImEovOlmURw+i5DksRR2xqtKyR5hG7zru/gKJqT+U4PQN3kGTkMBV56
	koEhmX//fwc3s1JL4M+qmCQG+afajDJ028veva5iuxNKPKPTNQHRqNdQpeKxLssNC0W5NcF1ld5
	GDqJ/5Q9DZu6bZY2hJG5A6/1cusEAl4zAlBL9CYP/LmsRqFNNocfJlV2jJ9nI868QxCNddnjjbA
	RGc+KfCsKoC4MsPWJ36+4MI9lgCjZuu6Ia3Mkaiyqx9U9zvCA1+Z7JUy6+PW/Ecj4MLzFrtPQtA
	rQUsP4qbcq6BCkp5qBNmgcShhMoDS48XVlx46bGAMVnV+UFYT+Jm4iCDt8e9sYwSjLGQ==
X-Received: by 2002:a05:622a:1e0b:b0:509:116c:8e17 with SMTP id d75a77b69052e-50b37501d1bmr54040101cf.47.1774028414378;
        Fri, 20 Mar 2026 10:40:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50b36e44479sm2455291cf.8.2026.03.20.10.40.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:40:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b3c9568a3so1542855f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028413; cv=none;
        d=google.com; s=arc-20240605;
        b=bAZTPZMkqQV9drKG5M4dcB9kyxbcCpKC7apKTXSKZg/+GfK7LAM1YyXoowzSDlA99P
         YiutizdXsUv21aD/mhC7YXjW5Z1OU3ny4v0naLqZdQGvChUAvIiuUS3cWyEqrM36TW66
         Mp74NzgsIYWlVd+V5oaQOqBKxjy7k3xPC5mfX8KwdgzZzl53PmicreaN7HbSCPTSQonP
         e389qE3yvvepsrhfufwKEK6RRBOnT3IGqoRMJa4cwaH9bWjBu/RZ0R1ghemrJ/AyyotV
         J4jUw3N4zhYtst6J2olvKbf5vpDFUttbum1wKv4kQdtwzHD/fcLa9zLyAg+F2pFP72p2
         /tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L3wDYqRK62/punnoqNUCv1C3/jsF7Rw780BqS2N92L8=;
        fh=H7QQv3OEFsD1HVpz+3uR6feknpwvlP3vBj6ioUlRm1Q=;
        b=cNqV8HVLnLFgXx+N61s6ZvWWvyFCPtiMib3EdWmgCg9uQSZiQ3yyoUwRkvCY3U+rPI
         hhv6JC5HI36e3VpkHQdPOFXNQh20pTsK1j3naycqqU3WXs1ixtG3wFcqpAOwgrI16EoL
         0YVgNEwz2EAGyd/SQ0Qst2PmX/7vgrDY59DJE0c4mCDod5ed3xtMZSV5dCuEwRZHKQwN
         XOLiyuF2xASd8U4O8+uJ1jT7tDIIVDFkeMdpdxoGWCEDGE2NzUwn1gXRW1fF9KOfIqCV
         6kSldgYsn53eVefK0UUZPnBSFdrMWB0TUxxxe7QekAdkG+VJJxjaKLmjmB/un8uQrk3B
         xSww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774028413; x=1774633213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L3wDYqRK62/punnoqNUCv1C3/jsF7Rw780BqS2N92L8=;
        b=Zw8ytkj1KG3YMVqMWRf6qYbJUbH6M/avbww2rMABEi4tj7HhO/M9XpiFWrUv6aCuZS
         trXwS4uXJRGGkbJy1A9SYnAsbiJMbMR3X3UDRr2lpx5tZ3fg/CW9X12r+Ow4gRRjp/4R
         Cnor+Gd4zOriJmdSe7NDRwWwnzqXIxB78MHzg=
X-Received: by 2002:a05:600c:608c:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-486feb5a653mr57923505e9.0.1774028412538;
        Fri, 20 Mar 2026 10:40:12 -0700 (PDT)
X-Received: by 2002:a05:600c:608c:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-486feb5a653mr57922905e9.0.1774028411896; Fri, 20 Mar 2026
 10:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-5-jitendra.vegiraju@broadcom.com> <abSXP3gMFQEiC5Lm@shell.armlinux.org.uk>
 <CAMdnO-LYAPfyvM4vgmGcZgy-aagHSkP+VDmpRskNU-414j3gnQ@mail.gmail.com>
 <CAMdnO-+YWowCDh4iB9EZ=eqUidE6Mu4TOqjwyoMgyEaG=pBLBg@mail.gmail.com> <abuwcYH791D_oJp_@shell.armlinux.org.uk>
In-Reply-To: <abuwcYH791D_oJp_@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 20 Mar 2026 10:39:59 -0700
X-Gm-Features: AaiRm51daUnGzokEEKCgv3bQbjbYDVOMLsocPZLljrnpxo0gYhLkY9qweCsnxyA
Message-ID: <CAMdnO-Jx+z7ZVFyuS-MhcaPr+jDEJ6sLiAL15Q2pYsphaXcEFg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rohan.g.thomas@altera.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com, 
	lizhi2@eswincomputing.com, boon.khai.ng@altera.com, 
	maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com, 
	yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org, 
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000629adb064d782d47"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270003-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jitendra.vegiraju@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.903];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 0B8902DEDE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000629adb064d782d47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:15=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 18, 2026 at 11:12:23PM -0700, Jitendra Vegiraju wrote:
> > Hi Russell,
> > On Mon, Mar 16, 2026 at 1:34=E2=80=AFPM Jitendra Vegiraju
> > <jitendra.vegiraju@broadcom.com> wrote:
> > >
> > > On Fri, Mar 13, 2026 at 4:01=E2=80=AFPM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > > +
> > > > > +     plat->suspend           =3D stmmac_pci_plat_suspend;
> > > > > +     plat->resume            =3D brcm_pci_resume;
> > > > > +     plat->bsp_priv =3D brcm_priv;
> > > >
> > > > Populating suspend/resume means that plat->init and plat->exit
> > > > will only be called on driver probe (former), probe failure (latter=
)
> > > > or remove (latter). Please consider using these to ensure that
> > > > all appropriate resources are properly cleaned up in all cases.
> > > >
> > >
> > > Thanks for pointing this out. I will check resource cleanup more clos=
ely.
> > After reviewing the need for  plat->init and plat-exit, I don't think w=
e need
> > these handlers as this driver with fixed-link doesn't need to restore a=
ny device
> > specific state such as clocks.
>
> Huh?
>
> plat->init and plat->exit have nothing to do with "restoring" anything.
>
> plat->init is for platform specific initialisation.
>
> plat->exit is for reversing the effects of plat->init once plat->init
> has suceeded, and will be called should the probe fail or on device
> removal.
>
> So, where you have:
>
> static int foo_probe()
> {
>         do init stuff();
>
>         ret =3D stmmac_dvr_probe();
>         if (ret)
>                 goto cleanup;
>
>         return 0;
>
> cleanup:
>         do cleanup stuff();
>
>         return ret;
> }
>
> static void foo_remove()
> {
>         stmmac_dvr_remove();
>         do cleanup stuff();
> }
>
> Using ->init for "do init stuff()" and ->exit for "do cleanup stuff()"
> will simplify the code, and actually make things more correct.
>
> Currently, you have this in your remove path:
>
> +       pci_free_irq_vectors(pdev);
> +       device_set_node(&pdev->dev, NULL);
> +       software_node_unregister_node_group(brcm_swnodes);
>
> but in your probe error path, you have failure paths that leave
> the swnode connected to the device, and you don't call
> software_node_unregister_node_group(). Thus, it seems to me that
> your cleanup path is buggy.
>
> My suggestion of using ->init and ->exit means you have slightly
> less to think about when stmmac_dvr_probe() fails - although if
> you still have to do appropriate cleanup within ->init if it
> partially fails.
>
Sorry, I missed the resource leak with software node on probe error path.
Your suggestion to use make use of ->init, ->exit makes the code
look cleaner. I will make the changes in v8.
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--000000000000629adb064d782d47
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGbTCCBFWg
AwIBAgIMGHX6KxYK3WW2YyprMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MDkyNTEzNTAzMVoXDTI2MDkyNjEzNTAzMVowgbMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEaMBgGA1UEAxMRSml0ZW5kcmEgVmVnaXJhanUx
LTArBgkqhkiG9w0BCQEWHmppdGVuZHJhLnZlZ2lyYWp1QGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBAKWV+9PYvG4njqRsbQas79f8Q46VL7b1ZxvWT6ik6VMbdRZx
tfpfZalVXksqcb02/N1H7UA9V04cV2q97FkSr/KxeFLMetPb3cVJZICg23IRO2NTPdmgPFzwkPTo
35h9h/OYLgh3/9a1nTsC2xqJa8GtohD5+42rsskGcI57U4n1r1L4R5IL9ypSqDxX/xVEAdGI5FTj
VgvoZC6iuEbnez+yO8TT3wun9b/PQowOB5P0CwIFv7ERW0S1s6B8yrbsoaTrz0vQaEA786k1pZkg
ykC1+zXq/iTyZuPP4B4RkzFd43Pw+GAH0Tt2nx5V4rNisJHeAVNU92Gj01cEg0I+FnsCAwEAAaOC
Ad8wggHbMA4GA1UdDwEB/wQEAwIFoDCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQw
OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAy
MzBlBgNVHSAEXjBcMAkGB2eBDAEFAwEwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIw
ADBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKQYDVR0RBCIwIIEeaml0ZW5kcmEudmVnaXJhanVAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1Ud
DgQWBBRq5Jlxz3MqC+zEgUxK566xEc2g3DANBgkqhkiG9w0BAQsFAAOCAgEARXrmeeWA31pp9Tr0
M6mOlMv+Pr2raES4GzPSyftvxf6tBQCBNaqi6LSbyusDYOj3mG9bp6VeVn+68OxNY9iNAk+ujtId
f3+30BlZOQ1v8z9u2peUOUtWI60y2MxhdH0X0n2H+BCGvUOFqs5z440jqqy1HsscZTXHB7FEZmVP
fyD+0Z6cxyh7WNC6+BgLiFwf8iqmAbu7Yb1sGTUGyS5gfYEjJbF2PJfwNUcJDd7eS4w5Ju5mK5y7
spgjH2/JmDgbkpSk9JyuWfjGZIg4ah/q2nb6UMd1XJb6gLQZuzPOI3SgXPvd8MHGjKZrX2BHOBSC
bJJ8rp4w4a9QMS6dde2MFObusxkZAft4tUnwo+ProchHs7iA85sL7sWEZhAmjmKKCpECpEfZm0+/
hpvKQV3AZp5vBstb4IVL8QmLj8beDVHYnNhEicsSiG1wW7zSYyBnmGbFRrFQIJnJDWPjTZOlVEyp
T1ShrXRCtqJpOt6rgg+rFEY3D8j6/bAkJXnmKnE2LZ0YyrrKk7eC6UfNNimx38w3NWchtcGY8zJn
Y/1/C9Jv/mWm/2lK8nvusOFxhKmbG83Hx8toQdZ5F1kYk6zAWjfB7lwXr/En9mCmLieJ18hen9EK
qbYyUkmCmuoLi5GXFMJy+iQv6DgMVQ7CACagybU6FUrmL9lVa+A6caBEEh4xggJXMIICUwIBATBi
MFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9i
YWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgwYdforFgrdZbZjKmswDQYJYIZIAWUDBAIBBQCg
gccwLwYJKoZIhvcNAQkEMSIEIOjDrFYUtizxQa+Umj9q17p/hPIJ1PoQph346uqBvFJGMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMyMDE3NDAxM1owXAYJKoZI
hvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAD0tNjAqlZqj
tjjU+6U6EsE8u6KXw5jhsrr5YhUX1IAEvn8KPH8FCLbz1i7Crl8XQproVWXD4/TK2keR3Rrisg4H
Md8YRrzLGNa8HHuDpK7eweejtPewW916J0mOJ0imGptf2nAHuTq+PE9gEs4LkJfsaV14zu91Zp/1
QF5X6nQxJcNrYk5UYv0mrUkhWRpQBmjP84ixPI9jNTjndlLyjqg7tiYAeM6SqGWeXpJSYbCGl50w
+DvEGjpsLkVEb2E1UqpXAGqRM27fq1X38NLPDNv3+L1FdelHTJOOZCXeASwXZWZJ2WUVHTdv2tOH
QaQADJQa+rKT7y2yOBLarlaDuhc=
--000000000000629adb064d782d47--

