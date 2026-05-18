Return-Path: <netdev+bounces-289189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFVxNtKRC2ohJgUAu9opvQ
	(envelope-from <netdev+bounces-289189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:25:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370985746C6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99BD3059005
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA63932FD;
	Mon, 18 May 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XU2ozsEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B12571DD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142907; cv=none; b=JOxLr28GBrr/ja68120jRDkvRf4+qBRpb3S3N+HkXaFF17rlPYwU5f6GfClHZ1TV2gA/LkdwDWuLlkqW3iXVSqh1CjYHmAmP7QN5QeuWL80m9pL4MRGHDRolCMzKg+JxxYQHC/QHzsa+MGkN8vYpJ8CBxqZfdBHKBTWCgjPcauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142907; c=relaxed/simple;
	bh=bQuaTm1j11ZBAmW3XORT12HXwYxYdS2zUuG6f14DQms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxdDe9TwAuF5I8f3gspGyDgzdrbEA+vFw2X/gFSK3AwZAop5Ym/+L/SVntG5Siffyzmw03Qp7/RaiAPZfqa3PDhNBJ7Ac7JAniZ6Xjiiu10MvNd5LItXRlDinvnGZBxMVYv6rdMN30ipgNidVjygxptB/ajXjZBP/qimlTo7Hh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XU2ozsEI; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c82471904fcso1167771a12.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142905; x=1779747705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OhyDRu2kLWfZr2SYR+Y1Z+le+TBDgKFYsW1xx3YLNY=;
        b=fAhmcNKZCtyVoJom2DsA9Uwfo8pGdZAyzkAVH6CmV9hzNnQCHRnaKpsyrbdOVnvkn7
         XlG1yiVH5LvlkrxB0v5mZxLNC5INUCOUNV8zpiPCWKOyeODFw8x/mUjj5yRS3i6W8zaa
         5hEHWPxNSJ3rlIU/WkxCYE3Xb8t0boq7ARwNlqrKk/lp/3gkSLOqxKs6ESa8t5g3jZsm
         NLnLdxYo4Ga8orxxiaEk5do6eNekTS30BEHpb/2lgcQDa4QJAuyVyzu+LlcF4v77P9p8
         qYUxXJv1an1uKxlBRkpwDy1DW1Um+BqWy5+nN/N06qZON5tsCgTIiAoMHNNXdzSYEdo0
         FCxw==
X-Forwarded-Encrypted: i=1; AFNElJ80lWGvKYt1VF1JwdBDy2aMJOclpu9MGnyTuQS66JSxkrT3mSQOi4EPCxEoiKNXiVtf3CbgQQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SyFrtxY3avRnlzcu/xt+2X1JDsgbW3iBJaO3RNMyYVSxadQz
	mn2yiXAjF9UtZgH6RHdi/6OtD0MtSF/wEHOd+3v5LMTwBHNjOWXjfiCgPNJlhjkr2QiXk+YDEd9
	ItH/1fOvrp+oKWJLSQ3YH0w0RZ7xhA5P92mmy+wIu61t9xVl6bhK5nnJ8fMUJTy14T6C+ylt3vG
	7Wft28il17Auv1OZaafdKp+lbmCwbuo2P6D9VUp5cydT/rRgh9khFnUJ2tW/5oxNpGEeI/et5Cn
	ys8ijbt59E=
X-Gm-Gg: Acq92OFu69rwtTbq4Yqqg6PBhpJUAW7KYTkbCcFUWvrX/q5CYIEsnQjGmQ3DofaZzJX
	3jHcP43eqoMwLglPj7WRbpgjEaVH6NYLaT4J7+Hi4c9DbSqS6d3MMfjurdr0sjZ499EgzNgyIUm
	4DhyoJFQa3uwLyHfzZPl7I4/hw0QVkdDkLQD4EhF4GXxNEOpBDqbwfuW3n4l4yMLHRmPD79BN0o
	LJduSBAoOmNQ6AIXQwrUC7RKfC2exZuELYzOX9yBxznBCtGee1dCrpuNmPsjx7KgQ7jEmKLB7LO
	a2yae6WH+5E9TIQXdrvE2EdT1FM+rfuniugGzU74JFsFVPX4UINkQp4tjHLPcAeUpKcMgUMkuXT
	X6y1AYE9WcaYC+3adFlZN9/9Byrl4Sy8I66eY7Tc5TsTcmQbwAsO8Quj4IegJhY/cXbbV2RaWvZ
	qe38GstMSN+XadNg3tu7ncsrOnDT6Z44vGZ9+KBfNcRPXEynGe8RLl0qJy
X-Received: by 2002:a17:903:3bc7:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2bd7e9e58aemr195793425ad.37.1779142904641;
        Mon, 18 May 2026 15:21:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2bd5c0650b0sm11671895ad.14.2026.05.18.15.21.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2026 15:21:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-678a5c665b5so3071923a12.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 15:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779142902; x=1779747702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6OhyDRu2kLWfZr2SYR+Y1Z+le+TBDgKFYsW1xx3YLNY=;
        b=XU2ozsEIa8I9w+8nV7xHeXnBW2Foqfzqogg5Z0WPo+Y71+klcmIkGmen9nsAnULabI
         GYjZy/7Zno1jXX+vEThSbGI2prK6+n/5IqLZEzG4YODttrmjwOT7lN6JDOPA/wGUbvo2
         903cDnryHa18pfb5/QiLuJ2I+U+CF5ET4y5nY=
X-Forwarded-Encrypted: i=1; AFNElJ/caw0MBWp/dnRsKsOlBx82YcXu1q07yLw13HExXt88ad0EDoYwRav6frz11StX8cGv/pCqClM=@vger.kernel.org
X-Received: by 2002:a05:6402:1947:b0:67f:58b:4968 with SMTP id 4fb4d7f45d1cf-683bd195a41mr7399664a12.24.1779142902321;
        Mon, 18 May 2026 15:21:42 -0700 (PDT)
X-Received: by 2002:a05:6402:1947:b0:67f:58b:4968 with SMTP id
 4fb4d7f45d1cf-683bd195a41mr7399652a12.24.1779142901961; Mon, 18 May 2026
 15:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512212105.3488258-16-michael.chan@broadcom.com> <20260516011024.1857806-1-kuba@kernel.org>
In-Reply-To: <20260516011024.1857806-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 18 May 2026 15:21:28 -0700
X-Gm-Features: AVHnY4L99u9T_dnrdNAWZ3FfYEzGjgyePdffKCWytNfmwlycm9ClQb2LDQ9WvnI
Message-ID: <CACKFLi=DRvf7tu=WWYjpma1JFLgHMTZPH+-w=hVaTA_fbC7dOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 15/15] bnxt_en: Add kTLS retransmission support
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b8137806521efc0d"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 370985746C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b8137806521efc0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 6:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> A few questions on the new code below.
>
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 89c900db45ba..5697190dc541 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -499,7 +499,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >
> >       txq =3D netdev_get_tx_queue(dev, i);
> >       txr =3D &bp->tx_ring[bp->tx_ring_map[i]];
> > -     prod =3D txr->tx_prod;
> >
> >  #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
> >       if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
> > @@ -532,6 +531,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> >       if (unlikely(!skb))
> >               return NETDEV_TX_OK;
> >
> > +     prod =3D txr->tx_prod;
> >       length =3D skb->len;
> >       len =3D skb_headlen(skb);
> >       last_frag =3D skb_shinfo(skb)->nr_frags;
>
> [High]
> What unwinds the presync BDs if a DMA mapping fails later in
> bnxt_start_xmit()?
>

