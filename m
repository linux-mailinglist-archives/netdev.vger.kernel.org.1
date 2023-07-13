Return-Path: <netdev+bounces-17601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D37524D7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D4281E0B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BB18010;
	Thu, 13 Jul 2023 14:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734A1800C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:14:52 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F5030F2
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:14:43 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230713141440epoutp04c7f7bdfe78a01178ca1cde7a0aa4560f~xcukQTCRK0643906439epoutp04p
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:14:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230713141440epoutp04c7f7bdfe78a01178ca1cde7a0aa4560f~xcukQTCRK0643906439epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1689257680;
	bh=312JiJGC50Aj03UfODorZ4eyzLGFpA+dccvHEKWz2wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lx2SwbQrvK0pAGF1dV+FBobR7Eg4lsL+FGfaal6l9laiUYB+yiqsQdN/DvxphWk9a
	 q/d+kpI2sxW8klyuCeAWdAzSbnhStGAy7uzggJ4MJcX1ikH81ILiXWopRHEV9bJmKq
	 G90YddvyZVbUuq845ADP7tQiutE276wZkF9TwABY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230713141439epcas5p21a8cf4cb3db697195df6ff3f9eabb4c0~xcujsTmok2001320013epcas5p2j;
	Thu, 13 Jul 2023 14:14:39 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4R1xSZ14WLz4x9Pq; Thu, 13 Jul
	2023 14:14:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.ED.06099.DC600B46; Thu, 13 Jul 2023 23:14:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230713125228epcas5p122d9f0aa599efc466a3f454573851561~xbmzJkSOd3021230212epcas5p10;
	Thu, 13 Jul 2023 12:52:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230713125228epsmtrp16d4b01c733440f765be741403a77afa6~xbmzI0WdD2369923699epsmtrp1y;
	Thu, 13 Jul 2023 12:52:28 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-f4-64b006cd5864
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.C3.14748.C83FFA46; Thu, 13 Jul 2023 21:52:28 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230713125227epsmtip10d24c81460e7a758f8362c73e9f2c1a1~xbmxiWefW0033900339epsmtip1k;
	Thu, 13 Jul 2023 12:52:26 +0000 (GMT)
Date: Thu, 13 Jul 2023 18:19:14 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: davem@davemloft.net, holger@applied-asynchrony.com,
	kai.heng.feng@canonical.com, simon.horman@corigine.com,
	nic_swsd@realtek.com, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: Performance Regression due to ASPM disable patch
