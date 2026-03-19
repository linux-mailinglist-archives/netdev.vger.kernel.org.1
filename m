Return-Path: <netdev+bounces-269412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKHLIBrgu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:38:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBE2CA684
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC257305A412
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555B35DA6F;
	Thu, 19 Mar 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NeshLwAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACC348860
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919951; cv=pass; b=Z0HATvexo8vZKKTuFfcRePnU+Sjm3R/4xNRPv4mfKgZB6QkjFX6JyT2Ug9lcewxumx/SyexQLqe4XZTR2w3rVakfIC2nGW2w9SvTe4aftddSYEr8JTglMGHlRmjwChDKG3q3w4wyfeTWJ6pWCYNOsOWg+Pj43zxatXb4a5Elzik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919951; c=relaxed/simple;
	bh=hLbP5YuSN4PJoMCPJtAUuyb8zgbBdU3Cl6Gnz0aku6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEpKN7FQAf+awk6x8q2EZVMcLjwkJw32HcbJhDHwy0WrJB8Hht2eufA1FYMQUNrzcyqszfYwfDb+ttSz/k9NQUUDbltrlpyI3VeKQvElHtL7GEfoEIJgrNfhNA8sD8nqZrmB/Mrp6PLcZNlU89dMEK6DUso0XccnOlM8UqOz6jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NeshLwAq; arc=pass smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d7e565c877so78328a34.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919947; x=1774524747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyvcgXguz4n/8pbaw5WLGpXDYTGspF6y0zhaaRkRxw0=;
        b=rAffcWTeyKp1NnBU5qjj5K9gLuPxyjasl1AyYWZXCJSTjmev1KzxuqvhAlZCtJJQsD
         DRGp1PblgYXRbACnOhx9T1BvfCnxDxb5SSRmFwXmlWJNW19F2HZd13m8oSiGEZwwDLEX
         /+BCrS76f2x6zY/DjJ2OL51T7wlVoygB+6s3fQ39ObDs2US0Xe+tP8xOU9vn3+k8ejU8
         d8r3vKu8UcqhsHMlgxtYoAF1MeRrHoWvKjQdKGyP8z+2nCX+VHY2qdIGM/Jz6IHEkGmB
         jA9N6o3DsASizh0hKkkaUFDUTDW0MY3ItSl9ZCpfsIo9nv9Ey76luGSUgkyq3xluVNYY
         NQeQ==
X-Gm-Message-State: AOJu0YxPvAg+9HEK4rrkb61aJbi8OkjaqxItR2YyUJGFnV1XXk0Wkmlh
	w8bV0plMVt8boyIQW3grSvuSk0MOoArthY++H8rfaC6gDT2iJ7zX2VnIL/hsSNJ4KREQShnZeux
	/2huA+LruV3+lQ+4CrgHT77+cddD0UAjIM2CCcdCPuL7uwalpHBuCN4XvxEe9YLPKNx/rdoaB6h
	/Lx4upyz3JEOonZV9Of4yrnt4kqPH8TLnltq+sfRNTTMiN/gaebTknf3v5gJTe0M72MQja9Nr0A
	Cyk0G3XsQA=
X-Gm-Gg: ATEYQzy2eYySZPFSqBty+kJxJFL6pafcI3lsnPKgaYMwSydMDch4+NXetlPMhz5p0S+
	ntz70VUXVAz2p0KeQ3l3FeVSa4o4s/VIMg5UFePV+J6TLO6aWCtyQr2ntaqMSYDbBCVlIIxxFYP
	W8429TQG8cvsv7Ku2H6+VspbpnaiQicqKOUaGbMGK5qN1CPaBsLTb4bz5JF1EuS4RBt0gmASq2W
	BDLxELjjcGgRyqQFeOlWTofRbaFqsXe0osR/UwwQGXkaQ42Q4BLPq1MB3PJRB0d5lGDP/0dvTk1
	/t8ZLCnbOBExwkHvU3xzO/vYbf8eDW6IqQNp5ARKnEdOWOv3nGVHzrSqOlLYknhjD1rKKiQVKwU
	ZC6C230a40aKrzQJ6VZYJ8ZSuxCQdnEMq18bxPx7YWxr5RIz+6P/Hy5QtYU/kepnM7EBMbAWpSo
	R+IEIC3Yv/AjvC2GOMSKJ0kfgg2T43w+gh7zVZQTHy91JD8CDsBkUNFPCyKvQ=
