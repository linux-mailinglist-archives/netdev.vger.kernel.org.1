Return-Path: <netdev+bounces-18182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A2755ADA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0226E281427
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 05:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9215399;
	Mon, 17 Jul 2023 05:19:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCB15B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 05:19:47 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708B1AC
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 22:19:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b8413671b9so30598821fa.1
        for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689571183; x=1692163183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBfy2zsHFgsFWpTKvxFMOwiU+5TxFfsF10cmYQASA7E=;
        b=YcC+hWQF7Vxl1gDv/Feb9VBpDrjU+tMY99j9cS4CuUBtME/YVknah3Fdm1e50xgBsq
         BIa9Vm9jbeAd9gaDUpgzJHpLQsdzcCruYpqkR3pPvYH9EEbYhaiVAmzLmFEG9aUODgVy
         bysyxUSDP0zOY9ukbVaCFo6vpBwpUoT5w8Jrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689571183; x=1692163183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBfy2zsHFgsFWpTKvxFMOwiU+5TxFfsF10cmYQASA7E=;
        b=BHUcXZQDv+LBWUCUh43aernqYrrPdGYIhW8V5RuQh86ixNzAqvIxUlMSyabtdg+gR6
         s+VJ7NNJM/wHs2bd9qhxVHa6c957ViY0rfI0jVaGbcIhV+r3sXbWxHMeCFDw7Dn3qETC
         eThByoYld1R4nYzyGos5FRceBlkjlZgIatASGIDdNwlzwbjswlS9jNxCHj2y2dmsGyMt
         4ucBj5YL6vuEQ/LmTW2z0UOcr+rDINu8837aq6S4CPLsOr5LhokLYa4BMBepltCQXuGO
         uEzQ32zoIHXxiiYJmDdA1jKyCGiIUA9rKdgRxMhe85e7oxaHKhrhyxleAbeH7w4Eo4Xv
         LK1w==
X-Gm-Message-State: ABy/qLYcamkacOBapPVMj/558Ns1NJqYxdKI88QmtE6wi1JV2XBpGJmr
	2esJYAaGNEs1JAl7iC55gG0tf8WV1U0URzBjFS54Mg==
X-Google-Smtp-Source: APBJJlESLBJ4tFbet6e8wQjn3/MJim6Ewam674webXQNkyA3pFxaMU8GoIxUnLZeXmi5V3T0Mp0Z/A9ojxyUxRcyovo=
X-Received: by 2002:a2e:9f46:0:b0:2b7:18ff:946e with SMTP id
 v6-20020a2e9f46000000b002b718ff946emr2682242ljk.25.1689571182717; Sun, 16 Jul
 2023 22:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1689351768-3733-1-git-send-email-sbhatta@marvell.com>
 <CAH-L+nOdTe_Y1i-gzJTUz_7yRSBBvvzFc-efb3posnK4qkyY_A@mail.gmail.com>
 <CO1PR18MB4666877CBEAB2D8290C2ACB8A13BA@CO1PR18MB4666.namprd18.prod.outlook.com>
 <CO1PR18MB4666E1AE0EBA66707B33267FA13BA@CO1PR18MB4666.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB4666E1AE0EBA66707B33267FA13BA@CO1PR18MB4666.namprd18.prod.outlook.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 17 Jul 2023 10:49:30 +0530
Message-ID: <CAH-L+nOpwX3VNgzYxfd+-PjDCSntmHLOkFwfX=A5wimXqPYkhw@mail.gmail.com>
Subject: Re: [EXT] Re: [net PATCH] octeontx2-pf: mcs: Generate hash key using ecb(aes)
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
	Geethasowjanya Akula <gakula@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Naveen Mamindlapalli <naveenm@marvell.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000035326b0600a7f294"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--00000000000035326b0600a7f294
Content-Type: multipart/alternative; boundary="0000000000002b86980600a7f26e"

