Return-Path: <netdev+bounces-36195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E007AE3BC
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 04:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 735161C2083C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57961100;
	Tue, 26 Sep 2023 02:47:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA357F
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 02:47:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92FF10A
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695696428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
	b=LoKi+dsMjd/hRh/rWGKH++5GB1vbdVqxAo8s/Eyj1PvCwtxsAkAa94aPLrjqUAtR6fG6E2
	N6QS7Q2K93s3FgQgSAvrZDtwiLavLnZtt1KY6Cx9B35zstZYnRcXtJtVAJukW8qTyc0JDO
	wCSEBUy6ABQOvlNUe0MCrfrr+FhxTj0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-e62fqxzTO02MHedEKxMG6A-1; Mon, 25 Sep 2023 22:47:07 -0400
X-MC-Unique: e62fqxzTO02MHedEKxMG6A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5043c0cbb62so8855557e87.1
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 19:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696425; x=1696301225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbkEy7nXr1l5VA1EBNnZyo/vTZ0cPvoDisYtJVR0B78=;
        b=Yi0rP5fq4IJ1RHDU3KhRjsBD/k3D9hsFBeT5YjEIFpugJpaoTEHweewlKqkomn4D5c
         NqE6P3ErZyJUm9MbICYoAaq9Fkkmh+sRy72UreqE+zcLP+DGuf7R8I67OOhAzjysvcP7
         g2sulIi6KG5X0ThLxEZkXUjhbU5C9tRN1Gx3K8aGb69LIeu0ClvwJf5BROk1DtmNUxU9
         NTAgAPM7YJh8/PyRdPvAgndVnzxlK8cNQ+TeyQyizcOBWbQWqMIgYnGqxE6eVKOtsW6D
         r16gQ4xlX/AcMe7/0TKBPMLXLY37BVse/HMX7SULAX7QGhIW2q5LQkvZvq3Kv+KWhdqG
         mFzg==
X-Gm-Message-State: AOJu0YwZAVgWMHEZNFDpDCE8gpU+wsavStAiGML+8ar6HDW/0teC5g16
	1/kBjjthdCnX/fvlV7aslgRiI6WG/2H5KPNNj8+5VNgGwZY0ov5Yq2VCfKDgIguh0wb+9rOV0aT
	L3EaHMGrQGJLytUSMdOFQZvLTvJtQ1AYh
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id k42-20020a0565123daa00b005031adfb4d5mr8558589lfv.52.1695696425634;
        Mon, 25 Sep 2023 19:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCEVaBqO/+URj99AR2MxQjceBS7mj2Mlw1O/b53LZJbHeEMTYn3ctrlVFyFihUW9jZ0zcY9enbbfrCL1KLUJg=
X-Received: by 2002:a05:6512:3daa:b0:503:1adf:b4d5 with SMTP id
 k42-20020a0565123daa00b005031adfb4d5mr8558574lfv.52.1695696425334; Mon, 25
 Sep 2023 19:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:46:54 +0800
Message-ID: <CACGkMEvx5V8+-LZa8-G4VCXYiJVm0DL8pu_Ao0rvPtK48-FTDQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 1:05=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Hi All
> Really apologize for the delay, this is the draft RFC for
> iommufd support for vdpa, This code provides the basic function
> for iommufd support
>
> The code was tested and passed in device vdpa_sim_net
> The qemu code is
> https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
>
> ToDo
> 1. this code is out of date and needs to clean and rebase on the latest c=
ode
> 2. this code has some workaround, I Skip the check for
> iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> mutex for iommfd operations
> 3. only test in emulated device, other modes not tested yet
>
> After addressed these problems I will send out a new version for RFC. I w=
ill
> provide the code in 3 weeks

Something more needs to be done after a quick glance at the codes.

1) The support for device with platform IOMMU support
2) The support for multiple ASes per device

...

Thanks

>
> Thanks
> Cindy
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> The test step is
> 1. create vdpa_sim device
> ...
> vdpa dev add name vdpa15 mgmtdev vdpasim_net
> ...
> 2. load the VM with the command
>   -object iommufd,id=3Diommufd0 \
>   -device virtio-net-pci,netdev=3Dvhost-vdpa1,disable-legacy=3Don,disable=
-modern=3Doff\
>   -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa1=
,iommufd=3Diommufd0\
>
> 3. in guest VM you can find the vdpa_sim port works well.
> [root@ubuntunew ~]# ifconfig eth0
> eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
>         ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
>         RX packets 53  bytes 9108 (8.8 KiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 53  bytes 9108 (8.8 KiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> [root@ubuntunew ~]# ./test.sh eth0
> [  172.815279] pktgen: Packet Generator for packet performance testing. V=
ersion: 2.75
> Adding queue 0 of eth0
> Configuring devices eth0@0
> Running... ctrl^C to stop
>
> [root@ubuntunew ~]# ifconfig eth0
> eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>         inet6 fe80::5054:ff:fe12:3456  prefixlen 64  scopeid 0x20<link>
>         ether 52:54:00:12:34:56  txqueuelen 1000  (Ethernet)
>         RX packets 183455  bytes 11748533 (11.2 MiB)
>         RX errors 0  dropped 0  overruns 0  frame 0
>         TX packets 183473  bytes 11749685 (11.2 MiB)
>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>
> Cindy Lu (7):
>   vhost/iommufd: Add the functions support iommufd
>   Kconfig: Add the new file vhost/iommufd
>   vhost: Add 3 new uapi to support iommufd
>   vdpa: change the map/unmap process to support iommufd
>   vdpa: Add new vdpa_config_ops
>   vdpa_sim :Add support for iommufd
>   iommufd: Skip the CACHE_COHERENCY and iommu group check
>
>  drivers/iommu/iommufd/device.c   |   6 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c |   8 ++
>  drivers/vhost/Kconfig            |   1 +
>  drivers/vhost/Makefile           |   1 +
>  drivers/vhost/iommufd.c          | 151 +++++++++++++++++++++++
>  drivers/vhost/vdpa.c             | 201 +++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h            |  21 ++++
>  include/linux/vdpa.h             |  34 +++++-
>  include/uapi/linux/vhost.h       |  71 +++++++++++
>  9 files changed, 490 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vhost/iommufd.c
>
> --
> 2.34.3
>


