Return-Path: <netdev+bounces-260637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPEdI9L5nWnHSwQAu9opvQ
	(envelope-from <netdev+bounces-260637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:19:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B3818BE79
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 632F7302496D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A93ACA57;
	Tue, 24 Feb 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rz7S1A3N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2893AA1B6
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960771; cv=pass; b=k+/1+6l9OZ10HUl38F0bxf3znxHt8/wrTh6YLRbYPL9JZHxmHIK7ot0nhHmAJqq/K6YBIVQ3uygn4L1V0dkXNoefkIiNF5e0HcAlGgXFoIGpAXQNNm9b7u9HhRvBOO44K94dEfTAtMWzSZPt7W7B1aW0mcfh98pWK9Pmz5+AliU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960771; c=relaxed/simple;
	bh=mTtJbxwzhP4dzFuymNYdv3K8wYnzF16VwJe8ITyfZuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z32hBx5fz92/Z8lugcaLtZT4BlLo7J7oSlscWHD36WMJEUozQK0BFLl0KL9baw8yKys/IZr9299zmHp02w6jS0cboIPF12N3FsH9+1UEWCQ/yRcpBK55sCrkUXRdbvShySWGzCxSab9qxJmo11lxxPfj2TeUaaob3ySP7+SzI0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rz7S1A3N; arc=pass smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8954c9daaeaso74177986d6.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960769; x=1772565569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kESN94DhqodSyBX5yLrmDB25WDRhNiQNYwgSSS/roSQ=;
        b=KhxFh3WVbBLhPDLpq0DaNclKfhqJddQ+V4zJLyVEAAtHUOjgEiGtNPXDEu1JHM/gy6
         9HNhlV2E8tdkBbKDWX+KVwAYNRjKSFW47ZOt1dsh+lNNe5YTXbPf+gK3u+gVO5ra7q1j
         kOWY3lTw3bw990Oj0VbBCJ/Nvwmvbpg4INnco6jCb3Vx5T512h1ytZJmEGJsNU3Y1KHr
         HAPs+2TpRMpqQvAoZYQqKFG/B9xvPqGSak8vklRih3/pxDW1eKTKo+YIC9g8vCycHh9f
         +tUtV0w47rDYQ4pbmJ9HoFTDHtOdQHDpPyUyN7fGy5P9HCdMhNJ/KAhjiNx5iCrmRX8+
         6bHw==
X-Forwarded-Encrypted: i=2; AJvYcCUbODN1iM1dQBT+jGPO8An4GT/2+Av+rInIHQBVwPI+YvoBt8yuv04TWzCY6rGUeeiW8sDk9Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVD86ylgW+bRiwZatbq7Lgh/7t9pT97MxZJ/Vcj9ea2/1EAHn
	P1uD9oFhLVlmcJdbOW21KKD5pD7CAVyDfAm/7PJGZXIhZDejteOa2HD6XI84Wa8vZMxnepPNkTS
	YoH+U7fVGeU7QdksBnygTyXSxAEN4DSjuylzdv24aXBBLCKO/0W8Cp1IVJMEJ31Tssa21NSCJV+
	NJk0mdBQWKxa5mtM9K4y9dzcK3HyaPle2UoXnCK/UUNqK7ZZdx4KO/ZOoOb6KoTaq0H2ELG2txe
	Qw24foyQXRb4OIgbA==
X-Gm-Gg: ATEYQzxNURmu99sS7S16V6nDSJ9NAgfdpyrkXBvI1O5qP0aERCO2QyHxmTCc63JiBAh
	PA3t+kdElmdxHUf7UiTPljmFbmwAXVaVZsuFZT6e259jwKrW0T3Nnsr7tathHtMAIJ5v0xpc9X/
	KCVfguuuRN2oTct1U04C8Wd1c8lwnovY7819U0MEr9f6w6CV9c5ZUVTa5N3K8OCST+XUXD6d/UN
	q8mYEZye9oVBlMV+99GOzp7dAdMeTAq/AbrWkzE+Hi34MNWtU4c+vLwfr1P6OH/2lMV2N4BwBQj
	2OnRYDFMuTic25qSrtyv/RQA1jgaaSrxDYPsxblGT7aPqBuNybJkFlJCbmSqf66ePvmQPKe59Q8
	k7gdc0cAuvAOfNavfQEkyLjmC/d51IDcMe6PLr03OyyHpG92MYsovzbBTVA+l3vk/lZGcL5Ec3P
	vFug8c+16rzvH1Hrl3a5t/3AG173vzVQIDsoXlH6RMi6CUJZ4aCtFkp355UtNrYIY=
X-Received: by 2002:a05:6214:2aaf:b0:894:85ee:63c7 with SMTP id 6a1803df08f44-89979ee8592mr191730106d6.43.1771960768696;
        Tue, 24 Feb 2026 11:19:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-95.dlp.protect.broadcom.com. [144.49.247.95])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8cb8d0c103csm147628385a.3.2026.02.24.11.19.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 11:19:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7229456eec.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960767; cv=none;
        d=google.com; s=arc-20240605;
        b=TCQyPeDa+q27O4sNWHibn07VcVrz22g+7RTF+PO/VbAhBbVjdyadxaZqAT2Nh97JYa
         KWoCaHM7VM0v1+ZsfyzmFsinM5qx6nuVYRwGOwUG1NcehMSpuB9YrOPmkubSK17X2ybW
         VWDVHllhmzH7Nfi1PeIGLJK+DaXXe7oZra1dnx14+EVnAQ86yztwU9/+i6fxX+G/clsW
         9zJbZqhL3YjQ27fyrRBrTQSeqcjjERbA7tW6nKau7DH/asLYtMmqUjvxvXiAyQiC/LZw
         SDKdUGDJ1B2XsBbtDjQr/DxLbdxbIB/pWaUa78b4Lp/OGPqi/wQY2ezeuKVgsJ4azeqG
         qcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kESN94DhqodSyBX5yLrmDB25WDRhNiQNYwgSSS/roSQ=;
        fh=3L4Ax03Gc9bzSmMX1sp/78bQj9FophPJHH35yFYUBrw=;
        b=afh0L0I4ps2ebCojGIyxzQ+pVQbIIwV/7TXBcz+pUweCwDLR+V0m03iFkAKs4V6MzZ
         bBGLM6wIeZHsjC6d8XOAs0k/zB/kLem8O77H16FOQbZCh3BTOUr9JrKTbMiiOVOyRJ4x
         7f/EnV69WKda5f6UziOfo0RBgt4Ls3NPK7WFFvEaAqvrKQK8FU3qirmdGLee0gHAIGDT
         q3MIlzDAeVm+ilCR6A0Zrs6rXpDHCiA9GtXdq3yp8lfCYM+P7fVyapvBs8L3s9ndlFx4
         waHmzHSX+dQTp/khmiRgR7DkkNX1NGbv6WU4IlcRu0DQGPKQVT7fQKe7GH3iYuDhDY2d
         58/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771960767; x=1772565567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kESN94DhqodSyBX5yLrmDB25WDRhNiQNYwgSSS/roSQ=;
        b=Rz7S1A3N3Luhg1x1Mi6Qec5zhPmgpGtT7NvB4QP6ZM0vFq3Gj4qZ0tXyZJlzygjF2L
         Ac9OmQ19F8S4DYjjhRCOW1TibnTiO5ZkU1HLCcNNY2nKi7P2XvQKhe7Y32HRDTbn8pKc
         0jv460Nnzw0oQYLNp+3NUPcGsSqQR0vFm433E=
