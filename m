Return-Path: <netdev+bounces-255140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBK4AwmtfGkaOQIAu9opvQ
	(envelope-from <netdev+bounces-255140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:07:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73536BADF4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D46300DA44
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE63271457;
	Fri, 30 Jan 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dnKEAE0b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873792D97BA
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778436; cv=pass; b=RQhtJdfNO6s8exNO94lZc2bsbFAwHlb7f0mBUP6yLDxSzrKP68GCVq9ubh31NM4ATQeWgbQ1daa23/9xhI5DBPOqvo0uoQlHE3sJpEZrOwbyyWDSFkRU6hBxB+Rg9U8LOncJW7xYFWYOxwznsepqdypXCOtbdo7KIOHeyXryqQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778436; c=relaxed/simple;
	bh=ZRNo2bQIq+9lovRYNtT02qK6Vnx2cOCDesMeZpMmtCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxO+LvSmKYpijKgl6n6elAuScDZer//4ouBFLJ4pGQ5M66xGZ2BfX7EEZSvD5R9XSJDgOuRPQCuiry4Hmj9UrMJ1MqZIlSnUTqBbR6RgdB2INmIYKf8YmcXCVjkuwIKrXhRAVq/fv++xAMQEvt2N0+nPzdX6HOKlDlacLXs9rdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dnKEAE0b; arc=pass smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8c5265d06c3so315834685a.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769778432; x=1770383232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX7SuiXHHsBCDKmCnpGLbRdTN6t3VzABaR5EVG3Vgmk=;
        b=Z/wxnSP8kpPpfR4UDDJSQG73cZnEtnsDmLVvFr4HsRpC1HorvK3xjUzq/KbPN+1mfG
         NU4sHu3832R6lctDnf5zYBKmlcAfFkBIN7RF66oMUHPiPQArtqyjkQqj+tTLKLMs7RM2
         NmS3yva0541NYuiwNDveqDh6ZcXoueZqQMUZTgBxrQP76WCViQbN7PEfNbEI4wsdzyil
         qdBHamAcmHNHitXrZkAimfwqO1x96s4piAjmi5UIW+y+LlaPIUowHNcXlbPeHso6ZCIY
         9D/wyyPsgka2CiSOyFoebVEkIvf5Cr+InT4f7hAiQ3EIf5uCW8du9YZExQ57b5wWUGvp
         Dkcg==
X-Forwarded-Encrypted: i=2; AJvYcCVlTjCQ2S43h0Stf5KHHcsVormfGFimqg+N2dXD1itaKChKXgHLXWXCoz+o6EK7QFT+MyVgEHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTi61F1AWRAtHkHZvXMkLbwgP6v2uXGl7m91cSIpsrVWbcWpzv
	VRlJqvCDpilSqeimW/HYIxJXYlnd/QJsH1lA2sVU47ui/EboyCpFVHwQTlE0yEHPt51NUA3tbdE
	RjRLN3x9WpQvEXe5dcB/b2s9F3+VNIXmrWl+Tt42uybi6JPejUCW0wH97Qzey0zHVxzckbgPBlQ
	aqV+CmaGWkwYhLiITIWBbNywyQZyTFd+uXOqwGxbcM8EArQQB9KdUfgK5hkEALMLaVOnyybrZTu
	wIuK1sfr/zLXcIXlQ==
X-Gm-Gg: AZuq6aLf0ytkGm0vbrKNYaf7ZuiA2199549BtVnLbB6gyDksyaZHvcIcfCZBUbeSKgD
	6u8N/PjCHUz74PCm0Wy3Kb72EtJnBA+CGIIvPGK7YGlSBdKiEiSJtn8VvqhiEgPJwd9BjffSObr
	LA2P4GK5Em9iV3vzB6YGv6V7gz6YCGgSgQWqtsQHbjtfa6Uo1z+zrCrZtUWPzhwxoI/WQe4LqXj
	QbpVX4adPLYxo0skRDUxvntEvH06V/nS8OqR4X33M4TjPzvp8W9LZSHsbxLZC3Wn4BgG76SxtyG
	w6kdJFoyynfqZDVQ6sgVmJ4hrZsuWVaz2Hw7z9sRo2f11YVyKzHUT68znsNutlXQd7iWrgwUBz+
	4jgXQMS3fwX/i4YZGNTzZwJAFn3qzq+oUsi91TcYz7mEbT5O2ZgpX3T/G65jxPFe9ITMFaY9XcU
	Ri04HYHE4vA7U75TkJKltO7An49fuUzCrtpzB4GIuawVDM3+E2
X-Received: by 2002:a05:620a:408a:b0:8ac:70cd:8727 with SMTP id af79cd13be357-8c728abf1edmr776497685a.11.1769778431998;
        Fri, 30 Jan 2026 05:07:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c711bef2b1sm61592185a.3.2026.01.30.05.07.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:07:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b71bdcd037so1304566eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 05:07:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769778430; cv=none;
        d=google.com; s=arc-20240605;
        b=CVCFYxlxlalA6LkRiUivmmsnrsErlRxsw0aPIu2OALnOAEMi33f9bOwsr52ReU8sav
         /2mBkfanU1BPvOH4ToRoZZruLl4ymm10cKXM76xNNmCH73zLa5Op+FbeX3QInno+e1xp
         Nu2AUv1ZZ0ZcNrGQ99xD3dPc3umZgpq2SwzyW3tECAVe+2TUj11HEVjBnh2vV3CjT9t7
         czkVg1/U+4kDkendlJM3A4ca2vwMA59KrrB0vFasjDfAts6AhcsyGdyFpswjwnDfQM6u
         z/1IPHf+v0pQGNSmwG+rKGKVOI18dEN04If5H8mNLuiPiUL+mlBImFgHZL1W3CzLLBgJ
         dmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SX7SuiXHHsBCDKmCnpGLbRdTN6t3VzABaR5EVG3Vgmk=;
        fh=edPRSTJ2kXtIt8OOmYlAF6C7lnO9yiXgCbfHanSdJg0=;
        b=b6K5U3BxgD6LL93WPJxGZngMGY+JhOKUgBgcJh5cojYLDxeND0Beg2Cq5X8yFg+1ma
         sjcHYbv9QRdw1xs+xyoqCjAkPoEh+dj5etSUaV9Lut00aqzqubDrNYXeXupc/4PRExgJ
         ld5uvCO1F52nPTkYHPMfIobFUUDXGV8ltRwfyPnvsjCxruBPlIX9doOga2ZnPO3Ckl3E
         VU2cwapfKrIbW3o/2LrIxe490aWO1bId03BWY7Jl0GSJ5f6VsE+y0UerkFGtz57+rY25
         89sEMDUr8x5yinjT/DzqvjvA9BBrFX7NYmVyAQuUR3FsY05pXm+usB+vQykNKXpmqrZC
         H55w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769778430; x=1770383230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SX7SuiXHHsBCDKmCnpGLbRdTN6t3VzABaR5EVG3Vgmk=;
        b=dnKEAE0blyfeg1TTNMHq9vLmICgFJVkzXYxsgAw+sYiTivGA41Kn/hTnhSVvzNNUvx
         YFtDV+5hQBI4J3qqd3VorSkokMO1PAQpzXbbWXSdivHHtEcSeRmOb8KPPHcwsjBxcj5m
         cQ8znLPW/JdY/7dA+mpBG/+OphmsUR3Fd3NB0=
X-Forwarded-Encrypted: i=1; AJvYcCXZwtwyf0eh8VCPXp6agb540YCLmyPsubYg5kKM68DNV1SlRN/d0EP7wX3bh7j4dGdIEcuPQEQ=@vger.kernel.org
X-Received: by 2002:a05:7301:1288:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2b7c941886dmr1245843eec.14.1769778430530;
        Fri, 30 Jan 2026 05:07:10 -0800 (PST)
X-Received: by 2002:a05:7301:1288:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2b7c941886dmr1245796eec.14.1769778429205; Fri, 30 Jan 2026
 05:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
 <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com> <c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
In-Reply-To: <c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 30 Jan 2026 18:36:56 +0530
X-Gm-Features: AZwV_QjvE2a74A9qYfiCXueYJKOTt3GzWJRICCOBKcx2qNYabymyjiDAE0UWrlE
Message-ID: <CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for generic
 firmware version
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Vikas Gupta <vikas.gupta@broadcom.com>, rajashekar.hudumula@broadcom.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b4858c06499aa644"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255140-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 73536BADF4
X-Rspamd-Action: no action

--000000000000b4858c06499aa644
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 2:11=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 1/30/2026 2:05 PM, Vikas Gupta wrote:
> >>   drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/drive=
rs/net/ethernet/broadcom/bnge/bnge_devlink.c
> >> index a987afebd64d..57db3caabcfb 100644
> >> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> >> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> >> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink *d=
evlink,
> >>                                DEVLINK_INFO_VERSION_GENERIC_FW, buf);
> >>          if (rc) {
> >>                  NL_SET_ERR_MSG_MOD(extack,
> >> -                                  "Failed to set roce firmware versio=
n");
> >> +                                  "Failed to set generic firmware ver=
sion");
> > Thanks for fixing. I believe instead of generic, "Failed to set
> > firmware version"  is enough.
>
> ACK. will send v2.

Should this be a candidate for net with a Fixes tag?

Thanks,
Bhargava Marreddy

>
> >
> >>                  return rc;
> >>          }
> >>
> >> --
>
> Thanks,
> Alok

--000000000000b4858c06499aa644
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBxVso4lD/fXeCyKfVkQemctrAENgEVgOfKUrwxXFX51zAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMzAxMzA3MTBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJ+xey
K223muq8XVTIo3qS4u0u1af/QBb7c55onAM4yXDKm8oF7Ep8O8JGIh5Mv8w5fdXQrtoAhDkBSf9C
TXaluRMe1qoV/8m4bGfWcQ99xv0OGa5q6G/O2FJ53DpEatpH1PlEXIUMxXRRfeE17KEPt3Yum7MI
TvnG78nzQsIddjmgn+VNm7Vct2kQXToRLZzcWJ8P3mIsp41wcnWNYLmh4kGq134UMPuG2ekmUJvq
e4sfHs0k4lRGBGoBGclETNxTOyrsh05MjdLfdky5szX4CESMGYpORiNlT2NyRZIyTI7MAmWfS3V6
/t7B4kh8Qcx6dYmbYv0HW7HiicfpO8d6
--000000000000b4858c06499aa644--

