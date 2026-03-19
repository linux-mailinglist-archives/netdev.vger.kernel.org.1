Return-Path: <netdev+bounces-269416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACmhJnHiu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:48:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1842CA94C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1869329CF26
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B87377558;
	Thu, 19 Mar 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VMhXP2Q3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E082580CF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920481; cv=pass; b=avaisSexazXhS2BHY8lAse/v9RlEAca9pUK+RMOihgY1tVE3DoRebE6ERnyglhxdLHRyzzfQtrfh3n73RcQziYAC1QXw93S/Zy3q30++qLE7Yuj4LoPP8CNy3Q3yMmnFP9P8ggPd4S+cy85Kus5DV1sgSN7g4YdNwuVaRIksJaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920481; c=relaxed/simple;
	bh=fc7laSyQjo4x8Q6Dz4vD8kPRIu73y63SY4siLy/NMEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMKlCqaWpaIPctM9jcnFKKV5SOM9del1vqeMPF/XHBWAtLqRFn6Tp/t7aROiEIpXWbVMAU+8JJzOjGEAYvLbnBDEPq7xEaxJOBJekE0Rt4nrIkeO5uFZXdxdgkQvOHLlTR7olB7OLt6gV4Umjrf8bKcyVk8Y8yr8+s/7AoVeKmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VMhXP2Q3; arc=pass smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64c31ca77b4so1041517d50.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773920477; x=1774525277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8229MQVhgUCS9zi2i9v8f7uwvSC/fZC1j4CtFI5ucE=;
        b=FvPN3PTUc0UTlteZPvRwDV2NYIxEa+xraSyoGE+fVKklgm7gu8YOCJKLjycWWH2uti
         ONwHcdfFqVQDfWG3OlXR8hfa8lhkgmoFLZSemzIlgzFEjYkKO8tLQ6/O2HzNvAy865MI
         S07oLarfuuhOsMBiWkZJzOMF/GMi7ytO2ThHsvBF6fpXprcttdEkMo6zxlmBUANTu3/v
         CDC9lsPRghzEbstUtlrsJERiStgmAbrOiZc1UT7VUEtnfFFJUITus24VW2X9cxHWqrdW
         BU6OyDyttUsUw88GER94/yxZTNDPSk7OTquDzQvykEFSo1rsEKR3ILW6w9t3DWeIUcIk
         AwMw==
X-Gm-Message-State: AOJu0YzP1xfOrjj8TRAWr7Z1jWgFhrwqfN9gBmsMoJPKryj8qtYqroNe
	ttZJr5xweJLOTRPt7CynBNDmOxZoHraekkRSQv50ZPAPJ87E4viLkRdn5LDt9GgDyKoa7uboFno
	NaffBBmrS1VWrmaxzItWdbg7p5UsPSwoPfdnuTnk+neoSTfAQTpPkBvDYeOSiLX/UjP9y5qjsjR
	6oSVIrcDEWUvXRR7poAyPA8YeBy/w5m9WNWnwtmBCecMWg/rGbqNVoqrGzresd8yjevSjaOCkEA
	K8a0WKk894=
X-Gm-Gg: ATEYQzxFQwu/TMTSjxM3ZnDiCxeko9g81IeXOYkaPwPVLR8buzDPL+vmNLqtGg7W+FW
	xS6D47T1oMCVRJvp5zIP2Np2GnlIRnQq5+qgR5nl5MD15S99ehJjMTDMdpASw+daQZ1eTpk3SoJ
	nMaHaXum5uMe1MIHkmjTENbGtsSi2bhzjcI/YUtKBKTRIfslUePzWc+BRioVrqzY2kVBLalJUlb
	iHFU8iuZwSzsfSkOZdS2xf7HR7MXN1Nru8CvoS9SlhXndeh+OidC+81xNruhBlo8vZlSQZRRrVu
	CmcBhDaJrRfJOWLIHeVtq7RVU57S3p8hdduOSBzdzb45wcUjb1/9MlCmgKfQ+wUaEAASDMInvM4
	C6QIill7IzWT+wLAHKFaA9O9uORWrup78qSOTpZB/ECK9jpuFHpCShASN3Ie1ZbOIFqvaBuroZm
	Fekim8jIyMrGa92AKvYDsIUQjuYXoL6dRg4qFf+V8JN6WmQlDSBXyHKjuw
