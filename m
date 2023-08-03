Return-Path: <netdev+bounces-23954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055076E485
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3831C2143E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77436156D9;
	Thu,  3 Aug 2023 09:35:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A37E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 09:35:40 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F69422F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 02:35:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bf1f632b8so110080466b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691055333; x=1691660133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0662WPCeMDDF3xPJaNrr1MYOOK6rcGleUQyZEC0s0N4=;
        b=TYLnuCZ2oIsdjcwg3xnOB5OgS+HqhHnLrkYWzRc/nTGaZKQnH44a3Oj2NKRo0Ygq7C
         M45bmS4tJC04k2AFVARC6kpxP+tT4x7XizlDJLMeCVI+zsxJ51Vdzw6+3kaCoSOI07ic
         QWGA8hzb89SA4FvHR3raf13lafENVa9a1zI4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055333; x=1691660133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0662WPCeMDDF3xPJaNrr1MYOOK6rcGleUQyZEC0s0N4=;
        b=BHQuCdDbRg8QfARDeKnU/92l0z8qoC2NeAH6G2Vgb6Rzzk5u/VLJ00UvJi6QjN//3g
         1kjSkYlqTTgTJfzAsM3aOYgZL1tAnnwSjevgxPKgUfVc6kHalTyuGSv8Mi55mKCNw6TB
         +Pwh8rVq63QesohItsLndZ44eoYUkNO739BS8T+qFqhL/I8Vc1OKuhImTJyH5rPMHIqH
         DHQwoxMKedUFHFFYF2zy7Ja7FDaZTd44ojgPBDb6vogq+TMF8Gp4WABvNoI1O3fcmKrm
         SFNbAMSekESaG0IJIXpda5vkxA+bu7tEyodDkWfLOLpagKRSyz+7xz4KEXQDZM/rUdM2
         Lckw==
X-Gm-Message-State: ABy/qLbLmCTzHk+pdTOThVxLbCdi5bJHTJJK9k/BDriv0sur8SUNNv7h
	8ooGD8K4FmiTXYYxqVb+GAw64sGkUZYA8lxjf3Si6g==
X-Google-Smtp-Source: APBJJlFSfdVRy0hHcpiVzkuLDNgczzajEvq+dnRLFZadMxZFSxk6FYd+yTBovir9G0GLmJszHA0oHtG7DeRyhTaappQ=
X-Received: by 2002:a17:906:cc55:b0:99b:ebf9:90f2 with SMTP id
 mm21-20020a170906cc5500b0099bebf990f2mr7236482ejb.45.1691055333553; Thu, 03
 Aug 2023 02:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802161821.3621985-1-kuba@kernel.org> <20230802161821.3621985-2-kuba@kernel.org>
In-Reply-To: <20230802161821.3621985-2-kuba@kernel.org>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Thu, 3 Aug 2023 15:05:21 +0530
Message-ID: <CAOBf=mtcy7rP0HZru7qSaafzg3QBXgT1DcRUXgEqnc2n1gcaGw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] docs: net: page_pool: document
 PP_FLAG_DMA_SYNC_DEV parameters
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, aleksander.lobakin@intel.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	Michael Chan <michael.chan@broadcom.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000781f6d060201808d"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000781f6d060201808d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 2, 2023 at 10:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Using PP_FLAG_DMA_SYNC_DEV is a bit confusing. It was perhaps
> more obvious when it was introduced but the page pool use
> has grown beyond XDP and beyond packet-per-page so now
> making the heads and tails out of this feature is not
> trivial.
>
> Obviously making the API more user friendly would be
> a better fix, but until someone steps up to do that
> let's at least document what the parameters are.
>
> Relevant discussion in the first Link.
>
> Link: https://lore.kernel.org/all/20230731114427.0da1f73b@kernel.org/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - s/sync'/sync/ and other fixes from Randy
> v1: https://lore.kernel.org/all/20230801203124.980703-1-kuba@kernel.org/
>
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> CC: Michael Chan <michael.chan@broadcom.com>
> CC: Lorenzo Bianconi <lorenzo@kernel.org>
> CC: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/networking/page_pool.rst | 34 ++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/Documentation/networking/page_pool.rst b/Documentation/netwo=
rking/page_pool.rst
> index 0aa850cf4447..eb96a592ec6b 100644
> --- a/Documentation/networking/page_pool.rst
> +++ b/Documentation/networking/page_pool.rst
> @@ -109,6 +109,40 @@ a page will cause no race conditions is enough.
>    caller can then report those stats to the user (perhaps via ethtool,
>    debugfs, etc.). See below for an example usage of this API.
>
> +DMA sync
> +--------
> +Driver is always responsible for syncing the pages for the CPU.
> +Drivers may choose to take care of syncing for the device as well
> +or set the ``PP_FLAG_DMA_SYNC_DEV`` flag to request that pages
> +allocated from the page pool are already synced for the device.
> +
> +If ``PP_FLAG_DMA_SYNC_DEV`` is set, the driver must inform the core what=
 portion
> +of the buffer has to be synced. This allows the core to avoid syncing th=
e entire
> +page when the drivers knows that the device only accessed a portion of t=
he page.
> +
> +Most drivers will reserve headroom in front of the frame. This part
> +of the buffer is not touched by the device, so to avoid syncing
> +it drivers can set the ``offset`` field in struct page_pool_params
> +appropriately.
> +
> +For pages recycled on the XDP xmit and skb paths the page pool will
> +use the ``max_len`` member of struct page_pool_params to decide how
> +much of the page needs to be synced (starting at ``offset``).
> +When directly freeing pages in the driver (page_pool_put_page())
> +the ``dma_sync_size`` argument specifies how much of the buffer needs
> +to be synced.
> +
> +If in doubt set ``offset`` to 0, ``max_len`` to ``PAGE_SIZE`` and
> +pass -1 as ``dma_sync_size``. That combination of arguments is always
> +correct.
> +
> +Note that the syncing parameters are for the entire page.
> +This is important to remember when using fragments (``PP_FLAG_PAGE_FRAG`=
`),
> +where allocated buffers may be smaller than a full page.
> +Unless the driver author really understands page pool internals
> +it's recommended to always use ``offset =3D 0``, ``max_len =3D PAGE_SIZE=
``
> +with fragmented page pools.
> +
>  Stats API and structures
>  ------------------------
>  If the kernel is configured with ``CONFIG_PAGE_POOL_STATS=3Dy``, the API
> --
> 2.41.0
>
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--000000000000781f6d060201808d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBBxrfznzBUXHXy/+HSnnNN99E5a
/hryS8yZWMRFUMd3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDgwMzA5MzUzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAsbK1K4hlX+Xqt1w6TzcWe4W0amYez0Uko/o1vj/eUghno
Ofdx++9EcBPaDDQh138rB0oSKqAnKj0X6qOZA9LD1EQhMQeK4wuTZ0isLFLVEpwKzC1/y6iVIpCv
X7zACH0FYkFkdmdGiWZ+Z7e4ewdFrcSOpfCjWBN+aaVdfW+sXUvtVkT8zP5nnbKbetntoKaUiAQI
Jf/jBE9i5SHC5vodmILhcEKK9F4o9U5ljcoaZDZPvbz4rA6Dxh78oKpBt6scfRkx1XYiWCUqX3bl
yO9Xp2fYwYogwBqlS/WhZ8AJTfT3donfeINFi171hAyTmTkTPoNz0CRS1cLB28smr36M
--000000000000781f6d060201808d--

