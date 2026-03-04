Return-Path: <netdev+bounces-263642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KBKClrqp2nelgAAu9opvQ
	(envelope-from <netdev+bounces-263642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:16:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A1E1FC5AB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80FB330FB5E7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D1391518;
	Wed,  4 Mar 2026 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DSmqdIzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03538C2DF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611734; cv=pass; b=GNXM2TQFau+LNzjHS2dHaGlvZ6nadjztCiK9btqHokCph3vyweoBbrYolUPPbR/l90SRshkYFjjCZeI0sGgtBbC+Em5OzVzgdoF4n/iSkaDcIgP0ty8cAWKJ1JYBCnItXPSIpl3yoYRVg4gylXLavyrCXFn2qP4lzhElEjOCtMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611734; c=relaxed/simple;
	bh=c/jmA8c69/tEBmF2Ab0nmBNFmu4RD1CoSzWrUuZ/gIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkG9GRm/YwZ1yvMbwV/2xtu6rlp30snXJ81UcOfxLik/z+nVJ5uUCQIVOgHe6bf5+SQNTLtqp8/uPQpJVJXvUGcj9hUdcbG446tC8OzNMH09RjZin6M6Z6Nj7ifBLPcQB7c/i3VG3sMldQ/HwBHomz1JHxxfeJIMr6p38BZY8aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DSmqdIzM; arc=pass smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-679f980a239so3116947eaf.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611732; x=1773216532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXGJxrNATX1cswT2K4taLMFU78X5VBtwUcZ4FOsr4lo=;
        b=fjaJLeuKVpYWsREXf5EsATLS47PGs9zUZO5B6gaDakz/3L1Snj9bwuR9wKQ27TTAcK
         Imwb6ORoeXkuowHkKj63DiJxbAuWyV5bbxOSuLFRR3HxOmU1wSsJRCUcnl28UocczEeM
         ikiZLbBQFKewE5ssW559/IRg1nI+je3k7UpWtx6MmBvw/jyioL8meZ5jziotawzX8dIC
         bzoWwvEQQfoMxIu5XqUahqqkPJQZntegC3tQvh0Jp/gAlV3KJnakgIciOpM//NM5eeLV
         qjcJmm7ReL0hC1s60NBhuH6FI8dYd7WlERoa/xlp8fIkkGqcU829KWg5VQnDPoGnrxqA
         ZleA==
X-Forwarded-Encrypted: i=2; AJvYcCXAobLK5P3YHATzdCw0HewYuNTrveisfhwcUGPt7pqFF++Ph2RpYXcX9vgDnO49nMa2nEk5BkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWn7diIIEWtXU0Tm9Hhu83XgjXt6YNZ4CFWDl2pRaRd3gcy6F
	AxbjcIXbZ8VVV4OKP1g8cO/N50L/N5KZtqTsiSqYMlCnq9fknhzAQSPfJ0FSK7iKMTliImUEDab
	3fS6PnNVa2iYYmK/3iMYe6durNMwfqJ1nLXjH8+09aPW5ByUVtLj5U47hTrEd91UOKsDp3IEvDT
	3jgfr4PnWn5ckpctKA9b5P8QJC2kiQiNAKIKqUShj9ICbeaGzBoxTJqmqRbhnYCqYuKW4soRv+d
	8b84V9PqVbzJxTHdQ==
X-Gm-Gg: ATEYQzzP68XPKiltu4xPth7To/C2RHESkAt8E4DLobnjOXrKhQ0LskkLhzmZvSL2hIA
	D71PxiGz3BWwpAyVMxUIa5WlEl4aJdnuOJKZgYW9L72hXzMjKvejKnsyoi1sZU0fIeXG5qCOnD8
	ynOqgJuhnuwhnETMDcWoTEN4nj+98NFVxVZQySbaNEPz6IAQtxuop2XJlxKdQnLI5KcNYWVNELO
	3eCZ+JlJdPOp/Bufwa3ariu2Zx+D97nMWNSJpX/ziUe1FfZ95krdemswMPLRQjKmCaq4Z89tCSy
	vRwJtek6pgd2EjStzawZhLE818QH3akqx/vwwsQsJp/NxFTY6h+WgqF6dZsV8jd7B/6lySSucb5
	k+Ls0f2IBEiTYPi9p5UQzMZLRGICo923f6VL4SUAWO7zURpS8N+kRpeaouACzQhoB5feuNGRltK
	XC3wfTBoIdRmkyetZ1JnjAYh65lwUnpafLx9kYJaDVqQ+WDXO8ZgKceZGfIxLveUiuLw==
X-Received: by 2002:a05:6820:228d:b0:672:7258:c4f0 with SMTP id 006d021491bc7-67b17759031mr700925eaf.53.1772611731514;
        Wed, 04 Mar 2026 00:08:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4160d21dff0sm2839831fac.12.2026.03.04.00.08.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:08:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2be1a486968so41221096eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 00:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611730; cv=none;
        d=google.com; s=arc-20240605;
        b=a5RQlla+zR7JaJAjb1/2nel9q8CoUefMOMlm1wuuOdJP/+b2cY+KaVyPKJHQwzaoAt
         BjDOSkkWof4g8b58kqAdJ8xvA0NQZtFHPAzcd+4OPccp/OpsTnXZ1Uee6CTD3RPdeFeQ
         PRE37cY2MIf1KWi7ayiXFgoRqzNUQtBebIaZPGgV1/6xtJcSb5BCpSu68xUPxEvFAQkE
         eap0ukJ5yAKMi1WsoFTUFtfTgT1a4732dpSeVde+fz1kizBeoxT47ee0JEFhQ/r2m/+U
         JtajCkywjK4kLUmHHj6qZMK8qY+lnDBhiw/WiEh9HDpzxNCwDvuqj7G2MStOR9BfKEnl
         e2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hXGJxrNATX1cswT2K4taLMFU78X5VBtwUcZ4FOsr4lo=;
        fh=k39V4aPI25sAIWFBNJyTC9rEenA6mvIAnf6ZDfUyszM=;
        b=iAOxPp1Lc/URgwTUX6ZPUPZwOJvSZT6csGvdXlFNHPWV7G4R5b9rdOE5JxA+BG8Xc7
         nKQ993cX3A0RVf6JUyRjGmgxzuRjHfRnCQhmqxnvDSKun36PJlCOOoqVwJSYZ6xTUI+I
         m2bp4eOfKLtVmc0HozWGgEPyh/F96Uy6D2EQep1FrFj8AEjV3DMmROlMEGKY81dOz/QC
         VoIu88tf7fEM77qyvQe/SSDXXgiEJqNuxjhQ5+W0wWjfitFMkcjSzPWEEdrLki3BA5WU
         DA+1z8bkwMuhtkrJKUdAzU2Is7jsdvNvQmUexSkinJYNsTsmbWDhEOG31qbxpY3H9bFp
         ZLnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772611730; x=1773216530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXGJxrNATX1cswT2K4taLMFU78X5VBtwUcZ4FOsr4lo=;
        b=DSmqdIzMS5E+l1NNSuU64J4Vy8zgQlzsJ8o8nSKeAf/TL7rCaRfKV0oUAqTNQgZWM+
         /sh9CxGnujkh3iCp4jvKEKR/S3/wmsR2NuRT/fE7hmSBSsbJ6Kj/aoW2DRXiH59P7HhO
         rGuT6AXkAYpxRv2BkEn0beI4NJGTWvMDb8NWc=
X-Forwarded-Encrypted: i=1; AJvYcCWiaQjk3NHbfSR8uoDdHCBcDidEAbYw61nfX2Jtv6m8LOmCgonbqETaA3KZRsTvWw0jTM3z4GU=@vger.kernel.org
X-Received: by 2002:a05:7300:5710:b0:2be:6f6:a39f with SMTP id 5a478bee46e88-2be310ae9fdmr490496eec.26.1772611729759;
        Wed, 04 Mar 2026 00:08:49 -0800 (PST)
X-Received: by 2002:a05:7300:5710:b0:2be:6f6:a39f with SMTP id
 5a478bee46e88-2be310ae9fdmr490486eec.26.1772611729175; Wed, 04 Mar 2026
 00:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228072715.1632280-7-bhargava.marreddy@broadcom.com> <20260303030036.1885679-1-kuba@kernel.org>
In-Reply-To: <20260303030036.1885679-1-kuba@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Wed, 4 Mar 2026 13:38:35 +0530
X-Gm-Features: AaiRm52fdg10KrThJAyZu-eh3flSOoBLY3IYYjuyjjdXXITGDXfc_DB463GRA4E
Message-ID: <CANXQDtaMHmzU32jyyooXk7qdHPqroW9Y-Nni==qritBgegn2Dg@mail.gmail.com>
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
	boundary="00000000000080f290064c2e54a7"
X-Rspamd-Queue-Id: 93A1E1FC5AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263642-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,broadcom.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

--00000000000080f290064c2e54a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> bng_en: add initial support for ethtool stats display
>
> This commit implements ethtool -S callbacks for per-ring RX/TX, TPA,
> and port-level MAC/extended statistics, including string names, counts,
> and DMA-backed memory allocation for port stats via HWRM wrappers.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/driver=
s/net/ethernet/broadcom/bnge/bnge_ethtool.c
> > --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> > @@ -31,6 +31,331 @@ static int bnge_nway_reset(struct net_device *dev)
> >       return rc;
> >  }
> >
> > +static const char * const bnge_ring_rx_stats_str[] =3D {
> > +     "rx_ucast_packets",
> > +     "rx_mcast_packets",
> > +     "rx_bcast_packets",
> > +     "rx_discards",
> > +     "rx_errors",
> > +     "rx_ucast_bytes",
> > +     "rx_mcast_bytes",
> > +     "rx_bcast_bytes",
> > +};
> > +
> > +static const char * const bnge_ring_tx_stats_str[] =3D {
> > +     "tx_ucast_packets",
> > +     "tx_mcast_packets",
> > +     "tx_bcast_packets",
> > +     "tx_errors",
> > +     "tx_discards",
>
> Jakub Kicinski raised this concern during v3 review: standard stats like
> rx_errors and tx_errors should not be duplicated in ethtool -S output.
> While this patch adds structured callbacks (.get_eth_mac_stats,
> .get_rmon_stats, etc.) for standard stats, rx_errors and tx_errors still
> appear in the bnge_ring_rx_stats_str[] and bnge_ring_tx_stats_str[]
> arrays above.
>
> These arrays are used by bnge_get_strings() which feeds ethtool -S,
> meaning the standard stats will still appear in ethtool -S output.
>
> Should rx_errors and tx_errors be removed from these arrays to comply
> with the kernel policy against duplicating standard stats?

Thanks, Jakub.

I see the issue. These aren't actually duplicates of the standard
per-interface stats.
They are unique per-ring hardware counters, but the strings happen to match=
.

To fix the collision, I'll prefix the entire ring stat arrays with
rxq_ and txq_.

Example of the new output:
  - Per-ring stats (via ethtool -S):
      # ethtool -S eno12399np0 | grep rxq_errors
        [0]: rxq_errors: 0
         [1]: rxq_errors: 0
         ...
        [n-1]: rxq_errors: 0

  - Standard interface stats (via .ndo_get_stats64 / sysfs):
      # cat /sys/class/net/eno12399np0/statistics/rx_errors
         0

Does this approach look okay for v4?

Thanks,
Bhargava Marreddy.

--00000000000080f290064c2e54a7
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBvYub3VFZt9jpFbtNFOHZQINHW7iQfbLY5kFAQm2LTyTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDQwODA4NTBaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB4Acvc
czcXw8iOr0IzGPocT7tXLRd2NBTMcTjtnpmaodP8ZZ2vXn2NLlrsjuWG8mENnDHVHwvCtSPXpFmm
7WeqgcmiDjc/JYb0CwJn3gLtEsyNcRD0yEsPgWyGWNYYTtNFFjE89HrGgQU3Gzvzosj6upDF4FqR
cWugVbxsmShub/HDmrbjvTidqIbpxru3l7qdzYcWu3lALcCR5mVDC/6Zce6Fg2UQyvWvUSkwTWo2
/RGoZG1V6jUv84Rje4ACW5KWu14+j/TngrUiUYgZjiE4zDKfp/USbxaNvQhhYCFzMoMkIv5cczlI
DwsKY+QkbFdMuGapBcLM+N4/lJJQSXGH
--00000000000080f290064c2e54a7--

