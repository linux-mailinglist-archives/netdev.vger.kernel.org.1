Return-Path: <netdev+bounces-270054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBN3CvGmvWkAAAMAu9opvQ
	(envelope-from <netdev+bounces-270054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:58:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D62E0A17
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 532EC30A9A8F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144F3033E8;
	Fri, 20 Mar 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KU8ZMc33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC2352C4F
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036324; cv=pass; b=lc3iERyFJLz+ZQRug4DuQupfJDllg2OUgiLmc487w2G56XEZVXsoPyexlwkAHzKs4x4NjrbLVSCKguYrxmGp5cFrgd+62p61ZcL/uX5c7sIg5szkM3NFSejNGRrvEb6WO7Uo0z+8fEB3bqJGov3YuTB/jVs5Ph19+dKD2/D2pVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036324; c=relaxed/simple;
	bh=Q09mVP+Pugt/NdJ3L17gVf5+DR/j5XO594emMzIue6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTRRtlCsTSnFlK+WwyqchEDUEdWAbixwSeO2O0ro3zIeePZ6J/0R/TOMy6kjXS01L4JgtSwnPUfcZfz4xxWHkby29L6do5mHlQU+/bByh6/H99JrjWNJ1xPfciWD1L3e+e0De4xRbW1djVbvbytirKhwa+ro4XYfaeBwoL4Zmb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KU8ZMc33; arc=pass smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-128e4d0cc48so1139889c88.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774036321; x=1774641121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLRDWiwXqI6ozMy4XA4NZe/ZrS7qKLv6kb2LUJ6RNXU=;
        b=qQ1aiktL8vRHrs2NnKo83t0Nn6TAba1DPLZ4TqdAchlFrRwnSN5mMS+fL3Sef1PiAL
         s0PePftyAZ07ToRDb5AIlucoJsYxa/9Zh+hfwmA1AkNXyjXlQJG9Sg2vE4ER/5mL/sY1
         /tCvZBoZqwdHeXr040zoPQNiuWjg++70RZQOy9tUcUlz/SXc0xtjJyO6qQnIBdBzXQ49
         hOixbeHKgbbzzfV/45ESwrZzg/KUlt0Xf7iYxtMvy7IgKr0HT2Y9V/ED4KAmw6ngJ24I
         /GszzHRUU1My4kHU/v4yWjCWIvpdVKhe0Qo/gBImsbRCr3lPCoIa0PoHyuUQ0y5AXVKc
         GXMg==
X-Forwarded-Encrypted: i=2; AJvYcCV5Gf7R6PeNfuvZcdNyWRVfMSZyR6GJQ/f1W74GC16Tf1J1bi5X7qCGg1XxrhtWjbiAL6Gn4MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B/OS03QU0BDshoTgVAch6kcz3aQsa1cYpyovBl/gjq2crgyY
	d3yo/9cjX12aU6q+9oEHxhjxEGLV0/txNFLYzeL5KXuUHsATmyizf1d5EeXT3+QwlLSscru0mZB
	rmc1gIUKLnVL0NJ0N0XajPiEZAG9K7EXXKRV5JxWpDG/dMdSMEuYNPWiyr/9VLlH1GY9gd5d9Qj
	F7S3gp1nz/J34s5p22pjS8BIbIKtxSXFwz7svzJWLrcDfDd9MYFzRhOQ7pX8tWd35rsq9Eexhvz
	VPnBOm7IaexYN2pmQ==
X-Gm-Gg: ATEYQzzPQPHbnj0Ln2h4VI9YoHmmhGyIwNKFfQR7O16MiVBFuSx1fHff6Z8TWbutvAd
	U8W+gTTbOXb8jzW/iaSbf8G2L0knwI1Y0s5CYLLbN8UmHKce7qBN3aOB/8fcdPyG3ntU8UjXrDN
	nHKedK8zmHoxav9HXUjVVpR/cHMHHdE30rXJg4Nu1rCBv5MNitvYWGJDZvSMwukvEnIscCu+X4n
	NhPo6Z6qCeIBi7SKoDg8uIW8UzSvg+EaJfgNRPn3q/OBBl+tYj4k1FvATw9j49M7Bx1zAgDkHUm
	GuUwabu6KUES5oUK9O4KbokDbRlb9AYda7BYNVOadK0IW5ThE7tf4oTm6mRFQKRfI5CUEzeSMq+
	tiP7bcuzDRV0yJTL8BOGuMNzhOjrCCXv9Isa5OzHWXpG8Kun8vz0u/VUEANE2Y+72vPxLj1Co1k
	HGBioxoKQ2kh4h5eoyi9wSTzWLmB1APF8PljkCxn71qf2h38ylWB4Ob5dVQ7xcX39sWA==
X-Received: by 2002:a05:7022:43a4:b0:128:d5bd:3572 with SMTP id a92af1059eb24-12a726f5b50mr2106603c88.31.1774036320596;
        Fri, 20 Mar 2026 12:52:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12a73317a81sm233650c88.0.2026.03.20.12.52.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:52:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0ba59a830so928342eec.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 12:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774036319; cv=none;
        d=google.com; s=arc-20240605;
        b=RxsAWnhguNvsH4Z0SKSQuTz/3UFueuuXMagFksgnLmgTwKRjXsPyiNHnNlg6S8Eo9d
         vLOz6o9elMsYTyltc+p1bZv521LrhqhHxLAp9mQe4xUvcGYeHGxkg4B3QP5oRlRISu3h
         P0I8Rgk0cn0jxruYkZHKJ3LSqzdDGs1wmuOMpMLXvNyIt9Tqld4R3+1vnCdT00LcIFJs
         2QnxXG1v7Bq+JWthnKaDF0sOvKL+hVgo688OG5PsD+YTfLCT4GM0D6fX919EqTLjtw7d
         CXRkLIK/4vRaXfEl1IDDHN3gAQ+66T5cABUc9UexjxDlDGPkvX3+IGsbj7CdnamyMfN3
         KlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QLRDWiwXqI6ozMy4XA4NZe/ZrS7qKLv6kb2LUJ6RNXU=;
        fh=j09vHsNHKaDvrdzSS4Tcf96I9pnhGqe6YMw05YlmaLk=;
        b=Pa7GVNisbkD/AjlNEE1XLy1jGM4ebT8ZdaBh8kRe/Ne4dNHSZO2wM7Unkr2A9WtCXc
         tmJwWVh19Me658HK0DqIA62qKT2nk4WSYirdtZRuuKCr+3RzTC1eTVc5ksYeFD4wN4in
         JtGYVfch26Csm9ApcmFtBTzK2iMPrGvXEL5WBOavJ+0mRyRR61ONd4MDe7gFzKtj89ep
         1iee0yFLwvkrGudM+yJSDZk2R7lqgUN118MZvb6iwdI2e0bnS9Ar+1bdyEcHC9OX39xv
         IpcuyETdgG8Iz30VyqbjOKTtUlwgmFV0fIiNC/yWbbWwqENcaGJXIHWt0c8L2RSrgFgT
         8Umg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774036319; x=1774641119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLRDWiwXqI6ozMy4XA4NZe/ZrS7qKLv6kb2LUJ6RNXU=;
        b=KU8ZMc332U8MTz1IRB+kMh0esZ0xvTzsE4vtKJx08PHxPXhE9iq/M4kP0DqvxPmtYv
         4HpfOm0VbfbenJZbOvkMdN09qcs7IOy5HDIo5808/tA6c57GRGUoTOfnDZGOvFtJ6KQf
         ZkC70qesxULjzrtt443z/CqN0psFKS9w8fCSI=
X-Forwarded-Encrypted: i=1; AJvYcCU+4orHEpvNVe5o92PSqN8JGZU/tnPTAN80QiupApYMJ7tDbo+Q4JrV73ckGqbHGkerg97cSzg=@vger.kernel.org
X-Received: by 2002:a05:7022:626:b0:12a:6a64:81f1 with SMTP id a92af1059eb24-12a7267d7c1mr1856216c88.5.1774036318875;
        Fri, 20 Mar 2026 12:51:58 -0700 (PDT)
X-Received: by 2002:a05:7022:626:b0:12a:6a64:81f1 with SMTP id
 a92af1059eb24-12a7267d7c1mr1856197c88.5.1774036318331; Fri, 20 Mar 2026
 12:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319055124.1350670-11-vikas.gupta@broadcom.com> <20260320112717.2065386-3-horms@kernel.org>
In-Reply-To: <20260320112717.2065386-3-horms@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Sat, 21 Mar 2026 01:21:43 +0530
X-Gm-Features: AaiRm53VXBZSwrkCJND3RMGwGHCcnpE4oaYTa8MoU49Xza1RB5pemkX0Nt4Pe8k
Message-ID: <CANXQDta9vL5t+mxeBCqF6rzSjytLJ6PiKkvdMiv7jdOuMCzajw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 10/10] bng_en: add support for ethtool -S
 stats display
