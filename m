Return-Path: <netdev+bounces-255175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL5nLybVfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:58:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33FBC4E2
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20AC43099B2D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F6343D71;
	Fri, 30 Jan 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QzWDg/W6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBC342C98
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788394; cv=pass; b=CkIN8sEPTx+cAoZ4BaHKfF0kMUXWFLLwXELneeRxBVYCLKxB9NY0tHGfjPkpAQookgknpmkFmpMssrnqJYoxNFuGGdmBs8eRjZfCbSCkBl64IZCkBQ8DpAf2PJBHHah+b5SOdi0dGAAI8LHH11QpgG7O8K0umr/z6zTzxTX/jAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788394; c=relaxed/simple;
	bh=kHdJIlJk1Tcp+sXvZN7oA0d8euOHbWZ6s3AbYCj6A14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2NgDXf2t0WxgWnYbIW4px+D4vB0xSki5nAKvc+LAq1T4OegJz7zEbNRnZFYb2cOjavMWaIaDFw9i4Ev2gHE8eoKtaedAuvLcJObjW2N5go6jET6hTUzISlu7G5cjp4Yxzi4A7LF9VQIRwjBqqlYqfQupJ7RYnpJ7GeMR9gQsKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QzWDg/W6; arc=pass smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c70ab3b5fcso300604785a.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788392; x=1770393192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuS97IuU5KLc9gPA4PZiNw/PcFlhUsfZ8OuLYnuVnjQ=;
        b=PRCgPw2ULpEaNkIH+6suoMWMXn8eFUMcM2b/Il9D9P5cB4mHdsGMxrshs1ZibhTypT
         nFZI3xodNcf5+kCj8tL6ByiYpuQtAl5y8IyUDO2K2+Y3LFBEJxp6s1sTfa5DzIDEMaxB
         QFljGtFGMb68HqDoZWdYYYNlkw7U4gK41DOGAzf8Jfe5/EbW9Vfmm1WLcb5eylhuMEgv
         deNJPni1GSgyWCsXsHN05D7E7H4xah1M2GIh1cJ/l9fhvJJqcgktvs7YtmQEnpFmYttc
         hXAc0DjpzgcK3jKv3Y1neoYOK9VvocXR4oqZUC/ejtAPDGi3wYmjN60s2yv730eYeCex
         kYog==
X-Forwarded-Encrypted: i=2; AJvYcCWKg6P2qO8orJBQ5xYTbSDt5aBRkyvQoJZHjoqgNiyuAwzKKhC/CeOMB/RyN0H5EYJ3jkh94Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/MuMIUAVMaacZSbfobkLcxl8rTEDzRHsMgcpCesAvLM+ntwO
	FeECL7m9Dm08wTVPiAPnMdSX4iSv3yaXSQ8UakRD0cTRpaVSVI6NvZeXFIPxuMTv68ZBVf7ecmL
	lbKCvsU+0gYU2JvgKFOQakWw3qPp9txB42oVure8T9ybTjjRuQ4/foRkhbDtFfTINLXUIs3ik60
	VFV4TdvCCy/0rwuVJl6I833XUFrQrQXadvX7tnDtH30SEY3WbxQ9ZCTw0VzrQHQKl05XmEkAnWs
	vBLB5QOkenp7eV31Q==
X-Gm-Gg: AZuq6aK5JhjGe3V3YOvTdBNmKN1/XxuqCHvPiCwldxlfjElMvQJf62V2G7CFVFWNoeM
	GLYgG5HnL6nvmpmIHrjj2W+OVD5+09scOH5vhHGm3CFOIetvLSJM2UTpSnR4QLpqTvEEjKTPcUk
	eBy9ZP8j2S81leezmC/0Mnm2k709FOcJsoSmIs3r9SEzKhnWCNKeq1fhZisvjdhUjcXmSudLWDJ
	J1pPCn3Rg8XIF6ZbWFu7TexaWZD8DKFAP/OsEH8Og0D7aDowxBJduZlG7VND5X+HEtGJGCrOsGp
	0AhAa6VO7BZzVgUcYxxjf3RhySW9RmQr092PoEEMgkVauOjd16kW3E07sxxdYz3Sy+NbvmpMluF
	V+JS04s39sf9oQmpGLi8CuqRXfZKWTuTbIGvgO23tui9AFdqyUlIk9/zLYoI+Xw0RXoJiDINPYq
	DyuX9L6mfJljdbiQfCIlqufNpspM/SKQluzLg0LWkRZSXRREmfDHw=
