Return-Path: <netdev+bounces-264276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJgwNLVcqWkL6AAAu9opvQ
	(envelope-from <netdev+bounces-264276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:36:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB1D20FC5A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DB893062973
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A5037F8B6;
	Thu,  5 Mar 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UbOhpM1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259A379EEF
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706824; cv=pass; b=dsoeAU+6r+4CkJng7jKO6vPAN4au12rJtKm0qwJKY7bPw2QD+AAAxzUIkiP1mpx+s3HOAMV2ekmulGEHlCl/Y21//rxvYmu3o3Jpy+Tpw7etmMvBKQdM79d59Ycja8ZpHv71AWUjaNfb0bS5tK4apFJNLMsC0b9I4Txmn7HK/6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706824; c=relaxed/simple;
	bh=ky3Th/3j/4TqXAumAAWPOsHs2BoO1apUvKM3AKOraOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Obo6tPBBo0/CclKFCTkweziGa/LiuoYHlmQjbdCi4Gz8ao9qYXTZBN39PeYdUlAXv2FrEjOL5WG5TEEBMph1MytOy16CSO9CRiCWi7JzmtDROF1MmVcTpWoO8TZuHhwtutBhfbKApbTaBLzhN6TJFhi0jSwPB7sNDHqkz+ZVjjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UbOhpM1P; arc=pass smtp.client-ip=74.125.82.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9030855eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772706822; x=1773311622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUJyvegGKU5+7ZUk8ykGZrXYDZY7N1vMavvn+uFjnUs=;
        b=MiuKWXhB1q2P8RnR5P/aQoAdYFDtuN0fzQIAXC8QPt8s7U8HA7ImzGMdPZjpPbJ3mJ
         FY8W9HXPLCNzIUppotcuagaheVe5TDm2/jxfdLRpjmAKJ14vsbZwaLlp37YCI2yuTo9V
         DjLx8cGZDJcwU9BjY1MEuFqCPX6ZeNsY3O2eJTcRsNFqAUVFuAOcOQsms4L17F3Afvv0
         PyqKvsKbFIiDj6CWsXQ2zzt29n4X4f9zDkLrLhdOFrVZxi0qbN+LIoo8WQdxRsPu9xCM
         JGT3DS55S0k3iN1ZwO5tdSmCVnsSs4iMTUN76lM+VnKCEd3y8pMVfJpdVXnwF6A3mUfT
         4qEw==
X-Forwarded-Encrypted: i=2; AJvYcCVdlX0IipmFRvAiGnn8v06aPUl8oALX52RgYYOfhvwxCOUnxasF54OxO72z7DtRvRbTe7clHUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxBXaI3T3plX7F6a8mQPEAjpGAqN57QgvKANiWKEIO2vkjTts
	mGUV2oO7mLc+pPMWXZdDo5fQS33LE5KY56XclpLiMU/RMVbevgGWUmIVhxVRNhpLARqZJWAHCVK
	vWWWUjCU9SxTFUT1rdf7b8QZuE9OTcrGlPJk7ykXZLoW+3fOfx3DhD9PChDdL77OuaOJirqvxrI
	tXhytPQXH4oupCs8aSPWtU6I9fEr+Rb/oDfC2PBZhI5rykgcJVwjpfPaScRazknFMWewnJGR2xO
	KfkbRCO93xmuWI7oA==
X-Gm-Gg: ATEYQzxnvulrfT9Tvmn8e0bnNiwVsXudYb+flZemYex8bYApMiPniJYmx3BniCQwV0F
	AM1mXDKqUyTpQ/qaSvaw+TM2klva9cIZRbTIeaa7v1wqCxtiKIWMah+ljFyyjXEbRGT4MgSSeHj
	yjXqY6w0/SONu/H1JFcorqnR8+HkenVGMCydeofT1aERpF/CFq/GGe7cdhZpK6pk6w2TrL7kbzC
	exbC8+nu8u2hbhmf0vAx+mut6OMjD4Qii49eN0NQbApyMiD3BfgrIteWNqZ9m4T5iDypc+hThc1
	JtQO+uFn4IgLXwXWaCftcvrOmKB+v0iGyHmw79Wjdjuw3AdWjvo+zlkF+i9VP6lqrxGoeRry8KZ
	+1hN9c46iY+nLd43U62YeHlkQBru1FDQgXDblGCLzyPXBvHLfaFs2o8+kATWUtA/RDGZTqbAWvL
	EwKmPwZhNDzj5dlOxRsanqj/QR/QFHdMbSIktFN11H9YOPAUBy2Un6WBS1FV7jav2JRQ==
X-Received: by 2002:a05:7301:1e82:b0:2be:ca4:e13f with SMTP id 5a478bee46e88-2be310819d1mr2155641eec.23.1772706820839;
        Thu, 05 Mar 2026 02:33:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-127899d591csm3296991c88.1.2026.03.05.02.33.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:33:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5330985eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772706819; cv=none;
        d=google.com; s=arc-20240605;
        b=UPfdUDBs43RruqeTHrJoNFEp5A90irymejgfrmWazIdo66M6SK/2ZTChaAdl7+cQHY
         er9QXSX/h16894DFMege3PCuwVaNWbv5HxVPW0DSEsnllJmP33qUO+lNJ4ntIKri/mE2
         JXYeuKUDrO2oBBm96Uk9sA6WI1GZ8+FpvRBIVc8RQGALF5uuVpcjOBxddpT1ecuurL5P
         SINecOmOW2BLc/uNbbt5iHLyi0o8b1D+klvkFJZ2i0F/we+lI70/gEnMSWr259yi4yE4
         X2ySnLh/HKdw/QUWlOJBeNttia6kKhz1crB2FmcOd43tJlOzjnq78WE5CcXNvNPGh6WB
         pH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VUJyvegGKU5+7ZUk8ykGZrXYDZY7N1vMavvn+uFjnUs=;
        fh=7JHeFWiBE6brwEdkEr+bLuBsKJDRA5ykhh2343gL15A=;
        b=lLORIeYgD7sFE6q/U4t2/4FrrvnfXhK01WqJbRR2dF8qzr6l270/k7oOxfEN0hiGdE
         DTyYta0qw25qMB7WH8wXxekBI3AB90bb0+KoS5eY0W9bcuZP77Nah1hfvldne7v3gVkA
         SJASaTubWczE+kM3PEJ0VZeNWQEiaEkoZCLnChA3jSvZajo0EQmr+VUk2dhyAjnRzlB7
         PGh/P6iXEWK0U4G+Dyo5k+lyuvWSdWGSJGpY7IoNMU9pUZAX1iq5oAPGHoBGKhPjkak9
         kPa9z6tzb2QhVmvirWYZKLu0XP8dhzqHmS/9JIfxFbcIAtrpS8XkUXygjihjAo4+fVEA
         ghVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772706819; x=1773311619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VUJyvegGKU5+7ZUk8ykGZrXYDZY7N1vMavvn+uFjnUs=;
        b=UbOhpM1Pkg7Dtr0rpeTMckAMC8DBnS4UHCFaplO1UjYNMkg5C8kKcWPav7BEBws/5b
         YNHsJTL30VTmqN2Tz+vs6glSrFGkUTcSHGoBe/oBVLhKcQgjUAb3KrZJFbCDZe1IC4iD
         pjJ6JsJuFLvWfrPdOrE1s7C2uMRl5tchbL6fQ=
X-Forwarded-Encrypted: i=1; AJvYcCVzOL6kSeq/w1BEF8c+nQAH6NnZO8P34KUYrk1LWF1zD/pMQ1UwmA+Be1TTADs9f/MWX60E6Ek=@vger.kernel.org
X-Received: by 2002:a05:7301:1293:b0:2be:494:71ce with SMTP id 5a478bee46e88-2be3106fd82mr2019921eec.18.1772706818989;
        Thu, 05 Mar 2026 02:33:38 -0800 (PST)
X-Received: by 2002:a05:7301:1293:b0:2be:494:71ce with SMTP id
 5a478bee46e88-2be3106fd82mr2019912eec.18.1772706818421; Thu, 05 Mar 2026
 02:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228072715.1632280-7-bhargava.marreddy@broadcom.com>
 <20260303030036.1885679-1-kuba@kernel.org> <CANXQDtaMHmzU32jyyooXk7qdHPqroW9Y-Nni==qritBgegn2Dg@mail.gmail.com>
 <20260304102256.0771e576@kernel.org>
In-Reply-To: <20260304102256.0771e576@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Thu, 5 Mar 2026 16:03:22 +0530
X-Gm-Features: AaiRm53Mr9TE3tOxkuFi9bBG3rAA3KJFlFm8R0TQuaU9BeUfzuux0G1Q0GpzNvk
Message-ID: <CANXQDtbdh681aEX9DAgUKCi3OZ+AqhKi=rJqOaPtfM=rpjyvkg@mail.gmail.com>
Subject: Re: [net-next,v3,6/8] bng_en: add initial support for ethtool stats display
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com, 
	horms@kernel.org, pabeni@redhat.com, michael.chan@broadcom.com, 
	linux-kernel@vger.kernel.org, vsrama-krishna.nemani@broadcom.com, 
	davem@davemloft.net, netdev@vger.kernel.org, rajashekar.hudumula@broadcom.com, 
	vikas.gupta@broadcom.com, pavan.chebbi@broadcom.com, 
	rahul-rg.gupta@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000428a55064c4478f7"
X-Rspamd-Queue-Id: 5CB1D20FC5A
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
	TAGGED_FROM(0.00)[bounces-264276-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

--000000000000428a55064c4478f7
Content-Type: text/plain; charset="UTF-8"

> >         [n-1]: rxq_errors: 0
>
> Unrelated to the previous comment, but could you perhaps not use
> this `[id]: name: value` notation in bng_en? Having spaces in the name
> of the stats in bnxt breaks a bunch of scripts for me. rxq$id_$name is
> the notation majority of the drivers use.

Hi Jakub,

Understood, I'll update the stat names to rxq$id_$name.

> Standard stats does not mean just rtnl_stats. Please TAL at the per
> queue stats for instance. If you think some of the counters don't
> match you can keep them but please include in the commit msg the
> analysis of what counters you considered + what the HW counter is doing
> = why the two don't match.

Thanks for the detailed explanation.

I have reviewed the various kinds of stats and the duplications.
I will add support for the 'per-queue statistics' (netdev_stat_ops)
and remove the redundant counters from ethtool -S.

Thanks,
Bhargava Marreddy

--000000000000428a55064c4478f7
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCN7wnxp7P/nB38rc03LlLminzLJnaliAZvpbINd6f06TAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDUxMDMzMzlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBvwbwd
x02rIIH6I+ONNJ8Efy/fLgBlNZM+FJrtFzzTYkYoxK8FXubjViwfWX+61MGob+1WfleyVACMGMg/
9kB97UQbjsTdnbSwktKtyJOROFCR/YVwPbBua/+4Uy0JLUS6INMrhNqgxd5hl3nrPNsPtD7JNNpO
QYgnMAl1f9CMTfs5w6FDUtHn+Qu8ligzjmikTNdmcugDzywAZvKdMxc1zKQN6vuUA1HIcOdjjgyL
YSyPr7HlndGgeL/GChsh1SbDsIk47blt8uNvSo0ZBfN5CVSCx4WXBlE6JP0Ej8jGaFjRg2BNWLao
JLCImjCrg/NONpqYLTxfuYrNUXcCMBB1
--000000000000428a55064c4478f7--

