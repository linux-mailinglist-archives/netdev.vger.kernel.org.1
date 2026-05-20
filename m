Return-Path: <netdev+bounces-289952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLDIMQfADWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:07:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60E58F503
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C15730B92F7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8013A6B7F;
	Wed, 20 May 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JCxYf0lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BA3783BB
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285116; cv=none; b=iFNxxjbE19la7t/Jtbt27R6XzGBiZ362xDclYNcSg0RYcAixcN37wTKReYfTsc5RYcWTYMV3CK7s2obAzSobRa0jhysVejw9POgUj8/qcm8FsqtxFjE6qpJdCbhQfAcJ7uFbimeuZ7aDZws9Gg3vonWtEkRmKEwpwefpKI/EbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285116; c=relaxed/simple;
	bh=0QlGGlhVUgMc8cm8o1iB/D/AlyEj6BU7JrHB29rMGLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT3xb64kH+KC4N98xUJOfYbzaqTAITFs7DPj7Hw8BDzk6p+JqnH2bErU2kq7WBmD+PZW9BSzeZYmCHqZGAngj/3TgRDRjJN4j/GKUaHnWi7BpKm7Dopwx/hmqy84G7+mc2wuVzFp7vR+UDWY5ppPuwEjJsYbGntDT3vPdN7WN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JCxYf0lk; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-575602688deso1656838e0c.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285113; x=1779889913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNZHIEmXuo30UiFvrDlflR0Dr1Cll80JCqCyG6ZYpiU=;
        b=c2i036lVh1e/HasEZ8IbvCmAjnQcxaOScJnS1wckvzUg9BzWRplwXbnaoPRuwpNpit
         NCRDAagU6/4IHPp8yw8SLGY/vZ7Bn3GnKNeC/MU0zwTg1eQmkURL8g7XCfE+Hc2zFwpS
         4EuVrmSVR4mcehZGrlf9dPdvbzjZyTvm33wy5XwO1PblnAvXVmvvXMOsnGVYK4LP/ehI
         p+CGa/jadE88h5Z5aYRrZtWG6niy8XW2jp0eBz5dwEE7HbegRmhcCVEkwQWfUMzmG7IF
         HWYHasp182s9dXwYFlERZ4cv6Vw+mZ5iwuGQvk0lNLvaA/vV1zMT/mLqjZWXuekQnj5b
         8E+A==
X-Forwarded-Encrypted: i=1; AFNElJ92HZqY1ySGXwyNjpW3R8uqoWmoWjg5DpKt2roQptyIni9gf1AjJgF+4anxcDSpIjLO4Cd7BlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwAQIhLAORDAitQYlfZqWTOVbNO7A5SeBOfpDjCloaue4pdO0y
	l6clCoTC2IiZVlq33wrfhGfivK8FXoFTK2kdk7aX7CQKpapAoUrWt5Vb3Q+sQ2PUpLLmBDlzuzo
	3c4Q+vN7HqroZVQEsotHca1+KPiYCxOidMuTpDOk/mwutGto3dcpz1RJnzDaAXLssLNTdRv8KMG
	oaqSRmAdcxpkcen9FC5sum/xXHkK+MtLwa7RWUBZZq0sU+QJKqcr8ZUhbDgeaU5R5cpGvyXXhKB
	7XrEUwzrAe8tA==
X-Gm-Gg: Acq92OH6nrNW6/MecBA61ucyevhe269G01gBpsBo0K+mw1WIeZcUUqTdjIFY/P1mwSE
	4KgswPv7oRQqE6hKy7jgIv1gK4xdjtQp/ygH2AtH2Ggs+i/x/IzV0uAEmYkEurAz81dHf1eS+gd
	Ny6lAtyRbDcn+5O8gxlnUxmh+DcSNrnVn1agW+humPkc96hz5+EJnaP1SXJ6KruUotgOnoo4cOZ
	BYpP8PNfXC+I5U+Qje4Cmi/t72p2nvZhsNULNh0OU49PZUGJG0gS7T0QzE5KdgtQEVyNIXmTBo/
	E3KPlTjGNDI8esKwL+fZyeGRv59nmapvN9QM1MsyluO5twDx5e4RyvmQNScOmdqAEdESdyS9/Mt
	zPkL8KUhkqgh716z49O6avcMrGq/AOrUJJIWEO1COYYzXc2dTkSn9z6D9oB+pp8yQJE57mpuvFe
	hXbu8F8ZAgZrnYtXstkZDNPOU30kUilc6k1O86JhdEpwCUPhgWmQNqVM1h
X-Received: by 2002:a05:6102:945:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-63a3fb9434dmr11511436137.22.1779285112381;
        Wed, 20 May 2026 06:51:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63ce6910dadsm1095829137.17.2026.05.20.06.51.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 06:51:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-393adad635dso30535221fa.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779285110; x=1779889910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vNZHIEmXuo30UiFvrDlflR0Dr1Cll80JCqCyG6ZYpiU=;
        b=JCxYf0lk1KHctotTNA1klh1wZeI5xAT8JreqPUVEFtV6QT+WoZG1jOmvxDEJf+Q2F5
         MN8UozNmj876+GjhcXqGjmajz4E4H8QsEtUnKQVz63skwiMhOSm4keFCHYFyJM4hcUnk
         9EZBgs1y8XMKt1bie0oPv83CR47aV6E0SIUwg=
