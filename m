Return-Path: <netdev+bounces-17279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5C7510A7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7ED281A31
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620B14F9E;
	Wed, 12 Jul 2023 18:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A012101
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:40:13 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCE1FE3
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:40:05 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230712184002epoutp04153166eccb78b1082acacd0e7540ea0b~xMs_UL-zh2429924299epoutp04Q
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 18:40:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230712184002epoutp04153166eccb78b1082acacd0e7540ea0b~xMs_UL-zh2429924299epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1689187202;
	bh=5udMUw8ZOI5kI4ggj/Zu4b22t6Qo1rZXdPP8gUdpj6c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=YgC8ra9YMb7bTvsPB/ufLswAqc17O3q1G7UmeHKMpM03fSG4lPjmFBlntYnwjg4sA
	 pUX0p5xHzBgxMIUYuKQvScdjMs1/PEELE/BHczIGOSp0gtEChZh6MI/CaoRw9so3fh
	 Z3XxKWeoro/KJV4JKxsm8DshfpKZjVKa4/3Ir6ZY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230712184001epcas5p2b95fc7a9dcb4b5a1595eefbfe691e5e5~xMs9QDVg71503115031epcas5p2d;
	Wed, 12 Jul 2023 18:40:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4R1RPC3q6vz4x9Pt; Wed, 12 Jul
	2023 18:39:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.3D.55522.F73FEA46; Thu, 13 Jul 2023 03:39:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230712155834epcas5p1140d90c8a0a181930956622728c4dd89~xKf-6ueT60052900529epcas5p1f;
	Wed, 12 Jul 2023 15:58:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230712155834epsmtrp15ce7440e631f5d0e1940f1bf9ab3e8ce~xKf-5-wpn1965519655epsmtrp1Y;
	Wed, 12 Jul 2023 15:58:34 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-30-64aef37fed8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.C0.30535.AADCEA46; Thu, 13 Jul 2023 00:58:34 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230712155833epsmtip10a5ae24d57bfc6461e2271881f64a8bd~xKf_l_nGm2267922679epsmtip1e;
	Wed, 12 Jul 2023 15:58:33 +0000 (GMT)
Date: Wed, 12 Jul 2023 21:25:21 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: hkallweit1@gmail.com, davem@davemloft.net
Cc: holger@applied-asynchrony.com, kai.heng.feng@canonical.com,
	simon.horman@corigine.com, nic_swsd@realtek.com, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Performance Regression due to ASPM disable patch