To: Simon Horman <horms@kernel.org>
Cc: vikas.gupta@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	edumazet@google.com, ajit.khaparde@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pavan.chebbi@broadcom.com, 
	rajashekar.hudumula@broadcom.com, pabeni@redhat.com, davem@davemloft.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a0e951064d7a0476"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270054-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 9C5D62E0A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a0e951064d7a0476
Content-Type: text/plain; charset="UTF-8"

> This isn't a bug, but Documentation/networking/statistics.rst flags a
> potential concern about interface duplication. The patch adds per-queue
> ring statistics (rxqN_ucast_packets, rxqN_mcast_packets,
> rxqN_bcast_packets, rxqN_ucast_bytes, rxqN_mcast_bytes, rxqN_bcast_bytes,
> and tx equivalents) to the ethtool -S interface.
>
> However, this driver already implements the standard per-queue statistics
> API via netdev_stat_ops (bnge_get_queue_stats_rx and
> bnge_get_queue_stats_tx in bnge_netdev.c). That interface exposes
> per-queue packets and bytes through netlink, which is the designated
> mechanism for per-queue counters.
>
> According to Documentation/networking/statistics.rst, per-queue stats
> should use the standard netdev_stat_ops interface rather than ethtool -S.
> The documentation states that drivers should avoid adding new counters to
> ethtool -S for values that have a standard uAPI.
>
> While the ethtool -S stats provide a ucast/mcast/bcast breakdown not
> directly available from the standard per-queue API (which aggregates to
> total packets and bytes), this still represents duplication of the
> fundamental per-queue packet and byte counters. Could these per-queue
> stats be omitted from ethtool -S, keeping only the truly hardware-specific
> stats like TPA, port-level, and priority stats that don't have a standard
> interface?

