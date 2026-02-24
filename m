Return-Path: <netdev+bounces-260639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPh9HhsBnmkfTAQAu9opvQ
	(envelope-from <netdev+bounces-260639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:50:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7418C36E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003DA304C139
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F232E6BD;
	Tue, 24 Feb 2026 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F1+iFGsU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818032C94B
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962647; cv=pass; b=duSnDb/GzH2ULr5+OU+U8gAc94OGtWC3YPPU3fiwJqWXGlQHqH5beI55Tgss/HBh8QnweE0kQBUI4NWB1X9odnGJmTLTZuy+vAoVj6iFHbw2PFDGdzGmfQUrR16cX3xEQIN7hvU6nvakeOsq1GiO+VL+bCcTKYQD8FaOSx0FIe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962647; c=relaxed/simple;
	bh=yhaNSbEG6/PE+JKbpF3xxaKbKG8IIPAomr145kTti+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko/GEKfNO2zzO3cMltkEQaCbvIePgG6c52ZRxfYZSoCOudFDhoU/3A4lJwwboje1LcV2lFL62GvgwrSVKLLEr6/giS4Rwnn80lWCKM3u+/btEjB5a0FMmrHljW3XgOyJwy8jguxhJuTEJ8uoMOL8qCHnZLaLueQN1/xK1dA2/4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F1+iFGsU; arc=pass smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5663724e4daso5552494e0c.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771962645; x=1772567445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z0+2Qvwtsc6bZPmM44bdJDU4V692OMaJL2cwJ3fWKM=;
        b=K+NSSB8t28vNCuFbzO3W7sbPDNeAa1Y5zdV3TFZWsBuUxZICBr3Df5x0hpt5VIsyyJ
         XKjdMU8yCGK738W8FQ1UwhLX/yBLyUnEj3q8Kp6mdFJhNkCrIwiKdKsxx9Y+s74iNa3T
         AFCPBcuQD4pTOlHKtkwoSy5fNp6xF46vEzAEZRv6xvg83LGdiKAQXs1DmNTFMlqJBhJq
         /Vtbp6hkfniR29xq7kdCKCxHTMEBMGQmVCmkfgjphr9oSthnrSS6yQO3yMqO4hNV4mD7
         3yvoB/Yh6AaP8ICYFonZwLpe80YTHVlsjac4gvzYTf61UhFuYrl1vPt0/szhpWXB7c93
         erbQ==
X-Forwarded-Encrypted: i=2; AJvYcCX0LlZpQUMqh2H9VC8JIwuZyJRf2QZEJYOxytyiua10tia8Fw4ZNdcFmlf/Bm14NMCnRIF+v7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/aw1jWP/idJss3GkoooqzXF9eB2lHjdy+OXRt6gNdp+3Uab1z
	SQKeytjpAs+Z4XNz9lFs29HfbCn67TYM/WDIsRXqD0vEcm+NusOvwblyE+E5m8JuDdPWKo2EUDd
	aprL4yOEMozjFB1k/LLCdXcxouxIKhAxxHTh5pxOCVKw6j14bHq3jIWGCRc/hr7Lj3jDqlzhYjU
	egDgx/wE11tpF6o5z/9PYdOgBRy2FAy3ePO9tqWRAvVSogdJy2e229H7M95C3xOSHlbDCuIOtNY
	hQoeGqrNf1Wp71I2g==
X-Gm-Gg: ATEYQzweSTyx/c8mE+vqKZIfcp34ioDq7cR1G6/eB47ZkFldnOr82+4Bo41uKRgXsBq
	qC0ZcduOZxQm+/9dXmuuAsYKK/x6zsCI2ib/cZ/9MmXkCvihcbdLBB2Alrl3n8mXVBSWHWjqZRx
	df9enLOLpztTm3L/zMWOzGsiZTz5KYvLd+pxMu83df+vLquqblw9Deni0SH5BkA/WhEakN7VsSU
	B1bAPmR26JiPhg+YljrDFxdE2gjBB3apFavAmDiXMohTQwyALE5JArLgf5DfOi9hAqW+QalnDQY
	sT6rE/0VRi1/3aEYSZvRzMuZirJGuLFb44QhblI0kFLEHFxcnhTZUhfY8HfTxV2FpDGyQfFm6N6
	nPRZ1dZMFm8tU28cqP5GmUcKi/ZfF8mi9eYBkR+TF9oGGfpZnXSsM3uWUCMb6gJx15g/7oWc0xu
	wzfkf2ILjaCGSQl/Xmhif1HM35gGdjv//TkXFdEPbnhJ0T+jEYQcheHQ/W48UKuy6SpQ==
X-Received: by 2002:a05:6122:4596:b0:55a:63c3:f7a7 with SMTP id 71dfb90a1353d-568e48bb403mr6296416e0c.14.1771962644649;
        Tue, 24 Feb 2026 11:50:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-568e58822a7sm2041949e0c.5.2026.02.24.11.50.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:50:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so161342eec.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771962643; cv=none;
        d=google.com; s=arc-20240605;
        b=Uxn8Aa8HYciSd9RhtLOAiWTX6wo9zfppgM40JFtVRS3PEgtom/fCCEp8dgOBBr3zj+
         7Wz5a+MAYZxnhzvqxQiTk3xZssOtUp2rh5MmIA7VRNYAI1KxAJGUGIw/mhkk5GNag4vb
         knPdySixar0OdgnNyUhYoFTDRpUPfyGmyu0VkncKQQeGDrNi4OubPb3nQcmHLsK1FCVZ
         NR++idGedoqFtWe/30iQWEClIPEJ0QOEzWYZeU+uJSDu1qzHHNUck01VEKJYkvhExA0B
         DQICrE4/73FuO+BjjwRkptusbA4sAHO9HVepxb77W48r0YVfiF3186ProRDYrh2PPbe1
         3bxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6Z0+2Qvwtsc6bZPmM44bdJDU4V692OMaJL2cwJ3fWKM=;
        fh=oqcNsrOjg2Falsm7n4btTDNvbTTjDC/AO8LIhnXUqT0=;
        b=Hw92SvLbRo0oM9NWBjizdNFKPnKI6gYVdDZjPDp4TgaTEHrKjlou0BPNSrj4o9EGRx
         79e4BUDYBjwphyri1CwUg6Ma0HYh++PLsGEAW7DLkiWMTrNQsxDWTPgtnXhLuQ9noqbr
         0q9L4GC5H828L9fcbZgFN2hurIp02+Rlvr3a+iVDPkz4AEWwTmSvkgbDDhRWLdlqsfXz
         sTFglaj82B/HYNd0LIV45r3gxshqzhjlTfaQaBpmqQ0zuYB90zuB0d3R1YxaODpT7ydo
         tGIrgOd853dG40/FU2akVJl4VT94HKeSr0lKMI93CpaWW8Y4FfqSGOntoeCuds1qghN6
         2Rew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771962643; x=1772567443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z0+2Qvwtsc6bZPmM44bdJDU4V692OMaJL2cwJ3fWKM=;
        b=F1+iFGsUAYSKNfI/7HOCF+2/G/ky4KS1IkqdFihmJZ6XNi+Ub/zFhXdDNyk6Lan3he
         eLfe8zXAnvAMvhvfhdSBENH43Aqb2JsW+zlN7oUaBtjgOMkkD4C7QCve+wKak9oShv1E
         rPNCvaHxWsgrwMqdiq4XAX+sKwouXpny49wRU=
X-Forwarded-Encrypted: i=1; AJvYcCW3zAcMSGa4asRZIVgwLYe+8i+JDgLYadJl3EUxkoA9Ear4TYXngdl6Jb84ObS8QrtosHXyvxc=@vger.kernel.org
X-Received: by 2002:a05:7300:6417:b0:2ba:659f:2002 with SMTP id 5a478bee46e88-2bd7bb4c609mr5551248eec.15.1771962643225;
        Tue, 24 Feb 2026 11:50:43 -0800 (PST)
X-Received: by 2002:a05:7300:6417:b0:2ba:659f:2002 with SMTP id
 5a478bee46e88-2bd7bb4c609mr5551231eec.15.1771962642657; Tue, 24 Feb 2026
 11:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-6-bhargava.marreddy@broadcom.com> <14ac2695-7046-4d67-8b00-6deeb27da73f@lunn.ch>
In-Reply-To: <14ac2695-7046-4d67-8b00-6deeb27da73f@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 25 Feb 2026 01:20:28 +0530
X-Gm-Features: AaiRm53lOEu-FQOBZeeFB7AG_oD_nkK95jr3BBbofgPK_F3YCYxwR9AhPZ8UnJI
Message-ID: <CANXQDtYvHg2h-Qz1ErEARnq+1T5_S4KXdJpY9yfBm3ckiN1eUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] bng_en: add initial support for ethtool
 stats display
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rahul Gupta <rahul-rg.gupta@broadcom.com>, 
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f18fac064b9733b3"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260639-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: A5E7418C36E
X-Rspamd-Action: no action

