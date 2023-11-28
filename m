Return-Path: <netdev+bounces-51575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49E7FB37C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9751EB20B3B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089914AAD;
	Tue, 28 Nov 2023 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bIm/sOpE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDED6D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:02:09 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a98517f3so6962912e87.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701158528; x=1701763328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7g5RGVrbLErhBgIlIvmWi3IcYx2cNp8jba9kLGwXQw=;
        b=bIm/sOpEjqOOQ8uU0L5YEqTQJAk+n5bDvIbZB75QPhKibnymlcKFK51EAdejgThZ3z
         xVqaArK2KED0Mh5Ce5qsx4ETcIKL9p4aZe6+dECM6oOgxuMr6ETGXgMRdlpxEE1p1nDR
         iqAw6km49tOoIUPAxdq9l/v7ctCugAR6g6Sas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158528; x=1701763328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7g5RGVrbLErhBgIlIvmWi3IcYx2cNp8jba9kLGwXQw=;
        b=NY9/xKPF4Pj5IevKiJsOt+hm1D4z4/KggCZ0tMiW/yD2SsFjCgY5aU9ugt4CAPHiBw
         Vty1xVRJH3LzxwOANmqaACPBg3PDzGzwapZkpKd9AvCqiwMn9wEMegPABa88PHd9QEbr
         hic6cjA8IDVOw6QBFrWi0lSe21x+E01512BvP1QlsnpqIkynUj1hv/5VYXhmJ1goQ0Xq
         3c8UxnvNyU30KL7QlI235T19eE+u5HjDSfJ7+XWcmsCczErDKZa7CwfG0ugRJx0z+O/J
         hmG6nwJFmzB9LUrIOL+vTSZzA8qhBqViW7OH47tH433WQWGk+uB7u95KVHG79ELjVQPD
         UCRQ==
X-Gm-Message-State: AOJu0YwOcbg8k6NTW5e/wTuYhZma+3Ch8ut5yms+bNUfPYW2h6N4rzve
	l56aBm+ueY1e6Z+OSdK5d2TXFGzCY9WI3TOWRzcbyA==
X-Google-Smtp-Source: AGHT+IGbHEQOm5KmW0DmqJJsAl1Rky1a6u9BLuq4n/4esIO5nupFyZezYbi7s4IJuvTCwWHE0Y/VbDpYSIWzICg1VTY=
X-Received: by 2002:a05:6512:708:b0:50b:bf35:40d0 with SMTP id
 b8-20020a056512070800b0050bbf3540d0mr165595lfs.67.1701158527853; Tue, 28 Nov
 2023 00:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127211037.1135403-1-anthony.l.nguyen@intel.com> <20231127211037.1135403-2-anthony.l.nguyen@intel.com>
In-Reply-To: <20231127211037.1135403-2-anthony.l.nguyen@intel.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 28 Nov 2023 13:31:56 +0530
Message-ID: <CAH-L+nN78UeLALkoUkHzv3nunScw=WVA8ZvBdXBZtMzdgNJ=Hw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] i40e: Delete unused and useless i40e_pf fields
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>, 
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c8422c060b31d53e"

--000000000000c8422c060b31d53e
Content-Type: multipart/alternative; boundary="000000000000c2ca50060b31d547"

--000000000000c2ca50060b31d547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 2:41=E2=80=AFAM Tony Nguyen <anthony.l.nguyen@intel=
.com>
wrote:

