Return-Path: <netdev+bounces-289954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIxAMhK+DWrH2wUAu9opvQ
	(envelope-from <netdev+bounces-289954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C158F309
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 981C430216E1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072143D1CC6;
	Wed, 20 May 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fmpluZcN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F47344DA4
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285322; cv=none; b=kigjDWrq8Vp2JMHBCogHy8/onkyS250wilCgpoRQd76SzmEPZTdTDZIIAoaWtpRba5B0LKgywarVjhwY1s1hho2bFrP/thu2r0K6OsMR8Mbns7KlnNuZUgcwyEhJ/9LVqJvIy+Wm3iOjsi2kizx2MZwmgLTsPxRtJeNL4PoKtrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285322; c=relaxed/simple;
	bh=Q9HFyvJduxNCY+fQIqwpjhtE9eL/qFnJOESX0LB8SHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWGK3ouCASHICVZWXgImzxxzwcxayDU0Q+BPpsmekGmTiGwXEMhg/hlxiv5WMltGQBJPYBxkzHdtihunq7DiWq9mWhLmfAPB5uHa1lkzal/I9xHd9XsEXEQQR3bVW+hPxEziJCHnFh8131oL7BOX80eYXL0Jk1xvDBh9Yi/5WTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fmpluZcN; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso55176526d6.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285320; x=1779890120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYW16x8A4gwowZHTfzIg0hhsjp/1freb/UcO0f9Cd9c=;
        b=CXMoNAKhBpTk4rlMPUc9s3AN7Zaix58E6cz/FSBSv1x1QdYRxSwh2R+Jqgxs5mfyqD
         WsYf/md7yfeAOl/yrcIqE0RwEevd8ZBZt/uIMPVT2jSEnPWOnztqNdFpSvEDc2Udvml7
         3X/OATvB7eaatMvylw03iHsiXmvLjDMUJt6FzbWcudYfK6PT+fmUfAs21b8Jm9WHg7bC
         WGlLNxjdWEYjuqS4xHVCzuGbXacBNLdKEMRTveGO7lKcwUpnJ827Pnz2yZ4VcIBbT/m6
         bQVvidaPE21EqOsAJ7sxusmaWdkSb9o67TYc5issA5i8+F/tU23XyGkNq+6UB7teNtNG
         kcgQ==
X-Forwarded-Encrypted: i=1; AFNElJ81y2JwDpW2g1HohswmKG2xUirO4fFIcM6Yy7WgZsAaBgNve+mD4BEVtF+o7uYwmV2Xy+bTibk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTbxdZTJaU4Bos2zGOpJtTZ5STCelsR+Jryv90PziKsS4zuQk
	LklwZKk7Hgmi9ENe1wFYIUR6IhnY4khICjg3z2K0BRLWzLktXPu8HXKDpFdX42w++0wsjUP6fXB
	vUS2Mih3oPW//tjHQBVXIesaNBC7AD5TibKC1MjUnc4C/swOLijBNsePW2yVWV10TctT7EzuN4K
	5Vif+f0/AdtDojv9NpqMM4WZlS5uwIf1luGZ/30SO9mfsnd8BryNNtcOCECLF4ZYt/NRRvrsKNG
	0eL4CuDTugTyQ==
X-Gm-Gg: Acq92OFhF84VKrScun6DzPL5+v2/euElcMaoBtCrg7ayhlofP6Sv0tkNNbBjIm6DViU
	p5N6G+uHc/8IC6U6ONPpoIb6ijJlwtCoxFUt+Jyt18Y9+wu2a9obaYPQ6y4L8CfNYM4oiTY7o95
	s+HHPFdc6+SO+j/NEFu/NMIj51geQic6xjoes0z3njZ67dk9VxjcGQseiMmaI2PDKdCFJrVmZMm
	Inx3JMidKM2RKX815pdzsoLVjyUJwGomcZxBYVsRPJtEye4tRm3B2PyMMxuDpPBdFIv4IUCFMlf
	kR06PYPJfACFuFlE5VcGy6FhRg1FyV4iSiwwwsbd14UibVkjaJpdG6Ae+xaGmHk9Q5Ozrxwz9m6
	+/OtqjuxKHJpe9Y+ED0VHpMRFdpfAv533bcw3rtvz/PyCcrwZzeFYUocUn/yOiTXlguYH95N9uo
	6BNPEYCakp2D2WJt/y+ohG5WdQ9AOyFgpY5OeHmfD6UqBbqbI8skhi1vLcrRk=
X-Received: by 2002:a05:6214:3214:b0:8cc:51b7:dbb3 with SMTP id 6a1803df08f44-8cc51b7dce9mr5618556d6.8.1779285320119;
        Wed, 20 May 2026 06:55:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ca36092534sm10340106d6.10.2026.05.20.06.55.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 06:55:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38e83f0482eso18190691fa.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779285318; x=1779890118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DYW16x8A4gwowZHTfzIg0hhsjp/1freb/UcO0f9Cd9c=;
        b=fmpluZcN5SHuy5zNWVlShjz40Z7Sc/J4w0gxOeZWH89NgOCPjh77+LZyVcGj+A4rhN
         7+kueG2efu8MFPRUljDnVhlgrdTcov0rkv679agg/qL+oiBwtsKDhpGmGFfKsmftssWa
         0TZWqyaYpvaA45zhCEJsznxbFIFaKI9Q5RFLc=
X-Forwarded-Encrypted: i=1; AFNElJ99cRPqAvWhFz8KcsJrFQ3RvMNjOqpryFFExkqoJrfeVomFXdAoorchXqJzjW9SNXgfdD7fEMs=@vger.kernel.org
X-Received: by 2002:a05:651c:1ca:b0:38f:e9fa:266 with SMTP id 38308e7fff4ca-39561fcff2bmr75940781fa.31.1779285318289;
        Wed, 20 May 2026 06:55:18 -0700 (PDT)
X-Received: by 2002:a05:651c:1ca:b0:38f:e9fa:266 with SMTP id
 38308e7fff4ca-39561fcff2bmr75940671fa.31.1779285317872; Wed, 20 May 2026
 06:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512025851.189140-1-minhnguyen.080505@gmail.com>
 <3518e2b5-b669-4aaa-82ca-bbf479a85889@redhat.com> <agwv3YkxYIC7mvyj@sgarzare-redhat>
In-Reply-To: <agwv3YkxYIC7mvyj@sgarzare-redhat>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Wed, 20 May 2026 14:55:06 +0100
X-Gm-Features: AVHnY4KsOadhFPqTYhanc42rDQzi3pOOICpPN-4w7jVbe_h0wb-2f4c0V8ZyS9w
Message-ID: <CAOuBmubrJNFODWq05bzXKWi1GV=UZd2LCrJqMaVuTxUuv_9cNA@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/vmci: fix UAF when peer resets connection
 during handshake
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Minh Nguyen <minhnguyen.080505@gmail.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f05d1065240250b"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289954-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,broadcom.com,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan-bt.tan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 002C158F309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000005f05d1065240250b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 10:41=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, May 14, 2026 at 03:26:28PM +0200, Paolo Abeni wrote:
> >On 5/12/26 4:58 AM, Minh Nguyen wrote:
> >> vmci_transport_recv_connecting_server() jumps to its destroy: label
> >> and performs an unconditional sock_put(pending) to release the
> >> explicit sock_hold() taken by vmci_transport_recv_listen() before
> >> schedule_delayed_work().  The existing comment claimed this was safe
> >> because the listen handler removes pending from the pending list on
> >> the way out, which would prevent vsock_pending_work() from dropping
> >> the same reference later.
> >
>
> [...]
>
> >Sashiko says:
> >
> >---
> >Could this change lead to a socket memory leak if another packet arrives
> >before vsock_pending_work() executes?
> >If a peer RST is received (err =3D=3D 0), the socket stays on the
> >pending_links list with its state set to TCP_CLOSE, and the base
> >reference is kept.
> >If the peer then sends another packet (such as another RST) within the
> >delay window before vsock_pending_work() runs,
> >vmci_transport_get_pending() might find this same socket.
> >Since its state is TCP_CLOSE, vmci_transport_recv_listen() would hit the
> >default switch case, set err =3D -EINVAL, and call vsock_remove_pending(=
).
> >This removes the socket from the list and drops the list reference, but
> >it bypasses vmci_transport_recv_connecting_server(), meaning the base
> >reference is never dropped.
> >When vsock_pending_work() runs later, vsock_is_pending() evaluates to fa=
lse.
> >This sets cleanup =3D false and bypasses the sock_put(sk) call, leaking
> >the pending socket.
> >While not introduced by this patch, does this error path leak
> >sk_ack_backlog slots on failed handshakes?
> >If a handshake fails due to an error, vmci_transport_recv_listen()
> >handles it by calling vsock_remove_pending(). This removes the socket
> >from the pending_links list but does not call sk_acceptq_removed(sk).
> >When vsock_pending_work() runs later, vsock_is_pending() evaluates to
> >false because the socket is no longer in the list. This causes the work
> >function to skip its own sk_acceptq_removed(listener) call, meaning the
> >listener's sk_ack_backlog is never decremented.
> >---
> >
> >it looks like the above is trading an UaF for a leak ?!?
> >
>
> @Minh @Bryan can you check this report?
> It seems a real issue, so the patch was not applied.

Thanks Paolo, Sashiko. We'll fix the sk_ack_backlog handling.

>
> Thanks,
> Stefano
>

--0000000000005f05d1065240250b
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
IIcJTSXBXmaeflizD0q3fLuqRVGEesY8/RkiNFQKdtlOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUyMDEzNTUxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADCVo1r9kvwsczkt0fKHfT14SuEiyikqdNFA
FxDPJmGChJYpH4+dLFFpYAIgblbO7JvUJWSHRZtDaY+mcP4xQCFurBqY/bnmIIW1AUwdy3OFPeNH
kttqPLrvYw15FipUFkzgv7+o3PZ7JIJT+4KJVraarsYTjzJo3Oxzdb555jZ7qQ+zJX6y8mW//+N6
HoKk5sznuBweHcVEJhcq3DF0qEWhtQncOXeblCI6v7CcS4eKQJPcr/ntIZ95KO1qjOxNwl0m8yx+
QtII5MyZHhk10r3fjTtrE6wpKgqazuKvoJ+5buPwJtGepohZ0xJqH8s2mUz4xSS1ivXTKm229zEm
z7g=
--0000000000005f05d1065240250b--

