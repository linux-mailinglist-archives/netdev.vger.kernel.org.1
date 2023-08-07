Return-Path: <netdev+bounces-24803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917A771BDF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2651C209BF
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B018C2D6;
	Mon,  7 Aug 2023 07:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC7AD45
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:54:57 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326A1701
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:54:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso64125621fa.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1691394890; x=1691999690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9h+LANG3KhU9f3AH+ttnNaJC0ZZt7fLI3er8OydCGo=;
        b=GVg+BkLX7uXmBndGDC4vN0C38bDwhVMzqG5uFS5hwG8idYB1lHgsBZc8zdKx37l7W2
         8w9BtGBIupz+URhoam8lDN3QzzfNofFuqxqjYITLeViAT7khZXICdtRA4ACUxAAKMtAC
         4BidHXkBjzIy2NYsPsqNBE5t0MdOPZH37SdqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691394890; x=1691999690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9h+LANG3KhU9f3AH+ttnNaJC0ZZt7fLI3er8OydCGo=;
        b=IIsq+Wfab/8mDG6UMVBcRc2obZjqrk8bMQj9dsxdlPgHjrEFIKwjDt6btR0J5k5R+8
         B3w7jl6fRLgyJn2iy5XB2sIkhY1TNae+x2Qp47ieWm+X5+vsymjNHeMUsvfBKitGtA0y
         MT/B4KVlYT9IsjQeYiiJlxJ+IDHeqewEWV4uL4hDztt2wHgnk2Unwhl6c3iFUU466tPw
         0Vp1WYwzfwD/pbdoh3zHpsYck3rlEfSGP7riV5PdCTtGzpMRUwNA/powxsAdZSKYsZKv
         EHhCmHyrfOwMPbD3iQbCyPMUCNCa5VWa2D8CS+aJiOjNN0WrjdIaVYD+in2Dbag0vx4O
         RamA==
X-Gm-Message-State: AOJu0YxThy92VZsFqQFFajECijCNbyDHFYkCEol6keNOSH0Pmn0LhKNl
	8kTUtKN+LS+sx5VwVpafHBmEZIgeuf6FOCTGk2i4Og==
X-Google-Smtp-Source: AGHT+IEXO9XRGd8+8DXKKqiHAkCM2nyqrQs98pmNp6hGMRMpwDmBiYOnpXlUoEmKp5kBfSds05ssJzFSho63evpMU0E=
X-Received: by 2002:a05:651c:454:b0:2b6:ffd1:165a with SMTP id
 g20-20020a05651c045400b002b6ffd1165amr6062617ljg.30.1691394890372; Mon, 07
 Aug 2023 00:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804093014.2729634-1-saikrishnag@marvell.com>
In-Reply-To: <20230804093014.2729634-1-saikrishnag@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 7 Aug 2023 13:24:38 +0530
Message-ID: <CAH-L+nPKTv6Fh62NO=gKu6MPMhN8tZeWom+as4GQA4QU8iNcqA@mail.gmail.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, richardcochran@gmail.com, 
	Naveen Mamindlapalli <naveenm@marvell.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a66f290602508f7f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000a66f290602508f7f
Content-Type: multipart/alternative; boundary="0000000000009df2ff0602508f2e"

--0000000000009df2ff0602508f2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 4, 2023 at 3:00=E2=80=AFPM Sai Krishna <saikrishnag@marvell.com=
> wrote:

