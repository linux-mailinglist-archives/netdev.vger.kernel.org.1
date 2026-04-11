Return-Path: <netdev+bounces-277720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AmWBTOy2mnl5QgAu9opvQ
	(envelope-from <netdev+bounces-277720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 22:42:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A173E1A8C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F9C305830E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140D3BB9E0;
	Sat, 11 Apr 2026 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvvhj5+u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451802EBB84
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940067; cv=pass; b=Gw68cHiI05U3xNkVnmrRCBZGXS4qVHERG/kE6G5SMh7QrE1xwXsBjqaw5ETs4ywumd0SkbZwfjnGV1+Ce4A/4jYamI6LbCd4rlQRXDp8G10wYJAFY5OW7094N07HX19uyt5lczumITeRdJ0q63w90F29UX/juA5laOlNMCAkIOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940067; c=relaxed/simple;
	bh=XGLi5he+Qr/B0C/ZRtsiep2VaWnzQaJMNVbdQ9H4Pa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAT87Zh+qbM+SULz5KKKVVTED2MkIH17D+gIrQKAp5eK/fMQUGJ+iX+bRpaeem1jVPRMW2qk0xZ7DhESPtBtcwu4djlpslt25uGU3SyGNkn+WF43ylrxKdNZePzRUnu0bjusytQKUlYJRp7spusnfjfMczYBovdZ7Qix6BHAPws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvvhj5+u; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf906b007so1905973f8f.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 13:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775940063; cv=none;
        d=google.com; s=arc-20240605;
        b=WXa5nlwV1VKPv7mGU6ROtrcwj61tj7u6y22bWgIWOU2sojI3Lbb4w6XOfGBlnFb216
         T6Pr7V3dg+TLmrqkQ0cor+ZyNIg3yWg4P3PyktCLqLBmIboNUz/YCaJLbpQNllPhp2gF
         3kIbtG90r8sfOHeC64o0aZyev58LdzV2FTBQv6xxNNT0Dq4gdDG/lK87RIBmYTtQ3fOj
         AR7UXbv4XV6GZTopAesaEbbEl+M+dAlvX0FZ7Mn5lq55lxiCJTHWDfawgmHEHtXKdU77
         q0MM3JCfW9M067PBI86gorGozZpbXTOzrYXY4mjbGVs/0sDcZm2HgE5MeFXDnPgJ7Wg/
         6TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5q5RroT50XruNLk8tby8qXtaVeWRUZkkC5f73ORjtiQ=;
        fh=v4STzYC8oOo6UI62uSVlHUBs52aXS+Dk+EQC74kQHu4=;
        b=JMNF151JTiaPOGdrvnPmmDnPSUinNVg2iZeKDO2niNA13JIOJRKKy4Hduj31MuprnY
         lYg1va/odEc1VCOGnLPM1VWEc0J46HDsbYhDHRrbjNU0tGaxDeu39R2sW21qCXu6qjgX
         pjf6vM6nIBsbfuv5oDSG2e1952T1N+j1X8QyJ+iFHlxGfzRANout92oqFYpG0RwT4WWY
         paS5sH0jgRlXPNfr/CqtnHAi+opA8Lj/Oh1w5reUQDCXs5h80WpC/kWuuVF7jk9VKiyw
         PZnMmZ46npQz8T2XD/LbYQsNkD48L1tnY6fbU9yxTgc7os2jm6tijw6HuuM5mxeix7UM
         U6GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775940063; x=1776544863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q5RroT50XruNLk8tby8qXtaVeWRUZkkC5f73ORjtiQ=;
        b=dvvhj5+uF1fsl5U+NV+GNPjs47ulgIRAev2+OzaqrTbwrtI0gF2e2l1IpNvGWRoN0o
         0fAqdMEQmJWzoEdTCxhZ8U7PltwoX802lluxXHMcvdpl0TnIMadQ83MO7H9ukWFw44Bb
         YIb6/9lFFDofUX/GFWYuQ2kBPVcejhdpq6KMhWyjJO996L2TNSBrzbX3fkcCOJaOJxu/
         T8atmpLD5tVLuDBvw3bG7W7g/OH2DXVlEiLWn5w9Yf3jOFdogEja9crS+MT2FlTZ2FfG
         xyEGfDYMZFq2NcO8dmyElJH8goJJbaDTYr0IpsmYdAoc+Y+l9eBg9xu5sC+a/P+0A6yx
         Gw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775940063; x=1776544863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5q5RroT50XruNLk8tby8qXtaVeWRUZkkC5f73ORjtiQ=;
        b=npfLWWS8G6IR/QQI7u3l/oxvCQLBRIvNGdvRIm2h/dO1DHIqOKns+t8wGemSICoIRn
         dUMja7A20B2M67kY0roP5rl4INRIkRaemq6VHoa/ItumhoJURfE2VrFSitn5W3GVlLws
         w4IdxA/qUBgmc0QEQU0uid7iMx+o+zTEpUnFYdMn9tsTxzH+dW4HdFoCw1ZPuC8EvyJg
         vAI4g88z6ChkwbHI0ouC9C3Lht9UhWcJEbIMm1xFrELYDJ/wS0dOShT21ibFQdFkd707
         dOJZsKJJ4PgH+Aw27ZSWfArWhEo/2KqSciSnUtpAKxc8AZf8weBLuZkunpE+MxNNXnCj
         bgUg==
X-Forwarded-Encrypted: i=1; AFNElJ+YCQjeSeHKy21+melZYFk5TccBT4PdP6dSmjkebCvWC92nm0UNudypqliC/KzSnxFdvyUuhJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrcc9xGCpcyikwl9kcZ7XU4d/89XRb9dg1iIZ7OzTg0OZXZ0wy
	FDcWBcITvwNaxIae5J99WrLtNaEmtCF1MMssKBh3Rumr0a3VogZ0YDTfKWLbBdz/ySXv+xJhKww
	DlHeT4jPzXKPs0MPcVTlOoRMt94yiyz0=
X-Gm-Gg: AeBDietG/zVOsb/ulcPo5gKV6W0DZ4+VAKOynuqrMF0RAmvIkpoV+Y55EtnSY7IHqHg
	YMhTDRgXNMIi0eo4EGR8qELdkbMnw8JjZOn0QlJ/0gj1GMxpYRqweEMfOrRUr6vk+qN7jw+mydp
	5aMT4PeVFgA5cPZat+MxrHaFFqTOxV+j+sOXHRaD6a3QfDWVYJUw/Nf6YjV79NVeC4cnsfNqS3C
	NGnQGaZARlO/tCAjR5iEDRgdPJFX0avbjwdA78+LjdfNRqRl2+HP12OlWIAcr0Mm6oriGN+hkiI
	2J9bau3mGqLbV352iUxHZib7wPE1oijH5RiSZg==
X-Received: by 2002:a05:6000:18a9:b0:43c:f1da:488b with SMTP id
 ffacd0b85a97d-43d642b9ce4mr12087419f8f.30.1775940063242; Sat, 11 Apr 2026
 13:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401041929.12392-1-CFSworks@gmail.com> <ac6kfQ98Xjt3dCGj@shell.armlinux.org.uk>
 <CAH5Ym4g3pbU_bWzMwJMdhEFv4K2sp3pty3g04=0=9Z80_LzW1w@mail.gmail.com> <adjrtRSepmac2hpN@shell.armlinux.org.uk>
In-Reply-To: <adjrtRSepmac2hpN@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sat, 11 Apr 2026 13:40:51 -0700
X-Gm-Features: AQROBzCWE5R1ZaXZe3VP4juckZTMVk39IF4qj9BF-f9NpOBdP5trAKumJEG9Iww
Message-ID: <CAH5Ym4if3Wh8uBF85F8VrPWxXFHrs6eE=vrL=-bdHN0SnLat9A@mail.gmail.com>
Subject: Re: [PATCH net v4 0/2] stmmac crash/stall fixes when under memory pressure
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277720-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tegra-ubuntu:email,armlinux.org.uk:email,armlinux.org.uk:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C6A173E1A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 5:23=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 02, 2026 at 10:39:32AM -0700, Sam Edwards wrote:
> > On Thu, Apr 2, 2026 at 10:16=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > > I've tested this on my Jetson Xavier platform. One of the issues I've
> > > had is that running iperf3 results in the receive side stalling becau=
se
> > > it runs out of descriptors. However, despite the receive ring
> > > eventually being re-filled and the hardware appropriately prodded, it
> > > steadfastly refuses to restart, despite the descriptors having been
> > > updated.
> >
> > Hi Russell,
> >
> > Just to make sure I understand correctly: before my patches, you've
> > been observing this problem on Xavier for a while (no interrupts, ring
> > goes dry); with my patches, the ring is refilled, but the dwmac5
> > doesn't resume DMA. (Ah, just saw your follow-up email.)
> >
> > > Any ideas?
> >
> > Off the top of my head, my hypothesis is that dwmac5 has an additional
> > tripwire when the receive DMA is exhausted, and the
> > stmmac_set_rx_tail_ptr()/stmmac_enable_dma_reception() at the end of
> > stmmac_rx_refill() aren't sufficient to wake it back up.
> >
> > I think this is new to dwmac5, because my RK3588 (dwmac4.20 iirc)
> > happily resumes after the same condition.
> >
> > You gave a lot of info; thanks! I'll try to scrape up some
> > documentation on dwmac5 to see if there's something more
> > stmmac_rx_refill() ought to be doing. I think I have a Xavier NX
> > around here somewhere, I'll see if I can repro the problem.
>
> I've added dma_rmb() into dwmac4_wrback_get_tx_status() and
> dwmac4_wrback_get_rx_status(), and with that I've had an iperf3
> instance finally complete... but only once:

Hi Russell,

To me it feels relevant that the T194 doesn't use first-party
ARM/Cortex cores but rather Nvidia's in-house "Carmel" architecture.
Do you suppose the cache there is quirky in such a way that either:
1) We're seeing poor cache hygiene in stmmac where other caches are
more forgiving (more likely)
2) Carmel's cache has a subtle hardware bug triggered by stmmac's
specific access pattern (less likely)?

