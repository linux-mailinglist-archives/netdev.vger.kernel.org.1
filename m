Return-Path: <netdev+bounces-306029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqAlFREMT2rkZgIAu9opvQ
	(envelope-from <netdev+bounces-306029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 04:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB7F72C256
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 04:48:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Eq1nmR65;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306029-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 644413004D9B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFBA36680C;
	Thu,  9 Jul 2026 02:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB53655F1
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 02:48:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783565298; cv=pass; b=dDC7xS0qdBHTSYea4kJ+JCtwjSNv/Zmp1zrZDgB8euJ+wLO8tWhPuimXmPO1uATXEHiPEJCS2FI7jWIDyCa+g/7g7NWwLR/4coHWZUSkxObxCHj/N37YnXijteHXxr8mHKm5EoEebS9bi5Mj4lSkIoFCnFBPQu41Ba06bsk9vpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783565298; c=relaxed/simple;
	bh=97Y5G3bemZJPx1xBDJhKVeFxaQdRimz6xlQijZv/PXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ad8Pk7KVLRmGD+QTE5JjWy6JtYPNr/oBk9ETeuanx4n+vy/NYSzMayjhlXnQ/ETQNYA76t1hikXkqn79e8bCOProB6VXnFSg6ST/iFTUFa/mKp5KHUz2hw6krMW/MXMroBpdg6QLXq9iFOXOfgmwQlb0MQz+fakWuC8xNmOpzKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq1nmR65; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so597332a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 19:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783565293; cv=none;
        d=google.com; s=arc-20260327;
        b=c/+J8eSiMQ/FYtNjciMmlW+XZ+U8w19RihUa3KL5jn8O81sVhFTBe7JelMriPioiwM
         yg30tib274uasx70r1vBFwlZESE0qx8giVzBATHGRQSqMfX9cgmaHVM2lIFwG60JzPkq
         YfH59zV6kEsJ9BXo4ZWIG9VA8gxFJaY2L097NVtJLd8GZlCqXoYboF4vWfACvsAG0Ula
         EeaqEWYGbs8LlfANdIiJwPloxZANzrzsMSTV5G3NWunqja+MBfHaewgEQGBgcetpfX4R
         dKVuiaMR8CTlOY79onn0vXohENSYlQZ/fb23EOh+tbB20rqXKLEJzGP6jeWVn7m+JKss
         FjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RzIbPzyaxROQi2DmI6cNz6eEd7xiOCPNeCs2VmCd4w=;
        fh=Qqv0gPKQjBFV7ofgmr/Jm6XxUVyxyR+zTsF4evqJH94=;
        b=AhUjskfEYxgEFwM7Kv6F0iD0yU+k/IZVySqpgVeOxIWbYENuQGAauWBdkl8h+08zUf
         p/171cd9JVVYMhtaKZjwxEBJVRslkIoFJgtGVy51tkCQWu1LNHD4BwcfKZB0Ap0fPUrr
         DvBjZgxcawrlVVA9GTeYS/wJ2d5EyFot38FsL7UFvdZlOz7YDbSsIQNL7rNZHiPs99Qo
         rTF/kJRnhbfGsZpZL0xNRAEq5yiLeUhkYJVe0coW20wUBk0VOEn1XnzJPQL+O3Rdg5Co
         V+yWn7bYwV5hSs/Wq5mt1quseBDFTHEf5cFe1YEbwYI/HJMfJtA6XSlzUYQzF3yPGjXr
         JTgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783565293; x=1784170093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+RzIbPzyaxROQi2DmI6cNz6eEd7xiOCPNeCs2VmCd4w=;
        b=Eq1nmR65vlHGjzMaKUdvS28YsYaLyVos236+YUTI7beBnE74WptKRuZZTxEB/RUM4W
         Q2JdwI16sPVRLuiu7zsKFrypnQS/6jgfIIklpQOegwB7Erb4Zad3oCCwsYECHazO7qWh
         fLtwYcntdq4S4iAGNI8ObAIr/IvTXSv1vBBlcJZ0xy7DcLAim6g6BuZuYu8D6o++CLlB
         w0cyzLMRxBPqh3lqmbIPFiKwOn1YMlROyDIAJVS3OLPKR4QcReUrjX2VxAqQqQCrxBtb
         nzNywYHo2Kh/emCZo4qcmnlO26hN4QYjCK2T0jsqfxZ12zHBQx5IAb6Ge3hkBHWYTn03
         U1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783565293; x=1784170093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+RzIbPzyaxROQi2DmI6cNz6eEd7xiOCPNeCs2VmCd4w=;
        b=kGCqh+jwLscWtbYkyK8z106ARxmyv4ZPdFSRe14blVaK3zT6BVolr2dBXeeFkH1Jz1
         hEYAy/nSRL88sZE3mj+gG0nXZKK9vOGFx8xAIzvJHUfOW4A0ZpobYuZkOII2DjLnHnmP
         rZ5osHDl60isoH6e5cJJwKxS7e6yMYmlaceYBkVdmD8EREyLGykliA3TiT56Yx6Rkznb
         S7pZsjaMZn5Wi4uzIrrl0SqPHJB4aCeqb+u7RSQMt3YuxDN6FZch+5/L9vWUiVrOJjBd
         HxQ7V3t7mRyuV4mSy07mvRA8RKOliFRz+4mLCZ+hSdtZEO8A4gmNTyMjpCWvPs5d9deC
         G/9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpgFV4p7GgfeTBNUDhFEnUtbi8LfgNQZUEdEmn6OVXguZaaFCL8QKu/v9WNZQL33ploIbXKt2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDrTJlqeyCrg60XIKDAHAHWnmSD3s4zLAVdsjPswYmegzSKVU
	qBPoFpcGL2tmLdAI153ys4WRvuJy+e1yT9+huGZbh7WbNeRL+REUt1EPnxXUWwX6Y+ig/5TNbuq
	Vm3QtJB4zPbUYPtBsfqvPe94PsJoqhQM=
X-Gm-Gg: AfdE7cnGZMDjKdYR160Hkd3h4RxQXTsvsppNxRJGWDiXGA3ElmmwrjSVNIUjc556tes
	7+OYvHy51ac2F02pc0/fkHnRt5LjSjgUpSLCE0vm5Y8IOPJ+pNswDuupTVEYAVE/srJ1WXcmDd5
	UGENv8EwVxIc+Zvi27p73YBRJhczRb8JP4CladM4YDbPVjqUVc8IYIUuqGSekDpam4pNVa2hTcK
	s1WBOmmUCgo3w7+BO3ppYdjRm4ngh+q1xtic14vBLddo2MvxfkobGgys2WQ6UjZge0cDRFEquTF
	yMz6OoiV
X-Received: by 2002:a05:6402:2b90:b0:698:3b7c:7e50 with SMTP id
 4fb4d7f45d1cf-69ab44aa1a2mr1864953a12.38.1783565292883; Wed, 08 Jul 2026
 19:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630144831.1109-1-hujy652@gmail.com> <20260706101044.161059-1-pabeni@redhat.com>
In-Reply-To: <20260706101044.161059-1-pabeni@redhat.com>
From: Zhi-Jun You <hujy652@gmail.com>
Date: Thu, 9 Jul 2026 10:48:01 +0800
X-Gm-Features: AUfX_mwdocD4sBig_WoK4SaEZrNCS0Q_Edgdfsxn5LciBLfJp0MkFDpcIGf2CVc
Message-ID: <CAHGaMk-=0FfVq_73mr6wcn+3XaGXRJZVTbBVEQ3uTcYrBhdNtQ@mail.gmail.com>
Subject: Re: [PATCH net] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for
 non-DBDC MT7986
To: Paolo Abeni <pabeni@redhat.com>
Cc: lorenzo@kernel.org, nbd@nbd.name, netdev@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:lorenzo@kernel.org,m:nbd@nbd.name,m:netdev@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306029-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hujy652@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FB7F72C256

On Mon, Jul 6, 2026 at 6:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
>
> This commit updates mtk_wed_start() to configure WDMA_RING_TX(0) on
> non-DBDC MT7986 devices. It adds a call to mtk_wed_wdma_tx_ring_setup()
> for v2 hardware if the descriptor is not yet set up.
>
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethe=
rnet/mediatek/mtk_wed.c
> > index 10d9beaae3721..2420557f6c966 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -2334,6 +2334,10 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 ir=
q_mask)
> >               if (!dev->rx_wdma[i].desc)
> >                       mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this loop need to che=
ck
> the return value of mtk_wed_wdma_rx_ring_setup()?
>
> If mtk_wed_wdma_rx_ring_setup() returns -ENOMEM, the hardware registers a=
re
> not programmed, but mtk_wed_start() continues execution and enables DMA.
>
> Could this lead to hardware DMA using an uninitialized ring base address?
Hi,

