Return-Path: <netdev+bounces-24113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4676ED1A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1A281FC4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114791ED4F;
	Thu,  3 Aug 2023 14:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C401ED4A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:47:30 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567554486
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:47:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so1358472a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691074023; x=1691678823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxipnLtqVUKoWWcohpI5k8sBVt55SuMlyUa48pm+jy0=;
        b=c0hhME9iX1Vktk1Ltsm+O1vHEIVObpdV7/AZ5XiyXXcwhoCi/fjlsHeKIK8X2FaNK+
         PXokgGfmJrAKGaFxn83mA7O6OSsMYirxR0PW6D0c3wjgKaprWAvuKNxpKdgL/R2lzZ7+
         rAxUZLe7Ld+PbbCgnXoJoBQAaNQQFIMvZs+UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691074023; x=1691678823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxipnLtqVUKoWWcohpI5k8sBVt55SuMlyUa48pm+jy0=;
        b=aiTgEwRmwgAT8ANI0kJj3UVN8tBY/cgEjDB0ubH5DltAChAfnDeQZXDCichL+yveUt
         vbSS5llNE3aKTtJat/QORs9/1qXlWSFi/ZgPZ32TScpwoXtaq538OanSXRTN+iiZ7IML
         jXiQjLR5eE8vuehGkD30923rTDAQHAS9LqFAJVgT4AGNAzdcfpGvv2ETKpE3YODl3hOA
         Raxjg7kitP862S99QtEwq1R/P4nFsk8rzChRwETFQfHSyN2Fq85lhEC7DZCA7NXAK5mf
         cpKbI4upgB0oOYVGgKESlDnwiDuqwejlUzcLIXIvQQtegYeGv75tAJ893Ey/2vcZTt9R
         N8dw==
X-Gm-Message-State: ABy/qLbmWjVrw38EsagB8zsgnaVngOOkX/0Gu9yTD6SS38UEi3IUAQ4O
	GJ2JnnfZtrjgYqyz7/HLdK598hBoHRg21tbC4SYpEw==
X-Google-Smtp-Source: APBJJlG4Uof0yi+nwhfvap6PZJWxPfhvI0VnFh/NmqGga6GZzcjyfw4vulcqT3V+mdWYxAlm/YMI4iIYjU4f7ek7YpM=
X-Received: by 2002:aa7:d48b:0:b0:522:580f:8c75 with SMTP id
 b11-20020aa7d48b000000b00522580f8c75mr7645476edr.17.1691074022967; Thu, 03
 Aug 2023 07:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230727190726.1859515-1-kuba@kernel.org> <20230727190726.1859515-2-kuba@kernel.org>
 <58c12dc4-87e2-5c91-5744-27777acfa631@embeddedor.com> <20230803072123.1fbd56db@kernel.org>
In-Reply-To: <20230803072123.1fbd56db@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 3 Aug 2023 07:46:50 -0700
Message-ID: <CACKFLinikvXmKcxr4kjWO9TPYxTd2cb5agT1j=w9Qyj5-24s5A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] eth: bnxt: fix one of the W=1 warnings about
 fortified memcpy()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000076b94e060205da97"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000076b94e060205da97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 3, 2023 at 7:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 3 Aug 2023 07:08:13 -0600 Gustavo A. R. Silva wrote:
> > In function 'fortify_memcpy_chk',
> >      inlined from 'bnxt_hwrm_queue_cos2bw_qcfg' at drivers/net/ethernet=
/broadcom/bnxt/bnxt_dcb.c:165:3:
> > include/linux/fortify-string.h:592:25: warning: call to '__read_overflo=
w2_field' declared with attribute warning: detected read beyond size of fie=
ld (2nd
> > parameter); maybe use struct_group()? [-Wattribute-warning]
> >    592 |                         __read_overflow2_field(q_size_field, s=
ize);
> >        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> >
> > Here is a potential fix for that:
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt_dcb.c
> > index 31f85f3e2364..e2390d73b3f0 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
> > @@ -144,7 +144,7 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt =
*bp, struct ieee_ets *ets)
> >          struct hwrm_queue_cos2bw_qcfg_output *resp;
> >          struct hwrm_queue_cos2bw_qcfg_input *req;
> >          struct bnxt_cos2bw_cfg cos2bw;
> > -       void *data;
> > +       struct bnxt_cos2bw_cfg *data;
> >          int rc, i;
> >
> >          rc =3D hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_QCFG);
> > @@ -158,11 +158,11 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnx=
t *bp, struct ieee_ets *ets)
> >                  return rc;
> >          }
> >
> > -       data =3D &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, qu=
eue_id);
> > +       data =3D (struct bnxt_cos2bw_cfg *)&resp->queue_id0;
> >          for (i =3D 0; i < bp->max_tc; i++, data +=3D sizeof(cos2bw.cfg=
)) {
> >                  int tc;
> >
> > -               memcpy(&cos2bw.cfg, data, sizeof(cos2bw.cfg));
> > +               memcpy(&cos2bw.cfg, &data->cfg, sizeof(cos2bw.cfg));
> >                  if (i =3D=3D 0)
> >                          cos2bw.queue_id =3D resp->queue_id0;
>
> Neat trick, but seems like casting to the destination type should
> really be the last resort. There's only a handful of members in this
> struct, IMHO assigning member by member is cleaner.
> But I'll defer to Michael.

The way I plan to fix this is to change the auto-generated struct
hwrm_queue_cos2bw_qcfg_output to have an array of substruct.  I think
that will look the cleanest.  I'll post it later today or tomorrow.

--00000000000076b94e060205da97
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJX6Va5rehGh5zqNgnyhk0yg/ua2Fapo
uhwwFbR8s2AAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgw
MzE0NDcwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA1XoS0li4aelnCvrOyfrkGsIQXXbYYLZP8+XTCULBmZv20Ose5
qrdHG1kn3TvHvclV/aErrnTWp7yNcBwgjZWFTQEkw8jljdN2QgOp628YuXYbtHJQpRlpIQoGFt4G
u9kRvitV2cJUedXXPkkS3ciDGUE0DotV+2P/TxIpQxANdGRzb4AfXKFhWeGtWjCCdFqsdL0JmaWN
zftnkt8rPA5DNxjYeTc0206QTEe4Cpug7Gt91jKoZq0MqgOx/IQ3iIn5Bgcez6n+ljGgxycmNKhn
WhqTOwb7dd3XwChc0A/h0HEQ2FVDqFwjdjKRw+eD1KkUabcHJir7pgVrALMUO1Qg
--00000000000076b94e060205da97--