I'm still trying to get my Xavier NX to boot on net-next. It's running
into eMMC corruption/stalls very early in the boot process (at
slightly different times; feels like a problem in autocalibration)
that I'm not seeing on older kernels. Once I'm done bisecting that
regression I'll take a deeper look at this stmmac mystery. :)

Cheers,
Sam

>
> root@tegra-ubuntu:~# iperf3 -c 192.168.248.1 -R
> Connecting to host 192.168.248.1, port 5201
> Reverse mode, remote host 192.168.248.1 is sending
> [  5] local 192.168.248.174 port 42232 connected to 192.168.248.1 port 52=
01
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  50.8 MBytes   426 Mbits/sec
> [  5]   1.00-2.00   sec  54.9 MBytes   460 Mbits/sec
> [  5]   2.00-3.00   sec  54.0 MBytes   453 Mbits/sec
> [  5]   3.00-4.00   sec  53.8 MBytes   452 Mbits/sec
> [  5]   4.00-5.00   sec  52.4 MBytes   438 Mbits/sec
> [  5]   5.00-6.00   sec  54.3 MBytes   455 Mbits/sec
> [  5]   6.00-7.00   sec  53.7 MBytes   452 Mbits/sec
> [  5]   7.00-8.00   sec  52.8 MBytes   443 Mbits/sec
> [  5]   8.00-9.00   sec  53.7 MBytes   451 Mbits/sec
> [  5]   9.00-10.00  sec  54.3 MBytes   455 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.01  sec   537 MBytes   450 Mbits/sec   13             sen=
der
> [  5]   0.00-10.00  sec   535 MBytes   448 Mbits/sec                  rec=
eiver
>
> iperf Done.
>
> So, it seems better, but not completely solved.
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index 2994df41ec2c..119f31c94b61 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -17,10 +17,12 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_=
extra_stats *x,
>                                        struct dma_desc *p,
>                                        void __iomem *ioaddr)
>  {
> -       u32 tdes3 =3D le32_to_cpu(p->des3);
> +       u32 tdes3;
>         int ret =3D tx_done;
>
>         /* Get tx owner first */
> +       dma_rmb();
> +       tdes3 =3D le32_to_cpu(p->des3);
>         if (unlikely(tdes3 & TDES3_OWN))
>                 return tx_dma_own;
>
> @@ -70,12 +72,12 @@ static int dwmac4_wrback_get_tx_status(struct stmmac_=
extra_stats *x,
>  static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
>                                        struct dma_desc *p)
>  {
> -       u32 rdes1 =3D le32_to_cpu(p->des1);
> -       u32 rdes2 =3D le32_to_cpu(p->des2);
> -       u32 rdes3 =3D le32_to_cpu(p->des3);
> +       u32 rdes1, rdes2, rdes3;
>         int message_type;
>         int ret =3D good_frame;
>
> +       dma_rmb();
> +       rdes3 =3D le32_to_cpu(p->des3);
>         if (unlikely(rdes3 & RDES3_OWN))
>                 return dma_own;
>
> @@ -107,6 +109,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_=
extra_stats *x,
>
>         message_type =3D FIELD_GET(RDES1_PTP_MSG_TYPE_MASK, rdes1);
>
> +       rdes1 =3D le32_to_cpu(p->des1);
>         if (rdes1 & RDES1_IP_HDR_ERROR) {
>                 x->ip_hdr_err++;
>                 ret |=3D csum_none;
> @@ -152,6 +155,7 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_=
extra_stats *x,
>         if (rdes1 & RDES1_TIMESTAMP_DROPPED)
>                 x->timestamp_dropped++;
>
> +       rdes2 =3D le32_to_cpu(p->des2);
>         if (unlikely(rdes2 & RDES2_SA_FILTER_FAIL)) {
>                 x->sa_rx_filter_fail++;
>                 ret =3D discard_frame;
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