I am not sure how to proceed with this one.
mtk_wed_start is a void function and both mt7915 and mt7996's dma
function that calls it don't have return value handling either.

>
> >
> > +     if (mtk_wed_is_v2(dev->hw))
> > +             if (!dev->tx_wdma[0].desc)
> > +                     mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_R=
ING_SIZE, false);
>
> [Severity: High]
> Are there similar error handling concerns with this new call to
> mtk_wed_wdma_tx_ring_setup()?
>
> Like the RX path, if dma_alloc_coherent() fails inside this setup functio=
n,
> it returns -ENOMEM without programming the hardware registers.
>
> Since mtk_wed_start() doesn't check this return value, it will proceed to
> enable hardware DMA, which might attempt to use an uninitialized DMA addr=
ess.
>
> [Severity: High]
> Does the check for !dev->tx_wdma[0].desc prevent necessary hardware
> initialization after a warm reset?
>
> When the WLAN driver triggers a hardware reset, the WED hardware register=
s
> are cleared, and mtk_wed_start() is called again.
>
> Because dev->tx_wdma[0].desc was allocated during the initial start, the
> guard will evaluate to false, skipping the hardware register reprogrammin=
g
> for tx_wdma[0].
>
> Will the hardware DMA end up using a zeroed ring base address after a res=
et?

During warm reset, MTK_WDMA_RING_TX(i) + MTK_WED_RING_OFS_CPU_IDX is set to=
 0.
Other parts are left untouched.
After the warm reset, mtk_wed_rx_ring_setup will be called with
reset=3Dtrue, which also calls
mtk_wed_wdma_tx_ring_setup with reset=3Dtrue.

reset=3Dtrue will skip ring allocation and call an extra mtk_wed_ring_reset
but for non-DBDC mt7986, this path won't happen for the tx_wdma[0].

Usually rx_ring and tx_wdma are paired together but this is a special
case that rx_ring[1] and
tx_wdma[1] are allocated but tx_wdma[0] is still required.
Maybe something like this would work?
Runs only if wed is v2 and rx ring 0 is not allocated, reset only when
tx_wdma[0] was already allocated.

if (mtk_wed_is_v2 && !dev->rx_ring[0].desc)
        mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE,
!!dev->tx_wdma[0].desc);

Best regards,
Zhi-Jun

>
> > +
> >       if (dev->wlan.hw_rro) {
> >               for (i =3D 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
> >                       u32 addr =3D MTK_WED_RRO_MSDU_PG_CTRL0(i) +
> --
> This is an AI-generated review.
>