X-Received: by 2002:a05:620a:254f:b0:8b2:e70c:427a with SMTP id af79cd13be357-8c9eb2fac2emr458094985a.44.1769788392276;
        Fri, 30 Jan 2026 07:53:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8c711bef2b1sm64078185a.3.2026.01.30.07.53.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:53:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b738854780so415228eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:53:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769788391; cv=none;
        d=google.com; s=arc-20240605;
        b=lBb/+/S9PHJdzl5DoLwrz5tUTg4QiIbzUnlHUZMpmci7y+VLHq15P51EPevArjx9we
         l37BO6qbm8m68ttpNlDZRxlMwuJRMGyS78jyzIx/D6gqrS24ZdK2D50QozZjRBKR29GT
         N8s3i6DyenKBZsg3Gt8wNYzHhp+qNcCfA3MF7rODu+voQob2A8ZpRqX4W4fDDm9C/wiT
         cd10nEaKjKLnL98orT4Dkwi3ZaIpW13knLkcrhh+4mi3tMN5V72OnqW9qcOEfGwAlqzd
         SI7K/ftQFNQWjN7MPTQ/ACLe4wgpiVWrpV8TyVPxiniTQuPy0WIsLwf8At+joahGEaYj
         U8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uuS97IuU5KLc9gPA4PZiNw/PcFlhUsfZ8OuLYnuVnjQ=;
        fh=jrBVe+EbaAX2u1no0ayKGL+wq0j39DfzhTpPkxYJ/Sg=;
        b=EbSjikKRJWsv3FQ+bw9qzINDIQ4AW6H1H8tnmiGiT0mHLNU/QuHbleo8BnEqMNTwpZ
         nzI6sZ99KXtAnvgz6WgIj4xeBEZr++pxon5nDLFt/RSPhRj3U1lUS+vTcWMsGH8kruub
         ajKfGSB6sdxB17rlgX15q2+WiC0VnC/2DFUkreASC9RzqX/DGGQUPzaOBxP5isCTLjld
         2GoxCQXZkOP48cdk/9F7zd6dUPMF0jOfA0N3zgjptMAVExeO6tlf9R/ILUbkehtXMk2B
         RQOamfNFo8MBbrHCPxT0CzXS1RZOJ6yiqqkzfus1xyTDIpeGfAnPFalP04yazSR0mYPV
         Qumw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769788391; x=1770393191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuS97IuU5KLc9gPA4PZiNw/PcFlhUsfZ8OuLYnuVnjQ=;
        b=QzWDg/W6KImcXLAeti5TFxKNUsONhvQ1kA3WH9vIRK/mae+eFEr9yfy8F0AKhadhTq
         i/9acMt1XwKrIXPQzQF9J6CAcXX6tlN4g8uWuPTu/fZPFkteEINK3+m116WcOglfTt2H
         MqUDyi7pWsJxdf/B3Y7dAZahHaZF8mEJp2vA8=
X-Forwarded-Encrypted: i=1; AJvYcCVYXR1M4kGfGy8C6kqm0OaNZm4+YU3mjjO/LJVVGYjeb7vUs3WXkRtML4DSxHz+gh5XCvF0bjg=@vger.kernel.org
X-Received: by 2002:a05:693c:2d82:b0:2b7:befe:373f with SMTP id 5a478bee46e88-2b7c88d5dd6mr1679742eec.27.1769788390895;
        Fri, 30 Jan 2026 07:53:10 -0800 (PST)
