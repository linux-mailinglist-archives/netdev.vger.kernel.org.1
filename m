Return-Path: <netdev+bounces-270883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIBVFTguwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:24:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35E302D44
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5C431BF08B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E943AD50E;
	Tue, 24 Mar 2026 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czwr3N4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F762459ED
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332484; cv=pass; b=k2O8Q0ZT/MfLUiIXBqYBrPcgoOjoXh+ouZCTjTImsKR7cw5MXQQuiizL/QLtx/gdkxpLRyplb7ZCqhI/1X1l6tFxQUAIYAUEyzCh/BjraQA17HXZbPw1rS4ImpHAs+TSiryZCb7BKqqCc9Y+n5BFsYNUJRd0tJ9KQ44Oqd8pHRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332484; c=relaxed/simple;
	bh=mI7IXHOvVwfOeSEe+wG0QApSngBTg9jiiTJhWvTjxNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCCej9bwS59Xd5Stfhx5tvRT2qUrCRBWc+eShudkW3MPM/Ew/im3DSjw074ZjQI90bZiek4smJ378mH6Mb0ZImCmZbVZrYX2eb6zsg7VQ2rniOW1ET1/pR+2EmpnC4xCHEINF5ieFxxkI8mT1k+ZCZcIuqnhAW7bQoLqT6fuJPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czwr3N4O; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so8430384a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774332480; cv=none;
        d=google.com; s=arc-20240605;
        b=KXbThscGPXWprTzC33jJitRPatUIiHsNKStaS+FGXFH3F6Y63IZapNkHyoZ08nzPj6
         9Ft7sklxQfyMvVmTckBnJCGDj8HPgLdCwmN8nr5oOemkpybBPQyetxIOaXcsl8moQR9U
         5MLKnDjYlQJ6rWK+9KfrgQO7glfAGaD1+9eViUWWv3g4XVNrNQDLoceMfvsVn7brNVcX
         cu2kA2Jtimzv3kWjuwPRQ19Vw45Ojkfl4YEq9o64BkIOWu5AFklmtYlMj/WW5mZXvnoy
         VIsZMJljaI0U2LyMgO/qfuDdz04aqrEBO/VPPNe8m1XWPGV+A4y+5X46oTRCmYQAte9Y
         NxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        fh=+ErJ6w0RUBPxX2LlWIG+xqarT7vGhnFKBMFb7KA3mBY=;
        b=WBLsy3FpC0hkRGBjgHOZvkq1zswtaFTsJSveGnOOpQwTeZryjuuyEBTL1oEV+FKY69
         4isfFyTeMAqhj3S2KBt8t79xn+EMp6DWK1k58/hzvrqI36ppV91vz6aYJb6xDZiID7Ce
         k/i0YZoH6V/p7HW/W5a0pnBHHpUZirzJkpLEmGiJ6ITD+7Nd+D6Hf2+284Zh2028vZnI
         1kl9DOjLa+l4xb2bJRMyce8DQXd6c1Q2SlLP48JcbHR4E1htN9AYpxlwKJeDwlMNhhxV
         y9LwWpEDqA4cuDrwzQN4ueHzLFaJ/lhjXsb1hYUZSWq0MDOY4NDNgh5Bt0LZovhsOnZV
         Xaiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332480; x=1774937280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        b=czwr3N4OzNJYD72GQtxe/dMQdazGlyXGbhN3w45SUsLiu5pBfrdqcdFn2k7KZcPGOY
         lEKEjKC6jlsEs9w3hIDXhMqqQ2kO2bguL5uKHEYsGaVQe5D4Y4KjsvBrwwo+NMJbijo7
         WUNLHAheDm6ZhyK6Y+V70T3mA9xBa6T3U+ntIeQhcowqONeCiRTMW4DQfOzystf9fU9S
         K1NK+tRt0WUe+zN5uHEEHuPwr4VeTsUspLNjL/AwG3qSwhaFns6iY32GWzDU+QspXwbU
         TPOAzOxlygMcY7Myu6FL16/Srd0BMuCyYELA45lfFlIcP6at+ekHiT+hFT0Fq5H2QP9R
         sz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332480; x=1774937280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5zvAs0ntexVIDD9sucPNtVKRPH24qK9vYHSkiDVFPc=;
        b=YzWJ0ep01KBXuUkpZzELgeHpcSDcqJpCfeAHu6f8GQOarq7SAeKZWYScWMU4MVaowu
         7DipVN0xCIywOiQVPR20sjxPKaErfhr2Dp/5lrafb25D41BJG8Bg7XYQvPDPDaD681od
         9bxp64dc48tSFR3YVp4I4+uLAlT16TqG1XzJdvTPvkDvBeMGi8WBU2UhHVcuwo7oBdeo
         syd1eeORbdbcOctDL2PYqTwVlB2/YXw3e0EdAj51Uyc66Py6XsklA3+GitiEkpx1DsqA
         kgb45n5cgA1FkPulbH2+J0hkSJIUjGAP20j03Hc5stYWkAFJpH6kT2SDfEmtZqq6zBcA
         m8Ag==
X-Gm-Message-State: AOJu0Yw3zbgDfia9eW9EzDWEg3uTwCVFiNgdVhrFk9LQHeY7mnxHTRcR
	A05iQugR2WeGe1LL6BTGb3TmFIIo/NgRGRDYfOvMB9MT35MqewgNXFIPokAUMXZq2EMnBa3NYsr
	yzvfz3Y79P4rZXNAF3jZX6GLQvTYgojc=