Message-ID: <20230712155052.GA946@green245>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmlm7953UpBn27ZCzmnG9hsVj0fgar
	xbeD31gt/nUvY7OYv+wpu8WxBWIWX3pnsVpcv23jwOHx++R5do9ZDb1sHotWLWLy2LLyJpPH
	zll32T02L6n3ePx2M7vH501yARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
	Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
	E3OLS/PS9fJSS6wMDQyMTIEKE7Izlm+6yVrwjKfiePsbxgbG31xdjJwcEgImEpOev2PsYuTi
	EBLYzShx+9FZdgjnE6PElTW7WUGqhAS+MUr0zWSH6Xj4ei0bRHwvo8TDCxIQDc+Aar5uZwRJ
	sAioShyeuxGsiE1AXeLI81awuIiArsT6DS1sIA3MAqsZJdbeng62QVjAUmLJvXNgG3gFtCXe
	rN8CZQtKnJz5hAXEFhVQljiw7TgTSLOEQCOHxIsri4AmcQA5LhJvTuRDXCcs8er4FqhLpSRe
	9rdB2ekSPy4/ZYKwCySaj+1jhLDtJVpP9TOD2MwCGRLbbp2CqpGVmHpqHRNEnE+i9/cTqDiv
	xI55MLaSRPvKOVC2hMTecw1MEOd4SHRsFYQEUKxEw+srzBMY5WYh+WYWkm0Qto7Egt2f2GYB
	dTMLSEss/8cBYWpKrN+lv4CRdRWjZGpBcW56arFpgWFeajk8ipPzczcxghOqlucOxrsPPugd
	YmTiYDzEKMHBrCTCq7JtXYoQb0piZVVqUX58UWlOavEhRlNg9ExklhJNzgem9LySeEMTSwMT
	MzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpjyRU7LCOxYuVtaT/3E2577R1bv
	Yfad8W6CseDkxOdRNRuczmltT5J8Z1vKcsiUs29RT0dbbZ7aPebjc3TYWUxu8MrNE7zVqpTx
	6RVDs9/uhQ/dZMQs3Fffc71zKc/H5v0qcXP/BS+THWY9XOq/1zuDXcXslsbjTyaNn41zPfhX
	RU3+3JYmusD0N0vXNwGeGa12zI35/6yfPN/y62vV3HcHruz1E/p5rLIh6cC9baxSLg79S1dm
	+OzXDZu7e+/7B58d3Y6+O/CjcsNeYZ5ds0tFntx76iSxt8uiI/W/ZnBDxLT8E5/nP1v7OSxY
	LvXuwS+bZya26s/dHfHufs2h3pTXyXzlEVd/K3m+vl9R/cFbiaU4I9FQi7moOBEAS3Zt8TEE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnO6qs+tSDB52KFjMOd/CYrHo/QxW
	i28Hv7Fa/OtexmYxf9lTdotjC8QsvvTOYrW4ftvGgcPj98nz7B6zGnrZPBatWsTksWXlTSaP
	nbPusntsXlLv8fjtZnaPz5vkAjiiuGxSUnMyy1KL9O0SuDJOv5rGVrCMq2LN60tMDYxXOLoY
	OTkkBEwkHr5ey9bFyMUhJLCbUWLS3htsEAkJiVMvlzFC2MISK/89Z4coesIosWTRbiaQBIuA
	qsThuRvBGtgE1CWOPG8FaxAR0JVYv6EFbCqzwGpGiV1bPoA1CAtYSiy5d44dxOYV0JZ4s34L
	lC0ocXLmExYQm1lAS+LGv5dA9RxAtrTE8n9gl4oKKEsc2HacaQIj/ywkHbOQdMxC6FjAyLyK
	UTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM47LW0djDuWfVB7xAjEwfjIUYJDmYlEV6V
	betShHhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamCK3/gj
	O8zY17WmedrXh5oBSmE79/DO3KqW6/tTsXFCjvr3/NP9P83+PEyPen520qtj+jtL7R0Vv+8W
	STj549iUxemBn6UmxTbvzb+Q0u/yadb5W/u71PzP1VRKnfpguJEzcsL8x7kvd04zZ5q1Le1Q
	WMsd3tOGl391Nj+Y/iPcteDTzuPfLqyu40i4JXf/0L+z59KVdSp3T5y8wS18qQf/kaeabgv1
	yj8dvfH5RcumacUL9vgfEzpfrM9pPvtEw9umNXyB27aumFUr+/ztxWdnhfb/Phtbstnr6r4b
	Vycnv1DiiOj03bttSfuHNKc1nB+un1m+kCe0ctp8rlc8xu81Hqf18PDuvxBV2v1kysoC6Ugl
	luKMREMt5qLiRABiWp/96gIAAA==
X-CMS-MailID: 20230712155834epcas5p1140d90c8a0a181930956622728c4dd89
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_ba39d_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230712155834epcas5p1140d90c8a0a181930956622728c4dd89
References: <CGME20230712155834epcas5p1140d90c8a0a181930956622728c4dd89@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_ba39d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

I see a performance regression for read/write workloads on our NVMe over
fabrics using TCP as transport setup.
IOPS drop by 23% for 4k-randread [1] and by 18% for 4k-randwrite [2].

I bisected and found that the commit
e1ed3e4d91112027b90c7ee61479141b3f948e6a ("r8169: disable ASPM during
NAPI poll") is the trigger.
When I revert this commit, the performance drop goes away.

The target machine uses a realtek ethernet controller - 
root@testpc:/home/test# lspci | grep -i eth
29:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 2600
(rev 21)
2a:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Killer
E3000 2.5GbE Controller (rev 03)

I tried to disable aspm by passing "pcie_aspm=off" as boot parameter and
by setting pcie aspm policy to performance. But it didn't improve the
performance.
I wonder if this is already known, and something different should be
done to handle the original issue? 

[1] fio randread
fio -direct=1 -iodepth=1 -rw=randread -ioengine=psync -bs=4k -numjobs=1
-runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
-output=psync_read
[2] fio randwrite
fio -direct=1 -iodepth=1 -rw=randwrite -ioengine=psync -bs=4k -numjobs=1
-runtime=30 -group_reporting -filename=/dev/nvme1n1 -name=psync_read
-output=psync_write

------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_ba39d_
Content-Type: text/plain; charset="utf-8"


------CHyoCALg6LzvWsSTaVDWulLjyDTSZVBAz8-9IIrQs0inuafE=_ba39d_--