--0000000000002b86980600a7f26e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 10:20=E2=80=AFAM Subbaraya Sundeep Bhatta <
sbhatta@marvell.com> wrote:

> Hi,
>
> >From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
> >Sent: Sunday, July 16, 2023 4:20 PM
> >To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.or=
g
> ;
> >davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; Sunil
> >Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> ><gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Naveen
> >Mamindlapalli <naveenm@marvell.com>
> >Subject: Re: [net PATCH] octeontx2-pf: mcs: Generate hash key using
> ecb(aes)
> >
> >
> >On Fri, Jul 14, 2023 at 9:53=E2=80=AFPM Subbaraya Sundeep
> ><mailto:sbhatta@marvell.com> wrote:
> >Hardware generated encryption and ICV tags are found to
> >be wrong when tested with IEEE MACSEC test vectors.
> >This is because as per the HRM, the hash key (derived by
> >AES-ECB block encryption of an all 0s block with the SAK)
> >has to be programmed by the software in
> >MCSX_RS_MCS_CPM_TX_SLAVE_SA_PLCY_MEM_4X register.
> >Hence fix this by generating hash key in software and
> >configuring in hardware.
> >
> >Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware
> >offloading")
> >Signed-off-by: Subbaraya Sundeep <mailto:sbhatta@marvell.com>
> >---
> > .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  | 132
> +++++++++++++++---
> >---
> > 1 file changed, 95 insertions(+), 37 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> >b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> >index 6e2fb24..9f23118 100644
> >--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> >+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> >@@ -4,6 +4,7 @@
> >  * Copyright (C) 2022 Marvell.
> >  */
> >
> >+#include <crypto/skcipher.h>
> > #include <linux/rtnetlink.h>
> > #include <linux/bitfield.h>
> > #include "otx2_common.h"
> >@@ -42,6 +43,51 @@
> > #define MCS_TCI_E                      0x08 /* encryption */
> > #define MCS_TCI_C                      0x04 /* changed text */
> >
> >+#define CN10K_MAX_HASH_LEN             16
> >+#define CN10K_MAX_SAK_LEN              32
> >+
> >+static int cn10k_ecb_aes_encrypt(struct otx2_nic *pfvf, u8 *sak,
> >+                                u16 sak_len, u8 *hash)
> >+{
> >+       u8 data[CN10K_MAX_HASH_LEN] =3D { 0 };
> >[Kalesh]: There is no need in 0 here, just use {}
> >
> Input has to be all zeroes. AES-ECB block encryption of an all 0s block
> with the SAK key.
> Hence needed.
>

> >+       struct skcipher_request *req =3D NULL;
> >+       struct scatterlist sg_src, sg_dst;
> >+       struct crypto_skcipher *tfm;
> >+       DECLARE_CRYPTO_WAIT(wait);
> >+       int err;
> >+
> >+       tfm =3D crypto_alloc_skcipher("ecb(aes)", 0, 0);
> >+       if (IS_ERR(tfm)) {
> >+               dev_err(pfvf->dev, "failed to allocate transform for
> ecb-aes\n");
> >+               return PTR_ERR(tfm);
> >+       }
> >+
> >+       req =3D skcipher_request_alloc(tfm, GFP_KERNEL);
> >+       if (!req) {
> >+               dev_err(pfvf->dev, "failed to allocate request for
> skcipher\n");
> >+               err =3D -ENOMEM;
> >+               goto out;
> >+       }
> >+
> >+       err =3D crypto_skcipher_setkey(tfm, sak, sak_len);
> >[Kalesh]: No need for a return value check here?
> Missed it. Will add.
>
> >+
> >+       /* build sg list */
> >+       sg_init_one(&sg_src, data, CN10K_MAX_HASH_LEN);
> >+       sg_init_one(&sg_dst, hash, CN10K_MAX_HASH_LEN);
> >+
> >+       skcipher_request_set_callback(req, 0, crypto_req_done, &wait);
> >+       skcipher_request_set_crypt(req, &sg_src, &sg_dst,
> >+                                  CN10K_MAX_HASH_LEN, NULL);
> >+
> >+       err =3D crypto_skcipher_encrypt(req);
> >+       err =3D crypto_wait_req(err, &wait);
> >+
> >+out:
> >+       skcipher_request_free(req);
> >[Kalesh]: I think you should move the label here.
>
> No. After adding the new check, label must be above only.

[Kalesh] Sorry, I did not get that.

Why to invoke skcipher_request_free() when skcipher_request_alloc() fails?
Am I missing something here?

>
>
> >+       crypto_free_skcipher(tfm);
> >+       return err;
> >+}
> >+
> > static struct cn10k_mcs_txsc *cn10k_mcs_get_txsc(struct cn10k_mcs_cfg
> *cfg,
> >                                                 struct macsec_secy *sec=
y)
> > {
> >@@ -330,19 +376,53 @@ static int cn10k_mcs_write_sc_cam(struct otx2_nic
> >*pfvf,
> >        return ret;
> > }
> >
> >+static int cn10k_mcs_write_keys(struct otx2_nic *pfvf,
> >+                               struct macsec_secy *secy,
> >+                               struct mcs_sa_plcy_write_req *req,
> >+                               u8 *sak, u8 *salt, ssci_t ssci)
> >+{
> >+       u8 hash_rev[CN10K_MAX_HASH_LEN] =3D { 0 };
> >[Kalesh]: There is no need in 0 here, just use {}
> >
> Okay
>
> Thanks,
> Sundeep
>
> >+       u8 sak_rev[CN10K_MAX_SAK_LEN] =3D { 0 };
> >+       u8 salt_rev[MACSEC_SALT_LEN] =3D { 0 };
> >+       u8 hash[CN10K_MAX_HASH_LEN] =3D { 0 };
> >+       u32 ssci_63_32;
> >+       int err, i;
> >+
> >+       err =3D cn10k_ecb_aes_encrypt(pfvf, sak, secy->key_len, hash);
> >+       if (err) {
> >+               dev_err(pfvf->dev, "Generating hash using ECB(AES)
> failed\n");
> >+               return err;
> >+       }
> >+
> >+       for (i =3D 0; i < secy->key_len; i++)
> >+               sak_rev[i] =3D sak[secy->key_len - 1 - i];
> >+
> >+       for (i =3D 0; i < CN10K_MAX_HASH_LEN; i++)
> >+               hash_rev[i] =3D hash[CN10K_MAX_HASH_LEN - 1 - i];
> >+
> >+       for (i =3D 0; i < MACSEC_SALT_LEN; i++)
> >+               salt_rev[i] =3D salt[MACSEC_SALT_LEN - 1 - i];
> >+
> >+       ssci_63_32 =3D (__force u32)cpu_to_be32((__force u32)ssci);
> >+
> >+       memcpy(&req->plcy[0][0], sak_rev, secy->key_len);
> >+       memcpy(&req->plcy[0][4], hash_rev, CN10K_MAX_HASH_LEN);
> >+       memcpy(&req->plcy[0][6], salt_rev, MACSEC_SALT_LEN);
> >+       req->plcy[0][7] |=3D (u64)ssci_63_32 << 32;
> >+
> >+       return 0;
> >+}
> >+
> > static int cn10k_mcs_write_rx_sa_plcy(struct otx2_nic *pfvf,
> >                                      struct macsec_secy *secy,
> >                                      struct cn10k_mcs_rxsc *rxsc,
> >                                      u8 assoc_num, bool sa_in_use)
> > {
> >-       unsigned char *src =3D rxsc->sa_key[assoc_num];
> >        struct mcs_sa_plcy_write_req *plcy_req;
> >-       u8 *salt_p =3D rxsc->salt[assoc_num];
> >+       u8 *sak =3D rxsc->sa_key[assoc_num];
> >+       u8 *salt =3D rxsc->salt[assoc_num];
> >        struct mcs_rx_sc_sa_map *map_req;
> >        struct mbox *mbox =3D &pfvf->mbox;
> >-       u64 ssci_salt_95_64 =3D 0;
> >-       u8 reg, key_len;
> >-       u64 salt_63_0;
> >        int ret;
> >
> >        mutex_lock(&mbox->lock);
> >@@ -360,20 +440,10 @@ static int cn10k_mcs_write_rx_sa_plcy(struct
> otx2_nic
> >*pfvf,
> >                goto fail;
> >        }
> >
> >-       for (reg =3D 0, key_len =3D 0; key_len < secy->key_len; key_len =
+=3D 8)
> {
> >-               memcpy((u8 *)&plcy_req->plcy[0][reg],
> >-                      (src + reg * 8), 8);
> >-               reg++;
> >-       }
> >-
> >-       if (secy->xpn) {
> >-               memcpy((u8 *)&salt_63_0, salt_p, 8);
> >-               memcpy((u8 *)&ssci_salt_95_64, salt_p + 8, 4);
> >-               ssci_salt_95_64 |=3D (__force u64)rxsc->ssci[assoc_num] =
<<
> 32;
> >-
> >-               plcy_req->plcy[0][6] =3D salt_63_0;
> >-               plcy_req->plcy[0][7] =3D ssci_salt_95_64;
> >-       }
> >+       ret =3D cn10k_mcs_write_keys(pfvf, secy, plcy_req, sak,
> >+                                  salt, rxsc->ssci[assoc_num]);
> >+       if (ret)
> >+               goto fail;
> >
> >        plcy_req->sa_index[0] =3D rxsc->hw_sa_id[assoc_num];
> >        plcy_req->sa_cnt =3D 1;
> >@@ -586,13 +656,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct
> otx2_nic
> >*pfvf,
> >                                      struct cn10k_mcs_txsc *txsc,
> >                                      u8 assoc_num)
> > {
> >-       unsigned char *src =3D txsc->sa_key[assoc_num];
> >        struct mcs_sa_plcy_write_req *plcy_req;
> >-       u8 *salt_p =3D txsc->salt[assoc_num];
> >+       u8 *sak =3D txsc->sa_key[assoc_num];
> >+       u8 *salt =3D txsc->salt[assoc_num];
> >        struct mbox *mbox =3D &pfvf->mbox;
> >-       u64 ssci_salt_95_64 =3D 0;
> >-       u8 reg, key_len;
> >-       u64 salt_63_0;
> >        int ret;
> >
> >        mutex_lock(&mbox->lock);
> >@@ -603,19 +670,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct
> otx2_nic
> >*pfvf,
> >                goto fail;
> >        }
> >
> >-       for (reg =3D 0, key_len =3D 0; key_len < secy->key_len; key_len =
+=3D 8)
> {
> >-               memcpy((u8 *)&plcy_req->plcy[0][reg], (src + reg * 8), 8=
);
> >-               reg++;
> >-       }
> >-
> >-       if (secy->xpn) {
> >-               memcpy((u8 *)&salt_63_0, salt_p, 8);
> >-               memcpy((u8 *)&ssci_salt_95_64, salt_p + 8, 4);
> >-               ssci_salt_95_64 |=3D (__force u64)txsc->ssci[assoc_num] =
<<
> 32;
> >-
> >-               plcy_req->plcy[0][6] =3D salt_63_0;
> >-               plcy_req->plcy[0][7] =3D ssci_salt_95_64;
> >-       }
> >+       ret =3D cn10k_mcs_write_keys(pfvf, secy, plcy_req, sak,
> >+                                  salt, txsc->ssci[assoc_num]);
> >+       if (ret)
> >+               goto fail;
> >
> >        plcy_req->plcy[0][8] =3D assoc_num;
> >        plcy_req->sa_index[0] =3D txsc->hw_sa_id[assoc_num];
> >--
> >2.7.4
> >
> >
> >
> >
> >--
> >Regards,
> >Kalesh A P
>


--=20
Regards,
Kalesh A P

--0000000000002b86980600a7f26e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 10:20=E2=80=
=AFAM Subbaraya Sundeep Bhatta &lt;<a href=3D"mailto:sbhatta@marvell.com">s=
bhatta@marvell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi,<br>
<br>
&gt;From: Kalesh Anakkur Purayil &lt;<a href=3D"mailto:kalesh-anakkur.puray=
il@broadcom.com" target=3D"_blank">kalesh-anakkur.purayil@broadcom.com</a>&=
gt;<br>
&gt;Sent: Sunday, July 16, 2023 4:20 PM<br>
&gt;To: Subbaraya Sundeep Bhatta &lt;<a href=3D"mailto:sbhatta@marvell.com"=
 target=3D"_blank">sbhatta@marvell.com</a>&gt;<br>
&gt;Cc: <a href=3D"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev@=
vger.kernel.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=
=3D"_blank">linux-kernel@vger.kernel.org</a>; <a href=3D"mailto:kuba@kernel=
.org" target=3D"_blank">kuba@kernel.org</a>;<br>
&gt;<a href=3D"mailto:davem@davemloft.net" target=3D"_blank">davem@davemlof=
t.net</a>; <a href=3D"mailto:edumazet@google.com" target=3D"_blank">edumaze=
t@google.com</a>; <a href=3D"mailto:pabeni@redhat.com" target=3D"_blank">pa=
beni@redhat.com</a>; Sunil<br>
&gt;Kovvuri Goutham &lt;<a href=3D"mailto:sgoutham@marvell.com" target=3D"_=
blank">sgoutham@marvell.com</a>&gt;; Geethasowjanya Akula<br>
&gt;&lt;<a href=3D"mailto:gakula@marvell.com" target=3D"_blank">gakula@marv=
ell.com</a>&gt;; Hariprasad Kelam &lt;<a href=3D"mailto:hkelam@marvell.com"=
 target=3D"_blank">hkelam@marvell.com</a>&gt;; Naveen<br>
&gt;Mamindlapalli &lt;<a href=3D"mailto:naveenm@marvell.com" target=3D"_bla=
nk">naveenm@marvell.com</a>&gt;<br>
&gt;Subject: Re: [net PATCH] octeontx2-pf: mcs: Generate hash key using ecb=
(aes)<br>
&gt;<br>
&gt;<br>
&gt;On Fri, Jul 14, 2023 at 9:53=E2=80=AFPM Subbaraya Sundeep<br>
&gt;&lt;mailto:<a href=3D"mailto:sbhatta@marvell.com" target=3D"_blank">sbh=
atta@marvell.com</a>&gt; wrote:<br>
&gt;Hardware generated encryption and ICV tags are found to<br>
&gt;be wrong when tested with IEEE MACSEC test vectors.<br>
&gt;This is because as per the HRM, the hash key (derived by<br>
&gt;AES-ECB block encryption of an all 0s block with the SAK)<br>
&gt;has to be programmed by the software in<br>
&gt;MCSX_RS_MCS_CPM_TX_SLAVE_SA_PLCY_MEM_4X register.<br>
&gt;Hence fix this by generating hash key in software and<br>
&gt;configuring in hardware.<br>
&gt;<br>
&gt;Fixes: c54ffc73601c (&quot;octeontx2-pf: mcs: Introduce MACSEC hardware=
<br>
&gt;offloading&quot;)<br>
&gt;Signed-off-by: Subbaraya Sundeep &lt;mailto:<a href=3D"mailto:sbhatta@m=
arvell.com" target=3D"_blank">sbhatta@marvell.com</a>&gt;<br>
&gt;---<br>
&gt;=C2=A0.../ethernet/marvell/octeontx2/nic/cn10k_macsec.c=C2=A0 | 132 +++=
++++++++++++---<br>
&gt;---<br>
&gt;=C2=A01 file changed, 95 insertions(+), 37 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c<=
br>
&gt;b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c<br>
&gt;index 6e2fb24..9f23118 100644<br>
&gt;--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c<br>
&gt;+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c<br>
&gt;@@ -4,6 +4,7 @@<br>
&gt;=C2=A0 * Copyright (C) 2022 Marvell.<br>
&gt;=C2=A0 */<br>
&gt;<br>
&gt;+#include &lt;crypto/skcipher.h&gt;<br>
&gt;=C2=A0#include &lt;linux/rtnetlink.h&gt;<br>
&gt;=C2=A0#include &lt;linux/bitfield.h&gt;<br>
&gt;=C2=A0#include &quot;otx2_common.h&quot;<br>
&gt;@@ -42,6 +43,51 @@<br>
&gt;=C2=A0#define MCS_TCI_E=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08 /* encryption */<br>
&gt;=C2=A0#define MCS_TCI_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04 /* changed text */<br>
&gt;<br>
&gt;+#define CN10K_MAX_HASH_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A016<br>
&gt;+#define CN10K_MAX_SAK_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 32<br>
&gt;+<br>
&gt;+static int cn10k_ecb_aes_encrypt(struct otx2_nic *pfvf, u8 *sak,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 sak_len, u8 *hash)<br>
&gt;+{<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 data[CN10K_MAX_HASH_LEN] =3D { 0 };<br>
&gt;[Kalesh]: There is no need in 0 here, just use {}<br>
&gt;<br>
Input has to be all zeroes. AES-ECB block encryption of an all 0s block wit=
h the SAK key.<br>
Hence needed.<br></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct skcipher_request *req =3D NULL;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist sg_src, sg_dst;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct crypto_skcipher *tfm;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0DECLARE_CRYPTO_WAIT(wait);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0tfm =3D crypto_alloc_skcipher(&quot;ecb(aes=
)&quot;, 0, 0);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(tfm)) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pfvf-&g=
t;dev, &quot;failed to allocate transform for ecb-aes\n&quot;);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(=
tfm);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D skcipher_request_alloc(tfm, GFP_KER=
NEL);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!req) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pfvf-&g=
t;dev, &quot;failed to allocate request for skcipher\n&quot;);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENOMEM=
;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D crypto_skcipher_setkey(tfm, sak, sa=
k_len);<br>
&gt;[Kalesh]: No need for a return value check here?<br>
Missed it. Will add.<br>
<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* build sg list */<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one(&amp;sg_src, data, CN10K_MAX_HA=
SH_LEN);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0sg_init_one(&amp;sg_dst, hash, CN10K_MAX_HA=
SH_LEN);<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0skcipher_request_set_callback(req, 0, crypt=
o_req_done, &amp;wait);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0skcipher_request_set_crypt(req, &amp;sg_src=
, &amp;sg_dst,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CN10K_MAX_HASH_LEN, NULL);=
<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D crypto_skcipher_encrypt(req);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D crypto_wait_req(err, &amp;wait);<br=
>
&gt;+<br>
&gt;+out:<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0skcipher_request_free(req);<br>
&gt;[Kalesh]: I think you should move the label here.<br>
<br>
No. After adding the new check, label must be above only.</blockquote>[Kale=
sh] Sorry, I did not get that.<br><br><div>Why to invoke skcipher_request_f=
ree() when skcipher_request_alloc() fails? Am I missing something here?=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_free_skcipher(tfm);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;+}<br>
&gt;+<br>
&gt;=C2=A0static struct cn10k_mcs_txsc *cn10k_mcs_get_txsc(struct cn10k_mcs=
_cfg *cfg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct macsec_secy *secy)<br>
&gt;=C2=A0{<br>
&gt;@@ -330,19 +376,53 @@ static int cn10k_mcs_write_sc_cam(struct otx2_nic=
<br>
&gt;*pfvf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0}<br>
&gt;<br>
&gt;+static int cn10k_mcs_write_keys(struct otx2_nic *pfvf,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct macsec_secy *secy,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mcs_sa_plcy_write_req *req,=
<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *sak, u8 *salt, ssci_t ssci)<br=
>
&gt;+{<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 hash_rev[CN10K_MAX_HASH_LEN] =3D { 0 };<=
br>
&gt;[Kalesh]: There is no need in 0 here, just use {}<br>
&gt;<br>
Okay<br>
<br>
Thanks,<br>
Sundeep<br>
<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 sak_rev[CN10K_MAX_SAK_LEN] =3D { 0 };<br=
>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 salt_rev[MACSEC_SALT_LEN] =3D { 0 };<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 hash[CN10K_MAX_HASH_LEN] =3D { 0 };<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 ssci_63_32;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err, i;<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D cn10k_ecb_aes_encrypt(pfvf, sak, se=
cy-&gt;key_len, hash);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pfvf-&g=
t;dev, &quot;Generating hash using ECB(AES) failed\n&quot;);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; secy-&gt;key_len; i++)=
<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sak_rev[i] =3D =
sak[secy-&gt;key_len - 1 - i];<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; CN10K_MAX_HASH_LEN; i+=
+)<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hash_rev[i] =3D=
 hash[CN10K_MAX_HASH_LEN - 1 - i];<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; MACSEC_SALT_LEN; i++)<=