X-Forwarded-Encrypted: i=1; AFNElJ8Y3e2FnTKRJR35k8a5XYIEoYToDG7N37HCvsCBkxp7ZjH12a7uDZL/Pv0RAS213SPZkM0lbSI=@vger.kernel.org
X-Received: by 2002:a05:651c:987:b0:393:c254:20c6 with SMTP id 38308e7fff4ca-39561c04d52mr76572131fa.1.1779285110658;
        Wed, 20 May 2026 06:51:50 -0700 (PDT)
X-Received: by 2002:a05:651c:987:b0:393:c254:20c6 with SMTP id
 38308e7fff4ca-39561c04d52mr76572091fa.1.1779285110211; Wed, 20 May 2026
 06:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 20 May 2026 14:51:38 +0100
X-Gm-Features: AVHnY4Lj4twVB9bPJ2sY9gZT5RkqQB77iMFrkQTMYdpfgXCvej8miR3ijvgbEwc
Message-ID: <CAOuBmuZRxEMm=H6Xy3PWh1O5h30PV=jpQxHYXXCyZSJwf1GHsw@mail.gmail.com>
Subject: Re: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: pabeni@redhat.com, sgarzare@redhat.com, vishnu.dasa@broadcom.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fe91d70652401844"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan-bt.tan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 1F60E58F503
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000fe91d70652401844
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:23=E2=80=AFAM Minh Nguyen
<minhnguyen.080505@gmail.com> wrote:
>
> vmci_transport_recv_connecting_server() returned err =3D 0 for a peer
> RST in its default switch arm:
>
>         err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EI=
NVAL;
>
> That made vmci_transport_recv_listen() skip vsock_remove_pending(),
> leaving the pending socket on the listener's pending_links with
> sk_state =3D TCP_CLOSE while destroy: still dropped the explicit
> reference taken before schedule_delayed_work().
>
> One second later vsock_pending_work() observed is_pending=3Dtrue and
> performed full cleanup: vsock_remove_pending() then the two trailing
> sock_put(sk) calls -- the first reached refcount 0 and __sk_freed
> the socket, and the second wrote into the freed object:
>
>   BUG: KASAN: slab-use-after-free in refcount_warn_saturate
>   Write of size 4 at addr ffff88800b1cac80 by task kworker
>   Workqueue: events vsock_pending_work
>
> Treat peer RST like any other unexpected packet type (err =3D -EINVAL).
> All destroy: arms now return err < 0, so vmci_transport_recv_listen()
> removes pending from pending_links synchronously and
> vsock_pending_work() takes the is_pending=3Dfalse / !rejected branch,
> dropping only its own work reference.  This also closes the
> multi-packet race Sashiko reported on v2: pending is removed from
> the list before any subsequent packet can find it.
>
> The pre-existing sk_acceptq_removed() gap on the err < 0 path of
> vmci_transport_recv_listen() that Sashiko also noted is not
> introduced or changed by this patch.
>
> Tested on lts-6.12.79 with KASAN: 52/100 unpatched -> 0/100 patched.
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> v4:
>   - Resend as an independent thread per netdev workflow (v3 was
>     incorrectly posted in-reply-to the v2 thread).
>   - Drop the inline comment expansion; keep the original
>     /* Close and cleanup the connection. */.  No functional change.
>
> v3:
>   - Different approach to Sashiko/Paolo's "trading UAF for leak"
>     concern: normalize RST to err =3D -EINVAL so all destroy: arms
>     take the same err < 0 cleanup path -- no special case, no
>     multi-packet race.
>   - Sashiko's secondary observation ("while not introduced by this
>     patch, does this error path leak sk_ack_backlog slots on failed
>     handshakes?") is correct: the sk_acceptq_removed() gap on the
>     err < 0 branch of vmci_transport_recv_listen() is pre-existing
>     and is not introduced or changed by this patch.  A separate fix
>     for that gap is needed and would be welcome.
>
> v2: https://lore.kernel.org/netdev/20260512025851.189140-1-minhnguyen.080=
505@gmail.com/
>
> v1 was sent to security@kernel.org on 2026-05-10 (not on lore).
>
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Bryan Tan <bryan-bt.tan@broadcom.com>

>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 4296ca1..d257938 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1164,7 +1164,7 @@ vmci_transport_recv_connecting_server(struct sock *=
listener,
>                 /* Close and cleanup the connection. */
>                 vmci_transport_send_reset(pending, pkt);
>                 skerr =3D EPROTO;
> -               err =3D pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST ?=
 0 : -EINVAL;
> +               err =3D -EINVAL;
>                 goto destroy;
>         }
>
>
> base-commit: be48e5fe51a5864566307998286a699d6b986934
> --
> 2.54.0
>

--000000000000fe91d70652401844
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
ILDAnCmVZLW4gqfDqkJQ2XAvcDzjyPBluBCb9Ki10VFqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDEzNTE1MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACtO4bO5mdtGXpo9VpTfhSTcqwJ6ZtIDQSaY
a2Nvy4Zlix0lSWnGJ4iOC17fQlDz5e9Ovud7MDGyau4YNXpEsOvIzftmDAK5JKcIfN9PBo2eWAr/
tOil2FiAgjbVdi6xXNhrhnwr6YAHDcNBoVAzrKtm1pU3DW/RK+Gbg4iWfEGRKUt6PzGHvJyL6Xhm
jAarTfCbh2yuH6fUCKJ1VEMXRUE9+6u63YP4CQ+WdUMsWIl8JP1/mzM3mxoOrJ+H9CGTIzpYuE2e
IzhoimY/suvx1eBvZGzeYcXBx3IEX1i9rMQtguFKICIfpPqHnlO7qzjHlS5xf2yn/lLtvRFR46a3
/Gw=
--000000000000fe91d70652401844--

