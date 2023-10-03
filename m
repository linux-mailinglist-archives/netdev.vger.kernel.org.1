Return-Path: <netdev+bounces-37617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE3B7B659D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A6A2A2814B8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29614FC15;
	Tue,  3 Oct 2023 09:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9CD278
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:37:53 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B277B90
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 02:37:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so1075001a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696325870; x=1696930670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0MWy+RHoNgCgnYWcdDPuYDz2s3ffizCcPyJ0qqU4Ug=;
        b=AXWC48sRLPUr6AxrV6nbi0XxEZKJbwwGKNLOBaigknEJzv2FL74S1Fw1Ve7TsDH7Zu
         3gNAuu+gIlSGj4OT5ztoiPwNJQ2ER61mh2vKzi9L9KC/X7DPSwXyqstdF2QX3xkoBR/h
         +ALtINCu4dnIWuUA564gbR27/kgXVSnw2ymPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325870; x=1696930670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0MWy+RHoNgCgnYWcdDPuYDz2s3ffizCcPyJ0qqU4Ug=;
        b=IbGIQSQ1V+re4lRt56qe5iHX1FpThZysodn7jNuMD3TeFIfK36Ljkq1OqyCErf1ICc
         q53RTjoUSfEkpfrOkzkJoFOn6clQJfEm8d59oE7dibBnKNY6FT0nxKNvpdhf5XMaXs+S
         bQZxuQQMVvU2OTl2qb+NMHo5nmn6ZbhGfvjxbAYRnH4cxi6KZmoGYMjZGRpPbdZfF2hM
         vTB8aBb14qAD99Lc2W5QOIkYwpRIgOeysbkGCVt0eOwbASOviuXWRDSYm3PkzqpqNi0e
         +w+ew40hXbgL9yfl4iuanD5KMaOzMAovuHEsMV1IM2LQ4Tw5GZSr45GUKLxNPezU+ZnG
         eLow==
X-Gm-Message-State: AOJu0YwocQ59M2K7c0JCAwLw+7IuuVrW+ylHFRoOGoXkAChLm9RLgQOy
	qejcTpIOMgvS5q6hHG4d8vfqqwoC65HBEEd21psZ5JInZOf3qK3U
X-Google-Smtp-Source: AGHT+IF/qyy13tV3PUUOfUU4kk+geuzLl9siCXhFz+UX9e4DDK1Whd6SNmtFlcDjK00Zm87Sd1VPBFeAWq/rNom8AQc=
X-Received: by 2002:a05:6402:2486:b0:538:3cf4:e880 with SMTP id
 q6-20020a056402248600b005383cf4e880mr6836608eda.29.1696325869975; Tue, 03 Oct
 2023 02:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
In-Reply-To: <20231002185510.1488-1-thinhtr@linux.vnet.ibm.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 3 Oct 2023 02:37:37 -0700
Message-ID: <CACKFLinpJgLvYAg+nALVb6RpddXXzXSoXbRAq+nddZvwf5+f3Q@mail.gmail.com>
Subject: Re: [PATCH] net/tg3: fix race condition in tg3_reset_task_cancel()
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, siva.kallam@broadcom.com, prashant@broadcom.com, 
	mchan@broadcom.com, drc@linux.vnet.ibm.com, pavan.chebbi@broadcom.com, 
	Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ef21910606cca4bc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000ef21910606cca4bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 2, 2023 at 11:55=E2=80=AFAM Thinh Tran <thinhtr@linux.vnet.ibm.=
com> wrote:
>
> during the EEH error injection tests on the 4-port 1 GbE NetXtreme
> BCM5719 Gigabit Ethernet PCIe adapter, a race condition was observed in
> the process of resetting and setting the driver flag to
> TX_RECOVERY_PENDING between tg3_reset_task_cancel() and tg3_tx_recover().
> As a result, it occasionally leads to transmit timeouts and the
> subsequent disabling of all the driver's interfaces.
>
> [12046.886221] NETDEV WATCHDOG: eth16 (tg3): transmit queue 0 timed out
> [12046.886238] WARNING: CPU: 7 PID: 0 at ../net/sched/sch_generic.c:478
>    dev_watchdog+0x42c/0x440
> [12046.886247] Modules linked in: tg3 libphy nfsv3 nfs_acl .......
>  ..........
> [12046.886571] tg3 0021:01:00.0 eth16: transmit timed out, resetting
> ...........
> [12046.966175] tg3 0021:01:00.1 eth15: transmit timed out, resetting
> ...........
> [12046.981584] tg3 0021:01:00.2 eth14: transmit timed out, resetting
> ...........
> [12047.056165] tg3 0021:01:00.3 eth13: transmit timed out, resetting
>
>
> Fixing this issue by taking the spinlock when modifying the driver flag
>
>
> Fixes: 6c4ca03bd890 ("net/tg3: resolve deadlock in tg3_reset_task() durin=
g EEH")
>
>
> Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>
> Tested-by: Venkata Sai Duggi <venkata.sai.duggi@ibm.com>
>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index 14b311196b8f..f4558762f9de 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -6507,7 +6507,9 @@ static void tg3_tx_recover(struct tg3 *tp)
>                     "Please report the problem to the driver maintainer "
>                     "and include system chipset information.\n");
>
> +       tg3_full_lock(tp, 0);
>         tg3_flag_set(tp, TX_RECOVERY_PENDING);
> +       tg3_full_unlock(tp);

tg3_flag_set() calls set_bit() which is atomic.  The same is true for
tg3_flag_clear().  Maybe we just need some smp_mb__after_atomic() or
similar memory barriers.

>  }
>
>  static inline u32 tg3_tx_avail(struct tg3_napi *tnapi)
> @@ -7210,7 +7212,10 @@ static inline void tg3_reset_task_cancel(struct tg=
3 *tp)
>  {
>         if (test_and_clear_bit(TG3_FLAG_RESET_TASK_PENDING, tp->tg3_flags=
))
>                 cancel_work_sync(&tp->reset_task);
> +
> +       tg3_full_lock(tp, 0);
>         tg3_flag_clear(tp, TX_RECOVERY_PENDING);
> +       tg3_full_unlock(tp);
>  }
>
>  static int tg3_poll_msix(struct napi_struct *napi, int budget)
> --
> 2.25.1
>

--000000000000ef21910606cca4bc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPAopgfL6+BZwoJaBNEZjt3MT7KPdL8v
3WzmGwVRSWY3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAw
MzA5Mzc1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBplM9yUb0MkAa3j4JByIz1fntUoS9DUU/71gyk6+wtpWgvdaef
2WYkWUCW7KpnVNbu2tVoHY1dbyzkuHzA0S3bzW5i+IatEU4pyeK6PcxhEG2WAG7rvUCfUBaqMGAM
ZR9N55GqKl3NWCQH6kf8r/+RiGY+WT0StLmJq5sG1MR50an1wugwVc+1DQ3R5X0xeRIw0vFo5tD5
ZtJM9UdcTWaSUYK+SQU3kSnX2532YcVl2J3aYFkWIeO9bYzPVX/Xuxz1/Yn4K+ZYQzqZWwFHYjdn
/x+uB+MkoF95N5NvqYZt84P4G9MRV66SZLnJSB48zqJOzNwMH3k6Yged6+0ZV1hR
--000000000000ef21910606cca4bc--