br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0salt_rev[i] =3D=
 salt[MACSEC_SALT_LEN - 1 - i];<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0ssci_63_32 =3D (__force u32)cpu_to_be32((__=
force u32)ssci);<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;req-&gt;plcy[0][0], sak_rev, se=
cy-&gt;key_len);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;req-&gt;plcy[0][4], hash_rev, C=
N10K_MAX_HASH_LEN);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp;req-&gt;plcy[0][6], salt_rev, M=
ACSEC_SALT_LEN);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;plcy[0][7] |=3D (u64)ssci_63_32 &lt=
;&lt; 32;<br>
&gt;+<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;+}<br>
&gt;+<br>
&gt;=C2=A0static int cn10k_mcs_write_rx_sa_plcy(struct otx2_nic *pfvf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct macse=
c_secy *secy,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cn10k=
_mcs_rxsc *rxsc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 assoc_num=
, bool sa_in_use)<br>
&gt;=C2=A0{<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *src =3D rxsc-&gt;sa_key[asso=
c_num];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mcs_sa_plcy_write_req *plcy_req;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *salt_p =3D rxsc-&gt;salt[assoc_num];<br=
>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *sak =3D rxsc-&gt;sa_key[assoc_num];<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *salt =3D rxsc-&gt;salt[assoc_num];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mcs_rx_sc_sa_map *map_req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mbox *mbox =3D &amp;pfvf-&gt;mbox;<b=
r>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 ssci_salt_95_64 =3D 0;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 reg, key_len;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 salt_63_0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;mbox-&gt;lock);<br>
&gt;@@ -360,20 +440,10 @@ static int cn10k_mcs_write_rx_sa_plcy(struct otx2=
_nic<br>
&gt;*pfvf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (reg =3D 0, key_len =3D 0; key_len &lt;=
 secy-&gt;key_len; key_len +=3D 8) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;plcy_req-&gt;plcy[0][reg],<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (src + reg * 8), 8);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg++;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;-<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (secy-&gt;xpn) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;salt_63_0, salt_p, 8);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;ssci_salt_95_64, salt_p + 8, 4);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssci_salt_95_64=
 |=3D (__force u64)rxsc-&gt;ssci[assoc_num] &lt;&lt; 32;<br>