X-Received: by 2002:a05:693c:2d82:b0:2b7:befe:373f with SMTP id
 5a478bee46e88-2b7c88d5dd6mr1679726eec.27.1769788390443; Fri, 30 Jan 2026
 07:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130073055.1609162-1-alok.a.tiwari@oracle.com>
 <CAHLZf_vxzcOpavJ-rNUsmi3XQ-NAqmWBvy2MRgGb2A3iWFHFHw@mail.gmail.com>
 <c102db6f-c676-4bb9-a1ee-3a43b35e6290@oracle.com> <CANXQDtbG9cXkzAPoDF9p5sLon=4aOrKJQvojgbieyhQ=+8mWuA@mail.gmail.com>
 <c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
In-Reply-To: <c19fdbaf-e179-4bbd-b51e-4de154233776@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 30 Jan 2026 21:22:56 +0530
X-Gm-Features: AZwV_Qi8HAlH6Gf0xYKUyhxbzJzAh6Iv936TG7EJf7M4S-PA5NB34DRFBmmF_Us
Message-ID: <CANXQDtZWd2ii_k4E_uh7Xi02eAfbtwrwidLPw1DEDLdgV7+1xQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bng_en: fix misleading error message for generic
 firmware version
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Vikas Gupta <vikas.gupta@broadcom.com>, rajashekar.hudumula@broadcom.com, 
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000063363c06499cf81d"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255175-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B33FBC4E2
X-Rspamd-Action: no action

--00000000000063363c06499cf81d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 7:10=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 1/30/2026 6:36 PM, Bhargava Chenna Marreddy wrote:
> >> On 1/30/2026 2:05 PM, Vikas Gupta wrote:
> >>>>    drivers/net/ethernet/broadcom/bnge/bnge_devlink.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c b/dri=
vers/net/ethernet/broadcom/bnge/bnge_devlink.c
> >>>> index a987afebd64d..57db3caabcfb 100644
> >>>> --- a/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> >>>> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_devlink.c
> >>>> @@ -221,7 +221,7 @@ static int bnge_devlink_info_get(struct devlink =
*devlink,
> >>>>                                 DEVLINK_INFO_VERSION_GENERIC_FW, buf=
);
> >>>>           if (rc) {
> >>>>                   NL_SET_ERR_MSG_MOD(extack,
> >>>> -                                  "Failed to set roce firmware vers=
ion");
> >>>> +                                  "Failed to set generic firmware v=
ersion");
> >>> Thanks for fixing. I believe instead of generic, "Failed to set
> >>> firmware version"  is enough.
> >> ACK. will send v2.
> > Should this be a candidate for net with a Fixes tag?
>
> I am open to either approach. It does not break functionality, but the
> current message can be misleading so I am happy to tag it for net if you
> think it=E2=80=99s appropriate.

I think this should go to Net with a Fixes tag, curious if others have
a different take?

Thanks,
Bhargava Marreddy

>
> >
> > Thanks,
> > Bhargava Marreddy
>
> Thanks,
> Alok

--00000000000063363c06499cf81d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVdAYJKoZIhvcNAQcCoIIVZTCCFWECAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLhMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
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
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA3vDydn5NahgmRxYGhLInYbrfZA5bx1oL/8NuNKAPYPzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAxMzAxNTUzMTFaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCDsHVx
hjtLth52rBxVEfGszvjDtSbR0uT2mPdpwaKkbRqv05dIsSORhokeGe8ETXDpFyxtORizxSXrsJa9
NQl7FIzs8mBkgLU3rrMgZ2gG/egIMNu4iXNED+NovQ4J1c6L0gctRPpZfuxXS4WA9Y5Wld2+sgYk
inI02lukV3CSW66QAvFD1XBDLSuYFl75+RNxSrmHQ041yDeg/MJMLTERT8Vuh7dhXQo/j+nEXH1E
4vnwQQSYvBso2V74un0vlAWIpFmZUB+vU3r0uIQsP9/scpYsG+IcG7Md20VkrAbHELxRsyQRJUtq
G4bRGmkAsyQaxK2eiHpgyT7geA/gL/Ki
--00000000000063363c06499cf81d--

