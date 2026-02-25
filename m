Return-Path: <netdev+bounces-261043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDO0J7g7n2kiZgQAu9opvQ
	(envelope-from <netdev+bounces-261043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:13:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDC319C162
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B38A7304022D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B233E9F7B;
	Wed, 25 Feb 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gQqKrUZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369212EC081
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043115; cv=pass; b=FD4Znmh9PdYzoJkHPIt/dpgEO/Rfz0e5ONDT8OZF2N2kmm7v2adakhD3DeIvSH/aTTTZiglyHS5cOJ6GxELwES/5Uhlo5Cor81G0fa7Dhjpo5HU7KS2ld3ippdph5kuky4Z8RCm7OrW8C6WiejhnC9/sqlMAhhnR241BdhwWyTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043115; c=relaxed/simple;
	bh=jm6k2YKhNPCtCFtGdrxvuFT7sl3Mh3efJo4q4er9Sa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc2oIYdXB5mDC3pGxcpj8FXmt2BLiQ0agNgN2IIoGdB+f4Eic61qkODNQOyywj8t+sMwFDNM4IZzS+bqPOTr5Jpwjr0T5qjFA/l3NbIhOchTG3qSyL5vSPBD7Nyfln+y8EyPhyDJMp4+Z6Zd/M1rdbdcnjRs6x5BaF+2lCriJrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gQqKrUZZ; arc=pass smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8c7199e7f79so925933985a.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043111; x=1772647911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaVuLyLJTg5doKSxxBgpW1qgdcb8juucCYx+cIbDoUI=;
        b=Oqo7ODjzYKM1CgdtiCZ0E4Y5FscTsg1eNNYPM0HSHSrCjepA+38+HTxvrFG2XaAKU/
         BEbKrcrDNTd66VYu3zTRbvDZvfazPuNokNTME9J1PVg5sd1ARFFhHPZWHazfyKNiiwHw
         NjHoV3okT3AhuCCbbh1K0OFOeUd2eLQp6zBPERxwAxMp+MGQ0OtOmFUi32x6Mp3pVTPu
         crmIlqf62NTk9efBSwqahwJ+n3vEb3Wrjlyy+vqwBf8RPA4rXfy/xh8YrSdL/WaboQLU
         VMk7CZNnBaRN3T6bRHVorSA1BwZZkILLCNC7hooh2XCq6agKcr0f+OGTORcHLgOiYYBH
         y1ZA==
X-Forwarded-Encrypted: i=2; AJvYcCXGMrO/8NTpy/dK5kBAkJvnxplB71HF8yR8IRvcyhV+ibjDEaQIvXNmAJ0rqT5s1cJqJD3wqWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZp+/gUXy7ryeDfjtSZOE3Ci9t3Vr5AlBp4V2jZghHeZBWD4d
	tTLDgCQSvWmwvaBebg3jWOh/vNDl3BqTuYqDqppifnBd/jnZs6PJIkDZGvQ0Eo/6h/h9cwWANLA
	GRBTDOk09izBvDocKB9OZfMfl3opuEosVDDRqmScvxUeoqNADx5tpPKMEcUFz4D18aJ0ghW7RyB
	G1q3FtvEh8F9+RzJL7dKI8Wd8bfbuNq2qhSpwME99MIqEhWu/bHD8RojzFiJTExB6/GU/rnF6Id
	qHidKIi6mihwB0NyA==
X-Gm-Gg: ATEYQzy0YpkI5gwNz/7ZJEOCRASYL3AwZC4M2upqnHF95TAQwgcvWQekWFbvzPGDZ+S
	+dOxVCZkJT9rCxge3HNY+oz1Sw+tB5hRfQ/soCp6G04Nw+LdO38YThD23N3xGpMDf9ZOteliLmf
	kCNZli+Zn6co8oxJM57pBSBv5kJQc/7STskiECHqooRm5Nv6SOsjQRPtDcqNOJQrd9htb0c70ME
	bmxc1BJblwEjGgZSXEeqsH1CewKq0birMJ/WXDigFmGdImBFBnPhRZ88i4156RpGCjHEAKwSF+U
	I3XBsnSVqtxAKrY5C/fp/qiK899V9HYGt4gQ3ecvzszhsGBbr0r14rCMkNE2KCXiVIK9aGN4VBC
	MjlXTISEx220AOsagzy5f5xT/fnQ4lRpmmUYo5dsxWuLub63GFlQLLTIY1YzHVYEC9MDWKQrxQ2
	VocjUUueywbdTKbL925I8QpaOTdAwWV1iFlPaYX5p000Zfoi8DxOdrA32kbZJaYTX4Yg==
X-Received: by 2002:a05:620a:4892:b0:8cb:7b27:9336 with SMTP id af79cd13be357-8cbbcf42dfdmr182816585a.5.1772043110839;
        Wed, 25 Feb 2026 10:11:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8997c699717sm16638836d6.7.2026.02.25.10.11.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:11:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdc87facf6so686694eec.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772043109; cv=none;
        d=google.com; s=arc-20240605;
        b=AdtNPBlJ7Ph8+xt987b0r7XmfEIbAY8wrSwetiUwlGg+wC9wm1hctLmjpkgDprMcy7
         iXk8kIecxNwBkvtPMz4Ae8AH6Qb5s16ytO78ytZA7KR1xqF+DJ48p21zKb4MGeRmo1Wn
         pCjwKEVwkKvn8i+q0H4OpxgUbg37NBGrQ1toYpPtnWN+Dku0vsjRj4y0ry7LGvFLFTVO
         8zHj6vzf09Ftyo0bR31xRbQf9xFqAtYvmWeMsP3xOxxmZWm4L1knyiGXg1jM4ztOIQJm
         2klE7ePjo+uk8IxFYJOYPPe4QX6VIfZDBGy8DxIXULsh5uALNQf7I/kfXG9XcB6OkzCY
         BYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eaVuLyLJTg5doKSxxBgpW1qgdcb8juucCYx+cIbDoUI=;
        fh=gFULzqx0XNFANqhZFAPiQQ1OFNtaNKMP81zlVBESCnI=;
        b=geldq7o+N0Fz8bS+vRjkQRHra6sSr4qEBLmrjn/QHRAJnrZ3OdwarSECskVa1nGsG8
         VpwZ8/mCS4aAGeCyusfwaFFZBbs9IO5FwEtEgRNBcAjLuaHbFbkANPgzeysGRcp9hghC
         9t2RO3fizjgdQGp4Fo+q7aXRTZ892vWex+lGS+UJahl71j1qVy7qMl9+Iz2O5BlPqzNo
         rfa2GWnvmtDwGWARJbKGhjBSUpr5eZ10SOZvbnPUOPZj6IkNw2m9awXtlPzbH78dtHwo
         oH5pxlG9GDCJPt7Av2cQNaCa4bnZzuC8m/PQy5Ldi0WRT1gXJTdg863uxdK02TkVffLJ
         J6rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772043109; x=1772647909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eaVuLyLJTg5doKSxxBgpW1qgdcb8juucCYx+cIbDoUI=;
        b=gQqKrUZZfxxpv14rQ0zbRBJ8Twv5p4jFOU348mXs6qVsDJqcPc0v6wqBxpDPhWHaBx
         GxH9Y4BcJwWE2jbu0wVu2GyWOJ5I2ax7FCklhSPDsI42FmPNRtafD1IG8+aGTWbr3SwO
         bWM6nbRV73qLXy8wd8sG2RsicRUlBDV6xHL9s=
X-Forwarded-Encrypted: i=1; AJvYcCX6Ll22y6AnUb+Zv7ue9CzLv3m6orIjFjqoHxA5HhORzLcwFntkoCRSkSBT7ViEGhdRjtKZ/xY=@vger.kernel.org
X-Received: by 2002:a05:7300:230f:b0:2b7:1abc:a6e9 with SMTP id 5a478bee46e88-2bdcbf668e8mr530885eec.12.1772043109400;
        Wed, 25 Feb 2026 10:11:49 -0800 (PST)
X-Received: by 2002:a05:7300:230f:b0:2b7:1abc:a6e9 with SMTP id
 5a478bee46e88-2bdcbf668e8mr530877eec.12.1772043108859; Wed, 25 Feb 2026
 10:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-4-bhargava.marreddy@broadcom.com> <20260224001201.146384-2-kuba@kernel.org>
In-Reply-To: <20260224001201.146384-2-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 25 Feb 2026 23:41:34 +0530
X-Gm-Features: AaiRm516eoY_eNqkYPYzdDfk17c4_cv4QKTpsGJ0fj10I9hGFTHjCyAFlwlhb04
Message-ID: <CANXQDtYfFai8NBfMHK8C0M7u9-UatirS+PuhgrYp0qL7_8rRLQ@mail.gmail.com>
Subject: Re: [net-next,3/7] bng_en: add ethtool link settings, get_link, and nway_reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org, michael.chan@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, ajit.khaparde@broadcom.com, 
	rahul-rg.gupta@broadcom.com, edumazet@google.com, vikas.gupta@broadcom.com, 
	davem@davemloft.net, pabeni@redhat.com, rajashekar.hudumula@broadcom.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, pavan.chebbi@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001765fc064ba9f070"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,linux.dev:server fail,broadcom.com:server fail,mail.gmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-261043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:url,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECDC319C162
X-Rspamd-Action: no action

--0000000000001765fc064ba9f070
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 5:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: add ethtool link settings, get_link, and nway_reset
>
> This commit adds get/set_link_ksettings, get_link, and nway_reset
> support. It also adds reporting for supported, advertised, and
> link-partner speeds across NRZ, PAM4, and PAM4-112 signaling modes,
> and enables lane count reporting.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/n=
et/ethernet/broadcom/bnge/bnge_link.c
> > index bff04dfadaca..f037229db7b4 100644
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
>
> [ ... ]
>
> > +enum bnge_link_speed_indices {
> > +     BNGE_LINK_SPEED_UNKNOWN =3D 0,
> > +     BNGE_LINK_SPEED_50GB_IDX,
> > +     BNGE_LINK_SPEED_100GB_IDX,
> > +     BNGE_LINK_SPEED_200GB_IDX,
> > +     BNGE_LINK_SPEED_400GB_IDX,
> > +     BNGE_LINK_SPEED_800GB_IDX,
> > +     __BNGE_LINK_SPEED_END
> > +};
>
> [ ... ]
>
> > +static const u16 bnge_nrz_speed_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEED_MSK_100GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_pam4_speed_masks[] =3D {
> > +     [BNGE_LINK_SPEED_50GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_50GB,
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_100GB,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_PAM4_SPEED_MSK_200GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_nrz_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB,
> > +     [__BNGE_LINK_SPEED_END - 1] =3D 0 /* make any legal speed a valid=
 index */
> > +};
> > +
> > +static const u16 bnge_pam4_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_50GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_50GB_PAM4,
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB_PAM4,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_200GB_PAM4,
> > +     [BNGE_LINK_SPEED_400GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_400GB_PAM4,
> > +};
>
> Is the missing sentinel entry here intentional? The bnge_pam4_speeds2_mas=
ks
> array has its highest initializer at BNGE_LINK_SPEED_400GB_IDX (4), makin=
g
> it 5 elements long (indices 0-4). However, bnge_set_ethtool_speeds loops
> 'for (i =3D 1; i < __BNGE_LINK_SPEED_END; i++)' which reaches i =3D 5
> (BNGE_LINK_SPEED_800GB_IDX). When BNGE_PHY_FL_SPEEDS2 is set, sp_pam4_msk=
s
> points to bnge_pam4_speeds2_masks, causing sp_pam4_msks[5] to read past
> the array end. All other speed mask arrays include
> '[__BNGE_LINK_SPEED_END - 1] =3D 0' to prevent this.

Thanks Jakub, good catch.
The missing sentinel was unintentional and could lead to an OOB read.
I'll fix this in v2

Thanks,
Bhargava Marreddy

>
> > +
> > +static const u16 bnge_pam4_112_speeds2_masks[] =3D {
> > +     [BNGE_LINK_SPEED_100GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_200GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_400GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_=
112,
> > +     [BNGE_LINK_SPEED_800GB_IDX] =3D BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_=
112,
> > +};
> --
> pw-bot: cr

--0000000000001765fc064ba9f070
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCMFWS2jMUxgYKnKKkTYJwA9/ev0ROU1selwVWFb2QmEjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjUxODExNDlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCPz8qc
gMC/4jggKHQJfovDSk6VVWnTD1mEb4wz61vfDy1YFln5EOVu+RC498mKiK0M0aoXFwj4oiIv/auW
JOTBXwcX9z/esHFhWw/fTq4Gb+1UVIjbktjvxRZxIiehuf/rXRqkxDeM76KCmKEw+t3ZHv+Fx1G+
uYOEfi4CDdpqjaTd2EJLP3KtaDlfHZ/48ZlqtSfOgsj7RBgf79i1js69amQxdkqbfpjbQwMkoVO6
GTJSUi+EbAy6RVJ2Jlo85sDYjaWsclYafa9SqFRXvs0sSjjUpBo5s8W4RzAUAyVxV0sll52wdqlH
+q2Fu8B9NBCbesGE8yd/psvBuGGvx1hi
--0000000000001765fc064ba9f070--

