Return-Path: <netdev+bounces-26806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01121779056
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1201282176
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7356FDC;
	Fri, 11 Aug 2023 13:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73063B3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 13:08:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA114205
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691759257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai7RARy0GvFTKbJLxGWvhy53DloW1hW+vR5xgBFmeS8=;
	b=PYmUKjEYErKly/jXul0FYVk73ogU/yBqyoCrNORH5r/9eyVcz/zCSUTArSCQ8vqFjij9/m
	cJihcvpcBj2x3QR3EelRQ/8/1CGt2vSHBpjq5L3vMfeeyDFR27dSTrNEcHrzbSgweE/KIF
	7p1q96br11KCap64Wybr1fMMNDZYNWc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-swl-igHVPI-EYItEqfzOgQ-1; Fri, 11 Aug 2023 09:07:35 -0400
X-MC-Unique: swl-igHVPI-EYItEqfzOgQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40fc220d343so24016571cf.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759255; x=1692364055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai7RARy0GvFTKbJLxGWvhy53DloW1hW+vR5xgBFmeS8=;
        b=SHqd4A3ymlKINEpmv7mpnKU8FOhh6quq6meWuYgK5EekcU0rVhwxk8drA2qWnXYS6n
         +EIx0D4HhUvyfuGwJBZyoGS7beYlFLbddcH4HBFConLRbFAwxudSAUW9QJEXuWfY03Yq
         486nKkBn3FRtAiqyvr5IkvhoSa3codzUJlMN77hsXbIYt1CpgZeFgvMbWEUmbJHepzJl
         6x0w08J52pitp8GDpFUC11UFtZpbqShZLI1gvH07z1Ftj/5bNuHzvIb8GzrXKFioVEQo
         ylPwDeV6j7hlG9/5+IWXkoTsp9s/4jS6Q84y9oL+EwbjlZu/3/g1P9afxit41ufxOzWQ
         HARQ==
X-Gm-Message-State: AOJu0YwV+TTpu/7QiyUIpaOKh6AOHtsTgrohqUJ6k3AmCI3VYlnSVepu
	x2L+bRyhavwjJgMK8uolLENXLMTQYZCF4DVBF6ptijd/HhgaSHMc7qzwqO3XvCthqxqVyzA7SE5
	dfcjYEDc/OBgOpvUY
X-Received: by 2002:a05:622a:87:b0:403:af80:2ac0 with SMTP id o7-20020a05622a008700b00403af802ac0mr2404819qtw.1.1691759254939;
        Fri, 11 Aug 2023 06:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwZyMEfgorr/nuxhQV6T9odES4XX4L/rCdHOeXynmVcva+OcX4DaJoc8RVk2UsmmAMNnJ0hw==
X-Received: by 2002:a05:622a:87:b0:403:af80:2ac0 with SMTP id o7-20020a05622a008700b00403af802ac0mr2404788qtw.1.1691759254632;
        Fri, 11 Aug 2023 06:07:34 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id kk12-20020a05622a2c0c00b0040ff2f2f172sm1167192qtb.38.2023.08.11.06.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:07:34 -0700 (PDT)
Date: Fri, 11 Aug 2023 08:07:31 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
Message-ID: <shclvmt6icvski4z2tkzi77wdqgek7lbjfo32m5v4qtsexutp7@txdejlevvqjr>
References: <20230810080909.6259-1-brgl@bgdev.pl>
 <j57dowviaas552jt6fdynyowkwm6j6xjc5ixjdk2v4nn4doibn@qnr47drkhljp>
 <CAMRc=Md4UR=KdS716GTQ0+34NR4S5QDBM0HAoxj59=Y5G13L3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md4UR=KdS716GTQ0+34NR4S5QDBM0HAoxj59=Y5G13L3A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 02:00:21PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 10, 2023 at 10:13 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Thu, Aug 10, 2023 at 10:09:00AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > This series contains changes required to enable EMAC1 on sa8775p-ride.
> > > This iteration no longer depends on any changes to the stmmac driver to
> > > be functional. It turns out I was mistaken in thinking that the two
> > > MACs' MDIO masters share the MDIO clock and data lines. In reality, only
> > > one MAC is connected to an MDIO bus and it controlls PHYs for both MAC0
> > > and MAC1. The MDIO master on MAC1 is not connected to anything.
> > >
> >
> > I've taken this for a quick (disconnected from network) spin, and things
> > work as expected without having anything plugged in.
> >
> > I'm trying to get someone to plug it in so I can test that networking
> > actually works, but the interesting bit is the phy/mdio bit here, and
> > that's at least working ok I can tell. The rest is boilerplate similar
> > to the other MAC instance which works fine.
> >
> > Removing the driver results in the following oops, but that's already
> > discussed[0] and is independent of the devicetree description:
> >
> > I'd add a test tag but I want to wait for some network traffic tests
> > before I do such. I wouldn't wait on picking it up just because of
> > that though.

I got it plugged in :)

Things work as expected, throughput seems to be ~950 Mbps and latency is
good. Thanks!

Tested-by: Andrew Halaney <ahalaney@redhat.com>