X-Forwarded-Encrypted: i=1; AJvYcCWFVlqO5pQfNiHovD6gDyqUTuMEFbW5kplVABg66DiVBZlt39KklqEzNR6ngAw3jVt1q9HSg9E=@vger.kernel.org
X-Received: by 2002:a05:7300:691f:b0:2b7:4157:9afc with SMTP id 5a478bee46e88-2bd7bd23dfdmr5215858eec.19.1771960767133;
        Tue, 24 Feb 2026 11:19:27 -0800 (PST)
X-Received: by 2002:a05:7300:691f:b0:2b7:4157:9afc with SMTP id
 5a478bee46e88-2bd7bd23dfdmr5215840eec.19.1771960766563; Tue, 24 Feb 2026
 11:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-4-bhargava.marreddy@broadcom.com> <f2bbeb1f-962d-4e7e-9b0b-5d4a4ef762d4@lunn.ch>
In-Reply-To: <f2bbeb1f-962d-4e7e-9b0b-5d4a4ef762d4@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 25 Feb 2026 00:49:12 +0530
X-Gm-Features: AaiRm530h2blyCgP1m8_1kPHC2ahpxyVffO8NqNH89jBErOm95kLrSpxoIvif3c
Message-ID: <CANXQDta-k=QS6UV6_-AOoYG5yK8GOnLXYxb2pLyKWddun26wFw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] bng_en: add ethtool link settings, get_link,
 and nway_reset
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001ee4b3064b96c4cc"
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
	TAGGED_FROM(0.00)[bounces-260637-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83B3818BE79
X-Rspamd-Action: no action

--0000000000001ee4b3064b96c4cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     if (link_info->auto_pause_setting & BNGE_LINK_PAUSE_RX)
> > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > +                              lk_ksettings->link_modes.advertising);
> > +     if (hweight8(link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH=
) =3D=3D 1)
> > +             linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > +                              lk_ksettings->link_modes.advertising);
>
> It is not clear to me how you are configuring pause, and in particular
> if pause it being autoneg or forced.
>
> Ethtool has:
>
>        ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off=
]
>
> The autoneg here is separate to global autoneg. You can have global
> autoneg on, but pause autoneg off, meaning the pause configuration is
> forced.
>
> The PHY should only be advertising pause if pause autoneg is on.
>
>     Andrew

