Return-Path: <netdev+bounces-261482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WETQM5OGoGknkgQAu9opvQ
	(envelope-from <netdev+bounces-261482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:44:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1C1ACBF0
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5554A305B8DB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC6A4657CB;
	Thu, 26 Feb 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gvVrpU9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDA426EC7
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123331; cv=pass; b=a43GkfIym2PYVFAuilzXi6RZVsH4uuBfymu1IRe5fJ1lxWLwXzBi8MKKYGfF/6gLz7puRxcTLQcYzP38SofIcKFZNNAD+IeGndPhlw7hcMtbA8c9Q47SBXCwDUZgSgeYy6SYr8NTYe1hqn4g3nxXeS/4M6Rx/CeM5lj0yEKDJPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123331; c=relaxed/simple;
	bh=UGW9NtO9yI9az6AmiubD17p7VcvaE4Ab0XVdP2bFf0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxc8R+arSU+cEuZMzGb5/N8B0avQFBHpIMSpX5dpUd7FN4ONrkhpeBiYi+lTR/c/+Vo+RhAdPesEG05hS1p+ijP7H1u0MInCwdaLYkNfznCRg8Ei2Acn95aH9eBqFmvNSzU8mcU+b/TWbT62ob4xWHEi4BMZO62erQO6tEYMs3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gvVrpU9+; arc=pass smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79860421382so9217867b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123329; x=1772728129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKSUtSXfovCo0CjwvHZWORxCyVQa3/UVVrlcMiGigCk=;
        b=IUY10S/iF6r/VZOpLQBc4ehnUGdTXkF4JtUsKbavCpuETPfeabaw7KGqIw2PbSeT1j
         WoJ7WJ/pdvOh6t5K0dJ84dY6c0lKASE0DqR0ZHquJeiN5fKZuw+CRRZKVGcP3UfB5RxI
         QA1hEmJsFsm15pMqVLHiupwnvlyl9eVo1G5QnASJVf9xOhC2cjCCoslvaoM4FqvnJ9eY
         Xv17rE+CfkusTNnrSOWw9SaqjNzJIt4P0vx54dnxrGO0dlChA7Fal5wGhdTM/BNciUiZ
         WSQTRDY+S/XNqRfc68vCKDX4/IKRnrAtGCcXH1ZBPQLTnw7ny9udYWYc9R1jEgnhC9M4
         pxCQ==
X-Forwarded-Encrypted: i=2; AJvYcCUIkpnDPmrK7ENQyuxheVtMYcxfdvvdCPWrtVn2Pa1P4CYKrnUHN0xMCpLLZwOUQmjA+5YveZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yDFd7WZQhDaSOnab2Pe4u6T5UD16JHSbuY3Kl19oVeK5I2aQ
	Ka4o6iWYWAHkVRuCkUcDwCuzrYzsjJvwFdeY0xSIO4DW+rTTK/jVpfWKassz/U+8OY06YFbZJvC
	eaoPXkem17VO8tApp18Ildj318kM8rk5jDc+/PmaDKZ5KWGZm5aEEP4zWpkLDzA36e0NY6KuwN3
	R1w8JA0ZE0N6/QHWvxVIJtIh4+5p3gRtkfi51f6j9wHvHwyoXgJirfCqi55nu1ce3Ip1UJ9iwwx
	fwTtBLNWjmTT+i/Qw==
X-Gm-Gg: ATEYQzyUO0VBbzLjoZo8D/NgbDJrHCCzxdhFWU1xTpn9rMwvWkwdJcmrJjI4+MtyvSY
	7nLHAaYpd5+FmfDysItcjrj9KuBZBN3f7nRoidnR3gzZZaXMDfoB6r0TZ9kUuuHVLKigC8pPtWW
	YFhQKV91uC4dPgOTh1Mq43nZQrLzu5oaxCkAZ4J8DZN5qetn6cXO1UnlnH7ZjV7S7Z0g0Xs2vaz
	G0ycq/C2H6BY05auoRCiR7r94jIPB3VMjxk0WTVrSsQ7IXTi23iHqaaWg709JJE01PwBD2IvQ5S
	3E9WEGWDx3KSWt934+0akQrkaApGPhxjmh7KMWF5hTv5ujVsl0RdPOQnFBtqIAWoGeTqi6VWk4S
	BdOv5GdHFPbyWkxxu5lAmxra/sFcj1RE/NNSlYtgZt/E3Ls6+yiR80SaPik4oIarpPAxqTddKFo
	MzFx8dqEefyiUINtYWglf5MngPf6cTTgTUUCAoI0lFk7oe1fB72BapjaMXYV767UOlmg==
X-Received: by 2002:a05:690c:368d:b0:796:3f2f:a326 with SMTP id 00721157ae682-79828f56586mr170465987b3.28.1772123329190;
        Thu, 26 Feb 2026 08:28:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876bf333esm2792767b3.16.2026.02.26.08.28.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:28:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1135549eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123328; cv=none;
        d=google.com; s=arc-20240605;
        b=etgJuuoUNIAM/odGR+2nUP4BJp9KbAxryF5sLTkTUC+4KxUVIUrZjoisxgnjQvDCN+
         IRGkvdYoDTmo5mJDiwIKdHGAMPCdlLnoY6GHYdqzGKUMQMK8WVZd9O9UXujCkcDgtZXS
         EeDQq4hl5lztWWG08qeWSF+qDKi+w5GuKRkk5KZZvkN4u7ORj5bGXRpVeN/g0W3knlZe
         FdJ3EUVAJo5gglx45m9UQSxPgAJH80UQVtXmDY7z9IyajC9bUOAi9BbXLmvhnnlh6LnH
         7mQV0QjqcNmAmjRrWM9xEexsH4Eivih530Yido4WuSscbUhchDYB8TD6BfZp4qER7Si2
         njfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nKSUtSXfovCo0CjwvHZWORxCyVQa3/UVVrlcMiGigCk=;
        fh=LkAcS/CAdl8Voeo+AhTCiuL/cv87ZkLOMalDBJiyHHM=;
        b=aduLQVtJKWhcPuqb2A96zsLyZ+YN7Row5TFJvaprETH2H05L9rvlJE7U7pewDoQf86
         NPEARNKp8JmjQbAVcdfgQWIA1HS1jXFKYfaMCBuPdY0ds3ppEBJjEnf+fBIYCoOQ7e6C
         atEtpy/6Q9fkXKqX/X8uQuDARnHzYDcnacFFOqInB6tNpWCxdRvfxvDcCbGjCDINxX1j
         jL796OvuxlDmUEmkYwBS9k6Te+b6xJ73OZEePxus2Qouwc/UwvW+LYwFW5vpZuXertEc
         /ckvcojMtHmWZN5j50ZQ4gjPVLglbktaawn9ZW1WSC8LGqVofDo9EJFP2MtUCpwIW2Te
         4lbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772123328; x=1772728128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nKSUtSXfovCo0CjwvHZWORxCyVQa3/UVVrlcMiGigCk=;
        b=gvVrpU9+ho+fDlQD3BKE6vZMD958lagj4w3zv7ACNIqLh74HLgsIN7XNF2US6h2O+7
         Tkr/5yeBruudGde21hnUgx3neINBxXwGwyxi2EZ91vsT3BBBYWjSqxWPsEnbLdxpgXrh
         USsfM49dnWZT3JEij5dhnh61qToKtPJ38QW4c=
X-Forwarded-Encrypted: i=1; AJvYcCUoN5RmNKZ31qSzZ6WxEZHwS2PXppy3CiHJOT5LUgh1Tvp7o7kLDuuobsOAHur5zqQmpTQ52wE=@vger.kernel.org
X-Received: by 2002:a05:7300:2213:b0:2bd:d430:738a with SMTP id 5a478bee46e88-2bdd43077a4mr910696eec.8.1772123327444;
        Thu, 26 Feb 2026 08:28:47 -0800 (PST)
X-Received: by 2002:a05:7300:2213:b0:2bd:d430:738a with SMTP id
 5a478bee46e88-2bdd43077a4mr910678eec.8.1772123326844; Thu, 26 Feb 2026
 08:28:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
 <20260223163641.755200-6-bhargava.marreddy@broadcom.com> <14ac2695-7046-4d67-8b00-6deeb27da73f@lunn.ch>
 <CANXQDtYvHg2h-Qz1ErEARnq+1T5_S4KXdJpY9yfBm3ckiN1eUQ@mail.gmail.com> <9fe6bbb8-874f-4aac-9051-a5683ea80c46@lunn.ch>
In-Reply-To: <9fe6bbb8-874f-4aac-9051-a5683ea80c46@lunn.ch>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 26 Feb 2026 21:58:32 +0530
X-Gm-Features: AaiRm50Q0vuAuoOoWjd4pxj0mnc9tzTO1v7lCftf9YbkI3gZGmTLHDSzxxK0Tgk
Message-ID: <CANXQDtY3NByJ3GfsF8mze_M53oQiCvDJ+Vp8yhobYqgxPeH14Q@mail.gmail.com>
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
	boundary="0000000000007c1265064bbc9da2"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261482-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 13C1C1ACBF0
X-Rspamd-Action: no action

--0000000000007c1265064bbc9da2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 2:43=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Thanks for pointing this out. We'll review the stats and map them to
> > the appropriate structured callbacks (.get_rmon_stats, .get_eth_phy_sta=
ts,
> > .get_eth_mac_stats & .get_eth_ctrl_stats).
> > To make sure we get v2 right -- should these stats be moved entirely to
> > the structured callbacks, or should they remain in .get_ethtool_stats a=
s well?
>
> .get_ethtool_stats should only be used for anything which does not fit
> any other calls.
>
>     Andrew

Hi Andrew, thanks for the clarification; I will address this in the next sp=
in.

Thanks,
Bhargava Marreddy

--0000000000007c1265064bbc9da2
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCRysK3eKWBeP1vlkmQdF0Dd/qH9qrhOeJNk4NDyDj5zzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMjYxNjI4NDhaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA59B9m
FkzjEdue+280oWdr08mX5tCZJ2VKVm+B4S9iTuVEdNyMn8lcf7KIaQxtHdXyKk2gOHWYqYfgLiEs
2gJgUx/SenVKTuAlQ8cwLgl5pdSp5R/s7aAKn5d56CS9Z3kMeD5yVZEurM4waQguLP0DxCOzHcZP
YKZdnlz+DBLuprfNILBSmqUvEWs9rvSmQWKK3TsG2BHTzVlF0rPXVTKieBQ0LhlHJGaXmleA5lbZ
Df8aQlHlBaYN0upNHOzwEYX2wn966IvtS1nIpH81k23xHL3NXIzj4IaV5HkVWXClZfn4TORfO2hX
nG1Jfo/FEEAM3l0lWj9mv/l9rd8I1x9h
--0000000000007c1265064bbc9da2--

