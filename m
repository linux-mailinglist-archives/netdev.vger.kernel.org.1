Return-Path: <netdev+bounces-23467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57776C0D9
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 01:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88D1C210F2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A6125C0;
	Tue,  1 Aug 2023 23:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24A440C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:27:36 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78BCB4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:27:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76c97a137c8so17010285a.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690932451; x=1691537251;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46xBz2XWnnCy9KtNarW0gV1XMa27yiLoe1nyJLtxDhc=;
        b=OGWufqJhoR5w5FqYA6TaU8ac2vBu6pxzCFNfaGEnWTQbQ6SQm5crcQwVo/pRDZQrz4
         6C9oD6B9AIddRgfRJwPBYsRSyZd5Gv2Mwy1jsUNaLUY6fg8Lug+QefPLRMS3bTH8R2ZP
         2cIMI3wDsflrmmk0rNB4ogYN11U5pI6YMEHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932451; x=1691537251;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46xBz2XWnnCy9KtNarW0gV1XMa27yiLoe1nyJLtxDhc=;
        b=BGLqLUxxQCUFafYoQeBtT3g9rF37cg9IJy4zjtxUaHDc/jQhlHRhGH0FgF2RTirf5Q
         VC6eZEWPrYGtnq5i0s2UV+s3O9E0WgHtqVBYksNuaBwN7+/sbXoimuFeNfzeeQ/aobbi
         43ZGAA76Apn4qvWf7EZBcvoWGaZO0U/giQTEO5KGR6K7hPBbbo1/xe3sJFedgt7Y3JIN
         K0UicsGWF1lKj/SY6K9mjmfUoZKBml5PWaepXri815cdTjC4aWt1xfn2zgsmJszio0Ns
         lX2Gy0KJ8XeZ1fUoXFmjtok300uyrsDkMt3YHXAO/nw7i/VcJ58TiklhhaAuQEzmGC6u
         GKBg==
X-Gm-Message-State: ABy/qLbSPRCjJ7JsPpBknmdKjZk4dHu4MoR20S5p5EFE7f9AKLsr+vEQ
	Dwj2xSh6+8qy8r7VOaFgcyQhgA==
X-Google-Smtp-Source: APBJJlFUmnVHdr50yZl9APmjzOJ8eoviFc0RxiNCw99msi6Kmtpy70Y/X/S14Z8rkjlUdv2ERjctmg==
X-Received: by 2002:a05:620a:31a4:b0:76c:baeb:7ed7 with SMTP id bi36-20020a05620a31a400b0076cbaeb7ed7mr6326606qkb.0.1690932450829;
        Tue, 01 Aug 2023 16:27:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a134300b00762f37b206dsm3649302qkl.81.2023.08.01.16.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 16:27:30 -0700 (PDT)
Message-ID: <8b4b8f65-b536-2036-f946-bae55a34bce4@broadcom.com>
Date: Tue, 1 Aug 2023 16:27:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Jumbo frames on Broadcom Genet network hardware
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Doug Berger <opendmb@gmail.com>
Cc: netdev@vger.kernel.org
References: <CAPY8ntBEsfUhE7wHR7dOXh0=LiZkM0uBR9KxsmUspH2CAobtUg@mail.gmail.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <CAPY8ntBEsfUhE7wHR7dOXh0=LiZkM0uBR9KxsmUspH2CAobtUg@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001757580601e4e491"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000001757580601e4e491
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dave,

On 7/14/23 10:02, Dave Stevenson wrote:
> Hi Doug, Florian, and everyone else.
> 
> At Raspberry Pi we've had a few queries about enabling jumbo frames on
> Pi4 (BCM2711), which uses the Genet network IP (V5).

We have had quite a few inquiries through direct emails so there does 
appear to be interest in supporting Jumbo frames indeed.

> 
> I've had a look through and can increase the buffer sizes
> appropriately, but it seems that we get the notification of the packet
> whenever the threshold defined in GENET_0_RBUF_PKT_RDY_THLD is hit.
> The status block appears to be written at this point, so we end up
> dropping the packet because the driver believes it is fragmented (SOP
> but not EOP set [1]), and presumably any checksum offload is from that
> point in the frame too.
> Setting RBUF_PKT_RDY_THLD to 0xF0 (units of 16bytes) allows for 3840
> byte buffers plus the 64byte status block, and that all seems to work.
> (My hacking is available at [2])
> 
> Is this the right way to support jumbo frames on genet, or is there a
> better approach? It appears that you can configure the buffers to be
> up to 16kB, but I don't see how that is useful if you can't get beyond
> 3840 bytes sensibly before status blocks are written and the host CPU
> notified.

About 10 years ago is the last time I tried to implement Jumbo frames 
with GENET and at the time I only raised the Unimac maximum frame length 
register and would get an Ethernet frame that is fragmented with a 
SOF=1,EOF=0 initial buffer, multiple SOF=0,EOF=0 buffers, and a final 
SOF=0,EOF=1 buffer. This was the best I could achieve at the time.

> 
> Others have reported that before the status blocks were always enabled
> [3] then larger buffer sizes worked without changing the value in
> PKT_RDY_THLD. I haven't managed to reproduce that. They were also
> hacking global defines to allow selection of larger MTUs, so I
> wouldn't like to say if they broke anything else in the process, and
> it was also quite a long time ago (pre 5.6).

Yes, I have seen those hacks, and they do not look too good. Let me dig 
up the little hardware documentation I have left and see whether we can 
come up with proper 9000 bytes Ethernet frames without too much hacking 
around.

> 
> Many thanks in advance.
>    Dave
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/genet/bcmgenet.c#L2324
> [2] https://github.com/6by9/linux/tree/rpi-6.4.y-genet/drivers/net/ethernet/broadcom/genet
> [3] https://github.com/torvalds/linux/commit/9a9ba2a4aaaa4e75a5f118b8ab642a55c34f95cb

-- 
Florian


--0000000000001757580601e4e491
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHw4lYNVM/zDchPn
fq+v7gtHV7VarQNPran1WkevHLeMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDgwMTIzMjczMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBNxB7xNLVkkRcpU8MpIwAmVQdj9oANSvX9
d5UYZ5eCl4ElJuRG4aTl5TRD/CD2KVrqK2wyDDeKkZtjXDVDNs+dZKiwJtJqERfPUtZb1dD4g4hx
Lfc0YR2DYRJa/ncdoQ4LUYvoxcEO/8IbTnvO9YfcYYmeyLjfWy3A12V70OjqE6NXVFCIyblln1nC
zukaRYB2enS3qsVdmg/I9DM90+j4Wv2S27wK+5QSikybUeaCCZ9ljateTweCz31d+myPqWhsTbGD
ik/PxcZTOwt/NvfqbJt9lDx5Srt/zZNA3UMW77hyusVyGwu/pNrNiBu73mUF8SAl448YvQCy4MlO
rfri
--0000000000001757580601e4e491--