Message-ID: <20230713124914.GA12924@green245>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16fa03d5-c110-75d6-9181-d239578db0a2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmuu45tg0pBg/bmS3mnG9hsVi5+iiT
	xaL3M1gtvh38xmrxr3sZm8X8ZU/ZLY4tELP40juL1WLd6/csFtdv2zhwefw+eZ7dY1ZDL5vH
	olWLmDy2rLzJ5LFz1l12j/P3NrJ4bF5S77H7ZgObx+O3m9k9Pm+SC+CKyrbJSE1MSS1SSM1L
	zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
	U5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdMefFPOaCjcYVsw4X
	NDCu0epi5OSQEDCROHflGlsXIxeHkMBuRonJbX9YIJxPjBJr1h1ghXC+MUp8fbyCFabl7cVZ
	UFV7GSXWv1kDVfWMUeL0vE/sIFUsAqoSz99cZAKx2QTUJY48b2UEsUUEtCQmvF4DtpBZ4AGj
	xOu/P8ASwgK2EvvmvgGzeQV0Jaa+mQtlC0qcnPmEBcTmBKrpXnGGGcQWFVCWOLDtOBPESVs4
	JPq31EPYLhL9rw6xQ9jCEq+Ob4GypSRe9rdB2ekSPy4/heotkGg+to8RwraXaD3VDzafWSBD
	Yvvkm1BxWYmpp9YxQcT5JHp/P4Hq5ZXYMQ/GVpJoXzkHypaQ2HuuAcjmALI9JDq2CkICaBOj
	xIHJ3xgnMMrPQvLaLCTrIGwdiQW7P7HNAmpnFpCWWP6PA8LUlFi/S38BI+sqRsnUguLc9NRi
	0wLjvNRyeIQn5+duYgQnZS3vHYyPHnzQO8TIxMF4iFGCg1lJhFdl27oUId6UxMqq1KL8+KLS
	nNTiQ4ymwLiayCwlmpwPzAt5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0
	MXFwSjUwMUw1tlzGvf696OmjxYvnrK/e5fVFoK3kx3MnV8Hd5XVn3998et7vUc7N3cbnQnpP
	RvQEfLp6pH1SyIEPDJLLSg0+2DMEzHAqumRq9WW7ftqkS7XhE39nvUj8k5jLLsd9wt5pjnXe
	wsAeRc8O76Cq6z8zKs28fi+NC26peLXv/45w0Xm9Wqd3ci/P37UiqKHK+3xM8f7QjGeML+Yk
	ffadeXVZxNbT0xoX+TyYoTzHzOku41bNc8l2EavMtTj2/C77qiHzQzruTKRWldbMBP0VdXuC
	Qm/nr7249HKNH6cD6yMRu4aXCiIHd9QeiLZlvCESIOX/7OX/3lcODJwrWC5cDpm88kHDrMs8
	739cjTFyU2Ipzkg01GIuKk4EANxXWaVTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTrfn8/oUgwnflSzmnG9hsVi5+iiT
	xaL3M1gtvh38xmrxr3sZm8X8ZU/ZLY4tELP40juL1WLd6/csFtdv2zhwefw+eZ7dY1ZDL5vH
	olWLmDy2rLzJ5LFz1l12j/P3NrJ4bF5S77H7ZgObx+O3m9k9Pm+SC+CK4rJJSc3JLEst0rdL
	4Mq4ceoFU8FHg4r2KZ+YGhhbNboYOTkkBEwk3l6cxdLFyMUhJLCbUWJa32pmiISExKmXyxgh
	bGGJlf+es0MUPWGUePZ2MVgRi4CqxPM3F5lAbDYBdYkjz1vBGkQEtCQmvF7DBtLALPCAUeL1
	3x9gCWEBW4l9c9+A2bwCuhJT38xlhJi6iVFi0px7TBAJQYmTM5+wgNjMQJNu/HsJFOcAsqUl
	lv/jAAlzAs3pXnEG7AhRAWWJA9uOM01gFJyFpHsWku5ZCN0LGJlXMUqmFhTnpucmGxYY5qWW
	6xUn5haX5qXrJefnbmIER5SWxg7Ge/P/6R1iZOJgPMQowcGsJMKrsm1dihBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1M2jK/VjVvaOcXZLrLstvyotZU
	wVO58Q4sP0IWtnLN+JjuXHf57lotC6+1PE6sR2RnaW797cn1fL3suzCWH/v/vO238F9jzOqR
	UP/W3j220mrG9b8BPa0Hnix5kX9VMqraaX38lOSmcn3vkP6c6ZsObV1WsvTGVzM5fvtUP9d/
	je8/sL0IFWt+qfBZ/c6v6Zt/LTeviayZlt8zzZKd5eHhXaGKdw0SeMOeWk7k5T+WlpwxT2sC
	w+Ym62v+h2svaKuz7TyatVBz+YUHdnPW7/366llgxvSzmWsuBX/Xv5r+wFrOJ7SH7a1K4a3/
	RY8PTqh46GP2unJHj72Lyfr5Fm/qvbqb907dIzbBe9ZttwozJZbijERDLeai4kQA2HIH2RcD
	AAA=
X-CMS-MailID: 20230713125228epcas5p122d9f0aa599efc466a3f454573851561
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_bd9c2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230712155834epcas5p1140d90c8a0a181930956622728c4dd89
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
	<20230712155052.GA946@green245>
	<16fa03d5-c110-75d6-9181-d239578db0a2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_bd9c2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jul 13, 2023 at 07:59:32AM +0200, Heiner Kallweit wrote:
> On 12.07.2023 17:55, Anuj Gupta wrote:
> > Hi,
> > 
> > I see a performance regression for read/write workloads on our NVMe over
> > fabrics using TCP as transport setup.
> > IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].
> > 
> > I bisected and found that the commit
> > e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
> > NAPI poll") is the trigger.
> > When I revert this commit, the performance drop goes away.
> > 
> > The target machine uses a realtek ethernet controller - 
> > root@testpc:/home/test# lspci | grep -i eth
> > 29:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 2600
> > (rev 21)
> > 2a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Killer
> > E3000 2.5GbE Controller (rev 03)
> > 
> > I tried to disable aspm by passing "pcie_aspm=off" as boot parameter and
> > by setting pcie aspm policy to performance. But it didn't improve the
> > performance.
> > I wonder if this is already known, and something different should be
> > done to handle the original issue? 
> > 
> > [1] fio randread
> > fio -direct=1 -iodepth=1 -rw=randread -ioengine=psync -bs=4k -numjobs=1
> > -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> > -output=psync_read
> > [2] fio randwrite
> > fio -direct=1 -iodepth=1 -rw=randwrite -ioengine=psync -bs=4k -numjobs=1
> > -runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
> > -output=psync_write
> > 
> > 
> I can imagine a certain performance impact of this commit if there are
> lots of small packets handled by individual NAPI polls.
> Maybe it's also chip version specific.
> You have two NIC's, do you see the issue with both of them?

I see this issue with the Realtek Semiconductor Co., Ltd. Killer NIC.
I haven't used the other NIC.

> Related: What's your line speed, 1Gbps or 2.5Gbps?

Speed is 1000Mb/s [1].

> Can you reproduce the performance impact with iperf?