X-Received: by 2002:a05:6830:388d:b0:7d7:d133:4781 with SMTP id 46e09a7af769-7d7d133489bmr2812671a34.3.1773919946626;
        Thu, 19 Mar 2026 04:32:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d7c9a7cf35sm734815a34.7.2026.03.19.04.32.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:32:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829b8bb5211so3668970b3a.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773919945; cv=none;
        d=google.com; s=arc-20240605;
        b=QA1USbz6cdzC2bfvkb4LhEctNrGP07NP3Gos5ZW1AYOW893NddW26dkUSh53AR9tge
         7ebSZL5fxHqG8NVjm91XxNbSerf9W3r9vyhMkto9Sxt88YOTSPSc7WB+AYPbPurMiTds
         nz6xROjWt2XWCMB/KQjEmuDWM/sIGdRzx3ehHwgCEOQthXnJ51ga+dWVwcnF3/HKXcaV
         wLWxGjNB/gk9SYx2B6JFEMLjsA6xV9A4zABKo0vtlQmabZEwhsoNbSRq5Rj3VXg187Sd
         n3AmUKnHjm5wA8sFn9sPO/RKjUntQkLdfAhzkFfAyLraqvZO2O4Tp8mCIVIMpMPCts4F
         eSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QyvcgXguz4n/8pbaw5WLGpXDYTGspF6y0zhaaRkRxw0=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=MeKQF5Ga8SaX171PxJOCq05zmuv/43KVluj0kltwXXoH5QLf7AYA/sYKL2zNkcp/hw
         pIf6B4dDr7aVcj6AhT/jB3pEkCvG7Ahm3XtOX+yIkifWy0uYqsn+1otWV4+kx7myxBdF
         RddWw1Y8T2l34Obbjk49OCDgPU3swL1bOpFNpTk/sAqz0piAQe23L7stxZ2q2VT2Y8DV
         QyvFiGfnLVjsMedDqPBgd//WBA8SX00Csxul8y/5nTVoes4lJQfNgeIZkkR+rHxFHbMM
         mKY8wBYoohuOWsdMfpXOt57rqYciirLeFeCRBE30mUefBJmpdtzwZ9e/PCRFFhxP6c1/
         3FRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773919945; x=1774524745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QyvcgXguz4n/8pbaw5WLGpXDYTGspF6y0zhaaRkRxw0=;
        b=NeshLwAqwIzwOFxq8vHPIvNkxCfkAM6Rp5cIsS1k7yZK/4slOIeEnOXbL6n4RF6q3B
         BP7YWk/JfhGTsTkXOhB3oDQ8FF4yefXAE4g0rWJWuuqtPP4yJti5xu0Mns9zVaYNJfV2
         pcEGrT/0X9in132izpB1jIWFHakoKtjLxMixY=
X-Received: by 2002:a05:6a00:909c:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-82a6acafaf9mr6474015b3a.3.1773919944957;
        Thu, 19 Mar 2026 04:32:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:909c:b0:81f:3957:2772 with SMTP id
 d2e1a72fcca58-82a6acafaf9mr6474000b3a.3.1773919944540; Thu, 19 Mar 2026
 04:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318191325.1819881-1-joe@dama.to> <20260318191325.1819881-4-joe@dama.to>
In-Reply-To: <20260318191325.1819881-4-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 19 Mar 2026 17:02:12 +0530
X-Gm-Features: AaiRm51n2E_VJPfN2eZVkCMVbUutjeb4LAWLvKRUynLz4yloUfnyTWtBfw6b_mM
Message-ID: <CALs4sv0Wbuz+e1hvHRbbn5no6rcicc0S=wRhi2Oc+2RNa8M+tQ@mail.gmail.com>
Subject: Re: [net-next v3 03/12] net: bnxt: Export bnxt_xmit_get_cfa_action
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000336506064d5eec3e"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269412-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: C6EBE2CA684
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000336506064d5eec3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 12:43=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> Export bnxt_xmit_get_cfa_action so that it can be used in future commits
> which add software USO support to bnxt.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Thanks

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index c982aac714d1..c9206977fd54 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -447,7 +447,7 @@ const u16 bnxt_lhint_arr[] =3D {
>         TX_BD_FLAGS_LHINT_2048_AND_LARGER,
>  };
>
> -static u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
> +u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
>  {
>         struct metadata_dst *md_dst =3D skb_metadata_dst(skb);
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 90fa3e93c8d6..8147f31967b5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2950,6 +2950,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct =
bnxt *bp);
>  int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
>  void bnxt_tx_disable(struct bnxt *bp);
>  void bnxt_tx_enable(struct bnxt *bp);
> +u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
>  void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr=
,
>                           u16 curr);
>  void bnxt_report_link(struct bnxt *bp);
> --
> 2.52.0
>

--000000000000336506064d5eec3e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDA++MZ
tRJCbs+TqdylOHi1ph+f6CMfr63gRibVJ8dZ/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTkxMTMyMjVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBh4lWZ4W541lLzUqaUmFNY6WHNgmBWRI+UerZIu3ZV
1EiMCOyKtJsgDU8lC4DzbBXNKTjYLTlxO/w+4ZMRmsWhGHVScdWGTSSENMmCAiwSCa/emJo2yP2B
0D7+PRZrNtTOThWLqY4KI9Q8kS8XFO1RuDxmLxHGoI3+2Asgo2EgTxbQ1p1CFmKAP1NdO0GgRD2S
ST8CRFld/oCdsAkPPacSEFkL6Z/73/KJg12TI8YpcwMsNSAyp7gBScDzRU5Rr5m7BNaywURaMkbL
wUb+fssOTNw2Y6s4RSjAPH7sIuZd2g2jGOsXg50qyes0Mz/oZK1Hrn+myChXeDnHXUenSYjc
--000000000000336506064d5eec3e--