X-Gm-Gg: ATEYQzxT/E3N8qv2Qfn9PAHlCC+LlFbz5p1tam6LsdFKQkD7E45gBjybNqUcOXMpOaO
	Mf8PBz0xmmDqM1IbhzmVxeL2lvKgkfNMi0fKuHOOlCzfUGcv5EdJroNmfY8IgYk1CE0nNeBCLZO
	5VwKkeE5iOsTs8fMwINB9SPHzyAFvlJCwQJjIrT93Bjst+aGO0Euvxl4DPuoA3IElFvIjV6zZ2L
	8xDlSt/UdZrOUUYGQsom4iePy3cogPRmmzQbksgUwc55859PwCGQdvrCBIr2/+Sa8sDlMRg1nGc
	zK12cok=
X-Received: by 2002:a17:907:1c89:b0:b98:70fe:cd9a with SMTP id
 a640c23a62f3a-b9870feced9mr385081766b.57.1774332479655; Mon, 23 Mar 2026
 23:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321041058.901149-1-LivelyCarpet87@gmail.com> <20260323141822.GB69756@horms.kernel.org>
In-Reply-To: <20260323141822.GB69756@horms.kernel.org>
From: Tyllis Xu <livelycarpet87@gmail.com>
Date: Tue, 24 Mar 2026 01:07:47 -0500
X-Gm-Features: AQROBzC9ip5K_wNQFZvrDdtzllrm__8yUSGaMMq_v9fzmsTMIsGUbtrFjLi2bjE
Message-ID: <CAJsYhQJga9M1aqeOLu0ni4i5iRirTDTxP1c8qyWz4=-9pBpRtw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: fix integer underflow in chain mode jumbo_frm
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, peppe.cavallaro@st.com, 
	rayagond@vayavyalabs.com, stable@vger.kernel.org, danisjiang@gmail.com, 
	ychen@northwestern.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270883-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AB35E302D44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I will try to change the code to consolidate with the ring-mode
code, avoid whitespace diff, and resubmit the patch with a new
correct subject line. Thank you for your feedback!

On Mon, Mar 23, 2026 at 9:18=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 11:10:58PM -0500, Tyllis Xu wrote:
> > The jumbo_frm() chain-mode implementation unconditionally computes
> >
> >     len =3D nopaged_len - bmax;
> >
> > where nopaged_len =3D skb_headlen(skb) (linear bytes only) and bmax is
> > BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
> > decides to invoke jumbo_frm() based on skb->len (total length including
> > page fragments):
> >
> >     is_jumbo =3D stmmac_is_jumbo_frm(priv, skb->len, enh_desc);
> >
> > When a packet has a small linear portion (nopaged_len <=3D bmax) but a
> > large total length due to page fragments (skb->len > bmax), the
> > subtraction wraps as an unsigned integer, producing a huge len value
> > (~0xFFFFxxxx).  This causes the while (len !=3D 0) loop to execute
> > hundreds of thousands of iterations, passing skb->data + bmax * i
> > pointers far beyond the skb buffer to dma_map_single().  On IOMMU-less
> > SoCs (the typical deployment for stmmac), this maps arbitrary kernel
> > memory to the DMA engine, constituting a kernel memory disclosure and
> > potential memory corruption from hardware.
> >
> > The ring-mode counterpart already guards against this with:
> >
> >     if (nopaged_len > BUF_SIZE_8KiB) { ... use len ... }
> >     else { ... map nopaged_len directly ... }
> >
> > Apply the same pattern to chain mode: guard the chunked-DMA path with
> > if (nopaged_len > bmax), and add an else branch that maps the entire
> > linear portion as a single descriptor when it fits within bmax.  The
> > fragment loop in stmmac_xmit() handles page fragments afterward.
> >
> > Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
>
> As a fix for code present in net this patch should be targeted at the net
> tree like this:
>
> Subject: [PATCH net] net: stmmac: fix integer underflow in chain mode
>
> As is, our CI tries to apply this patch to the default tree, net-next.
> Which fails due to a conflict with commit 6b4286e05508 ("net: stmmac:
> rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()"). So no CI tests were
> run.
>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 71 ++++++++++++++--=
-------
> >  1 file changed, 44 insertions(+), 27 deletions(-)
>
> The bulk of this patch is whitespace change (indentation).
> So seems useful to examine this patch with whitespace changes ignored.
>
> git diff -w yeilds;
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/n=
et/ethernet/stmicro/stmmac/chain_mode.c
> index 120a009c9992..c8980482dea2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -31,6 +31,7 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, stru=
ct sk_buff *skb,
>         else
>                 bmax =3D BUF_SIZE_2KiB;
>
> +       if (nopaged_len > bmax) {
>                 len =3D nopaged_len - bmax;
>
>                 des2 =3D dma_map_single(priv->device, skb->data,
> @@ -77,6 +78,18 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, str=
uct sk_buff *skb,
>                                 len =3D 0;
>                         }
>                 }
> +       } else {
> +               des2 =3D dma_map_single(priv->device, skb->data,
> +                                     nopaged_len, DMA_TO_DEVICE);
> +               desc->des2 =3D cpu_to_le32(des2);
> +               if (dma_mapping_error(priv->device, des2))
> +                       return -1;
> +               tx_q->tx_skbuff_dma[entry].buf =3D des2;
> +               tx_q->tx_skbuff_dma[entry].len =3D nopaged_len;
> +               stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
> +                               STMMAC_CHAIN_MODE, 0, !skb_is_nonlinear(s=
kb),
> +                               skb->len);
> +       }
>
>         tx_q->cur_tx =3D entry;
>
> The code in the else arm of the new condition is quite similar to
> the (not visible in the diff above) code at the top of the non-else
> arm of the condition.
>
> I do see this is consistent with the ring-mode code.  So perhaps it is
> appropriate as a fix. But I do wonder if this could be consolidated - e.g=
.
> by setting up some local variables rather than moving the mapping logic
> into a condition.

