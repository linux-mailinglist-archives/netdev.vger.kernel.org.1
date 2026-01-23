Return-Path: <netdev+bounces-252908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEyCBFGzc2liyAAAu9opvQ
	(envelope-from <netdev+bounces-252908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218F7925E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F333F30488CB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E02652B6;
	Fri, 23 Jan 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ThEsy9qZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFF246783
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190152; cv=pass; b=fXeUv9Bu+DSC71KcHBx+MIkRdhMs74NHJWV/bZg16t0KD0aIPTL6/nmt02wPgPwKmW56qKCCBmjyy5+7zUO5//MAgO5iuL6Ag9D+/32Z1XxGpktgHcxVThuJkiyz4ahEuJFBIi9J5gktIoTo49Wjgfu41wr3HayR+MW7QzEs/nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190152; c=relaxed/simple;
	bh=/CdsOSS6DJl2mmFqC4epKZeUrSTnB+w910MdTwnR0eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEuvGA/ZxgBwfScCi/ipJBMk28+9lgG2iSg4TA6VoiukyP2t4Da7ys0LUJG4hCwJcpBOkZb1mlLE1X8azGQnzWJ/6vxgUS9shs2XnstZiYZToW9b0mRMIfuxbwlTRQiHi/If+Q9XpJaYLzr9lIAdp5tCbX345O7iOGDvVRU0SxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ThEsy9qZ; arc=pass smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8887ac841e2so22973186d6.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190150; x=1769794950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLVVZ/rbmu+gE7XaZCOkTBI14JwxgDTsLW6UP2WVWLk=;
        b=EFui81ls3i3jmrGECngHkd1Rr0QyUdCZ+iCBiMzMXBPb95PmTqXuJGmJSXY6uTCuoh
         DOobpwg/pc/V9xutajaVaiUS4TWbLVaVcr4Of+vB6L/DgwPTQ8vyQrOEt+26+zbd4a6H
         XumbWyuihfGe7cSSmauk0OTSsZiws7uLliKOdt0QhNW8+Mm4FrGultAWk5qXYMCtrggi
         CK8K9lvC9hIJUr4U+54W9HHFmi6qyaVQo0ExMk3pY4Vh7+RiyKwgH1zUQn/RndGufzjJ
         V6++Apu6/yBTIcwKwcW8//XNKnb4U0viUAnC2/EpM7cslv/J+yihUig8b9cuuUuXuGQr
         ojOA==
X-Forwarded-Encrypted: i=2; AJvYcCUeay+95y7LkA0blGpE/gMfeV4eDLjWDw93jr5f1dmukg6dvbc2I66foUKVV26BvtyiTG1T1lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dbafN/L+LUXABup8YLe7gFzpMDFGr5G9AoHSzU1H0+2CDRlZ
	PPDux5Aa9dhIFsOlaQQsyzAO1bVCuGjao/MWY+RLB91gk1xHUjLhU5XUMmrVBESYzEYKkw67DW6
	/V7IJTH2WD61dcwHByiZc/pVUMEMRoVg8U5XrVlwL4BkzbZZYFhdV9dvAJe+cIUEREsTnn0LVM9
	8Wy22ED7z4n9u9yWEWdbEXmP9dh82wFepPrWy45b1iXUWfhe8VRfN2TXbDCcyHImqIjL+Tx2bae
	r6W5ZrPIsH320107g==
X-Gm-Gg: AZuq6aLfho+5CanGBf1/0wT4jVlmJLpeUPes0+p9OZrOBQ04tnmPw7M61AWJlDdwAbr
	b76bUWaT+4kwJjv+6ud+gVRh5/yPcluIA0kC4mawiF/IuwyJDSFecUyzGeCf2fBLYYzyKw6glsN
	c9b608nuu24MES2TXPXCpcFNVkbRS/w7S5M7cTJU8tySl6KI1BF82sSROA09Y4EsOhtqfiK0BSv
	/cT0liIQ7Qu2YkOG6g81odAwoYoZGXyh5GK/G2zQD5H95UO4uf1N5nRlivGJCrn8SOc9lWzr1lx
	8GIhjwaZIEPLoexaaZ7TbSQNauWOqt3K8z37T6+v4Zg1WVzbX4EZdPxRqoeKF+/Quepvx1teOMF
	d3PHrXAIYqwSjs0s3LNI8a/POfNNk5TOjEYgS7+JYPmh1RVzYIgbV7AfqWjRPm8eF4/+n5SG+VI
	c49ml83D+x9bQYTBvIhZyWETZYNU0YqK8cbCeaXuTENuPMZKP21/U=
X-Received: by 2002:ad4:5de6:0:b0:894:2e2e:6385 with SMTP id 6a1803df08f44-894901e2c14mr51089746d6.30.1769190149570;
        Fri, 23 Jan 2026 09:42:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8949188033csm3529056d6.15.2026.01.23.09.42.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 09:42:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b71c5826fbso2545595eec.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769190148; cv=none;
        d=google.com; s=arc-20240605;
        b=YWOn0CWzIXMFxSww0ZosFPWsoghq0eVd1luJfbtNIzM2WImZP+NGeOS7tof1oE05DO
         XkyVvnm+wGfbJA+aMQ8R+bW1qkAmOhnu/tvs3zOQTM2zzIhK3cj5bhjfmGFT4sDlxV4r
         1Rd4+7G2maZLQPcDnw6FjDV1icjo1ahDf2yZhv0HUrdFukXqRwS9PDtnbXpptMmqbNJE
         ZPGsbKnFE1XUQtnmIHQV9ORJPkZl1SWEL3gBXKNK7ZfrlH/HCJAJ8O6UXH8hGII0P3Pq
         VI0b7u/xjOj6QSyfRhPck/EaeWJRsfT4hdAhiqTgJfUMyVqEEubdPxzYmXC5D+WWJESF
         W8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yLVVZ/rbmu+gE7XaZCOkTBI14JwxgDTsLW6UP2WVWLk=;
        fh=y183RClbE3Zc4qcBtfgrVbzPm6kVxVKiI9nwCqFHp8o=;
        b=dFGR2QBe40PdItDw+lJoBopchbSIJKRYHkZKS1MbXShHmkaFpTlzVaqOMeVqmJ9cuh
         qhLIALXBiqnGQA8armPZUFOb8AEfwhvn0CoLECXst1WlPjlJgjI/kDYQUhe6SWNI1UTZ
         8djzGOmH75YvaTQ8W2tXNtwNCwOLdKkqlepkwHIsb0CMkhtVMffrgxBjfA7XItbQpVqe
         E3wcnQkb8QsNHryTRa8YcPbc0v1louWF/2Tcp9NYNi0KUu/nYp/UCFtvD2pn3o0K3q+h
         a1Ea69Rl/mma5+1IVkFRrSThcFzk5cQkL59GPuUGzy3YZfgYVAvyPPQMhsQNwKIc3LuL
         t+lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769190148; x=1769794948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yLVVZ/rbmu+gE7XaZCOkTBI14JwxgDTsLW6UP2WVWLk=;
        b=ThEsy9qZWUcUS+RUhDLkr7YM+O/BKARJOwSCwxouG/LxkyJlbfBD53oClQlIhfFHgA
         Iqw2A7asddFJ9Kv4TQ7C4exU6WbtcuO1z4BGfwqwft5/FidB5TL994vfeEoVsO1VTm+I
         1KVXSmhjktv+cRhOhey4TI4OsVFeFyehYHNrM=
X-Forwarded-Encrypted: i=1; AJvYcCWBNDtL7hwuOK0oCh3nxPHrVJa6xymfZIidoNjZeHqmlzq4qTi/Ent3M0TWRd8QBnaZuFtG6gY=@vger.kernel.org
X-Received: by 2002:a05:7300:8c9e:b0:2a4:7f22:cc0d with SMTP id 5a478bee46e88-2b739b96eadmr2109957eec.32.1769190148274;
        Fri, 23 Jan 2026 09:42:28 -0800 (PST)
X-Received: by 2002:a05:7300:8c9e:b0:2a4:7f22:cc0d with SMTP id
 5a478bee46e88-2b739b96eadmr2109930eec.32.1769190147803; Fri, 23 Jan 2026
 09:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116193732.157898-7-bhargava.marreddy@broadcom.com> <20260119194550.1264743-1-kuba@kernel.org>
In-Reply-To: <20260119194550.1264743-1-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 23 Jan 2026 23:12:11 +0530
X-Gm-Features: AZwV_QiwogvTkb8s0mVpIFvtugqrwqvvnbTAQ33sQMtfN38Xu_CGGQ3Vk12CnY0
Message-ID: <CANXQDtYYg1psrAcPkpvAavW1AGezuG0M-Bo=SA=JuurPt1sA6A@mail.gmail.com>
Subject: Re: [v5,net-next,6/8] bng_en: Add support to handle AGG events
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, vikas.gupta@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, pabeni@redhat.com, 
	rajashekar.hudumula@broadcom.com, rahul-rg.gupta@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, pavan.chebbi@broadcom.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org, 
	ajit.khaparde@broadcom.com, michael.chan@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005a363b064911ae7b"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252908-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 6218F7925E
X-Rspamd-Action: no action

--0000000000005a363b064911ae7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: Add support to handle AGG events
>
> This patch adds AGG event handling in the RX path to receive packet data
> on AGG rings, enabling Jumbo and HDS functionality.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_txrx.c
> > index dffb8c17babe..d6c8557fcb19 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
>
> [ ... ]
>
> > @@ -284,14 +487,25 @@ static int bnge_rx_pkt(struct bnge_net *bn, struc=
t bnge_cp_ring_info *cpr,
> >       if (len <=3D bn->rx_copybreak) {
> >               skb =3D bnge_copy_skb(bnapi, data_ptr, len, dma_addr);
> >               bnge_reuse_rx_data(rxr, cons, data);
> > -             if (!skb)
> > +             if (!skb) {
> > +                     if (agg_bufs)
> > +                             bnge_reuse_rx_agg_bufs(cpr, cp_cons, 0,
> > +                                                    agg_bufs);
> >                       goto oom_next_rx;
> > +             }
> >       } else {
> >               skb =3D bnge_rx_skb(bn, rxr, cons, data, data_ptr, dma_ad=
dr, len);
> >               if (!skb)
> >                       goto oom_next_rx;
> >       }
>
> In the copy path (small packets), when bnge_copy_skb() returns NULL, the =
code
> properly calls bnge_reuse_rx_agg_bufs() to recycle the AGG buffers. Howev=
er,
> in the large packet path (else branch), when bnge_rx_skb() returns NULL, =
are
> the AGG buffers being leaked? At this point the completion ring consumer =
has
> already been advanced past the AGG completions by bnge_agg_bufs_valid(), =
but
> without calling bnge_reuse_rx_agg_bufs() the AGG ring producer won't be
> updated with replacement buffers.
>
> Should the large packet path also reuse AGG buffers on allocation failure=
,
> similar to the copy path?

Good catch. Leak was possible in the non-copy path if bnge_rx_skb() failed,
especially with smaller rx_copybreak values (i.e. less than 60).
This will be fixed in the next spin.

Thanks,
Bhargava Marreddy

> --
> pw-bot: cr

--0000000000005a363b064911ae7b
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAHJAHLjApa52x6fLLjZZZKk/fJnB3I1CO0QI566rOU0TAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMjMxNzQyMjhaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBP+eS1
nKMHnG8ldBNrK3rxgwQ5WdfvPzsllYdPC/CeK12iTleNoqrVI4tUxzhHkvNV4dpfkEFGKdhzovf6
YSz5baxAwA4xRdi+FLj3MK/J3U8NrtyDy8oXL9WDkhil6c4wvqdhLI5Ptt7PUMQZQIZvV+87Lrp1
cTnbxelSqdBrZ6B2qg/wsGc9Y0BjVl6tGP+tp1qajJwwgn9OsTq5PXIUSRdykEMyEqDAb+xJGBfW
MryN+YF/QUt+IDDd5fvwGy3uThJvFdHrXSvk+RFwlQohvpnxFx/EWTyR8WO9nhi37gOLMmrcLc7Q
Ws5GkI0ypkLqvgC2u96JYrmm0e9G+HSh
--0000000000005a363b064911ae7b--

