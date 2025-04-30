Return-Path: <netdev+bounces-187073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C5AA4C0D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4644D9C79F7
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DE3264F99;
	Wed, 30 Apr 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="S/mlh9fb"
X-Original-To: netdev@vger.kernel.org
Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF582221F0E
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017583; cv=pass; b=Tx6t7NX+YGrwDxXRqySYGq1VirkNb9wtkGQ51cMfRdrnfvdqCtqG9Q3d+b9cHIjqPcRqtpkZdO7m3IefaBBVXvwMsVgECLpjhRzuyW+dOJjNNzX3IYMDuliwpduCvukRIPwZUPHlw8gu7JAgEE37WZVnu/Hc2ARCGMTo1piNY7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017583; c=relaxed/simple;
	bh=7q4TON/CP5VNKrzQutWaJKu7s5Vv+U1P1Po+KKxM5E0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vodh6EbJ/AZd5AekGqs+gxh8zJOkgJ4qWnol35ZjXjdkGtf+0CttJQJDKebD371O9fjr23tCCO9YIQgDJ1x9wyrGCJp/TLYdmKvNXJ+S9Xufnpsv3dL2/0rpm+F4cngHu+TYrKVkpG35hS2YpyZB6hu/APLI75d0tetlC5j97ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=S/mlh9fb; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746017559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KuXrxPsvfwHO8r7LGCfG19D6NhgBrYCkyFqSm0zqtZB/R7SwqwVNf9CjW16E3J7+TuGp82vH4drCd48j7ggk0RVLgAN1epjMJPlPsNJxsIxSOYRjyMoYsGj8ZKDDuRw+Jn4PV9a7pErNCMlCkRvoaZGiNyzshVuDnl1nUNsJEe8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746017559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FNPV2pkJJq/D8J2/KeLCScpAIpXHwU7pqqsjNGQ7j6E=; 
	b=ANFFqHX4hXQvBS4YJxq4q2/NraUWoakxUZdfHT6lWDIFylGG+CaCM5UfjBylCb9mO5G0r/qlD27ehSNiS6/XFhy6hhnvSJVRDWnmRzVbxh6nyAykpQUQg+9DJY+gOhMRxJS2kTU9vG8NHBO2+ZtrvsfCvOD0kuCrLzu+sRW8fgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746017559;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FNPV2pkJJq/D8J2/KeLCScpAIpXHwU7pqqsjNGQ7j6E=;
	b=S/mlh9fbvnCZb0tLAKowtqEXPTIojNDTbge1BuYYa055klB6V3DvthhPoOI1cttZ
	d67P1VZJYjdqRf09cldNpiZ2qF4nznJH8ghfJbrXiqRpReYsYnNyL7wr8ZkrvBSV+8k
	De7G/gXWf4NblnLPSGUPuZmvmYOubUCG6mvthipw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746017558073615.1737686715957; Wed, 30 Apr 2025 05:52:38 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:52:38 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Aurelien Aptel" <aaptel@nvidia.com>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"netdev" <netdev@vger.kernel.org>, "sagi" <sagi@grimberg.me>,
	"hch" <hch@lst.de>, "kbusch" <kbusch@kernel.org>,
	"axboe" <axboe@fb.com>, "chaitanyak" <chaitanyak@nvidia.com>,
	"davem" <davem@davemloft.net>, "kuba" <kuba@kernel.org>,
	"aurelien.aptel" <aurelien.aptel@gmail.com>,
	"smalin" <smalin@nvidia.com>, "malin1024" <malin1024@gmail.com>,
	"ogerlitz" <ogerlitz@nvidia.com>, "yorayz" <yorayz@nvidia.com>,
	"borisp" <borisp@nvidia.com>, "galshalom" <galshalom@nvidia.com>,
	"mgurtovoy" <mgurtovoy@nvidia.com>, "tariqt" <tariqt@nvidia.com>,
	"edumazet" <edumazet@google.com>
Message-ID: <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jakub,

---- On Wed, 30 Apr 2025 05:57:21 -0300 Aurelien Aptel <aaptel@nvidia.com> =
wrote ---

 > Hi,=20
 > =20
 > The next iteration of our nvme-tcp receive offload series, rebased on to=
p of=20
 > yesterday net-next 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW St=