Thanks, Simon.

These counters report unicast, multicast, and broadcast traffic
separately. This
granularity is missing from the standard per-queue API, but we find it
essential for
hardware-level debugging (e.g., multicast storms or verifying RSS
steering logic).

Since this data is lost in the standard view, would it be acceptable
to provide these
via ethtool -S for better visibility?

Thanks,
Bhargava Marreddy

>
> [ ... ]
>
> > @@ -262,6 +740,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
> >       .nway_reset             = bnge_nway_reset,
> >       .get_pauseparam         = bnge_get_pauseparam,
> >       .set_pauseparam         = bnge_set_pauseparam,
> > +     .get_sset_count         = bnge_get_sset_count,
> > +     .get_strings            = bnge_get_strings,
> > +     .get_ethtool_stats      = bnge_get_ethtool_stats,
> >       .get_eth_phy_stats      = bnge_get_eth_phy_stats,
> >       .get_eth_mac_stats      = bnge_get_eth_mac_stats,
> >       .get_eth_ctrl_stats     = bnge_get_eth_ctrl_stats,

--000000000000a0e951064d7a0476
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDLRky0cxpUXjPGzUmeMEhUqfsDzATcbFBSKoxGxEchOjAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjAxOTUxNTlaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCXtPne
RONy5Ld8HeO1hU27hZmqk7EE9ivEsCvf7l4be6+GiGPkdUx4TeTItJGlZ5PTPTjoxoPpIzrl71MG
io5ZfXaDThok8wFpQJHXdY9JcXlnWQXMP9HXQrl3Oeluct01aMtGFFmNUmqY8Hf8hun0SCPVGa4D
7Kf1vYDfI9pD1Dhq4aKwKeNcd7DnLJcRZ+JV2/g8OcqHynNFh9LGfFCl62w6tlktMsJF83bCn61g
34jbBqUtoa+uqWKg6/zJlLN4lIc1Ea8aILElfBQnJKapplf9PRiqHAZYduQSHE2AQA5nasWS6IV9
z/dQlo7rIH2/ALFLm9s2ShUoOMV17iRi
--000000000000a0e951064d7a0476--