> From: Ivan Vecera <ivecera@redhat.com>
>
> Removed fields:
> .fc_autoneg_status
>     Since commit c56999f94876 ("i40e/i40evf: Add set_fc and init of
>     FC settings") write-only and otherwise unused
> .eeprom_version
>     Write-only and otherwise unused
> .atr_sample_rate
>     Has only one possible value (I40E_DEFAULT_ATR_SAMPLE_RATE). Remove
>     it and replace its occurrences by I40E_DEFAULT_ATR_SAMPLE_RATE
> .adminq_work_limit
>     Has only one possible value (I40E_AQ_WORK_LIMIT). Remove it and
>     replace its occurrences by I40E_AQ_WORK_LIMIT
> .tx_sluggish_count
>     Unused, never written
> .pf_seid
>     Used to store VSI downlink seid and it is referenced only once
>     in the same codepath. There is no need to save it into i40e_pf.
>     Remove it and use downlink_seid directly in the mentioned log
>     message.
> .instance
>     Write only. Remove it as well as ugly static local variable
>     'pfs_found' in i40e_probe.
> .int_policy
> .switch_kobj
> .ptp_pps_work
> .ptp_extts1_work
> .ptp_pps_start
> .pps_delay
> .ptp_pin
> .override_q_count
>     All these unused at all
>
> Prior the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>         /* size: 5368, cachelines: 84, members: 127 */
>         /* sum members: 5297, holes: 20, sum holes: 71 */
>         /* paddings: 6, sum paddings: 19 */
>         /* last cacheline: 56 bytes */
> };
>
> After the patch:
> pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5
>         /* size: 4976, cachelines: 78, members: 112 */
>         /* sum members: 4905, holes: 17, sum holes: 71 */
>         /* paddings: 6, sum paddings: 19 */
>         /* last cacheline: 48 bytes */
> };
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A
> Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 16 ----------------
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  3 ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 18 ++++--------------
>  3 files changed, 4 insertions(+), 33 deletions(-)
>

