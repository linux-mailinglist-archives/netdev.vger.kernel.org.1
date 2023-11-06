Return-Path: <netdev+bounces-46137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9517E1942
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 04:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9314628129B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B595139D;
	Mon,  6 Nov 2023 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L2inK74V"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF59441C
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 03:50:18 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB2FB
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:50:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507cee17b00so5107733e87.2
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 19:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699242614; x=1699847414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPRoed9/z+EmTEGNdvgePBCLPyOkBm1UgwR3yBhWuXw=;
        b=L2inK74VOyONj03f7N5S+JD8FkFGoNm2EaYArSld5bCw/SM7dtIiUCy0Qez3y24QZw
         qsWxQ0j1mko5hA7zmLTzELIJpf0NvHhrdUvK8QJ0gdJ/HPGlMw3b1XfahhtJvQpldv9S
         NAhddGddOoELIXvIs3bQh/MSa0ddkLEZqUkBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699242614; x=1699847414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPRoed9/z+EmTEGNdvgePBCLPyOkBm1UgwR3yBhWuXw=;
        b=CdvXQc7ivxxHV0nt8sPe7z6BkDjtzJ5L+Crv7SUS+lzRYkAVcsR3vZgfndk5drEhUT
         FnkiZSWyaYNjQbcKz5ieCZ4tzOrsAZHq0W6FcSCIEXl2MJ9/sZvCbXa1JjeSbpKGFsmh
         +RLgAurj1wao/u1Z1keWekPURp9+Ya330K7ZLxg01rvJurSu/TUoq4TdXg4K8hieT1+A
         EUdPO/AorDEDJvwW0pweyetqealD9kQpDCIi1kUfIpqYBf8vGY+0P/vPTV5PLbsQ++P9
         g2YZwjm3T72osu3uAa1kZFcPhIMwcUHIJZLz/Z5WYAgxboptuQ3RrxuRNiKYKsdiF79T
         geQQ==
X-Gm-Message-State: AOJu0YwJ+0aiaVcJBLVTLXvoSrrIVm3WohTizC2TPX6GUSkYmdKfze76
	myabAhHjibGV45WaM91Oxms+6+lFvPwcC1VHKRJ5kw==
X-Google-Smtp-Source: AGHT+IEeHFiFkJ02s24JiKTQ50Sv6sCN2Sh6A/yN+4UfB80ZixwWngyP9tyzhUD9jdB2ZudmqFuK26hrl200nNua7sM=
X-Received: by 2002:a05:6512:3c98:b0:509:493a:7d64 with SMTP id
 h24-20020a0565123c9800b00509493a7d64mr10530401lfv.41.1699242613482; Sun, 05
 Nov 2023 19:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105185828.287004-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231105185828.287004-1-alexey.pakhunov@spacex.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 5 Nov 2023 19:50:01 -0800
Message-ID: <CACKFLikZgXQLnSN95vQgzZqmFisrxUvKiqF78RYcMAA2BE+6Zg@mail.gmail.com>
Subject: Re: [PATCH v3] tg3: Fix the TX ring stall
To: alexey.pakhunov@spacex.com
Cc: mchan@broadcom.com, vincent.wong2@spacex.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065ea96060973c0d9"

--00000000000065ea96060973c0d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 10:58=E2=80=AFAM <alexey.pakhunov@spacex.com> wrote:
>
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
>
> The TX ring maintained by the tg3 driver can end up in the state, when it
> has packets queued for sending but the NIC hardware is not informed, so n=
o
> progress is made. This leads to a multi-second interruption in network
> traffic followed by dev_watchdog() firing and resetting the queue.
>
> The specific sequence of steps is:
>
> 1. tg3_start_xmit() is called at least once and queues packet(s) without
>    updating tnapi->prodmbox (netdev_xmit_more() returns true)
> 2. tg3_start_xmit() is called with an SKB which causes tg3_tso_bug() to b=
e
>    called.
> 3. tg3_tso_bug() determines that the SKB is too large, ...
>
>         if (unlikely(tg3_tx_avail(tnapi) <=3D frag_cnt_est)) {
>
>    ... stops the queue, and returns NETDEV_TX_BUSY:
>
>         netif_tx_stop_queue(txq);
>         ...
>         if (tg3_tx_avail(tnapi) <=3D frag_cnt_est)
>                 return NETDEV_TX_BUSY;
>
> 4. Since all tg3_tso_bug() call sites directly return, the code updating
>    tnapi->prodmbox is skipped.
>
> 5. The queue is stuck now. tg3_start_xmit() is not called while the queue
>    is stopped. The NIC is not processing new packets because
>    tnapi->prodmbox wasn't updated. tg3_tx() is not called by
>    tg3_poll_work() because the all TX descriptions that could be freed ha=
s
>    been freed:
>
>         /* run TX completion thread */
>         if (tnapi->hw_status->idx[0].tx_consumer !=3D tnapi->tx_cons) {
>                 tg3_tx(tnapi);
>
> 6. Eventually, dev_watchdog() fires triggering a reset of the queue.
>
> This fix makes sure that the tnapi->prodmbox update happens regardless of
> the reason tg3_start_xmit() returned.
>
> Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
> Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
> ---
> v3: Split "Fix the TX ring stall" into a standalone patch. No code change=
s from v2.
> v2: https://lore.kernel.org/netdev/CACKFLi=3DZLAb1Y92LwvqjOGPCuinka7qbHwD=
P2pkG4-_a7DMorQ@mail.gmail.com/T/#t
>     - Sort the local variables in tg3_start_xmit() in the RCS order
> v1: https://lore.kernel.org/netdev/20231101191858.2611154-1-alexey.pakhun=
ov@spacex.com/T/#t
> ---

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--00000000000065ea96060973c0d9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIeR4IkblsdCXwkOaMnP5mADZRG0IHuq
TO/MtJHixfnkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
NjAzNTAxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBdN5ihyNk58Vmzdw+aHkcfOutGtV7iNCT1oj9l8L+PYRKPgW+n
wOtAhmrdaeY3vOGYzpKISDdtEsxIkcnVz8C+DvsbFWPC9ImDe5FlRlfimyT0xmQKk0VxGHz4oZ3D
rV3UV1FuLPPdTD2ylNtF8oCTKQTfQ3K5jL7KYqL2lnmmSn1oWZ51Qn9ht54sC+9YlKfAGTtZC8iv
fFduJ37oW2urJG4UwDY8+94v0vK0h+pHU4SpqIUn5t4lyrjOFmIIH6vX78NY2mYqLGGTz/nJeVOW
7QdEx0SLjOlsubVepxNUdtr8UBp06YkgxuxxGgEGoPFbYhk5jZdqD59XTAPYoBH8
--00000000000065ea96060973c0d9--