ats").=20
 > =20
 > As requested, we now have CI for testing this feature. This has been=20
 > realized through the addition of a NIPA executor in=20
 > KernelCI[0]. KernelCI now has access to execute tests on the NVIDIA=20
 > hardware where we use this feature and then report the results for=20
 > NIPA collection.=20
 > =20
 > If you want, you can follow the test executions through the NIPA=20
 > contest page[1]. As expected, tests are failing right now as they need=
=20
 > this patchset applied to the netdev-testing hw branch, but they should=
=20
 > pass once the patches make their way in to that branch.=20

When I go to patchwork to look for the CI results for this patchset:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D958427&state=
=3D*

No tests ran. I wonder if this is because the patches were marked as "Not a=
pplicable". [1]
I could figure out why it was marked as Not applicable right way. My guess =
is that
NIPA believes the patches should be applied elsewhere and not in net-next?

Could you advise on what we need to do get this patchset through netdev-CI =
testing?

Best,

- Gus

[1] https://github.com/linux-netdev/nipa/blob/main/pw_brancher.py#L79

 > =20
 > Previous submission (v27):=20
 > https://lore.kernel.org/netdev/20250303095304.1534-1-aaptel@nvidia.com/=
=20
 > =20
 > The changes are also available through git:=20
 > Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v28=20
 > Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v28=20
 > =20
 > The NVMe-TCP offload was presented in netdev 0x16 (video available):=20
 > - https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Im=
plementation-and-Performance-Gains=20
 > - https://youtu.be/W74TR-SNgi4=20
 > =20
 > [0] https://kernelci.org/=20
 > [1] https://netdev.bots.linux.dev/contest.html?executor=3Dkernelci-lava-=
collabora (tick the Individual sub-tests box)=20
 > =20
 > =20
 > From: Aurelien Aptel <aaptel@nvidia.com>=20
 > From: Shai Malin <smalin@nvidia.com>=20
 > From: Boris Pismenny <borisp@nvidia.com>=20
 > From: Or Gerlitz <ogerlitz@nvidia.com>=20
 > From: Yoray Zack <yorayz@nvidia.com>=20
 > From: Max Gurtovoy <mgurtovoy@nvidia.com>=20
 > =20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > =20
 > This series adds support for NVMe-TCP receive offloads. The method here=
=20
 > does not mandate the offload of the network stack to the device.=20
 > Instead, these work together with TCP to offload:=20
 > 1. copy from SKB to the block layer buffers.=20
 > 2. CRC calculation and verification for received PDU.=20
 > =20
 > The series implements these as a generic offload infrastructure for stor=
age=20
 > protocols, which calls TCP Direct Data Placement and TCP Offload CRC=20
 > respectively. We use this infrastructure to implement NVMe-TCP offload f=
or=20
 > copy and CRC.=20
 > Future implementations can reuse the same infrastructure for other proto=
cols=20
 > such as iSCSI.=20
 > =20
 > Note:=20
 > These offloads are similar in nature to the packet-based NIC TLS offload=