I was not able to reproduce it with iperf [2]. One of the reasons could
be that, currently performance drop happends in nvme over fabrics scenario,
where block IO processing takes sometime before sending next I/O and hence
network packets. I suspect iperf works by sending packets continuously,
rather than at intervals, let me know If I am missing something here.

> Do you use any network optimization settings for latency vs. performance?

No, I haven't set any network optimization settings. We are using
default Ubuntu values. If you suspect some particular setting, I can check.

> Interrupt coalescing, is TSO(6) enabled?

I tried this command on different PC containing the same realtek NIC and
a intel NIC. The command worked fine for the intel NIC, but failed for the
realtek nic. It seems that, the error is specific to realtek nic.
Is there some other way to check for Interrupt coalescing?

> An ethtool -k output may provide further insight.

Please see [3].

[1]
# ethtool enp42s0
Settings for enp42s0:
        Speed: 1000Mb/s

[2]

WITH ASPM patch :

------------------------------------------------------------
# iperf -c 107.99.41.147 -l 4096 -i 1 -t 10
------------------------------------------------------------
Client connecting to 107.99.41.147, TCP port 5001
TCP window size:  531 KByte (default)
------------------------------------------------------------
[  3] local 107.99.41.244 port 40340 connected with 107.99.41.147 port
5001
[  3]  0.0-10.0 sec  1.10 GBytes   942 Mbits/sec

-----------------------------------------------------------

WITHOUT ASPM patch :
------------------------------------------------------------
# iperf -c 107.99.41.147 -l 4096 -i 1 -t 10
------------------------------------------------------------
Client connecting to 107.99.41.147, TCP port 5001
TCP window size:  472 KByte (default)
------------------------------------------------------------
[  3] local 107.99.41.244 port 51766 connected with 107.99.41.147 port
5001
[  3]  0.0-10.0 sec  1.10 GBytes   942 Mbits/sec

[3]

# ethtool -k enp42s0
Features for enp42s0:
rx-checksumming: on
tx-checksumming: on
tx-checksum-ipv4: on
tx-checksum-ip-generic: off [fixed]
tx-checksum-ipv6: on
tx-checksum-fcoe-crc: off [fixed]
tx-checksum-sctp: off [fixed]
scatter-gather: off
tx-scatter-gather: off
tx-scatter-gather-fraglist:
off [fixed]
tcp-segmentation-offload:
off
tx-tcp-segmentation:
off
tx-tcp-ecn-segmentation:
off
[fixed]
tx-tcp-mangleid-segmentation:
off
tx-tcp6-segmentation:
off
generic-segmentation-offload:
off
[requested
on]
generic-receive-offload:
on
large-receive-offload:
off
[fixed]
rx-vlan-offload:
on
tx-vlan-offload:
on
ntuple-filters:
off
[fixed]
receive-hashing:
off
[fixed]
highdma:
on
[fixed]
rx-vlan-filter:
off
[fixed]
vlan-challenged:
off
[fixed]
tx-lockless:
off
[fixed]
netns-local:
off
[fixed]
tx-gso-robust:
off
[fixed]
tx-fcoe-segmentation:
off
[fixed]
tx-gre-segmentation:
off
[fixed]
tx-gre-csum-segmentation:
off
[fixed]
tx-ipxip4-segmentation:
off
[fixed]
tx-ipxip6-segmentation:
off
[fixed]
tx-udp_tnl-segmentation:
off
[fixed]
tx-udp_tnl-csum-segmentation:
off
[fixed]
tx-gso-partial:
off
[fixed]
tx-tunnel-remcsum-segmentation:
off
[fixed]
tx-sctp-segmentation:
off
[fixed]
tx-esp-segmentation:
off
[fixed]
tx-udp-segmentation:
off
[fixed]
tx-gso-list:
off
[fixed]
fcoe-mtu:
off
[fixed]
tx-nocache-copy:
off
loopback:
off
[fixed]
rx-fcs:
off
rx-all:
off
tx-vlan-stag-hw-insert:
off
[fixed]
rx-vlan-stag-hw-parse:
off
[fixed]
rx-vlan-stag-filter:
off
[fixed]
l2-fwd-offload:
off
[fixed]
hw-tc-offload:
off
[fixed]
esp-hw-offload:
off
[fixed]
esp-tx-csum-hw-offload:
off
[fixed]
rx-udp_tunnel-port-offload:
off
[fixed]
tls-hw-tx-offload:
off
[fixed]
tls-hw-rx-offload:
off
[fixed]
rx-gro-hw:
off
[fixed]
tls-hw-record:
off
[fixed]
rx-gro-list:
off
macsec-hw-offload:
off
[fixed]
rx-udp-gro-forwarding:
off
hsr-tag-ins-offload:
off
[fixed]
hsr-tag-rm-offload:
off
[fixed]
hsr-fwd-offload:
off
[fixed]
hsr-dup-offload:
off
[fixed]

> 
> 

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_bd9c2_
Content-Type: text/plain; charset="utf-8"


------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_bd9c2_--