The unwind is indeed missing.  The cleanup path (e.g. during TX
timeout) is also missing the proper accounting for the extra inline
BDs.  I will fix it in v3.

> [Low]
> Is the "tx_tls_drop_no_sync" name accurate?  BNXT_KTLS_TX_DROP_NO_SYNC
> is bumped in bnxt_ktls_tx_ooo() when tls_get_record() returns NULL or a
> record with num_frags =3D=3D 0, after which -EPROTO is returned and the
> caller falls back to tls_encrypt_skb() rather than dropping the packet.
> Would something like "tx_tls_resync_no_record" be more descriptive of
> what the counter actually counts, given that ethtool -S strings are
> hard to rename once shipped?

I will go over these counters and make any necessary adjustments.

> [ ... ]
> > +     if (tls_ctx->prot_info.version =3D=3D TLS_1_2_VERSION) {
> > +             u32 nonce_bytes =3D tls_ctx->prot_info.iv_size;
> > +             u32 retrans_off =3D seq - hdr_tcp_seq;
> > +
> > +             if (retrans_off > 5 && retrans_off < 5 + nonce_bytes)
> > +                     nonce_bytes =3D retrans_off - 5;
> > +             memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes);
> > +     }
>
> [High]
> Can hdr be NULL here?  skb_frag_address_safe() is documented to return
> NULL when page_address(page) returns NULL, e.g. for highmem pages on
> 32-bit kernels with CONFIG_HIGHMEM that have not been kmap'd.

I think that's right.  For 32-bit highmem, it can be NULL so I need to
check for NULL.

>
> > +     memcpy(&pcmd.record_seq_num[0], &rec_sn, sizeof(rec_sn));
>
> [High]
> Does this copy the record sequence number with the byte order the NIC
> expects on big-endian hosts?

Endian conversion is indeed needed here.

> [Low]
> How is an operator expected to break the OOO counter down by outcome?
>

The TX path is not quite complete and some TX counters are deferred to
future patches.  But I will make them more complete for this patchset
in v3.  I will also review all the other AI comments and make changes
for v3.  Thanks.

--000000000000b8137806521efc0d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCD1zwfs
zQ9dURBQtdsw/Zk44jsC4iL+Wg6nLrah4qggcDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA1MTgyMjIxNDJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBLfQm4GePRRjdYzGxqAKtsGJILVYdL+GYF8Dg6AcMs
3h6HjUUUScxHY4e3Xh1qoVYh4156UWWyswvlendYMr/dICoIYGzLjDe+gzZgRYJYSWKRHkaby1vA
jF1vCLVqr7fuBv+uTcVtgc1BJQHOAMefd/c7AUyCQ8QQx+muRSorl9qv0ZX+AS+du8AWK8l0Xwnj
0eGoxj+YAgXMbuXubbFRp175lxb3RYRdy2LoDXzjAoXBCqwl8t9HOpyME2lNAm8o2SWgVgXNuGsN
toDFFZ8F26VF5l/3AMdmpgLM21LZN/LsahrpxNPuX/ZZPQYq1pnKosy0Tj2JAMPdj4aD5PAa
--000000000000b8137806521efc0d--