> Some of the newer silicon versions in CN10K series supports a feature
> where in the current PTP timestamp in HW can be updated atomically
> without losing any cpu cycles unlike read/modify/write register.
> This patch uses this feature so that PTP accuracy can be improved
> while adjusting the master offset in HW. There is no need for SW
> timecounter when using this feature. So removed references to SW
> timecounter wherever appropriate.
>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  12 ++
>  .../net/ethernet/marvell/octeontx2/af/ptp.c   | 161 ++++++++++++++--
>  .../net/ethernet/marvell/octeontx2/af/ptp.h   |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  12 ++
>  .../marvell/octeontx2/nic/otx2_common.h       |   1 +
>  .../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 177 ++++++++++++++----
>  7 files changed, 313 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index a8f3c8faf8af..407c220840d9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -136,6 +136,7 @@ M(GET_HW_CAP,               0x008, get_hw_cap,
> msg_req, get_hw_cap_rsp)     \
>  M(LMTST_TBL_SETUP,     0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
>                                 msg_rsp)                                \
>  M(SET_VF_PERM,         0x00b, set_vf_perm, set_vf_perm, msg_rsp)       \
> +M(PTP_GET_CAP,         0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)   \
>  /* CGX mbox IDs (range 0x200 - 0x3FF) */                               \
>  M(CGX_START_RXTX,      0x200, cgx_start_rxtx, msg_req, msg_rsp)        \
>  M(CGX_STOP_RXTX,       0x201, cgx_stop_rxtx, msg_req, msg_rsp)         \
> @@ -1437,6 +1438,12 @@ struct npc_get_kex_cfg_rsp {
>         u8 mkex_pfl_name[MKEX_NAME_LEN];
>  };
>
> +struct ptp_get_cap_rsp {
> +       struct mbox_msghdr hdr;
> +#define        PTP_CAP_HW_ATOMIC_UPDATE BIT_ULL(0)
> +       u64 cap;
> +};
> +
>  struct flow_msg {
>         unsigned char dmac[6];
>         unsigned char smac[6];
> @@ -1567,6 +1574,8 @@ enum ptp_op {
>         PTP_OP_GET_TSTMP =3D 2,
>         PTP_OP_SET_THRESH =3D 3,
>         PTP_OP_EXTTS_ON =3D 4,
> +       PTP_OP_ADJTIME =3D 5,
> +       PTP_OP_SET_CLOCK =3D 6,
>  };
>
>  struct ptp_req {
> @@ -1575,11 +1584,14 @@ struct ptp_req {
>         s64 scaled_ppm;
>         u64 thresh;
>         int extts_on;
> +       s64 delta;
> +       u64 clk;
>  };
>
>  struct ptp_rsp {
>         struct mbox_msghdr hdr;
>         u64 clk;
> +       u64 tsc;
>  };
>
>  struct npc_get_field_status_req {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> index c55c2c441a1a..70256372bec6 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
> @@ -12,9 +12,9 @@
>  #include <linux/hrtimer.h>
>  #include <linux/ktime.h>
>
> -#include "ptp.h"
>  #include "mbox.h"
>  #include "rvu.h"
> +#include "ptp.h"
>
>  #define DRV_NAME                               "Marvell PTP Driver"
>
> @@ -40,6 +40,7 @@
>  #define PTP_CLOCK_CFG_TSTMP_EDGE               BIT_ULL(9)
>  #define PTP_CLOCK_CFG_TSTMP_EN                 BIT_ULL(8)
>  #define PTP_CLOCK_CFG_TSTMP_IN_MASK            GENMASK_ULL(15, 10)
> +#define PTP_CLOCK_CFG_ATOMIC_OP_MASK           GENMASK_ULL(28, 26)
>  #define PTP_CLOCK_CFG_PPS_EN                   BIT_ULL(30)
>  #define PTP_CLOCK_CFG_PPS_INV                  BIT_ULL(31)
>
> @@ -53,36 +54,70 @@
>  #define PTP_TIMESTAMP                          0xF20ULL
>  #define PTP_CLOCK_SEC                          0xFD0ULL
>  #define PTP_SEC_ROLLOVER                       0xFD8ULL
> +/* Atomic update related CSRs */
> +#define PTP_FRNS_TIMESTAMP                     0xFE0ULL
> +#define PTP_NXT_ROLLOVER_SET                   0xFE8ULL
> +#define PTP_CURR_ROLLOVER_SET                  0xFF0ULL
> +#define PTP_NANO_TIMESTAMP                     0xFF8ULL
> +#define PTP_SEC_TIMESTAMP                      0x1000ULL
>
>  #define CYCLE_MULT                             1000
>
> +/* PTP atomic update operation type */
> +enum atomic_opcode {
> +       ATOMIC_SET =3D 1,
> +       ATOMIC_INC =3D 3,
> +       ATOMIC_DEC =3D 4
> +};
> +
>  static struct ptp *first_ptp_block;
>  static const struct pci_device_id ptp_id_table[];
>
> -static bool is_ptp_dev_cnf10kb(struct ptp *ptp)
> +static bool is_ptp_dev_cnf10ka(struct ptp *ptp)
>  {
> -       return ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_B_PTP;
> +       return (ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CNF10K_A_PTP) ? true : false;
>
[Kalesh]: Isn't it enough?
return ptp->pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP;

>  }
>
> -static bool is_ptp_dev_cn10k(struct ptp *ptp)
> +static bool is_ptp_dev_cn10ka(struct ptp *ptp)
>  {
> -       return ptp->pdev->device =3D=3D PCI_DEVID_CN10K_PTP;
> +       return (ptp->pdev->subsystem_device =3D=3D
> PCI_SUBSYS_DEVID_CN10K_A_PTP) ? true : false;
>
[Kalesh]: Same as above

>  }
>
>  static bool cn10k_ptp_errata(struct ptp *ptp)
>  {
> -       if (ptp->pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_P=
TP ||
> -           ptp->pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_=
PTP)
> +       if ((is_ptp_dev_cn10ka(ptp) &&
> +            ((ptp->pdev->revision & 0x0F) =3D=3D 0x0 || (ptp->pdev->revi=
sion
> & 0x0F) =3D=3D 0x1)) ||
> +           (is_ptp_dev_cnf10ka(ptp) &&
> +            ((ptp->pdev->revision & 0x0F) =3D=3D 0x0 || (ptp->pdev->revi=
sion
> & 0x0F) =3D=3D 0x1)))
>                 return true;
> +
>         return false;
>  }
>
> -static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)
> +static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)
>  {
> -       if (ptp->pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_P=
TP ||
> -           ptp->pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_=
PTP)
> +       struct ptp *ptp =3D rvu->ptp;
> +       struct pci_dev *pdev;
> +
> +       if (is_rvu_otx2(rvu))
> +               return false;
> +
> +       pdev =3D ptp->pdev;
> +
> +       /* On older silicon variants of CN10K, atomic update feature
> +        * is not available.
> +        */
> +       if ((pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_PTP &=
&
> +            (pdev->revision & 0x0F) =3D=3D 0x0) ||
> +            (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CN10K_A_PTP =
&&
> +            (pdev->revision & 0x0F) =3D=3D 0x1) ||
> +            (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP=
 &&
> +            (pdev->revision & 0x0F) =3D=3D 0x0) ||
> +            (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP=
 &&
> +            (pdev->revision & 0x0F) =3D=3D 0x1))
> +               return false;
> +       else
>
[Kalesh]: No need of else here.

>                 return true;
> -       return false;
>  }
>
>  static enum hrtimer_restart ptp_reset_thresh(struct hrtimer *hrtimer)
> @@ -222,6 +257,65 @@ void ptp_put(struct ptp *ptp)
>         pci_dev_put(ptp->pdev);
>  }
>
> +static void ptp_atomic_update(struct ptp *ptp, u64 timestamp)
> +{
> +       u64 regval, curr_rollover_set, nxt_rollover_set;
> +
> +       /* First setup NSECs and SECs */
> +       writeq(timestamp, ptp->reg_base + PTP_NANO_TIMESTAMP);
> +       writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
> +       writeq(timestamp / NSEC_PER_SEC,
> +              ptp->reg_base + PTP_SEC_TIMESTAMP);
> +
> +       nxt_rollover_set =3D roundup(timestamp, NSEC_PER_SEC);
> +       curr_rollover_set =3D nxt_rollover_set - NSEC_PER_SEC;
> +       writeq(nxt_rollover_set, ptp->reg_base + PTP_NXT_ROLLOVER_SET);
> +       writeq(curr_rollover_set, ptp->reg_base + PTP_CURR_ROLLOVER_SET);
> +
> +       /* Now, initiate atomic update */
> +       regval =3D readq(ptp->reg_base + PTP_CLOCK_CFG);
> +       regval &=3D ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
> +       regval |=3D (ATOMIC_SET << 26);
> +       writeq(regval, ptp->reg_base + PTP_CLOCK_CFG);
> +}
> +
> +static void ptp_atomic_adjtime(struct ptp *ptp, s64 delta)
> +{
> +       bool neg_adj =3D false, atomic_inc_dec =3D false;
> +       u64 regval, ptp_clock_hi;
> +
> +       if (delta < 0) {
> +               delta =3D -delta;
> +               neg_adj =3D true;
> +       }
> +
> +       /* use atomic inc/dec when delta < 1 second */
> +       if (delta < NSEC_PER_SEC)
> +               atomic_inc_dec =3D true;
> +
> +       if (!atomic_inc_dec) {
> +               ptp_clock_hi =3D readq(ptp->reg_base + PTP_CLOCK_HI);
> +               if (neg_adj) {
> +                       if (ptp_clock_hi > delta)
> +                               ptp_clock_hi -=3D delta;
> +                       else
> +                               ptp_clock_hi =3D delta - ptp_clock_hi;
> +               } else {
> +                       ptp_clock_hi +=3D delta;
> +               }
> +               ptp_atomic_update(ptp, ptp_clock_hi);
> +       } else {
> +               writeq(delta, ptp->reg_base + PTP_NANO_TIMESTAMP);
> +               writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
> +
> +               /* initiate atomic inc/dec */
> +               regval =3D readq(ptp->reg_base + PTP_CLOCK_CFG);
> +               regval &=3D ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
> +               regval |=3D neg_adj ? (ATOMIC_DEC << 26) : (ATOMIC_INC <<
> 26);
> +               writeq(regval, ptp->reg_base + PTP_CLOCK_CFG);
> +       }
> +}
> +
>  static int ptp_adjfine(struct ptp *ptp, long scaled_ppm)
>  {
>         bool neg_adj =3D false;
> @@ -277,8 +371,9 @@ static int ptp_get_clock(struct ptp *ptp, u64 *clk)
>         return 0;
>  }
>
> -void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts)
> +void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts)
>  {
> +       struct ptp *ptp =3D rvu->ptp;
>         struct pci_dev *pdev;
>         u64 clock_comp;
>         u64 clock_cfg;
> @@ -297,8 +392,14 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32
> ext_clk_freq, u32 extts)
>         ptp->clock_rate =3D sclk * 1000000;
>
>         /* Program the seconds rollover value to 1 second */
> -       if (is_ptp_dev_cnf10kb(ptp))
> +       if (is_tstmp_atomic_update_supported(rvu)) {
> +               writeq(0, ptp->reg_base + PTP_NANO_TIMESTAMP);
> +               writeq(0, ptp->reg_base + PTP_FRNS_TIMESTAMP);
> +               writeq(0, ptp->reg_base + PTP_SEC_TIMESTAMP);
> +               writeq(0, ptp->reg_base + PTP_CURR_ROLLOVER_SET);
> +               writeq(0x3b9aca00, ptp->reg_base + PTP_NXT_ROLLOVER_SET);
>                 writeq(0x3b9aca00, ptp->reg_base + PTP_SEC_ROLLOVER);
> +       }
>
>         /* Enable PTP clock */
>         clock_cfg =3D readq(ptp->reg_base + PTP_CLOCK_CFG);
> @@ -320,6 +421,10 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32
> ext_clk_freq, u32 extts)
>         clock_cfg |=3D PTP_CLOCK_CFG_PTP_EN;
>         clock_cfg |=3D PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK_CFG_PPS_INV;
>         writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
> +       clock_cfg =3D readq(ptp->reg_base + PTP_CLOCK_CFG);
> +       clock_cfg &=3D ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;
> +       clock_cfg |=3D (ATOMIC_SET << 26);
> +       writeq(clock_cfg, ptp->reg_base + PTP_CLOCK_CFG);
>
>         /* Set 50% duty cycle for 1Hz output */
>         writeq(0x1dcd650000000000, ptp->reg_base + PTP_PPS_HI_INCR);
> @@ -350,7 +455,7 @@ static int ptp_get_tstmp(struct ptp *ptp, u64 *clk)
>  {
>         u64 timestamp;
>
> -       if (is_ptp_dev_cn10k(ptp)) {
> +       if (is_ptp_dev_cn10ka(ptp) || is_ptp_dev_cnf10ka(ptp)) {
>                 timestamp =3D readq(ptp->reg_base + PTP_TIMESTAMP);
>                 *clk =3D (timestamp >> 32) * NSEC_PER_SEC + (timestamp &
> 0xFFFFFFFF);
>         } else {
> @@ -414,14 +519,12 @@ static int ptp_probe(struct pci_dev *pdev,
>                 first_ptp_block =3D ptp;
>
>         spin_lock_init(&ptp->ptp_lock);
> -       if (is_ptp_tsfmt_sec_nsec(ptp))
> -               ptp->read_ptp_tstmp =3D &read_ptp_tstmp_sec_nsec;
> -       else
> -               ptp->read_ptp_tstmp =3D &read_ptp_tstmp_nsec;
> -
>         if (cn10k_ptp_errata(ptp)) {
> +               ptp->read_ptp_tstmp =3D &read_ptp_tstmp_sec_nsec;
>                 hrtimer_init(&ptp->hrtimer, CLOCK_MONOTONIC,
> HRTIMER_MODE_REL);
>                 ptp->hrtimer.function =3D ptp_reset_thresh;
> +       } else {
> +               ptp->read_ptp_tstmp =3D &read_ptp_tstmp_nsec;
>         }
>
>         return 0;
> @@ -521,6 +624,12 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct
> ptp_req *req,
>         case PTP_OP_EXTTS_ON:
>                 err =3D ptp_extts_on(rvu->ptp, req->extts_on);
>                 break;
> +       case PTP_OP_ADJTIME:
> +               ptp_atomic_adjtime(rvu->ptp, req->delta);
> +               break;
> +       case PTP_OP_SET_CLOCK:
> +               ptp_atomic_update(rvu->ptp, (u64)req->clk);
> +               break;
>         default:
>                 err =3D -EINVAL;
>                 break;
> @@ -528,3 +637,17 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct
> ptp_req *req,
>
>         return err;
>  }
> +
> +int rvu_mbox_handler_ptp_get_cap(struct rvu *rvu, struct msg_req *req,
> +                                struct ptp_get_cap_rsp *rsp)
> +{
> +       if (!rvu->ptp)
> +               return -ENODEV;
> +
> +       if (is_tstmp_atomic_update_supported(rvu))
> +               rsp->cap |=3D PTP_CAP_HW_ATOMIC_UPDATE;
> +       else
> +               rsp->cap &=3D ~BIT_ULL_MASK(0);
> +
> +       return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
> b/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
> index b9d92abc3844..0268a5e0b8bc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.h
> @@ -25,7 +25,7 @@ struct ptp {
>
>  struct ptp *ptp_get(void);
>  void ptp_put(struct ptp *ptp);
> -void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts);
> +void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts);
>
>  extern struct pci_driver ptp_driver;
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 73df2d564545..22c395c7d040 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3322,7 +3322,7 @@ static int rvu_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>         mutex_init(&rvu->rswitch.switch_lock);
>
>         if (rvu->fwdata)
> -               ptp_start(rvu->ptp, rvu->fwdata->sclk,
> rvu->fwdata->ptp_ext_clk_rate,
> +               ptp_start(rvu, rvu->fwdata->sclk,
> rvu->fwdata->ptp_ext_clk_rate,
>                           rvu->fwdata->ptp_ext_tstamp);
>
>         return 0;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index e8e65fd7888d..c4d999ef5ab4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -17,6 +17,7 @@
>  #include "mbox.h"
>  #include "npc.h"
>  #include "rvu_reg.h"
> +#include "ptp.h"
>
>  /* PCI device IDs */
>  #define        PCI_DEVID_OCTEONTX2_RVU_AF              0xA065
> @@ -26,6 +27,7 @@
>  #define PCI_SUBSYS_DEVID_98XX                  0xB100
>  #define PCI_SUBSYS_DEVID_96XX                  0xB200
>  #define PCI_SUBSYS_DEVID_CN10K_A              0xB900
> +#define PCI_SUBSYS_DEVID_CNF10K_A             0xBA00
>  #define PCI_SUBSYS_DEVID_CNF10K_B              0xBC00
>  #define PCI_SUBSYS_DEVID_CN10K_B               0xBD00
>
> @@ -634,6 +636,16 @@ static inline bool is_rvu_otx2(struct rvu *rvu)
>                 midr =3D=3D PCI_REVISION_ID_95XXMM || midr =3D=3D
> PCI_REVISION_ID_95XXO);
>  }
>
> +static inline bool is_cnf10ka_a0(struct rvu *rvu)
> +{
> +       struct pci_dev *pdev =3D rvu->pdev;
> +
> +       if (pdev->subsystem_device =3D=3D PCI_SUBSYS_DEVID_CNF10K_A &&
> +           (pdev->revision & 0x0F) =3D=3D 0x0)
> +               return true;
> +       return false;
> +}
> +
>  static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)
>  {
>         u64 npc_const3;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 25e99fd2e3fd..ee37235e6f09 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -326,6 +326,7 @@ struct otx2_ptp {
>         struct ptp_pin_desc extts_config;
>         u64 (*convert_rx_ptp_tstmp)(u64 timestamp);
>         u64 (*convert_tx_ptp_tstmp)(u64 timestamp);
> +       u64 (*ptp_tstamp2nsec)(const struct timecounter *time_counter, u6=
4
> timestamp);
>         struct delayed_work synctstamp_work;
>         u64 tstamp;
>         u32 base_ns;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> index 896b2f9bac34..839d7a07939d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
> @@ -10,6 +10,62 @@
>  #include "otx2_common.h"
>  #include "otx2_ptp.h"
>
> +static bool is_tstmp_atomic_update_supported(struct otx2_ptp *ptp)
> +{
> +       struct ptp_get_cap_rsp *rsp;
> +       struct msg_req *req;
> +       int err;
> +
> +       if (!ptp->nic)
> +               return 0;
>
[Kalesh]: return false; same comment applies for below 2 returns.

> +
> +       mutex_lock(&ptp->nic->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_ptp_get_cap(&ptp->nic->mbox);
> +       if (!req)
> +               return 0;
> +
> +       err =3D otx2_sync_mbox_msg(&ptp->nic->mbox);
> +       if (err)
> +               return 0;
> +
> +       rsp =3D (struct ptp_get_cap_rsp
> *)otx2_mbox_get_rsp(&ptp->nic->mbox.mbox, 0,
> +                                                         &req->hdr);
> +       mutex_unlock(&ptp->nic->mbox.lock);
> +
> +       if (IS_ERR(rsp))
> +               return false;
> +
> +       if (rsp->cap & PTP_CAP_HW_ATOMIC_UPDATE)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int otx2_ptp_hw_adjtime(struct ptp_clock_info *ptp_info, s64 delt=
a)
> +{
> +       struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
> +                                           ptp_info);
> +       struct otx2_nic *pfvf =3D ptp->nic;
> +       struct ptp_req *req;
> +       int rc;
> +
> +       if (!ptp->nic)
> +               return -ENODEV;
> +
> +       mutex_lock(&pfvf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_ptp_op(&ptp->nic->mbox);
> +       if (!req) {
> +               mutex_unlock(&pfvf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +       req->op =3D PTP_OP_ADJTIME;
> +       req->delta =3D delta;
> +       rc =3D otx2_sync_mbox_msg(&ptp->nic->mbox);
> +       mutex_unlock(&pfvf->mbox.lock);
> +
> +       return rc;
> +}
> +
>  static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)
>  {
>         struct ptp_req *req;
> @@ -37,6 +93,49 @@ static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)
>         return rsp->clk;
>  }
>
> +static int otx2_ptp_hw_gettime(struct ptp_clock_info *ptp_info,
> +                              struct timespec64 *ts)
> +{
> +       struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
> +                                           ptp_info);
> +       u64 tstamp;
> +
> +       tstamp =3D otx2_ptp_get_clock(ptp);
> +
> +       *ts =3D ns_to_timespec64(tstamp);
> +       return 0;
> +}
> +
> +static int otx2_ptp_hw_settime(struct ptp_clock_info *ptp_info,
> +                              const struct timespec64 *ts)
> +{
> +       struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
> +                                           ptp_info);
> +       struct otx2_nic *pfvf =3D ptp->nic;
> +       struct ptp_req *req;
> +       u64 nsec;
> +       int rc;
> +
> +       if (!ptp->nic)
> +               return -ENODEV;
> +
> +       nsec =3D timespec64_to_ns(ts);
> +
> +       mutex_lock(&pfvf->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_ptp_op(&ptp->nic->mbox);
> +       if (!req) {
> +               mutex_unlock(&pfvf->mbox.lock);
> +               return -ENOMEM;
> +       }
> +
> +       req->op =3D PTP_OP_SET_CLOCK;
> +       req->clk =3D nsec;
> +       rc =3D otx2_sync_mbox_msg(&ptp->nic->mbox);
> +       mutex_unlock(&pfvf->mbox.lock);
> +
> +       return rc;
> +}
> +
>  static int otx2_ptp_adjfine(struct ptp_clock_info *ptp_info, long
> scaled_ppm)
>  {
>         struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
> @@ -124,21 +223,15 @@ static u64 ptp_tstmp_read(struct otx2_ptp *ptp)
>         return rsp->clk;
>  }
>
> -static void otx2_get_ptpclock(struct otx2_ptp *ptp, u64 *tstamp)
> -{
> -       struct otx2_nic *pfvf =3D ptp->nic;
> -
> -       mutex_lock(&pfvf->mbox.lock);
> -       *tstamp =3D timecounter_read(&ptp->time_counter);
> -       mutex_unlock(&pfvf->mbox.lock);
> -}
> -
> -static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)
> +static int otx2_ptp_tc_adjtime(struct ptp_clock_info *ptp_info, s64 delt=
a)
>  {
>         struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
>                                             ptp_info);
>         struct otx2_nic *pfvf =3D ptp->nic;
>
> +       if (!ptp->nic)
> +               return -ENODEV;
> +
>         mutex_lock(&pfvf->mbox.lock);
>         timecounter_adjtime(&ptp->time_counter, delta);
>         mutex_unlock(&pfvf->mbox.lock);
> @@ -146,32 +239,33 @@ static int otx2_ptp_adjtime(struct ptp_clock_info
> *ptp_info, s64 delta)
>         return 0;
>  }
>
> -static int otx2_ptp_gettime(struct ptp_clock_info *ptp_info,
> -                           struct timespec64 *ts)
> +static int otx2_ptp_tc_gettime(struct ptp_clock_info *ptp_info,
> +                              struct timespec64 *ts)
>  {
>         struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
>                                             ptp_info);
>         u64 tstamp;
>
> -       otx2_get_ptpclock(ptp, &tstamp);
> +       mutex_lock(&ptp->nic->mbox.lock);
> +       tstamp =3D timecounter_read(&ptp->time_counter);
> +       mutex_unlock(&ptp->nic->mbox.lock);
>         *ts =3D ns_to_timespec64(tstamp);
>
>         return 0;
>  }
>
> -static int otx2_ptp_settime(struct ptp_clock_info *ptp_info,
> -                           const struct timespec64 *ts)
> +static int otx2_ptp_tc_settime(struct ptp_clock_info *ptp_info,
> +                              const struct timespec64 *ts)
>  {
>         struct otx2_ptp *ptp =3D container_of(ptp_info, struct otx2_ptp,
>                                             ptp_info);
> -       struct otx2_nic *pfvf =3D ptp->nic;
>         u64 nsec;
>
>         nsec =3D timespec64_to_ns(ts);
>
> -       mutex_lock(&pfvf->mbox.lock);
> +       mutex_lock(&ptp->nic->mbox.lock);
>         timecounter_init(&ptp->time_counter, &ptp->cycle_counter, nsec);
> -       mutex_unlock(&pfvf->mbox.lock);
> +       mutex_unlock(&ptp->nic->mbox.lock);
>
>         return 0;
>  }
> @@ -190,6 +284,12 @@ static int otx2_ptp_verify_pin(struct ptp_clock_info
> *ptp, unsigned int pin,
>         return 0;
>  }
>
> +static u64 otx2_ptp_hw_tstamp2time(const struct timecounter
> *time_counter, u64 tstamp)
> +{
> +       /* On HW which supports atomic updates, timecounter is not
> initialized */
> +       return tstamp;
> +}
> +
>  static void otx2_ptp_extts_check(struct work_struct *work)
>  {
>         struct otx2_ptp *ptp =3D container_of(work, struct otx2_ptp,
> @@ -204,7 +304,7 @@ static void otx2_ptp_extts_check(struct work_struct
> *work)
>         if (tstmp !=3D ptp->last_extts) {
>                 event.type =3D PTP_CLOCK_EXTTS;
>                 event.index =3D 0;
> -               event.timestamp =3D timecounter_cyc2time(&ptp->time_count=
er,
> tstmp);
> +               event.timestamp =3D ptp->ptp_tstamp2nsec(&ptp->time_count=
er,
> tstmp);
>                 ptp_clock_event(ptp->ptp_clock, &event);
>                 new_thresh =3D tstmp % 500000000;
>                 if (ptp->thresh !=3D new_thresh) {
> @@ -229,7 +329,7 @@ static void otx2_sync_tstamp(struct work_struct *work=
)
>         tstamp =3D otx2_ptp_get_clock(ptp);
>         mutex_unlock(&pfvf->mbox.lock);
>
> -       ptp->tstamp =3D timecounter_cyc2time(&pfvf->ptp->time_counter,
> tstamp);
> +       ptp->tstamp =3D ptp->ptp_tstamp2nsec(&ptp->time_counter, tstamp);
>         ptp->base_ns =3D tstamp % NSEC_PER_SEC;
>
>         schedule_delayed_work(&ptp->synctstamp_work,
> msecs_to_jiffies(250));
> @@ -302,15 +402,6 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
>
>         ptp_ptr->nic =3D pfvf;
>
> -       cc =3D &ptp_ptr->cycle_counter;
> -       cc->read =3D ptp_cc_read;
> -       cc->mask =3D CYCLECOUNTER_MASK(64);
> -       cc->mult =3D 1;
> -       cc->shift =3D 0;
> -
> -       timecounter_init(&ptp_ptr->time_counter, &ptp_ptr->cycle_counter,
> -                        ktime_to_ns(ktime_get_real()));
> -
>         snprintf(ptp_ptr->extts_config.name, sizeof(ptp_ptr->
> extts_config.name), "TSTAMP");
>         ptp_ptr->extts_config.index =3D 0;
>         ptp_ptr->extts_config.func =3D PTP_PF_NONE;
> @@ -324,13 +415,33 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
>                 .pps            =3D 0,
>                 .pin_config     =3D &ptp_ptr->extts_config,
>                 .adjfine        =3D otx2_ptp_adjfine,
> -               .adjtime        =3D otx2_ptp_adjtime,
> -               .gettime64      =3D otx2_ptp_gettime,
> -               .settime64      =3D otx2_ptp_settime,
>                 .enable         =3D otx2_ptp_enable,
>                 .verify         =3D otx2_ptp_verify_pin,
>         };
>
> +       /* Check whether hardware supports atomic updates to timestamp */
> +       if (is_tstmp_atomic_update_supported(ptp_ptr)) {
> +               ptp_ptr->ptp_info.adjtime =3D otx2_ptp_hw_adjtime;
> +               ptp_ptr->ptp_info.gettime64 =3D otx2_ptp_hw_gettime;
> +               ptp_ptr->ptp_info.settime64 =3D otx2_ptp_hw_settime;
> +
> +               ptp_ptr->ptp_tstamp2nsec =3D otx2_ptp_hw_tstamp2time;
> +       } else {
> +               ptp_ptr->ptp_info.adjtime =3D otx2_ptp_tc_adjtime;
> +               ptp_ptr->ptp_info.gettime64 =3D otx2_ptp_tc_gettime;
> +               ptp_ptr->ptp_info.settime64 =3D otx2_ptp_tc_settime;
> +
> +               cc =3D &ptp_ptr->cycle_counter;
> +               cc->read =3D ptp_cc_read;
> +               cc->mask =3D CYCLECOUNTER_MASK(64);
> +               cc->mult =3D 1;
> +               cc->shift =3D 0;
> +               ptp_ptr->ptp_tstamp2nsec =3D timecounter_cyc2time;
> +
> +               timecounter_init(&ptp_ptr->time_counter,
> &ptp_ptr->cycle_counter,
> +                                ktime_to_ns(ktime_get_real()));
> +       }
> +
>         INIT_DELAYED_WORK(&ptp_ptr->extts_work, otx2_ptp_extts_check);
>
>         ptp_ptr->ptp_clock =3D ptp_clock_register(&ptp_ptr->ptp_info,
> pfvf->dev);
> @@ -387,7 +498,7 @@ int otx2_ptp_tstamp2time(struct otx2_nic *pfvf, u64
> tstamp, u64 *tsns)
>         if (!pfvf->ptp)
>                 return -ENODEV;
>
> -       *tsns =3D timecounter_cyc2time(&pfvf->ptp->time_counter, tstamp);
> +       *tsns =3D pfvf->ptp->ptp_tstamp2nsec(&pfvf->ptp->time_counter,
> tstamp);
>
>         return 0;
>  }
> --
> 2.25.1
>
>
>

--=20
Regards,
Kalesh A P

--0000000000009df2ff0602508f2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 4, 2023 at 3:00=E2=80=AFP=
M Sai Krishna &lt;<a href=3D"mailto:saikrishnag@marvell.com">saikrishnag@ma=
rvell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Some of the newer silicon versions in CN10K series supports a fe=
ature<br>
where in the current PTP timestamp in HW can be updated atomically<br>
without losing any cpu cycles unlike read/modify/write register.<br>
This patch uses this feature so that PTP accuracy can be improved<br>
while adjusting the master offset in HW. There is no need for SW<br>
timecounter when using this feature. So removed references to SW<br>
timecounter wherever appropriate.<br>
<br>
Signed-off-by: Sai Krishna &lt;<a href=3D"mailto:saikrishnag@marvell.com" t=
arget=3D"_blank">saikrishnag@marvell.com</a>&gt;<br>
Signed-off-by: Naveen Mamindlapalli &lt;<a href=3D"mailto:naveenm@marvell.c=
om" target=3D"_blank">naveenm@marvell.com</a>&gt;<br>
Signed-off-by: Sunil Kovvuri Goutham &lt;<a href=3D"mailto:sgoutham@marvell=
.com" target=3D"_blank">sgoutham@marvell.com</a>&gt;<br>
---<br>
=C2=A0.../net/ethernet/marvell/octeontx2/af/mbox.h=C2=A0 |=C2=A0 12 ++<br>
=C2=A0.../net/ethernet/marvell/octeontx2/af/ptp.c=C2=A0 =C2=A0| 161 +++++++=
+++++++--<br>
=C2=A0.../net/ethernet/marvell/octeontx2/af/ptp.h=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0.../net/ethernet/marvell/octeontx2/af/rvu.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0.../net/ethernet/marvell/octeontx2/af/rvu.h=C2=A0 =C2=A0|=C2=A0 12 ++=
<br>
=C2=A0.../marvell/octeontx2/nic/otx2_common.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0.../ethernet/marvell/octeontx2/nic/otx2_ptp.c | 177 ++++++++++++++---=
-<br>
=C2=A07 files changed, 313 insertions(+), 54 deletions(-)<br>
<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net=
/ethernet/marvell/octeontx2/af/mbox.h<br>
index a8f3c8faf8af..407c220840d9 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h<br>
@@ -136,6 +136,7 @@ M(GET_HW_CAP,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x008, get_hw_cap, msg_req, get_hw_cap_rsp)=C2=A0 =C2=A0 =C2=
=A0\<br>
=C2=A0M(LMTST_TBL_SETUP,=C2=A0 =C2=A0 =C2=A00x00a, lmtst_tbl_setup, lmtst_t=
bl_setup_req,=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg_rsp)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
=C2=A0M(SET_VF_PERM,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00b, set_vf_perm, s=
et_vf_perm, msg_rsp)=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+M(PTP_GET_CAP,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00c, ptp_get_cap, msg_re=
q, ptp_get_cap_rsp)=C2=A0 =C2=A0\<br>
=C2=A0/* CGX mbox IDs (range 0x200 - 0x3FF) */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0M(CGX_START_RXTX,=C2=A0 =C2=A0 =C2=A0 0x200, cgx_start_rxtx, msg_req,=
 msg_rsp)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0M(CGX_STOP_RXTX,=C2=A0 =C2=A0 =C2=A0 =C2=A00x201, cgx_stop_rxtx, msg_=
req, msg_rsp)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -1437,6 +1438,12 @@ struct npc_get_kex_cfg_rsp {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 mkex_pfl_name[MKEX_NAME_LEN];<br>
=C2=A0};<br>
<br>
+struct ptp_get_cap_rsp {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mbox_msghdr hdr;<br>
+#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 PTP_CAP_HW_ATOMIC_UPDATE BIT_ULL(0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 cap;<br>
+};<br>
+<br>
=C2=A0struct flow_msg {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char dmac[6];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char smac[6];<br>
@@ -1567,6 +1574,8 @@ enum ptp_op {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PTP_OP_GET_TSTMP =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PTP_OP_SET_THRESH =3D 3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 PTP_OP_EXTTS_ON =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PTP_OP_ADJTIME =3D 5,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0PTP_OP_SET_CLOCK =3D 6,<br>
=C2=A0};<br>
<br>
=C2=A0struct ptp_req {<br>
@@ -1575,11 +1584,14 @@ struct ptp_req {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s64 scaled_ppm;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 thresh;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int extts_on;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0s64 delta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 clk;<br>
=C2=A0};<br>
<br>
=C2=A0struct ptp_rsp {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mbox_msghdr hdr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 clk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tsc;<br>
=C2=A0};<br>
<br>
=C2=A0struct npc_get_field_status_req {<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/=
ethernet/marvell/octeontx2/af/ptp.c<br>
index c55c2c441a1a..70256372bec6 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c<br>
@@ -12,9 +12,9 @@<br>
=C2=A0#include &lt;linux/hrtimer.h&gt;<br>
=C2=A0#include &lt;linux/ktime.h&gt;<br>
<br>
-#include &quot;ptp.h&quot;<br>
=C2=A0#include &quot;mbox.h&quot;<br>
=C2=A0#include &quot;rvu.h&quot;<br>
+#include &quot;ptp.h&quot;<br>
<br>
=C2=A0#define DRV_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Marvell PT=
P Driver&quot;<br>
<br>
@@ -40,6 +40,7 @@<br>
=C2=A0#define PTP_CLOCK_CFG_TSTMP_EDGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0BIT_ULL(9)<br>
=C2=A0#define PTP_CLOCK_CFG_TSTMP_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0BIT_ULL(8)<br>
=C2=A0#define PTP_CLOCK_CFG_TSTMP_IN_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 GENMASK_ULL(15, 10)<br>
+#define PTP_CLOCK_CFG_ATOMIC_OP_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0GENMASK_ULL(28, 26)<br>
=C2=A0#define PTP_CLOCK_CFG_PPS_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT_ULL(30)<br>
=C2=A0#define PTP_CLOCK_CFG_PPS_INV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 BIT_ULL(31)<br>
<br>
@@ -53,36 +54,70 @@<br>
=C2=A0#define PTP_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xF20ULL<br>
=C2=A0#define PTP_CLOCK_SEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xFD0ULL<br>
=C2=A0#define PTP_SEC_ROLLOVER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xFD8ULL<br>
+/* Atomic update related CSRs */<br>
+#define PTP_FRNS_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00xFE0ULL<br>
+#define PTP_NXT_ROLLOVER_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00xFE8ULL<br>
+#define PTP_CURR_ROLLOVER_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0xFF0ULL<br>
+#define PTP_NANO_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00xFF8ULL<br>
+#define PTP_SEC_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000ULL<br>
<br>
=C2=A0#define CYCLE_MULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000<br>
<br>
+/* PTP atomic update operation type */<br>
+enum atomic_opcode {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ATOMIC_SET =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ATOMIC_INC =3D 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ATOMIC_DEC =3D 4<br>
+};<br>
+<br>
=C2=A0static struct ptp *first_ptp_block;<br>
=C2=A0static const struct pci_device_id ptp_id_table[];<br>
<br>
-static bool is_ptp_dev_cnf10kb(struct ptp *ptp)<br>
+static bool is_ptp_dev_cnf10ka(struct ptp *ptp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ptp-&gt;pdev-&gt;subsystem_device =3D=3D=
 PCI_SUBSYS_DEVID_CNF10K_B_PTP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (ptp-&gt;pdev-&gt;subsystem_device =3D=
=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP) ? true : false;<br></blockquote><div>[Ka=
lesh]: Isn&#39;t it enough?</div><div>return ptp-&gt;pdev-&gt;subsystem_dev=
ice =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP;</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
=C2=A0}<br>
<br>
-static bool is_ptp_dev_cn10k(struct ptp *ptp)<br>
+static bool is_ptp_dev_cn10ka(struct ptp *ptp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ptp-&gt;pdev-&gt;device =3D=3D PCI_DEVID=
_CN10K_PTP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (ptp-&gt;pdev-&gt;subsystem_device =3D=
=3D PCI_SUBSYS_DEVID_CN10K_A_PTP) ? true : false;<br></blockquote><div>[Kal=
esh]: Same as above=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
=C2=A0}<br>
<br>
=C2=A0static bool cn10k_ptp_errata(struct ptp *ptp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ptp-&gt;pdev-&gt;subsystem_device =3D=3D PC=
I_SUBSYS_DEVID_CN10K_A_PTP ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;pdev-&gt;subsystem_device=
 =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((is_ptp_dev_cn10ka(ptp) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((ptp-&gt;pdev-&gt;revision &amp=
; 0x0F) =3D=3D 0x0 || (ptp-&gt;pdev-&gt;revision &amp; 0x0F) =3D=3D 0x1)) |=
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(is_ptp_dev_cnf10ka(ptp) &amp;&am=
p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((ptp-&gt;pdev-&gt;revision &amp=
; 0x0F) =3D=3D 0x0 || (ptp-&gt;pdev-&gt;revision &amp; 0x0F) =3D=3D 0x1)))<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0}<br>
<br>
-static bool is_ptp_tsfmt_sec_nsec(struct ptp *ptp)<br>
+static inline bool is_tstmp_atomic_update_supported(struct rvu *rvu)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ptp-&gt;pdev-&gt;subsystem_device =3D=3D PC=
I_SUBSYS_DEVID_CN10K_A_PTP ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;pdev-&gt;subsystem_device=
 =3D=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp *ptp =3D rvu-&gt;ptp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_rvu_otx2(rvu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pdev =3D ptp-&gt;pdev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* On older silicon variants of CN10K, atomic u=
pdate feature<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * is not available.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((pdev-&gt;subsystem_device =3D=3D PCI_SUBSY=
S_DEVID_CN10K_A_PTP &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;revision &amp; 0x0F) =
=3D=3D 0x0) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;subsystem_device =3D=
=3D PCI_SUBSYS_DEVID_CN10K_A_PTP &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;revision &amp; 0x0F) =
=3D=3D 0x1) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;subsystem_device =3D=
=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;revision &amp; 0x0F) =
=3D=3D 0x0) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;subsystem_device =3D=
=3D PCI_SUBSYS_DEVID_CNF10K_A_PTP &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pdev-&gt;revision &amp; 0x0F) =
=3D=3D 0x1))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br></blockquote><div>[Kalesh]: No need of =
else here.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
=C2=A0static enum hrtimer_restart ptp_reset_thresh(struct hrtimer *hrtimer)=
<br>
@@ -222,6 +257,65 @@ void ptp_put(struct ptp *ptp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dev_put(ptp-&gt;pdev);<br>
=C2=A0}<br>
<br>
+static void ptp_atomic_update(struct ptp *ptp, u64 timestamp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 regval, curr_rollover_set, nxt_rollover_set=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* First setup NSECs and SECs */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(timestamp, ptp-&gt;reg_base + PTP_NANO_T=
IMESTAMP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;reg_base + PTP_FRNS_TIMESTAMP=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(timestamp / NSEC_PER_SEC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp-&gt;reg_base + PTP_SE=
C_TIMESTAMP);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nxt_rollover_set =3D roundup(timestamp, NSEC_PE=
R_SEC);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0curr_rollover_set =3D nxt_rollover_set - NSEC_P=
ER_SEC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(nxt_rollover_set, ptp-&gt;reg_base + PTP=
_NXT_ROLLOVER_SET);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(curr_rollover_set, ptp-&gt;reg_base + PT=
P_CURR_ROLLOVER_SET);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Now, initiate atomic update */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regval =3D readq(ptp-&gt;reg_base + PTP_CLOCK_C=
FG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regval &amp;=3D ~PTP_CLOCK_CFG_ATOMIC_OP_MASK;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0regval |=3D (ATOMIC_SET &lt;&lt; 26);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(regval, ptp-&gt;reg_base + PTP_CLOCK_CFG=
);<br>
+}<br>
+<br>
+static void ptp_atomic_adjtime(struct ptp *ptp, s64 delta)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool neg_adj =3D false, atomic_inc_dec =3D fals=
e;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 regval, ptp_clock_hi;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (delta &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D -delta;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0neg_adj =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* use atomic inc/dec when delta &lt; 1 second =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (delta &lt; NSEC_PER_SEC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_inc_dec =3D =
true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!atomic_inc_dec) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_clock_hi =3D re=
adq(ptp-&gt;reg_base + PTP_CLOCK_HI);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (neg_adj) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (ptp_clock_hi &gt; delta)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_clock_hi -=3D delta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_clock_hi =3D delta - ptp_clock_hi=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ptp_clock_hi +=3D delta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_atomic_update(p=
tp, ptp_clock_hi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(delta, ptp-&=
gt;reg_base + PTP_NANO_TIMESTAMP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;r=
eg_base + PTP_FRNS_TIMESTAMP);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* initiate atomic =
inc/dec */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regval =3D readq(pt=
p-&gt;reg_base + PTP_CLOCK_CFG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regval &amp;=3D ~PT=
P_CLOCK_CFG_ATOMIC_OP_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regval |=3D neg_adj=
 ? (ATOMIC_DEC &lt;&lt; 26) : (ATOMIC_INC &lt;&lt; 26);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(regval, ptp-=
&gt;reg_base + PTP_CLOCK_CFG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0static int ptp_adjfine(struct ptp *ptp, long scaled_ppm)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool neg_adj =3D false;<br>
@@ -277,8 +371,9 @@ static int ptp_get_clock(struct ptp *ptp, u64 *clk)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts)<br>
+void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp *ptp =3D rvu-&gt;ptp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *pdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 clock_comp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 clock_cfg;<br>
@@ -297,8 +392,14 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_=
freq, u32 extts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp-&gt;clock_rate =3D sclk * 1000000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Program the seconds rollover value to 1 seco=
nd */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ptp_dev_cnf10kb(ptp))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_tstmp_atomic_update_supported(rvu)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;r=
eg_base + PTP_NANO_TIMESTAMP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;r=
eg_base + PTP_FRNS_TIMESTAMP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;r=
eg_base + PTP_SEC_TIMESTAMP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0, ptp-&gt;r=
eg_base + PTP_CURR_ROLLOVER_SET);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(0x3b9aca00, =
ptp-&gt;reg_base + PTP_NXT_ROLLOVER_SET);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writeq(0x3b9aca00, =
ptp-&gt;reg_base + PTP_SEC_ROLLOVER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Enable PTP clock */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_cfg =3D readq(ptp-&gt;reg_base + PTP_CLOC=
K_CFG);<br>
@@ -320,6 +421,10 @@ void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_=
freq, u32 extts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_cfg |=3D PTP_CLOCK_CFG_PTP_EN;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clock_cfg |=3D PTP_CLOCK_CFG_PPS_EN | PTP_CLOCK=
_CFG_PPS_INV;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 writeq(clock_cfg, ptp-&gt;reg_base + PTP_CLOCK_=
CFG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clock_cfg =3D readq(ptp-&gt;reg_base + PTP_CLOC=
K_CFG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clock_cfg &amp;=3D ~PTP_CLOCK_CFG_ATOMIC_OP_MAS=
K;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clock_cfg |=3D (ATOMIC_SET &lt;&lt; 26);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writeq(clock_cfg, ptp-&gt;reg_base + PTP_CLOCK_=
CFG);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set 50% duty cycle for 1Hz output */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 writeq(0x1dcd650000000000, ptp-&gt;reg_base + P=
TP_PPS_HI_INCR);<br>
@@ -350,7 +455,7 @@ static int ptp_get_tstmp(struct ptp *ptp, u64 *clk)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 timestamp;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ptp_dev_cn10k(ptp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ptp_dev_cn10ka(ptp) || is_ptp_dev_cnf10k=
a(ptp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timestamp =3D readq=
(ptp-&gt;reg_base + PTP_TIMESTAMP);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *clk =3D (timestamp=
 &gt;&gt; 32) * NSEC_PER_SEC + (timestamp &amp; 0xFFFFFFFF);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
@@ -414,14 +519,12 @@ static int ptp_probe(struct pci_dev *pdev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first_ptp_block =3D=
 ptp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_init(&amp;ptp-&gt;ptp_lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_ptp_tsfmt_sec_nsec(ptp))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;read_ptp_ts=
tmp =3D &amp;read_ptp_tstmp_sec_nsec;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;read_ptp_ts=
tmp =3D &amp;read_ptp_tstmp_nsec;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cn10k_ptp_errata(ptp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;read_ptp_ts=
tmp =3D &amp;read_ptp_tstmp_sec_nsec;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hrtimer_init(&amp;p=
tp-&gt;hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp-&gt;hrtimer.fun=
ction =3D ptp_reset_thresh;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;read_ptp_ts=
tmp =3D &amp;read_ptp_tstmp_nsec;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
@@ -521,6 +624,12 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct pt=
p_req *req,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case PTP_OP_EXTTS_ON:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D ptp_extts_o=
n(rvu-&gt;ptp, req-&gt;extts_on);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PTP_OP_ADJTIME:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_atomic_adjtime(=
rvu-&gt;ptp, req-&gt;delta);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PTP_OP_SET_CLOCK:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_atomic_update(r=
vu-&gt;ptp, (u64)req-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
@@ -528,3 +637,17 @@ int rvu_mbox_handler_ptp_op(struct rvu *rvu, struct pt=
p_req *req,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0}<br>
+<br>
+int rvu_mbox_handler_ptp_get_cap(struct rvu *rvu, struct msg_req *req,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ptp_get_cap_rsp *rsp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rvu-&gt;ptp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_tstmp_atomic_update_supported(rvu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rsp-&gt;cap |=3D PT=
P_CAP_HW_ATOMIC_UPDATE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rsp-&gt;cap &amp;=
=3D ~BIT_ULL_MASK(0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h b/drivers/net/=
ethernet/marvell/octeontx2/af/ptp.h<br>
index b9d92abc3844..0268a5e0b8bc 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.h<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.h<br>
@@ -25,7 +25,7 @@ struct ptp {<br>
<br>
=C2=A0struct ptp *ptp_get(void);<br>
=C2=A0void ptp_put(struct ptp *ptp);<br>
-void ptp_start(struct ptp *ptp, u64 sclk, u32 ext_clk_freq, u32 extts);<br=
>
+void ptp_start(struct rvu *rvu, u64 sclk, u32 ext_clk_freq, u32 extts);<br=
>
<br>
=C2=A0extern struct pci_driver ptp_driver;<br>
<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/=
ethernet/marvell/octeontx2/af/rvu.c<br>
index 73df2d564545..22c395c7d040 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c<br>
@@ -3322,7 +3322,7 @@ static int rvu_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_init(&amp;rvu-&gt;rswitch.switch_lock);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rvu-&gt;fwdata)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_start(rvu-&gt;p=
tp, rvu-&gt;fwdata-&gt;sclk, rvu-&gt;fwdata-&gt;ptp_ext_clk_rate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_start(rvu, rvu-=
&gt;fwdata-&gt;sclk, rvu-&gt;fwdata-&gt;ptp_ext_clk_rate,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 rvu-&gt;fwdata-&gt;ptp_ext_tstamp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/=
ethernet/marvell/octeontx2/af/rvu.h<br>
index e8e65fd7888d..c4d999ef5ab4 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h<br>
@@ -17,6 +17,7 @@<br>
=C2=A0#include &quot;mbox.h&quot;<br>
=C2=A0#include &quot;npc.h&quot;<br>
=C2=A0#include &quot;rvu_reg.h&quot;<br>
+#include &quot;ptp.h&quot;<br>
<br>
=C2=A0/* PCI device IDs */<br>
=C2=A0#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_DEVID_OCTEONTX2_RVU_AF=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xA065<br>
@@ -26,6 +27,7 @@<br>
=C2=A0#define PCI_SUBSYS_DEVID_98XX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0xB100<br>
=C2=A0#define PCI_SUBSYS_DEVID_96XX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0xB200<br>
=C2=A0#define PCI_SUBSYS_DEVID_CN10K_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0xB900<br>
+#define PCI_SUBSYS_DEVID_CNF10K_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00xBA00<br>
=C2=A0#define PCI_SUBSYS_DEVID_CNF10K_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0xBC00<br>
=C2=A0#define PCI_SUBSYS_DEVID_CN10K_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00xBD00<br>
<br>
@@ -634,6 +636,16 @@ static inline bool is_rvu_otx2(struct rvu *rvu)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 midr =3D=3D PCI_REV=
ISION_ID_95XXMM || midr =3D=3D PCI_REVISION_ID_95XXO);<br>
=C2=A0}<br>
<br>
+static inline bool is_cnf10ka_a0(struct rvu *rvu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev =3D rvu-&gt;pdev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev-&gt;subsystem_device =3D=3D PCI_SUBSYS=
_DEVID_CNF10K_A &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(pdev-&gt;revision &amp; 0x0F) =
=3D=3D 0x0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+}<br>
+<br>
=C2=A0static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 npc_const3;<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_common.h<br>
index 25e99fd2e3fd..ee37235e6f09 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h<br>
@@ -326,6 +326,7 @@ struct otx2_ptp {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ptp_pin_desc extts_config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 (*convert_rx_ptp_tstmp)(u64 timestamp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 (*convert_tx_ptp_tstmp)(u64 timestamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 (*ptp_tstamp2nsec)(const struct timecounter=
 *time_counter, u64 timestamp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct delayed_work synctstamp_work;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 tstamp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 base_ns;<br>
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/driver=
s/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c<br>
index 896b2f9bac34..839d7a07939d 100644<br>
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c<br>
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c<br>
@@ -10,6 +10,62 @@<br>
=C2=A0#include &quot;otx2_common.h&quot;<br>
=C2=A0#include &quot;otx2_ptp.h&quot;<br>
<br>
+static bool is_tstmp_atomic_update_supported(struct otx2_ptp *ptp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp_get_cap_rsp *rsp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct msg_req *req;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptp-&gt;nic)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br></bloc=
kquote><div>[Kalesh]: return false; same comment applies for below 2 return=
s.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ptp-&gt;nic-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D otx2_mbox_alloc_msg_ptp_get_cap(&amp;pt=
p-&gt;nic-&gt;mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!req)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D otx2_sync_mbox_msg(&amp;ptp-&gt;nic-&gt=
;mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rsp =3D (struct ptp_get_cap_rsp *)otx2_mbox_get=
_rsp(&amp;ptp-&gt;nic-&gt;mbox.mbox, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;req-&gt;hdr);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;ptp-&gt;nic-&gt;mbox.lock);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(rsp))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsp-&gt;cap &amp; PTP_CAP_HW_ATOMIC_UPDATE)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+}<br>
+<br>
+static int otx2_ptp_hw_adjtime(struct ptp_clock_info *ptp_info, s64 delta)=
<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ptp_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_nic *pfvf =3D ptp-&gt;nic;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp_req *req;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptp-&gt;nic)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pfvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D otx2_mbox_alloc_msg_ptp_op(&amp;ptp-&gt=
;nic-&gt;mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!req) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;p=
fvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;op =3D PTP_OP_ADJTIME;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;delta =3D delta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D otx2_sync_mbox_msg(&amp;ptp-&gt;nic-&gt;=
mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
+}<br>
+<br>
=C2=A0static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct ptp_req *req;<br>
@@ -37,6 +93,49 @@ static u64 otx2_ptp_get_clock(struct otx2_ptp *ptp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rsp-&gt;clk;<br>
=C2=A0}<br>
<br>
+static int otx2_ptp_hw_gettime(struct ptp_clock_info *ptp_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec64 *ts)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ptp_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 tstamp;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tstamp =3D otx2_ptp_get_clock(ptp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*ts =3D ns_to_timespec64(tstamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int otx2_ptp_hw_settime(struct ptp_clock_info *ptp_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct timespec64 *ts)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ptp_info);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_nic *pfvf =3D ptp-&gt;nic;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp_req *req;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 nsec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptp-&gt;nic)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nsec =3D timespec64_to_ns(ts);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pfvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req =3D otx2_mbox_alloc_msg_ptp_op(&amp;ptp-&gt=
;nic-&gt;mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!req) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;p=
fvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;op =3D PTP_OP_SET_CLOCK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0req-&gt;clk =3D nsec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D otx2_sync_mbox_msg(&amp;ptp-&gt;nic-&gt;=
mbox);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
+}<br>
+<br>
=C2=A0static int otx2_ptp_adjfine(struct ptp_clock_info *ptp_info, long sca=
led_ppm)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
@@ -124,21 +223,15 @@ static u64 ptp_tstmp_read(struct otx2_ptp *ptp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return rsp-&gt;clk;<br>
=C2=A0}<br>
<br>
-static void otx2_get_ptpclock(struct otx2_ptp *ptp, u64 *tstamp)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_nic *pfvf =3D ptp-&gt;nic;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pfvf-&gt;mbox.lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*tstamp =3D timecounter_read(&amp;ptp-&gt;time_=
counter);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
-}<br>
-<br>
-static int otx2_ptp_adjtime(struct ptp_clock_info *ptp_info, s64 delta)<br=
>
+static int otx2_ptp_tc_adjtime(struct ptp_clock_info *ptp_info, s64 delta)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ptp_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_nic *pfvf =3D ptp-&gt;nic;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ptp-&gt;nic)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;pfvf-&gt;mbox.lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 timecounter_adjtime(&amp;ptp-&gt;time_counter, =
delta);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
@@ -146,32 +239,33 @@ static int otx2_ptp_adjtime(struct ptp_clock_info *pt=
p_info, s64 delta)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-static int otx2_ptp_gettime(struct ptp_clock_info *ptp_info,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0struct timespec64 *ts)<br>
+static int otx2_ptp_tc_gettime(struct ptp_clock_info *ptp_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec64 *ts)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ptp_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 tstamp;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0otx2_get_ptpclock(ptp, &amp;tstamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ptp-&gt;nic-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tstamp =3D timecounter_read(&amp;ptp-&gt;time_c=
ounter);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;ptp-&gt;nic-&gt;mbox.lock);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *ts =3D ns_to_timespec64(tstamp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
-static int otx2_ptp_settime(struct ptp_clock_info *ptp_info,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const struct timespec64 *ts)<br>
+static int otx2_ptp_tc_settime(struct ptp_clock_info *ptp_info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct timespec64 *ts)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_ptp *ptp =3D container_of(ptp_info,=
 struct otx2_ptp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ptp_info);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct otx2_nic *pfvf =3D ptp-&gt;nic;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 nsec;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 nsec =3D timespec64_to_ns(ts);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pfvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;ptp-&gt;nic-&gt;mbox.lock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 timecounter_init(&amp;ptp-&gt;time_counter, &am=
p;ptp-&gt;cycle_counter, nsec);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;ptp-&gt;nic-&gt;mbox.lock);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -190,6 +284,12 @@ static int otx2_ptp_verify_pin(struct ptp_clock_info *=
ptp, unsigned int pin,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static u64 otx2_ptp_hw_tstamp2time(const struct timecounter *time_counter,=
 u64 tstamp)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* On HW which supports atomic updates, timecou=
nter is not initialized */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return tstamp;<br>
+}<br>
+<br>
=C2=A0static void otx2_ptp_extts_check(struct work_struct *work)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct otx2_ptp *ptp =3D container_of(work, str=
uct otx2_ptp,<br>
@@ -204,7 +304,7 @@ static void otx2_ptp_extts_check(struct work_struct *wo=
rk)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tstmp !=3D ptp-&gt;last_extts) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event.type =3D PTP_=
CLOCK_EXTTS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event.index =3D 0;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.timestamp =3D=
 timecounter_cyc2time(&amp;ptp-&gt;time_counter, tstmp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.timestamp =3D=
 ptp-&gt;ptp_tstamp2nsec(&amp;ptp-&gt;time_counter, tstmp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp_clock_event(ptp=
-&gt;ptp_clock, &amp;event);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_thresh =3D tstm=
p % 500000000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ptp-&gt;thresh =
!=3D new_thresh) {<br>
@@ -229,7 +329,7 @@ static void otx2_sync_tstamp(struct work_struct *work)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tstamp =3D otx2_ptp_get_clock(ptp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;pfvf-&gt;mbox.lock);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;tstamp =3D timecounter_cyc2time(&amp;pf=
vf-&gt;ptp-&gt;time_counter, tstamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ptp-&gt;tstamp =3D ptp-&gt;ptp_tstamp2nsec(&amp=
;ptp-&gt;time_counter, tstamp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp-&gt;base_ns =3D tstamp % NSEC_PER_SEC;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 schedule_delayed_work(&amp;ptp-&gt;synctstamp_w=
ork, msecs_to_jiffies(250));<br>
@@ -302,15 +402,6 @@ int otx2_ptp_init(struct otx2_nic *pfvf)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp_ptr-&gt;nic =3D pfvf;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cc =3D &amp;ptp_ptr-&gt;cycle_counter;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;read =3D ptp_cc_read;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;mask =3D CYCLECOUNTER_MASK(64);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;mult =3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;shift =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0timecounter_init(&amp;ptp_ptr-&gt;time_counter,=
 &amp;ptp_ptr-&gt;cycle_counter,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ktime_to_ns(ktime_get_real()));<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(ptp_ptr-&gt;<a href=3D"http://extts_co=
nfig.name" rel=3D"noreferrer" target=3D"_blank">extts_config.name</a>, size=
of(ptp_ptr-&gt;<a href=3D"http://extts_config.name" rel=3D"noreferrer" targ=
et=3D"_blank">extts_config.name</a>), &quot;TSTAMP&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp_ptr-&gt;extts_config.index =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp_ptr-&gt;extts_config.func =3D PTP_PF_NONE;<=
br>
@@ -324,13 +415,33 @@ int otx2_ptp_init(struct otx2_nic *pfvf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pps=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pin_config=C2=A0 =
=C2=A0 =C2=A0=3D &amp;ptp_ptr-&gt;extts_config,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .adjfine=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D otx2_ptp_adjfine,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.adjtime=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D otx2_ptp_adjtime,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.gettime64=C2=A0 =
=C2=A0 =C2=A0 =3D otx2_ptp_gettime,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.settime64=C2=A0 =
=C2=A0 =C2=A0 =3D otx2_ptp_settime,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .enable=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D otx2_ptp_enable,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .verify=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D otx2_ptp_verify_pin,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check whether hardware supports atomic updat=
es to timestamp */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_tstmp_atomic_update_supported(ptp_ptr)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.adjtime =3D otx2_ptp_hw_adjtime;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.gettime64 =3D otx2_ptp_hw_gettime;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.settime64 =3D otx2_ptp_hw_settime;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_tst=
amp2nsec =3D otx2_ptp_hw_tstamp2time;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.adjtime =3D otx2_ptp_tc_adjtime;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.gettime64 =3D otx2_ptp_tc_gettime;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_inf=
o.settime64 =3D otx2_ptp_tc_settime;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc =3D &amp;ptp_ptr=
-&gt;cycle_counter;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;read =3D ptp=
_cc_read;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;mask =3D CYC=
LECOUNTER_MASK(64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;mult =3D 1;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;shift =3D 0;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ptp_ptr-&gt;ptp_tst=
amp2nsec =3D timecounter_cyc2time;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timecounter_init(&a=
mp;ptp_ptr-&gt;time_counter, &amp;ptp_ptr-&gt;cycle_counter,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ktime_to_ns(ktime_get_real()));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_DELAYED_WORK(&amp;ptp_ptr-&gt;extts_work, =
otx2_ptp_extts_check);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptp_ptr-&gt;ptp_clock =3D ptp_clock_register(&a=
mp;ptp_ptr-&gt;ptp_info, pfvf-&gt;dev);<br>
@@ -387,7 +498,7 @@ int otx2_ptp_tstamp2time(struct otx2_nic *pfvf, u64 tst=
amp, u64 *tsns)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pfvf-&gt;ptp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*tsns =3D timecounter_cyc2time(&amp;pfvf-&gt;pt=
p-&gt;time_counter, tstamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*tsns =3D pfvf-&gt;ptp-&gt;ptp_tstamp2nsec(&amp=
;pfvf-&gt;ptp-&gt;time_counter, tstamp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--0000000000009df2ff0602508f2e--

--000000000000a66f290602508f7f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQiwYJKoZIhvcNAQcCoIIQfDCCEHgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
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
AQkEMSIEIM6PTvWi6vetIWlk+3H+FcyHgIPoFk+TQpfV98qVopzBMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgwNzA3NTQ1MFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCxpcM24950
qz6VHpJiPnOVW7OXtylSl2AbPP1HmFFMDAfM/uWQMF6RGMUp+e1kYYN9YMGJY/f16GvlXH8/Rj5g
P4IjPAiwc2txCT9PsV8i0v4bksIqECLRizDvU9AWNkDUpV75K5zkNTH+8RPhgA5cfUpUo+fqZ1D9
nHNdEHePJZ1/kVgIAEmBAA/uzpsev924WoMQAv0JRXGVT/WKvVKW5R8b33EsPvmpz3KGDUcRy5xf
DJbzHOwGw8zyoJwkxSZKVmh1iLpNJjYbFptsgUc+Slyya5QdALIFhw42mOroqJJwnPYhWJ93CJi9
1e1dyQKQ3Eoy1J50QJiIHJh/amvy
--000000000000a66f290602508f7f--