&gt;-<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plcy_req-&gt;pl=
cy[0][6] =3D salt_63_0;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plcy_req-&gt;pl=
cy[0][7] =3D ssci_salt_95_64;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cn10k_mcs_write_keys(pfvf, secy, pl=
cy_req, sak,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 salt, rxsc-&gt;ssci[assoc_=
num]);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 plcy_req-&gt;sa_index[0] =3D rxsc-&gt;hw_sa=
_id[assoc_num];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 plcy_req-&gt;sa_cnt =3D 1;<br>
&gt;@@ -586,13 +656,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct otx2=
_nic<br>
&gt;*pfvf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cn10k=
_mcs_txsc *txsc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 assoc_num=
)<br>
&gt;=C2=A0{<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char *src =3D txsc-&gt;sa_key[asso=
c_num];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mcs_sa_plcy_write_req *plcy_req;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *salt_p =3D txsc-&gt;salt[assoc_num];<br=
>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *sak =3D txsc-&gt;sa_key[assoc_num];<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 *salt =3D txsc-&gt;salt[assoc_num];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mbox *mbox =3D &amp;pfvf-&gt;mbox;<b=
r>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 ssci_salt_95_64 =3D 0;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 reg, key_len;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 salt_63_0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;mbox-&gt;lock);<br>
&gt;@@ -603,19 +670,10 @@ static int cn10k_mcs_write_tx_sa_plcy(struct otx2=
_nic<br>
&gt;*pfvf,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (reg =3D 0, key_len =3D 0; key_len &lt;=
 secy-&gt;key_len; key_len +=3D 8) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;plcy_req-&gt;plcy[0][reg], (src + reg * 8), 8);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg++;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;-<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (secy-&gt;xpn) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;salt_63_0, salt_p, 8);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy((u8 *)&a=
mp;ssci_salt_95_64, salt_p + 8, 4);<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssci_salt_95_64=
 |=3D (__force u64)txsc-&gt;ssci[assoc_num] &lt;&lt; 32;<br>
