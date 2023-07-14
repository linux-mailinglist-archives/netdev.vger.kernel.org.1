Return-Path: <netdev+bounces-17801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F180275310B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC712820CA
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B663DC;
	Fri, 14 Jul 2023 05:19:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DB6AB2
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:19:00 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD151BFA
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:18:58 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E0A43F71E
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689311937;
	bh=4RwCmrifjQAszMSdyafC6AItguqTd3yShrJPY3GuzKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=QQ3gBCdpdBSQygt0xnQGzNjc3esGtiEn5Dz4L/ojvbVzFQIBoOVIXcAaLqzSdXjhO
	 P/JzhH7RcYPksfPpoa5PQ5yx+K0RJ8OLThkEodqZndS0Rdjc4Q7UajM8anZg4jx6r7
	 IhbQy1HgR5JJjIACCRq48cKLoUEe12U+QuTE5gCgDumxwuWTWNK9OgvUaK0nbPnFga
	 EGks8trJzDzp7+Kkr2tlATWCLXZ03Kss0rsb6couo3cBfEOfGTpgsKS6FV/g5Rsa5+
	 3cSQsWwY3jV/ztKAzZzjI8y0/pbu9LPM2La/B8FmYjWvU2c297aclS5FFaxoarV6ul
	 OoPNrIa0KE8rA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-265826eef7fso1659451a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689311936; x=1691903936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RwCmrifjQAszMSdyafC6AItguqTd3yShrJPY3GuzKo=;
        b=GmwSUUyPPHcQ0nQJ5HgiJNd9luRo831F8bpk59cLMG2CGphQPaPEmiYNkKqsq0SYlR
         D0bhyHqb5K3srRNUvPt3MVasLzoQRb4g9RtXFuRx6jz9ZihYZMaj7fFSGwdnGvw0YcOZ
         MM9jbEGLvsSeJ5U4CskyTP2GljjxRNJKkBEq12QZzXWBGRTnFsgXZgWq8wt9zsM4tYmx
         SZune38xzujBVTpWbx5BjUOHpHtlihlyxglh0SjdhlyrkimolNZc5FrXQlQ2JjRwoqE3
         KUc5Pw6TxyvgMJHy27lCslzenWc5IgbTHgsD1mhbBtotysqrk52FmjUtGiimCAMdgATv
         1WJg==
X-Gm-Message-State: ABy/qLayy2hLFM62u+ygpQQXJyyoD+OcNHdeX7ZspQbGAN7qrFjWoqbg
	tcISOmC3sLulY4aYZVg5Cm5na4IOV2TJwf0/Q6TcQ0pP62cEVodq0AJZVbsvzgk1vLavQ9Fk6m/
	+p9hbY3ogRuizoTs9isrYOA8gLEJBz4AdjtOK2KnAdKPdLNtVuA==
X-Received: by 2002:a17:90b:1643:b0:261:110e:30c1 with SMTP id il3-20020a17090b164300b00261110e30c1mr2428908pjb.4.1689311935773;
        Thu, 13 Jul 2023 22:18:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPTMsnX8dr5FIZHQ03Hx09Ztz5Lxo0FqHU0UBxtvQNOQK3SfMNeJz5gWDCMTOZ2rKIk09TKJd+otiXntG6fG0=
X-Received: by 2002:a17:90b:1643:b0:261:110e:30c1 with SMTP id
 il3-20020a17090b164300b00261110e30c1mr2428889pjb.4.1689311935452; Thu, 13 Jul
 2023 22:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230526163001.67626-1-aaron.ma@canonical.com> <20230607015646.558534-1-aaron.ma@canonical.com>
In-Reply-To: <20230607015646.558534-1-aaron.ma@canonical.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 14 Jul 2023 13:18:44 +0800
Message-ID: <CAAd53p4V36qjyL1fMF20pY9wD4sLXWLQyJVib5Zt4NGOgnF5yg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net v2] igb: fix hang issue of AER error
 during resume
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jeff Garzik <jgarzik@redhat.com>, 
	Auke Kok <auke-jan.h.kok@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Aaron,

On Wed, Jun 7, 2023 at 9:56=E2=80=AFAM Aaron Ma <aaron.ma@canonical.com> wr=
ote:
>
> PCIe AER error_detected caused a race issue with igb_resume.
> Protect error_detected when igb is in down state.
>
> Error logs:
> kernel: igb 0000:02:00.0: disabling already-disabled device
> kernel: WARNING: CPU: 0 PID: 277 at drivers/pci/pci.c:2248 pci_disable_de=
vice+0xc4/0xf0
> kernel: RIP: 0010:pci_disable_device+0xc4/0xf0
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  igb_io_error_detected+0x3e/0x60
> kernel:  report_error_detected+0xd6/0x1c0
> kernel:  ? __pfx_report_normal_detected+0x10/0x10
> kernel:  report_normal_detected+0x16/0x30
> kernel:  pci_walk_bus+0x74/0xa0
> kernel:  pcie_do_recovery+0xb9/0x340
> kernel:  ? __pfx_aer_root_reset+0x10/0x10
> kernel:  aer_process_err_devices+0x168/0x220
> kernel:  aer_isr+0x1b5/0x1e0
> kernel:  ? __pfx_irq_thread_fn+0x10/0x10
> kernel:  irq_thread_fn+0x21/0x70
> kernel:  irq_thread+0xf8/0x1c0
> kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
> kernel:  ? __pfx_irq_thread+0x10/0x10
> kernel:  kthread+0xef/0x120
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x29/0x50
> kernel:  </TASK>
> kernel: ---[ end trace 0000000000000000 ]---
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217446
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> Reviewed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>

Can you please give [1] a try?
I think avoid using rtnl_lock() is more ideal.

[1] https://lore.kernel.org/intel-wired-lan/20230714050541.2765246-1-kai.he=
ng.feng@canonical.com/

Kai-Heng

> ---
> V1->V2: Add target tree tag net and Fixes tag.
>
>  drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 58872a4c2540..8333d4ac8169 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9581,14 +9581,21 @@ static pci_ers_result_t igb_io_error_detected(str=
uct pci_dev *pdev,
>         struct net_device *netdev =3D pci_get_drvdata(pdev);
>         struct igb_adapter *adapter =3D netdev_priv(netdev);
>
> +       if (test_bit(__IGB_DOWN, &adapter->state))
> +               return PCI_ERS_RESULT_DISCONNECT;
> +
> +       rtnl_lock();
>         netif_device_detach(netdev);
>
> -       if (state =3D=3D pci_channel_io_perm_failure)
> +       if (state =3D=3D pci_channel_io_perm_failure) {
> +               rtnl_unlock();
>                 return PCI_ERS_RESULT_DISCONNECT;
> +       }
>
>         if (netif_running(netdev))
>                 igb_down(adapter);
>         pci_disable_device(pdev);
> +       rtnl_unlock();
>
>         /* Request a slot reset. */
>         return PCI_ERS_RESULT_NEED_RESET;
> --
> 2.34.1
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