X-Received: by 2002:a05:690e:2055:b0:64c:97bc:52bc with SMTP id 956f58d0204a3-64e9157c05amr5758123d50.48.1773920476678;
        Thu, 19 Mar 2026 04:41:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64e91bbe770sm440114d50.10.2026.03.19.04.41.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:41:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so823414a12.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773920475; cv=none;
        d=google.com; s=arc-20240605;
        b=A/+TO0Ah6i7g3+EPwOZ3STBo8WRObf0835Vk1h/Sx+pY83Qr7zc6FJRq+0SP/Q7O8g
         QsQgmCL5Qk+U3Uaczw+e6M8bNToodnmtUsKlVWoElB5f72ayvTIxSwi8hY14K0lOgvr3
         HDcJuPxl22YKBLaDGh2qrhRQGRashUSPe4szPMh4taAKhYQeSJoqwIpHD9e/Vq3gXN9b
         wQ0eZ8ioCl5df9hE9G/S2IAtei8QTaHwlExsP6A4zG/1k9al9LXHlqpv7yAYMyTJZW37
         bowYmCjwJuIE0Nqr/6VdDAIM3kSF+2T7I99vKGY4rd+sqlVn31eEsYoZN+YKzxHYc4uL
         asMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q8229MQVhgUCS9zi2i9v8f7uwvSC/fZC1j4CtFI5ucE=;
        fh=mnz4pLJSGwwvZLl2lzZTPj3f6vRMBdNyavizvnGoydU=;
        b=SRF0O/8FMs89Vkjc8/5fpmu6un7pyNftdZldkj0QGpS5JJKIJk8ttYLiwlEcSzdqyx
         topEZYG5K8mhbTah7GLirnmZxGknvHC1D93MXwBDDR5KaOWooRyDmzmVQS5MQw5M9vXD
         lgCxVl0OHXt++MxvO3C1ctpd4STyveaZ9b74iiycr6rPuLSXbWXyNErobOVcXCy/tbG9
         OVnOwEq+OWnne/FlD61qDveRRHcC+2htH1snL2jTI2PU1HHiDs009SGCBVVEuQxSlA8L
         2xvH9v0Me3j6YsHLFxWSonlLK79wEmoXP6k/j9+9amoVaf3OrPmA9lfmWB0NjyLVrFqj
         6hFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773920475; x=1774525275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8229MQVhgUCS9zi2i9v8f7uwvSC/fZC1j4CtFI5ucE=;
        b=VMhXP2Q3eqM8SVYOxbOVL2qDDjiBotubR2WEgryAb3JWqsaIChQrpWSXVIsM8/ubOM
         9cGEiye87PGwB/k8P2g4fkLxKErnmGn0AL5ABUQDA9ygCN7te21SiDP2l2LYAdfPo93x
         KxBzgRel3ek9d/7qmlK14diRBLyiTKR/qH3nQ=
X-Received: by 2002:a05:6a00:3a1e:b0:81f:8387:53a8 with SMTP id d2e1a72fcca58-82a6ae6d31emr6152487b3a.34.1773920475518;
        Thu, 19 Mar 2026 04:41:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a1e:b0:81f:8387:53a8 with SMTP id
 d2e1a72fcca58-82a6ae6d31emr6152463b3a.34.1773920475070; Thu, 19 Mar 2026
 04:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318191325.1819881-1-joe@dama.to> <20260318191325.1819881-9-joe@dama.to>
In-Reply-To: <20260318191325.1819881-9-joe@dama.to>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 19 Mar 2026 17:11:03 +0530
X-Gm-Features: AaiRm536lErA4_skvw0Y3oGUlE5n0oPTVkOBz5Z7wg0BY7Qmj4xQiRXQ-S_hegM
Message-ID: <CALs4sv3i9qk879+OFyj1Ecq6-Kkuuu=GAY2hJCFYOfFg3sy_Jg@mail.gmail.com>
Subject: Re: [net-next v3 08/12] net: bnxt: Implement software USO
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, leon@kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d1d3fd064d5f0bde"
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
	TAGGED_FROM(0.00)[bounces-269416-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1F1842CA94C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d1d3fd064d5f0bde
Content-Type: text/plain; charset="UTF-8"

<...>

> +
> +       hdr_len = tso_start(skb, &tso);
> +       mss = skb_shinfo(skb)->gso_size;
> +       total_payload = skb->len - hdr_len;
> +       num_segs = DIV_ROUND_UP(total_payload, mss);
> +
> +       /* Zero the csum fields so tso_build_hdr will propagate zeroes into
> +        * every segment header. HW csum offload will recompute from scratch.
> +        */
> +       udp_hdr(skb)->check = 0;
> +       if (!tso.ipv6)
> +               ip_hdr(skb)->check = 0;
> +
> +       if (unlikely(num_segs <= 1))
> +               return NETDEV_TX_OK;

goto drop would be more appropriate?

> +

<...>

> +       if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
> +               netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
> +                                  bp->tx_wake_thresh);
> +
> +       return NETDEV_TX_OK;
> +
> +drop:
>         dev_kfree_skb_any(skb);
>         dev_core_stats_tx_dropped_inc(bp->dev);
>         return NETDEV_TX_OK;
> --
> 2.52.0
>

--000000000000d1d3fd064d5f0bde
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
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCokA0x
3cYKvN04Ar1RgP6bkzG0iNv2keo8KIAbYF27azAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTkxMTQxMTVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA/avg3sYuXnlB7EGUobFU0SDeSjfIw9xjiyADCYk3W
wtxRIRd5grZCqoV+c68vUZyDpvd9EA3l7b5tvJw+DJqwUne86YB7aq0RTN3eKLcKtHWw2YM184po
doYt+d2VbtizpCrG1S2xp/V/J0vQKIKTxSrMgM8GfgQWL/1TvCvYkrFIW2oe4dcKs26XZJ9i9Yee
ACYpKWqC06rbdklO6udyOr5NYRjZ/dPzPsx0BxTzi9x8YNtS23g3hl/Td0ZSrvL10Ce47xYgfdy9
6CWREa8JhRytYKLItdETyeeSTDBgVwrB86HatCbyISxvfdlSa/ShZAMWtlg6TyZoOtjyjtC7
--000000000000d1d3fd064d5f0bde--