Looks good to me.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 6022944d04f8..9b701615c7c6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -468,9 +468,7 @@ struct i40e_pf {
>         struct i40e_hw hw;
>         DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
>         struct msix_entry *msix_entries;
> -       bool fc_autoneg_status;
>
> -       u16 eeprom_version;
>         u16 num_vmdq_vsis;         /* num vmdq vsis this PF has set up */
>         u16 num_vmdq_qps;          /* num queue pairs per vmdq pool */
>         u16 num_vmdq_msix;         /* num queue vectors per vmdq pool */
> @@ -486,7 +484,6 @@ struct i40e_pf {
>         u16 rss_size_max;          /* HW defined max RSS queues */
>         u16 fdir_pf_filter_count;  /* num of guaranteed filters for this
> PF */
>         u16 num_alloc_vsi;         /* num VSIs this driver supports */
> -       u8 atr_sample_rate;
>         bool wol_en;
>
>         struct hlist_head fdir_filter_list;
> @@ -524,12 +521,10 @@ struct i40e_pf {
>         struct hlist_head cloud_filter_list;
>         u16 num_cloud_filters;
>
> -       enum i40e_interrupt_policy int_policy;
>         u16 rx_itr_default;
>         u16 tx_itr_default;
>         u32 msg_enable;
>         char int_name[I40E_INT_NAME_STR_LEN];
> -       u16 adminq_work_limit; /* num of admin receive queue desc to
> process */
>         unsigned long service_timer_period;
>         unsigned long service_timer_previous;
>         struct timer_list service_timer;
> @@ -543,7 +538,6 @@ struct i40e_pf {
>         u32 tx_timeout_count;
>         u32 tx_timeout_recovery_level;
>         unsigned long tx_timeout_last_recovery;
> -       u32 tx_sluggish_count;
>         u32 hw_csum_rx_error;
>         u32 led_status;
>         u16 corer_count; /* Core reset count */
> @@ -565,17 +559,13 @@ struct i40e_pf {
>         struct i40e_lump_tracking *irq_pile;
>
>         /* switch config info */
> -       u16 pf_seid;
>         u16 main_vsi_seid;
>         u16 mac_seid;
> -       struct kobject *switch_kobj;
>  #ifdef CONFIG_DEBUG_FS
>         struct dentry *i40e_dbg_pf;
>  #endif /* CONFIG_DEBUG_FS */
>         bool cur_promisc;
>
> -       u16 instance; /* A unique number per i40e_pf instance in the
> system */
> -
>         /* sr-iov config info */
>         struct i40e_vf *vf;
>         int num_alloc_vfs;      /* actual number of VFs allocated */
> @@ -669,9 +659,7 @@ struct i40e_pf {
>         unsigned long ptp_tx_start;
>         struct hwtstamp_config tstamp_config;
>         struct timespec64 ptp_prev_hw_time;
> -       struct work_struct ptp_pps_work;
>         struct work_struct ptp_extts0_work;
> -       struct work_struct ptp_extts1_work;
>         ktime_t ptp_reset_start;
>         struct mutex tmreg_lock; /* Used to protect the SYSTIME registers=
.
> */
>         u32 ptp_adj_mult;
> @@ -679,10 +667,7 @@ struct i40e_pf {
>         u32 tx_hwtstamp_skipped;
>         u32 rx_hwtstamp_cleared;
>         u32 latch_event_flags;
> -       u64 ptp_pps_start;
> -       u32 pps_delay;
>         spinlock_t ptp_rx_lock; /* Used to protect Rx timestamp registers=
.
> */
> -       struct ptp_pin_desc ptp_pin[3];
>         unsigned long latch_events[4];
>         bool ptp_tx;
>         bool ptp_rx;
> @@ -695,7 +680,6 @@ struct i40e_pf {
>         u32 fd_inv;
>         u16 phy_led_val;
>
> -       u16 override_q_count;
>         u16 last_sw_conf_flags;
>         u16 last_sw_conf_valid_flags;
>         /* List to keep previous DDP profiles to be rolled back in the
> future */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 88240571721a..ef70ddbe9c2f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -1028,9 +1028,6 @@ static ssize_t i40e_dbg_command_write(struct file
> *filp,
>                                  "emp reset count: %d\n", pf->empr_count)=
;
>                         dev_info(&pf->pdev->dev,
>                                  "pf reset count: %d\n", pf->pfr_count);
> -                       dev_info(&pf->pdev->dev,
> -                                "pf tx sluggish count: %d\n",
> -                                pf->tx_sluggish_count);
>                 } else if (strncmp(&cmd_buf[5], "port", 4) =3D=3D 0) {
>                         struct i40e_aqc_query_port_ets_config_resp
> *bw_data;
>                         struct i40e_dcbx_config *cfg =3D
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 7ded598a68e6..d71331a8a972 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3465,7 +3465,7 @@ static int i40e_configure_tx_ring(struct i40e_ring
> *ring)
>
>         /* some ATR related tx ring init */
>         if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
> -               ring->atr_sample_rate =3D vsi->back->atr_sample_rate;
> +               ring->atr_sample_rate =3D I40E_DEFAULT_ATR_SAMPLE_RATE;
>                 ring->atr_count =3D 0;
>         } else {
>                 ring->atr_sample_rate =3D 0;
> @@ -10226,9 +10226,9 @@ static void i40e_clean_adminq_subtask(struct
> i40e_pf *pf)
>                                  opcode);
>                         break;
>                 }
> -       } while (i++ < pf->adminq_work_limit);
> +       } while (i++ < I40E_AQ_WORK_LIMIT);
>
> -       if (i < pf->adminq_work_limit)
> +       if (i < I40E_AQ_WORK_LIMIT)
>                 clear_bit(__I40E_ADMINQ_EVENT_PENDING, pf->state);
>
>         /* re-enable Admin queue interrupt cause */
> @@ -12769,7 +12769,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>         if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
>             (pf->hw.func_caps.fd_filters_best_effort > 0)) {
>                 set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
> -               pf->atr_sample_rate =3D I40E_DEFAULT_ATR_SAMPLE_RATE;
>                 if (test_bit(I40E_FLAG_MFP_ENA, pf->flags) &&
>                     pf->hw.num_partitions > 1)
>                         dev_info(&pf->pdev->dev,
> @@ -12815,7 +12814,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>                                         I40E_MAX_VF_COUNT);
>         }
>  #endif /* CONFIG_PCI_IOV */
> -       pf->eeprom_version =3D 0xDEAD;
>         pf->lan_veb =3D I40E_NO_VEB;
>         pf->lan_vsi =3D I40E_NO_VSI;
>
> @@ -14976,12 +14974,11 @@ static void i40e_setup_pf_switch_element(struct
> i40e_pf *pf,
>                  * the PF's VSI
>                  */
>                 pf->mac_seid =3D uplink_seid;
> -               pf->pf_seid =3D downlink_seid;
>                 pf->main_vsi_seid =3D seid;
>                 if (printconfig)
>                         dev_info(&pf->pdev->dev,
>                                  "pf_seid=3D%d main_vsi_seid=3D%d\n",
> -                                pf->pf_seid, pf->main_vsi_seid);
> +                                downlink_seid, pf->main_vsi_seid);
>                 break;
>         case I40E_SWITCH_ELEMENT_TYPE_PF:
>         case I40E_SWITCH_ELEMENT_TYPE_VF:
> @@ -15160,10 +15157,6 @@ static int i40e_setup_pf_switch(struct i40e_pf
> *pf, bool reinit, bool lock_acqui
>         /* fill in link information and enable LSE reporting */
>         i40e_link_event(pf);
>
> -       /* Initialize user-specific link properties */
> -       pf->fc_autoneg_status =3D ((pf->hw.phy.link_info.an_info &
> -                                 I40E_AQ_AN_COMPLETED) ? true : false);
> -
>         i40e_ptp_init(pf);
>
>         if (!lock_acquired)
> @@ -15637,7 +15630,6 @@ static int i40e_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  #endif /* CONFIG_I40E_DCB */
>         struct i40e_pf *pf;
>         struct i40e_hw *hw;
> -       static u16 pfs_found;
>         u16 wol_nvm_bits;
>         char nvm_ver[32];
>         u16 link_status;
> @@ -15715,7 +15707,6 @@ static int i40e_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>         hw->bus.device =3D PCI_SLOT(pdev->devfn);
>         hw->bus.func =3D PCI_FUNC(pdev->devfn);
>         hw->bus.bus_id =3D pdev->bus->number;
> -       pf->instance =3D pfs_found;
>
>         /* Select something other than the 802.1ad ethertype for the
>          * switch to use internally and drop on ingress.
> @@ -15777,7 +15768,6 @@ static int i40e_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>         }
>         hw->aq.arq_buf_size =3D I40E_MAX_AQ_BUF_SIZE;
>         hw->aq.asq_buf_size =3D I40E_MAX_AQ_BUF_SIZE;
> -       pf->adminq_work_limit =3D I40E_AQ_WORK_LIMIT;
>
>         snprintf(pf->int_name, sizeof(pf->int_name) - 1,
>                  "%s-%s:misc",
> --
> 2.41.0
>
>
>

--=20
Regards,
Kalesh A P

--000000000000c2ca50060b31d547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 28, 2023 at 2:41=E2=80=AF=
AM Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com">anthony.l.=
nguyen@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">From: Ivan Vecera &lt;<a href=3D"mailto:ivecera@redhat.com"=
 target=3D"_blank">ivecera@redhat.com</a>&gt;<br>
<br>
Removed fields:<br>
.fc_autoneg_status<br>
=C2=A0 =C2=A0 Since commit c56999f94876 (&quot;i40e/i40evf: Add set_fc and =
init of<br>
=C2=A0 =C2=A0 FC settings&quot;) write-only and otherwise unused<br>
.eeprom_version<br>
=C2=A0 =C2=A0 Write-only and otherwise unused<br>
.atr_sample_rate<br>
=C2=A0 =C2=A0 Has only one possible value (I40E_DEFAULT_ATR_SAMPLE_RATE). R=
emove<br>
=C2=A0 =C2=A0 it and replace its occurrences by I40E_DEFAULT_ATR_SAMPLE_RAT=
E<br>
.adminq_work_limit<br>
=C2=A0 =C2=A0 Has only one possible value (I40E_AQ_WORK_LIMIT). Remove it a=
nd<br>
=C2=A0 =C2=A0 replace its occurrences by I40E_AQ_WORK_LIMIT<br>
.tx_sluggish_count<br>
=C2=A0 =C2=A0 Unused, never written<br>
.pf_seid<br>
=C2=A0 =C2=A0 Used to store VSI downlink seid and it is referenced only onc=
e<br>
=C2=A0 =C2=A0 in the same codepath. There is no need to save it into i40e_p=
f.<br>
=C2=A0 =C2=A0 Remove it and use downlink_seid directly in the mentioned log=
<br>
=C2=A0 =C2=A0 message.<br>
.instance<br>
=C2=A0 =C2=A0 Write only. Remove it as well as ugly static local variable<b=
r>
=C2=A0 =C2=A0 &#39;pfs_found&#39; in i40e_probe.<br>
.int_policy<br>
.switch_kobj<br>
.ptp_pps_work<br>
.ptp_extts1_work<br>
.ptp_pps_start<br>
.pps_delay<br>
.ptp_pin<br>
.override_q_count<br>
=C2=A0 =C2=A0 All these unused at all<br>
<br>
Prior the patch:<br>
pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* size: 5368, cachelines: 84, members: 127 */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sum members: 5297, holes: 20, sum holes: 71 =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* paddings: 6, sum paddings: 19 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* last cacheline: 56 bytes */<br>
};<br>
<br>
After the patch:<br>
pahole -Ci40e_pf drivers/net/ethernet/intel/i40e/i40e.ko | tail -5<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* size: 4976, cachelines: 78, members: 112 */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sum members: 4905, holes: 17, sum holes: 71 =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* paddings: 6, sum paddings: 19 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* last cacheline: 48 bytes */<br>
};<br>
<br>
Signed-off-by: Ivan Vecera &lt;<a href=3D"mailto:ivecera@redhat.com" target=
=3D"_blank">ivecera@redhat.com</a>&gt;<br>
Reviewed-by: Przemek Kitszel &lt;<a href=3D"mailto:przemyslaw.kitszel@intel=
.com" target=3D"_blank">przemyslaw.kitszel@intel.com</a>&gt;<br>
Reviewed-by: Wojciech Drewek &lt;<a href=3D"mailto:wojciech.drewek@intel.co=
m" target=3D"_blank">wojciech.drewek@intel.com</a>&gt;<br>
Tested-by: Pucha Himasekhar Reddy &lt;<a href=3D"mailto:himasekharx.reddy.p=
ucha@intel.com" target=3D"_blank">himasekharx.reddy.pucha@intel.com</a>&gt;=
 (A Contingent worker at Intel)<br>
Signed-off-by: Tony Nguyen &lt;<a href=3D"mailto:anthony.l.nguyen@intel.com=
" target=3D"_blank">anthony.l.nguyen@intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/ethernet/intel/i40e/i40e.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 16 ----------------<br>
=C2=A0drivers/net/ethernet/intel/i40e/i40e_debugfs.c |=C2=A0 3 ---<br>
=C2=A0drivers/net/ethernet/intel/i40e/i40e_main.c=C2=A0 =C2=A0 | 18 ++++---=
-----------<br>
=C2=A03 files changed, 4 insertions(+), 33 deletions(-)<br></blockquote><di=
v><br></div>Looks good to me.<br><br><div>Reviewed-by: Kalesh AP &lt;<a hre=
f=3D"mailto:kalesh-anakkur.purayil@broadcom.com">kalesh-anakkur.purayil@bro=
adcom.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/=
intel/i40e/i40e.h<br>
index 6022944d04f8..9b701615c7c6 100644<br>
--- a/drivers/net/ethernet/intel/i40e/i40e.h<br>
+++ b/drivers/net/ethernet/intel/i40e/i40e.h<br>
@@ -468,9 +468,7 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i40e_hw hw;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DECLARE_BITMAP(state, __I40E_STATE_SIZE__);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct msix_entry *msix_entries;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bool fc_autoneg_status;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 eeprom_version;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 num_vmdq_vsis;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* num vmdq vsis this PF has set up */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 num_vmdq_qps;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* num queue pairs per vmdq pool */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 num_vmdq_msix;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* num queue vectors per vmdq pool */<br>
@@ -486,7 +484,6 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 rss_size_max;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* HW defined max RSS queues */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 fdir_pf_filter_count;=C2=A0 /* num of guara=
nteed filters for this PF */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 num_alloc_vsi;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* num VSIs this driver supports */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 atr_sample_rate;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool wol_en;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hlist_head fdir_filter_list;<br>
@@ -524,12 +521,10 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hlist_head cloud_filter_list;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 num_cloud_filters;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0enum i40e_interrupt_policy int_policy;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 rx_itr_default;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 tx_itr_default;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 msg_enable;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char int_name[I40E_INT_NAME_STR_LEN];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 adminq_work_limit; /* num of admin receive =
queue desc to process */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long service_timer_period;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long service_timer_previous;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timer_list service_timer;<br>
@@ -543,7 +538,6 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tx_timeout_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tx_timeout_recovery_level;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long tx_timeout_last_recovery;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tx_sluggish_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 hw_csum_rx_error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 led_status;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 corer_count; /* Core reset count */<br>
@@ -565,17 +559,13 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i40e_lump_tracking *irq_pile;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* switch config info */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 pf_seid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 main_vsi_seid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 mac_seid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct kobject *switch_kobj;<br>
=C2=A0#ifdef CONFIG_DEBUG_FS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dentry *i40e_dbg_pf;<br>
=C2=A0#endif /* CONFIG_DEBUG_FS */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool cur_promisc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 instance; /* A unique number per i40e_pf in=
stance in the system */<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sr-iov config info */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i40e_vf *vf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int num_alloc_vfs;=C2=A0 =C2=A0 =C2=A0 /* actua=
l number of VFs allocated */<br>
@@ -669,9 +659,7 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long ptp_tx_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hwtstamp_config tstamp_config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec64 ptp_prev_hw_time;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct ptp_pps_work;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct work_struct ptp_extts0_work;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct ptp_extts1_work;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ktime_t ptp_reset_start;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mutex tmreg_lock; /* Used to protect the=
 SYSTIME registers. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 ptp_adj_mult;<br>
@@ -679,10 +667,7 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 tx_hwtstamp_skipped;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 rx_hwtstamp_cleared;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 latch_event_flags;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u64 ptp_pps_start;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pps_delay;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spinlock_t ptp_rx_lock; /* Used to protect Rx t=
imestamp registers. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct ptp_pin_desc ptp_pin[3];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long latch_events[4];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ptp_tx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ptp_rx;<br>
@@ -695,7 +680,6 @@ struct i40e_pf {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 fd_inv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 phy_led_val;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 override_q_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 last_sw_conf_flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 last_sw_conf_valid_flags;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* List to keep previous DDP profiles to be rol=
led back in the future */<br>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/e=
thernet/intel/i40e/i40e_debugfs.c<br>
index 88240571721a..ef70ddbe9c2f 100644<br>
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c<br>
@@ -1028,9 +1028,6 @@ static ssize_t i40e_dbg_command_write(struct file *fi=
lp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;emp reset count: %d\n&qu=
ot;, pf-&gt;empr_count);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_info(&amp;pf-&gt;pdev-&gt;dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pf reset count: %d\n&quo=
t;, pf-&gt;pfr_count);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(&amp;pf-&gt;pdev-&gt;dev,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pf tx sluggish count: %d\n&quo=
t;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;tx_sluggish_count);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (strncmp(=
&amp;cmd_buf[5], &quot;port&quot;, 4) =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct i40e_aqc_query_port_ets_config_resp *bw_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct i40e_dcbx_config *cfg =3D<br>
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c<br>
index 7ded598a68e6..d71331a8a972 100644<br>
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c<br>
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c<br>
@@ -3465,7 +3465,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *r=
ing)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* some ATR related tx ring init */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi-&gt;back=
-&gt;flags)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring-&gt;atr_sample=
_rate =3D vsi-&gt;back-&gt;atr_sample_rate;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring-&gt;atr_sample=
_rate =3D I40E_DEFAULT_ATR_SAMPLE_RATE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;atr_count =
=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;atr_sample=
_rate =3D 0;<br>
@@ -10226,9 +10226,9 @@ static void i40e_clean_adminq_subtask(struct i40e_p=
f *pf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opcode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (i++ &lt; pf-&gt;adminq_work_limit);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (i++ &lt; I40E_AQ_WORK_LIMIT);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &lt; pf-&gt;adminq_work_limit)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &lt; I40E_AQ_WORK_LIMIT)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clear_bit(__I40E_AD=
MINQ_EVENT_PENDING, pf-&gt;state);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* re-enable Admin queue interrupt cause */<br>
@@ -12769,7 +12769,6 @@ static int i40e_sw_init(struct i40e_pf *pf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((pf-&gt;hw.func_caps.fd_filters_guaranteed =
&gt; 0) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pf-&gt;hw.func_caps.fd_filters_b=
est_effort &gt; 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(I40E_FLAG_F=
D_ATR_ENA, pf-&gt;flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;atr_sample_r=
ate =3D I40E_DEFAULT_ATR_SAMPLE_RATE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_bit(I40E_F=
LAG_MFP_ENA, pf-&gt;flags) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&g=
t;hw.num_partitions &gt; 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_info(&amp;pf-&gt;pdev-&gt;dev,<br>
@@ -12815,7 +12814,6 @@ static int i40e_sw_init(struct i40e_pf *pf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I40E_MAX=
_VF_COUNT);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif /* CONFIG_PCI_IOV */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;eeprom_version =3D 0xDEAD;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;lan_veb =3D I40E_NO_VEB;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;lan_vsi =3D I40E_NO_VSI;<br>
<br>
@@ -14976,12 +14974,11 @@ static void i40e_setup_pf_switch_element(struct i=
40e_pf *pf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the PF&#39;=
s VSI<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;mac_seid =3D=
 uplink_seid;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;pf_seid =3D =
downlink_seid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;main_vsi_sei=
d =3D seid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (printconfig)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev_info(&amp;pf-&gt;pdev-&gt;dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pf_seid=3D%d main_vsi_se=
id=3D%d\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pf-&gt;pf_seid, pf-&gt;main_vsi_seid=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 downlink_seid, pf-&gt;main_vsi_seid)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case I40E_SWITCH_ELEMENT_TYPE_PF:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case I40E_SWITCH_ELEMENT_TYPE_VF:<br>
@@ -15160,10 +15157,6 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf=
, bool reinit, bool lock_acqui<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fill in link information and enable LSE repo=
rting */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 i40e_link_event(pf);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Initialize user-specific link properties */<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;fc_autoneg_status =3D ((pf-&gt;hw.phy.li=
nk_info.an_info &amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I40E_AQ_AN_COMPLETED) ? true :=
 false);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 i40e_ptp_init(pf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!lock_acquired)<br>
@@ -15637,7 +15630,6 @@ static int i40e_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)<br>
=C2=A0#endif /* CONFIG_I40E_DCB */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i40e_pf *pf;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct i40e_hw *hw;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0static u16 pfs_found;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 wol_nvm_bits;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char nvm_ver[32];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 link_status;<br>
@@ -15715,7 +15707,6 @@ static int i40e_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;bus.device =3D PCI_SLOT(pdev-&gt;devfn);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;bus.func =3D PCI_FUNC(pdev-&gt;devfn);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;bus.bus_id =3D pdev-&gt;bus-&gt;number;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;instance =3D pfs_found;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Select something other than the 802.1ad ethe=
rtype for the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* switch to use internally and drop on in=
gress.<br>
@@ -15777,7 +15768,6 @@ static int i40e_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;aq.arq_buf_size =3D I40E_MAX_AQ_BUF_SIZE=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw-&gt;aq.asq_buf_size =3D I40E_MAX_AQ_BUF_SIZE=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pf-&gt;adminq_work_limit =3D I40E_AQ_WORK_LIMIT=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(pf-&gt;int_name, sizeof(pf-&gt;int_nam=
e) - 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s-%s:m=
isc&quot;,<br>
-- <br>
2.41.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Regards,<div>Kalesh A P</div></div></div></div>

--000000000000c2ca50060b31d547--

--000000000000c8422c060b31d53e
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
AQkEMSIEIMcTwxGib7HEyVn1CffOIoLJdZib67NHqDiYcveC7syiMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEyODA4MDIwOFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAS7jC02EXL
Hh4HS0+BEoadZtQ+AcM7Q7cvBp3/gfgRk/SjyBEWELISjEXUCyWuTQzC2mvn7R/Jcxy9iU13UExR
EZ7PqDQUTrkVt3bU/hELH4l4fLT1V2pEcamR8fwIzYyyz4PV+E7Ihnp2AG85TGMnQPBZkcDhNfX7
xE4eyf5nxD+jeXEMufUQgdPfZ1XVJ6DcWvlAtpeOkD+uJJPmmdm74sV6E7aDHdD4LsyIuAr+CFnk
6lAEtUqR96IYYbr5ljjcUa7GaS3I/A0KPr3IwQnl8b7MVr+KBM7faoriogybBTFmzKhEsI449iK+
uM78/NfBMIn2iDUICqSrol+bVTvm
--000000000000c8422c060b31d53e--