s,=20
 > which are already upstream (see net/tls/tls_device.c).=20
 > You can read more about TLS offload here:=20
 > https://www.kernel.org/doc/html/latest/networking/tls-offload.html=20
 > =20
 > Queue Level=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > The offload for IO queues is initialized after the handshake of the=20
 > NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`=20
 > with the tcp socket of the nvme_tcp_queue:=20
 > This operation sets all relevant hardware contexts in=20
 > hardware. If it fails, then the IO queue proceeds as usual with no offlo=
ad.=20
 > If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may=
 be=20
 > called to perform copy offload, and crc offload will be used.=20
 > This initialization does not change the normal operation of NVMe-TCP in =
any=20
 > way besides adding the option to call the above mentioned NDO operations=
.=20
 > =20
 > For the admin queue, NVMe-TCP does not initialize the offload.=20
 > Instead, NVMe-TCP calls the driver to configure limits for the controlle=
r,=20
 > such as max_hw_sectors and max_segments, these must be limited to accomm=
odate=20
 > potential HW resource limits, and to improve performance.=20
 > =20
 > If some error occurs, and the IO queue must be closed or reconnected, th=
en=20
 > offload is teardown and initialized again. Additionally, we handle netde=
v=20
 > down events via the existing error recovery flow.=20
 > =20
 > IO Level=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=20
 > The NVMe-TCP layer calls the NIC driver to map block layer buffers to CI=
D=20
 > using `nvme_tcp_setup_ddp` before sending the read request. When the res=
ponse=20
 > is received, then the NIC HW will write the PDU payload directly into th=
e=20
 > designated buffer, and build an SKB such that it points into the destina=
tion=20
 > buffer. This SKB represents the entire packet received on the wire, but =
it=20
 > points to the block layer buffers. Once NVMe-TCP attempts to copy data f=
rom=20
 > this SKB to the block layer buffer it can skip the copy by checking in t=
he=20
 > copying function: if (src =3D=3D dst) -> skip copy=20
 > =20
 > Finally, when the PDU has been processed to completion, the NVMe-TCP lay=
er=20
 > releases the NIC HW context by calling `nvme_tcp_teardown_ddp` which=20
 > asynchronously unmaps the buffers from NIC HW.=20
 > =20
 > The NIC must release its mapping between command IDs and the target buff=
ers.=20
 > This mapping is released when NVMe-TCP calls the NIC=20
 > driver (`nvme_tcp_offload_socket`).=20
 > As completing IOs is performance critical, we introduce asynchronous=20
 > completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later=
=20
 > call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).=20
 > =20
 > On the IO level, and in order to use the offload only when a clear=20
 > performance improvement is expected, the offload is used only for IOs=20
 > which are bigger than io_threshold.=20
 > =20
 > SKB=20
 > =3D=3D=3D=20
 > The DDP (zero-copy) and CRC offloads require two additional bits in the =
SKB.=20
 > The ddp bit is useful to prevent condensing of SKBs which are targeted=
=20
 > for zero-copy. The crc bit is useful to prevent GRO coalescing SKBs with=
=20
 > different offload values. This bit is similar in concept to the=20
 > "decrypted" bit.=20
 > =20
 > After offload is initialized, we use the SKB's crc bit to indicate that:=
=20
 > "there was no problem with the verification of all CRC fields in this pa=
cket's=20
 > payload". The bit is set to zero if there was an error, or if HW skipped=
=20
 > offload for some reason. If *any* SKB in a PDU has (crc !=3D 1), then th=
e=20
 > calling driver must compute the CRC, and check it. We perform this check=
, and=20
 > accompanying software fallback at the end of the processing of a receive=
d PDU.=20
 > =20
 > Resynchronization flow=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > The resynchronization flow is performed to reset the hardware tracking o=
f=20
 > NVMe-TCP PDUs within the TCP stream. The flow consists of a request from=
=20
 > the hardware proxied by the driver, regarding a possible location of a=
=20
 > PDU header. Followed by a response from the NVMe-TCP driver.=20
 > =20
 > This flow is rare, and it should happen only after packet loss or=20
 > reordering events that involve NVMe-TCP PDU headers.=20
 > =20
 > CID Mapping=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > ConnectX-7 assumes linear CID (0...N-1 for queue of size N) where the Li=
nux NVMe=20
 > driver uses part of the 16 bit CCID for generation counter.=20
 > To address that, we use the existing quirk in the NVMe layer when the HW=
=20
 > driver advertises that they don't support the full 16 bit CCID range.=20
 > =20
 > Enablement on ConnectX-7=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=20
 > By default, NVMeTCP offload is disabled in the mlx driver and in the nvm=
e-tcp host.=20
 > In order to enable it:=20
 > =20
 >  # Disable CQE compression (specific for ConnectX)=20
 >  ethtool --set-priv-flags <device> rx_cqe_compress off=20
 > =20
 >  # Enable the ULP-DDP=20
 >  ./tools/net/ynl/pyynl/cli.py \=20
 >  --spec Documentation/netlink/specs/ulp_ddp.yaml --do caps-set \=20
 >  --json '{"ifindex": <device index>, "wanted": 3, "wanted_mask": 3}'=20
 > =20
 >  # Enable ULP offload in nvme-tcp=20
 >  modprobe nvme-tcp ddp_offload=3D1=20
 > =20
 > Following the device ULP-DDP enablement, all the IO queues/sockets which=
 are=20
 > running on the device are offloaded.=20
 > =20
 > Performance=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > With this implementation, using the ConnectX-7 NIC, we were able to=20
 > demonstrate the following CPU utilization improvement:=20
 > =20
 > Without data digest:=20
 > For  64K queued read IOs =E2=80=93 up to 32% improvement in the BW/IOPS =
(111 Gbps vs. 84 Gbps).=20
 > For 512K queued read IOs =E2=80=93 up to 55% improvement in the BW/IOPS =
(148 Gbps vs. 98 Gbps).=20
 > =20
 > With data digest:=20
 > For  64K queued read IOs =E2=80=93 up to 107% improvement in the BW/IOPS=
 (111 Gbps vs. 53 Gbps).=20
 > For 512K queued read IOs =E2=80=93 up to 138% improvement in the BW/IOPS=
 (146 Gbps vs. 61 Gbps).=20
 > =20
 > With small IOs we are not expecting that the offload will show a perform=
ance gain.=20
 > =20
 > The test configuration:=20
 > - fio command: qd=3D128, jobs=3D8.=20
 > - Server: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz, 160 cores.=20
 > =20
 > Patches=20
 > =3D=3D=3D=3D=3D=3D=3D=20
 > Patch 1:  Introduce the infrastructure for all ULP DDP and ULP DDP CRC o=
ffloads.=20
 > Patch 2:  Add netlink family to manage ULP DDP capabilities & stats.=20
 > Patch 3:  The iov_iter change to skip copy if (src =3D=3D dst).=20
 > Patch 4:  Export the get_netdev_for_sock function from TLS to generic lo=
cation.=20
 > Patch 5:  NVMe-TCP changes to call NIC driver on queue init/teardown and=
 resync.=20
 > Patch 6:  NVMe-TCP changes to call NIC driver on IO operation=20
 >  setup/teardown, and support async completions.=20
 > Patch 7:  NVMe-TCP changes to support CRC offload on receive=20
 >  Also, this patch moves CRC calculation to the end of PDU=20
 >  in case offload requires software fallback.=20
 > Patch 8:  NVMe-TCP handling of netdev events: stop the offload if netdev=
 is=20
 >  going down.=20
 > Patch 9:  Documentation of ULP DDP offloads.=20
 > =20
 > The rest of the series is the mlx5 implementation of the offload.=20
 > =20
 > Testing=20
 > =3D=3D=3D=3D=3D=3D=3D=20
 > This series was tested on ConnectX-7 HW using various configurations=20
 > of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-=
TCP=20
 > targets.=20
 > =20
 > Compatibility=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > * The offload works with bare-metal or SRIOV.=20
 > * The HW can support up to 64K connections per device (assuming no=20
 >  other HW accelerations are used). In this series, we will introduce=20
 >  the support for up to 4k connections, and we have plans to increase it.=
=20
 > * In the current HW implementation, the combination of NVMeTCP offload=
=20
 >  with TLS is not supported. In the future, if it will be implemented,=20
 >  the impact on the NVMe/TCP layer will be minimal.=20
 > * The NVMeTCP offload ConnectX 7 HW can support tunneling, but we=20
 >  don't see the need for this feature yet.=20
 > * NVMe poll queues are not in the scope of this series.=20
 > =20
 > Future Work=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > * NVMeTCP transmit offload.=20
 > * NVMeTCP offloads incremental features.=20
 > =20
 > Changes since v27:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - make driver code 80 columns when possible (Jakub).=20
 > - rebase on newer mlx5 driver.=20
 > =20
 > Changes since v26:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - remove inlines in C files (Paolo).=20
 > - use netdev tracker in netdev ref accounting calls (Paolo).=20
 > - add skb_cmp_ulp_crc() helper (Paolo).=20
 > =20
 > Changes since v25:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - continuous integration via NIPA.=20
 > - check for tls with nvme_tcp_tls_configured().=20
 > =20
 > Changes since v24:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - ulp_ddp.h: rename cfg->io_cpu to ->affinity_hint (Sagi).=20
 > - add compile-time optimization for the iov memcpy skip check (David).=
=20
 > - add rtnl_lock/unlock() around get_netdev_for_sock().=20
 > - fix vlan lookup in get_netdev_for_sock().=20
 > - fix NULL deref when netdev doesn't have ulp_ddp ops.=20
 > - use inline funcs for skb bits to remove ifdef (match tls code).=20
 > =20
 > Changes since v23:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - ulp_ddp.h: remove queue_id (Sagi).=20
 > - nvme-tcp: remove nvme_status, always set req->{result,status} (Sagi).=
=20
 > - nvme-tcp: rename label to ddgst_valid (Sagi).=20
 > - mlx5: remove newline from error messages (Jakub).=20
 > =20
 > Changes since v22:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - protect ->set_caps() with rtnl_lock().=20
 > - refactor of netdev GOING_DOWN event handler (Sagi).=20
 > - fix DDGST recalc for IOs under offload threshold.=20
 > - rebase against new mlx5 driver changes.=20
 > =20
 > Changes since v21:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - add netdevice_tracker to get_netdev_for_sock() (Jakub).=20
 > - remove redundant q->data_digest check (Max).=20
 > =20
 > Changes since v20:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - get caps&limits from nvme and remove query_limits() (Sagi).=20
 > - rename queue->ddp_status to queue->nvme_status and move ouf of ifdef (=
Sagi).=20
 > - call setup_ddp() during request setup (Sagi).=20
 > - remove null check in ddgst_recalc() (Sagi).=20
 > - remove local var in offload_socket() (Sagi).=20
 > - remove ifindex and hdr from netlink context data (Jiri).=20
 > - clean netlink notify handling and use nla_get_uint() (Jiri).=20
 > - normalize doc in ulp_ddp netlink spec (Jiri).=20
 > =20
 > Changes since v19:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - rebase against net-next.=20
 > - fix ulp_ddp_is_cap_active() error reported by the kernel test bot.=20
 > =20
 > Changes since v18:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - rebase against net-next.=20
 > - integrate with nvme-tcp tls.=20
 > - add const in parameter for skb_is_no_condense() and skb_is_ulp_crc().=
=20
 > - update documentation.=20
 > =20
 > Changes since v17:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - move capabilities from netdev to driver and add get_caps() op (Jiri).=
=20
 > - set stats by name explicitly, remove dump ops (Jiri).=20
 > - rename struct, functions, YAML attributes, reuse caps enum (Jiri).=20
 > - use uint instead of u64 in YAML spec (Jakub).=20
 > =20
 > Changes since v16:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - rebase against net-next=20
 > - minor whitespace changes=20
 > - updated CC list=20
 > =20
 > Changes since v15:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - add API func to get netdev & limits together (Sagi).=20
 > - add nvme_tcp_stop_admin_queue()=20
 > - hide config.io_cpu in the interface (Sagi).=20
 > - rename skb->ulp_ddp to skb->no_condense (David).=20
 > =20
 > Changes since v14:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Added dumpit op for ULP_DDP_CMD_{GET,STATS} (Jakub).=20
 > - Remove redundant "-ddp-" fom stat names.=20
 > - Fix checkpatch/sparse warnings.=20
 > =20
 > Changes since v13:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Replace ethtool interface with a new netlink family (Jakub).=20
 > - Simplify and squash mlx5e refactoring changes.=20
 > =20
 > Changes since v12:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Rebase on top of NVMe-TCP kTLS v10 patches.=20
 > - Add ULP DDP wrappers for common code and ref accounting (Sagi).=20
 > - Fold modparam and tls patches into control-path patch (Sagi).=20
 > - Take one netdev ref for the admin queue (Sagi).=20
 > - Simplify start_queue() logic (Sagi).=20
 > - Rename=20
 >  * modparam ulp_offload modparam -> ddp_offload (Sagi).=20
 >  * queue->offload_xxx to queue->ddp_xxx (Sagi).=20
 >  * queue->resync_req -> resync_tcp_seq (Sagi).=20
 > - Use SECTOR_SHIFT (Sagi).=20
 > - Use nvme_cid(rq) (Sagi).=20
 > - Use sock->sk->sk_incoming_cpu instead of queue->io_cpu (Sagi).=20
 > - Move limits results to ctrl struct.=20
 > - Add missing ifdefs.=20
 > - Fix docs and reverse xmas tree (Simon).=20
 > =20
 > Changes since v11:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Rebase on top of NVMe-TCP kTLS offload.=20
 > - Add tls support bit in struct ulp_ddp_limits.=20
 > - Simplify logic in NVMe-TCP queue init.=20
 > - Use new page pool in mlx5 driver.=20
 > =20
 > Changes since v10:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Pass extack to drivers for better error reporting in the .set_caps=20
 >  callback (Jakub).=20
 > - netlink: use new callbacks, existing macros, padding, fix size=20
 >  add notifications, update specs (Jakub).=20
 > =20
 > Changes since v9:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Add missing crc checks in tcp_try_coalesce() (Paolo).=20
 > - Add missing ifdef guard for socket ops (Paolo).=20
 > - Remove verbose netlink format for statistics (Jakub).=20
 > - Use regular attributes for statistics (Jakub).=20
 > - Expose and document individual stats to uAPI (Jakub).=20
 > - Move ethtool ops for caps&stats to netdev_ops->ulp_ddp_ops (Jakub).=20
 > =20
 > Changes since v8:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Make stats stringset global instead of per-device (Jakub).=20
 > - Remove per-queue stats (Jakub).=20
 > - Rename ETH_SS_ULP_DDP stringset to ETH_SS_ULP_DDP_CAPS.=20
 > - Update & fix kdoc comments.=20
 > - Use 80 columns limit for nvme code.=20
 > =20
 > Changes since v7:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Remove ULP DDP netdev->feature bit (Jakub).=20
 > - Expose ULP DDP capabilities to userspace via ethtool netlink messages =
(Jakub).=20
 > - Move ULP DDP stats to dedicated stats group (Jakub).=20
 > - Add ethtool_ops operations for setting capabilities and getting stats =
(Jakub).=20
 > - Move ulp_ddp_netdev_ops into net_device_ops (Jakub).=20
 > - Use union for protocol-specific struct instances (Jakub).=20
 > - Fold netdev_sk_get_lowest_dev() into get_netdev_for_sock (Christoph).=
=20
 > - Rename memcpy skip patch to something more obvious (Christoph).=20
 > - Move capabilities from ulp_ddp.h to ulp_ddp_caps.h.=20
 > - Add "Compatibility" section on the cover letter (Sagi).=20
 > =20
 > Changes since v6:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Moved IS_ULP_{DDP,CRC} macros to skb_is_ulp_{ddp,crc} inline functions=
 (Jakub).=20
 > - Fix copyright notice (Leon).=20
 > - Added missing ifdef to allow build with MLX5_EN_TLS disabled.=20
 > - Fix space alignment, indent and long lines (max 99 columns).=20
 > - Add missing field documentation in ulp_ddp.h.=20
 > =20
 > Changes since v5:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Limit the series to RX offloads.=20
 > - Added two separated skb indications to avoid wrong flushing of GRO=20
 >  when aggerating offloaded packets.=20
 > - Use accessor functions for skb->ddp and skb->crc (Eric D) bits.=20
 > - Add kernel-doc for get_netdev_for_sock (Christoph).=20
 > - Remove ddp_iter* routines and only modify _copy_to_iter (Al Viro, Chri=
stoph).=20
 > - Remove consume skb (Sagi).=20
 > - Add a knob in the ddp limits struct for the HW driver to advertise=20
 >  if they need the nvme-tcp driver to apply the generation counter=20
 >  quirk. Use this knob for the mlx5 CX7 offload.=20
 > - bugfix: use u8 flags instead of bool in mlx5e_nvmeotcp_queue->dgst.=20
 > - bugfix: use sg_dma_len(sgl) instead of sgl->length.=20
 > - bugfix: remove sgl leak in nvme_tcp_setup_ddp().=20
 > - bugfix: remove sgl leak when only using DDGST_RX offload.=20
 > - Add error check for dma_map_sg().=20
 > - Reduce #ifdef by using dummy macros/functions.=20
 > - Remove redundant netdev null check in nvme_tcp_pdu_last_send().=20
 > - Rename ULP_DDP_RESYNC_{REQ -> PENDING}.=20
 > - Add per-ulp limits struct (Sagi).=20
 > - Add ULP DDP capabilities querying (Sagi).=20
 > - Simplify RX DDGST logic (Sagi).=20
 > - Document resync flow better.=20
 > - Add ulp_offload param to nvme-tcp module to enable ULP offload (Sagi).=
=20
 > - Add a revert commit to reintroduce nvme_tcp_queue->queue_size.=20
 > =20
 > Changes since v4:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Add transmit offload patches.=20
 > - Use one feature bit for both receive and transmit offload.=20
 > =20
 > Changes since v3:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact=20
 >  when compiled out (Christoph).=20
 > - Simplify netdev references and reduce the use of=20
 >  get_netdev_for_sock (Sagi).=20
 > - Avoid "static" in it's own line, move it one line down (Christoph)=20
 > - Pass (queue, skb, *offset) and retrieve the pdu_seq in=20
 >  nvme_tcp_resync_response (Sagi).=20
 > - Add missing assignment of offloading_netdev to null in offload_limits=
=20
 >  error case (Sagi).=20
 > - Set req->offloaded =3D false once -- the lifetime rules are:=20
 >  set to false on cmd_setup / set to true when ddp setup succeeds (Sagi).=
=20
 > - Replace pr_info_ratelimited with dev_info_ratelimited (Sagi).=20
 > - Add nvme_tcp_complete_request and invoke it from two similar call=20
 >  sites (Sagi).=20
 > - Introduce nvme_tcp_req_map_sg earlier in the series (Sagi).=20
 > - Add nvme_tcp_consume_skb and put into it a hunk from=20
 >  nvme_tcp_recv_data to handle copy with and without offload.=20
 > =20
 > Changes since v2:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Use skb->ddp_crc for copy offload to avoid skb_condense.=20
 > - Default mellanox driver support to no (experimental feature).=20
 > - In iov_iter use non-ddp functions for kvec and iovec.=20
 > - Remove typecasting in NVMe-TCP.=20
 > =20
 > Changes since v1:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Rework iov_iter copy skip if src=3D=3Ddst to be less intrusive (David =
Ahern).=20
 > - Add tcp-ddp documentation (David Ahern).=20
 > - Refactor mellanox driver patches into more patches (Saeed Mahameed).=
=20
 > - Avoid pointer casting (David Ahern).=20
 > - Rename NVMe-TCP offload flags (Shai Malin).=20
 > - Update cover-letter according to the above.=20
 > =20
 > Changes since RFC v1:=20
 > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 > - Split mlx5 driver patches to several commits.=20
 > - Fix NVMe-TCP handling of recovery flows. In particular, move queue off=
load.=20
 >  init/teardown to the start/stop functions.=20
 > =20
 > Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>=20
 > =20
 > =20
 > Aurelien Aptel (3):=20
 >  netlink: add new family to manage ULP_DDP enablement and stats=20
 >  net/tls,core: export get_netdev_for_sock=20
 >  net/mlx5e: NVMEoTCP, statistics=20
 > =20
 > Ben Ben-Ishay (8):=20
 >  iov_iter: skip copy if src =3D=3D dst for direct data placement=20
 >  net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations=20
 >  net/mlx5e: NVMEoTCP, offload initialization=20
 >  net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration=20
 >  net/mlx5e: NVMEoTCP, queue init/teardown=20
 >  net/mlx5e: NVMEoTCP, ddp setup and resync=20
 >  net/mlx5e: NVMEoTCP, async ddp invalidation=20
 >  net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload=20
 > =20
 > Boris Pismenny (4):=20
 >  net: Introduce direct data placement tcp offload=20
 >  nvme-tcp: Add DDP offload control path=20
 >  nvme-tcp: Add DDP data-path=20
 >  net/mlx5e: TCP flow steering for nvme-tcp acceleration=20
 > =20
 > Or Gerlitz (3):=20
 >  nvme-tcp: Deal with netdevice DOWN events=20
 >  net/mlx5e: Rename from tls to transport static params=20
 >  net/mlx5e: Refactor ico sq polling to get budget=20
 > =20
 > Yoray Zack (2):=20
 >  nvme-tcp: RX DDGST offload=20
 >  Documentation: add ULP DDP offload documentation=20
 > =20
 >  Documentation/netlink/specs/ulp_ddp.yaml      |  172 +++=20
 >  Documentation/networking/index.rst            |    1 +=20
 >  Documentation/networking/ulp-ddp-offload.rst  |  372 +++++=20
 >  .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +=20
 >  .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +=20
 >  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   30 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-=20
 >  .../ethernet/mellanox/mlx5/core/en/params.c   |   13 +-=20
 >  .../ethernet/mellanox/mlx5/core/en/params.h   |    3 +=20
 >  .../mellanox/mlx5/core/en/reporter_rx.c       |    4 +-=20
 >  .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   30 +=20
 >  .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    5 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en/tir.c  |   16 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en/tir.h  |    3 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   34 +-=20
 >  .../mlx5/core/en_accel/common_utils.h         |   34 +=20
 >  .../mellanox/mlx5/core/en_accel/en_accel.h    |    3 +=20
 >  .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   12 +-=20
 >  .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-=20
 >  .../mellanox/mlx5/core/en_accel/ktls.c        |    3 +-=20
 >  .../mellanox/mlx5/core/en_accel/ktls_rx.c     |    6 +-=20
 >  .../mellanox/mlx5/core/en_accel/ktls_tx.c     |    9 +-=20
 >  .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   41 +-=20
 >  .../mellanox/mlx5/core/en_accel/ktls_utils.h  |   17 +-=20
 >  .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1191 +++++++++++++++++=
=20
 >  .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  147 ++=20
 >  .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  368 +++++=20
 >  .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   39 +=20
 >  .../mlx5/core/en_accel/nvmeotcp_stats.c       |   69 +=20
 >  .../mlx5/core/en_accel/nvmeotcp_utils.h       |   68 +=20
 >  .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-=20
 >  .../net/ethernet/mellanox/mlx5/core/en_main.c |   30 +-=20
 >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   73 +-=20
 >  .../ethernet/mellanox/mlx5/core/en_stats.h    |    9 +=20
 >  .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-=20
 >  drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +=20
 >  .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +=20
 >  drivers/nvme/host/tcp.c                       |  540 +++++++-=20
 >  include/linux/mlx5/device.h                   |   59 +-=20
 >  include/linux/mlx5/mlx5_ifc.h                 |   85 +-=20
 >  include/linux/mlx5/qp.h                       |    1 +=20
 >  include/linux/netdevice.h                     |   10 +-=20
 >  include/linux/skbuff.h                        |   50 +=20
 >  include/net/inet_connection_sock.h            |    6 +=20
 >  include/net/tcp.h                             |    3 +-=20
 >  include/net/ulp_ddp.h                         |  327 +++++=20
 >  include/uapi/linux/ulp_ddp.h                  |   61 +=20
 >  lib/iov_iter.c                                |    9 +-=20
 >  net/Kconfig                                   |   20 +=20
 >  net/core/Makefile                             |    1 +=20
 >  net/core/dev.c                                |   32 +-=20
 >  net/core/skbuff.c                             |    4 +-=20
 >  net/core/ulp_ddp.c                            |   54 +=20
 >  net/core/ulp_ddp_gen_nl.c                     |   75 ++=20
 >  net/core/ulp_ddp_gen_nl.h                     |   30 +=20
 >  net/core/ulp_ddp_nl.c                         |  346 +++++=20
 >  net/ipv4/tcp_input.c                          |    2 +=20
 >  net/ipv4/tcp_offload.c                        |    1 +=20
 >  net/tls/tls_device.c                          |   31 +-=20
 >  60 files changed, 4432 insertions(+), 158 deletions(-)=20
 >  create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml=20
 >  create mode 100644 Documentation/networking/ulp-ddp-offload.rst=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/com=
mon_utils.h=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp.c=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp.h=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp_rxtx.c=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp_rxtx.h=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp_stats.c=20
 >  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvm=
eotcp_utils.h=20
 >  create mode 100644 include/net/ulp_ddp.h=20
 >  create mode 100644 include/uapi/linux/ulp_ddp.h=20
 >  create mode 100644 net/core/ulp_ddp.c=20
 >  create mode 100644 net/core/ulp_ddp_gen_nl.c=20
 >  create mode 100644 net/core/ulp_ddp_gen_nl.h=20
 >  create mode 100644 net/core/ulp_ddp_nl.c=20
 > =20
 > --=20
 > 2.34.1=20
 > =20
 >=20