> >
> > [0] https://lore.kernel.org/netdev/ZNKLjuxnR2+V3g1D@shell.armlinux.org.uk/
> >
> > [root@dhcp19-243-28 ~]# modprobe -r dwmac_qcom_ethqos
> > [ 1260.620402] qcom-ethqos 23040000.ethernet eth1: stmmac_dvr_remove: removing driver
> > [ 1260.655724] qcom-ethqos 23040000.ethernet eth1: FPE workqueue stop
> > [ 1261.034265] qcom-ethqos 23000000.ethernet eth0: stmmac_dvr_remove: removing driver
> > [ 1261.042108] Unable to handle kernel paging request at virtual address dead000000000122
> > [ 1261.050379] Mem abort info:
> > [ 1261.053251]   ESR = 0x0000000096000044
> > [ 1261.057113]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [ 1261.062573]   SET = 0, FnV = 0
> > [ 1261.065712]   EA = 0, S1PTW = 0
> > [ 1261.068946]   FSC = 0x04: level 0 translation fault
> > [ 1261.073956] Data abort info:
> > [ 1261.076916]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> > [ 1261.082552]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> > [ 1261.087882]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [ 1261.093338] [dead000000000122] address between user and kernel address ranges
> > [ 1261.100667] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> > [ 1261.107096] Modules linked in: r8152 rfkill marvell dwmac_qcom_ethqos(-) qcom_pon stmmac_platform crct10dif_ce stmmac spi_geni_qcom i2c_qcom_geni phy_qcom_qmp_usb phy_qcom_sgmii_eth phy_qcom_snps_femto_v2 pcs_xpcs qcom_wdt socinfo phy_qcom_qmp_pcie fuse ufs_qcom phy_qcom_qmp_ufs
> > [ 1261.132407] CPU: 2 PID: 610 Comm: modprobe Not tainted 6.5.0-rc4-next-20230731-00008-g18ccccee8230 #7
> > [ 1261.141860] Hardware name: Qualcomm SA8775P Ride (DT)
> > [ 1261.147042] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 1261.154185] pc : device_link_put_kref+0x44/0x110
> > [ 1261.158926] lr : device_link_put_kref+0xf4/0x110
> > [ 1261.163662] sp : ffff800082a938e0
> > [ 1261.167066] x29: ffff800082a938e0 x28: ffff6ec68bdc9d80 x27: 0000000000000000
> > [ 1261.174390] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> > [ 1261.181714] x23: ffff800082a93b38 x22: ffff6ec68690f2d8 x21: ffff6ec6896aed30
> > [ 1261.189031] x20: ffff6ec68246b830 x19: ffff6ec68246b800 x18: 0000000000000006
> > [ 1261.196355] x17: ffff9259b7856000 x16: ffffdc7b42e3eaec x15: 725f7276645f6361
> > [ 1261.203679] x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000000
> > [ 1261.210996] x11: 0000000000000040 x10: ffffdc7b447de0b0 x9 : ffffdc7b447de0a8
> > [ 1261.218321] x8 : ffff6ec680400028 x7 : 0000000000000000 x6 : 0000000000000000
> > [ 1261.225645] x5 : ffff6ec680400000 x4 : 00000000c0000000 x3 : ffff6ec6896ae8b0
> > [ 1261.232963] x2 : dead000000000122 x1 : dead000000000122 x0 : ffff6ec68246b830
> > [ 1261.240287] Call trace:
> > [ 1261.242806]  device_link_put_kref+0x44/0x110
> > [ 1261.247190]  device_link_del+0x30/0x48
> > [ 1261.251040]  phy_detach+0x24/0x15c
> > [ 1261.254530]  phy_disconnect+0x44/0x5c
> > [ 1261.258295]  phylink_disconnect_phy+0x64/0xb0
> > [ 1261.262764]  stmmac_release+0x58/0x2d4 [stmmac]
> > [ 1261.267425]  __dev_close_many+0xac/0x14c
> > [ 1261.271458]  dev_close_many+0x88/0x134
> > [ 1261.275308]  unregister_netdevice_many_notify+0x130/0x7d0
> > [ 1261.280852]  unregister_netdevice_queue+0xd4/0xdc
> > [ 1261.285682]  unregister_netdev+0x24/0x38
> > [ 1261.289715]  stmmac_dvr_remove+0x80/0x150 [stmmac]
> > [ 1261.294636]  devm_stmmac_pltfr_remove+0x24/0x48 [stmmac_platform]
> > [ 1261.300887]  devm_action_release+0x14/0x20
> > [ 1261.305090]  devres_release_all+0xa0/0x100
> > [ 1261.309293]  device_unbind_cleanup+0x18/0x68
> > [ 1261.313676]  device_release_driver_internal+0x1f4/0x228
> > [ 1261.319039]  driver_detach+0x4c/0x98
> > [ 1261.322708]  bus_remove_driver+0x6c/0xbc
> > [ 1261.326739]  driver_unregister+0x30/0x60
> > [ 1261.330772]  platform_driver_unregister+0x14/0x20
> > [ 1261.335603]  qcom_ethqos_driver_exit+0x18/0x1a8 [dwmac_qcom_ethqos]
> > [ 1261.342035]  __arm64_sys_delete_module+0x19c/0x288
> > [ 1261.346952]  invoke_syscall+0x48/0x110
> > [ 1261.350804]  el0_svc_common.constprop.0+0xc4/0xe4
> > [ 1261.355636]  do_el0_svc+0x38/0x94
> > [ 1261.359040]  el0_svc+0x2c/0x84
> > [ 1261.362178]  el0t_64_sync_handler+0x120/0x12c
> > [ 1261.366646]  el0t_64_sync+0x190/0x194
> > [ 1261.370413] Code: d2802441 aa1403e0 f2fbd5a1 f9000462 (f9000043)
> > [ 1261.376661] ---[ end trace 0000000000000000 ]---
> > Segmentation fault
> >
> 
> Yep. This is a very deep problem and will be the same for any MAC
> reaching into another MAC's node to get its PHY's phandle. :(
> 
> Bart
> 