--000000000000f18fac064b9733b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     BNGE_RX_STATS_ENTRY(rx_64b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_65b_127b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_128b_255b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_256b_511b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_512b_1023b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_1024b_1518b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_good_vlan_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_1519b_2047b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_2048b_4095b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_4096b_9216b_frames),
> > +     BNGE_RX_STATS_ENTRY(rx_9217b_16383b_frames),
>
> > +     BNGE_TX_STATS_ENTRY(tx_64b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_65b_127b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_128b_255b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_256b_511b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_512b_1023b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_1024b_1518b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_good_vlan_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_1519b_2047b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_2048b_4095b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_4096b_9216b_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_9217b_16383b_frames),
>
> These look like rmon stats, which should be returned by the ethtool
> .get_rmon_stats call. Please take a look at the documentation of
>
>  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
>  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
>  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
>
> and see if you should be using these as well.

 Hi Andrew,

Thanks for pointing this out. We'll review the stats and map them to
the appropriate structured callbacks (.get_rmon_stats, .get_eth_phy_stats,
.get_eth_mac_stats & .get_eth_ctrl_stats).
To make sure we get v2 right -- should these stats be moved entirely to
the structured callbacks, or should they remain in .get_ethtool_stats as we=
ll?

Thanks,
Bhargava Marreddy

>
>         Andrew

--000000000000f18fac064b9733b3
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDWxCuuY0+VGJ0AKCVtwuKxmIaWdNPmyGOqRskn9Wh75zAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjQxOTUwNDNaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMYrEy
NhbLdX/SKI69O1l/vhoUlUE+1HTVpjakXVJUZqPhnmjpy3cfKQfeP+qJXqwF6aObkwojyYuApDrr
/XgnTmLMmr9bjRgf+I6bHX/0TRpHNCKP9OYX2QxgHRcHbr0YYEI1QUPpvcX5doCQrfz1o2p4nRo4
l7NarduXlfVlML/WDGkgqt2HNY5DAc/WEE4DTv1YafzSKHqAwVPER9rM8pZkgj1u16Bc4ksFexAd
dDivG7Ek0EPH2roLxK2Vvf6BvfI23CivEr5RSdWH3Oba7c9D3q984WgrbRlUPdCXfIucxvKWbreH
HVM5vFpsToWzi8K2T2GeYulI3W6QEYBO
--000000000000f18fac064b9733b3--