&gt;-<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plcy_req-&gt;pl=
cy[0][6] =3D salt_63_0;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plcy_req-&gt;pl=
cy[0][7] =3D ssci_salt_95_64;<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cn10k_mcs_write_keys(pfvf, secy, pl=
cy_req, sak,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 salt, txsc-&gt;ssci[assoc_=
num]);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 plcy_req-&gt;plcy[0][8] =3D assoc_num;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 plcy_req-&gt;sa_index[0] =3D txsc-&gt;hw_sa=
_id[assoc_num];<br>
&gt;--<br>
&gt;2.7.4<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;--<br>
&gt;Regards,<br>
&gt;Kalesh A P<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--0000000000002b86980600a7f26e--

--00000000000035326b0600a7f294
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
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIA4ZMB+RSg0d9RH820+JIcsvdbEqKKRodEfrVzgLTazuMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcxNzA1MTk0M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA9f8AUi1lm
OHgvp9kuaUtecuPB7z+xDBCrh7h1gXtFfLCfPk6FTbVdEiZ03AYPJVTErg4s5VELi1OxYL4hxfnW
TJIgjDreg+JeACIVqFXoChdMBu5r8hUqRx6mQojSkG7S93ZVmXqNyy53I/qUvCSRky8GrLdTRJrK
C4IUxbi6uNU/3pBzSX1TX1Ixx2X2Otk/RgBeQZpq8HGsetCGjA+BWP6jzpUHcWl2cOY5fF/5u7RR
GHNj3FO/XHsDiZnWo5gaqq4av7Kzn19qfZf2MvZnROHpmgsNf7HInZPEok/hUxgYYkxYkx9I9evx
ij0mMHTZjzD0CH8mF74YyzGl70Bl
--00000000000035326b0600a7f294--