Thanks, Andrew.

You are correct. Since we haven't yet implemented .get_pauseparam and
.set_pauseparam ethtool ops, there's currently no user-facing way to
independently
control pause autoneg vs. forced pause.

Internally, the driver is designed to handle these independently using
the following flags:

#define BNGE_AUTONEG_SPEED           1   (BIT 0 of elink_info->autoneg)
#define BNGE_AUTONEG_FLOW_CTRL  2   (BIT 1 of elink_info->autoneg)

During initialization, bnge_init_ethtool_link_settings() populates
these bits in elink_info->autoneg
based on the hardware's current state. However, the logic to toggle
them via ethtool is not yet exposed.

We intentionally kept this series focused on the base link bring-up to
keep the patch size manageable.
Would you prefer that we include the .get_pauseparam and
.set_pauseparam support in this series,
or is it okay to address the independent control in a follow-up patch?

Thanks,
Bhargava Marreddy

--0000000000001ee4b3064b96c4cc
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD7LdE8qyCc007/lrXXuKl2tFptpIEXt7tGahlCU2MswDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjQxOTE5MjdaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1mGQQ
nHlI90lizbL1/Q84vCjZlsRobOnD27zbk0CmxOji3fjnbeUiq8TiGq1WRqiFlTQuWwXo3gKBGa0v
oLrAALCTThFGVIgFHwTn/5DgC4E9QBCVyp9zTPQobMGLNpETAEkUsMiK6hwJql4dv1BQ7EHUNy43
4RchhvoeuGPfi64GIjjx1gVuYEvmz8D8mtH9m6wbhv4IAhTeBs6mbuwszkKK5dLG/fECr/5hnR2A
IcA/8aF0XNNyPmfw7KK4wkBGP6ngytspU2iwv2EtlFJWV2T2l5aFnwtfKBDil9/C4/yVohIgYb+O
SnzmfloyZI4uIR3lF6oalabMt3gBiujn
--0000000000001ee4b3064b96c4cc--

