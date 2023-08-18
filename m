Return-Path: <netdev+bounces-28771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F6780A5D
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD5328234C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B6A1800C;
	Fri, 18 Aug 2023 10:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B278E168B7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:42:37 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE6412C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:42:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230818104230epoutp02fe2fc8c67cc82c0597ea64bf3c1adca8~8dDmaSnm-2057820578epoutp02A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:42:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230818104230epoutp02fe2fc8c67cc82c0597ea64bf3c1adca8~8dDmaSnm-2057820578epoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1692355350;
	bh=cRAmN/o7KmxwYBkmYyEqUt7JLUOQKCQnyrj9UHrYzzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOcMVxnT5MezlG7maAiHj5iN0kjWbWPfTx+0L0kHjhM1E5MXIh1d7/c5zFvrOYYIZ
	 B78Vbd57luRQr5OYptMOi1exKQt+Kk3I3BSVHeeEeVnMdoDm68ad++OrbfjtvyZtVH
	 Xx/dEll3FYrgLClGg1d1ahZfuJyvEMu/Z221rgaU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230818104230epcas5p17a8de9a3e27fff7829a54a4128689991~8dDl6Y7HX1668516685epcas5p1s;
	Fri, 18 Aug 2023 10:42:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4RRz382Vq6z4x9Pw; Fri, 18 Aug
	2023 10:42:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.FF.29345.41B4FD46; Fri, 18 Aug 2023 19:42:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230818100233epcas5p2b5f459a525d26b110ba92410f366c563~8cgtglpIW3040830408epcas5p26;
	Fri, 18 Aug 2023 10:02:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230818100233epsmtrp2e9d523c684e3e4fad466bdffdc1e594f~8cgtf1I_R1793817938epsmtrp2a;
	Fri, 18 Aug 2023 10:02:33 +0000 (GMT)
X-AuditID: b6c32a49-d91ff700000172a1-7a-64df4b1420fd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.26.64355.9B14FD46; Fri, 18 Aug 2023 19:02:33 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230818100231epsmtip1e2ce055fb0b95bd82af86503b0c4dde6~8cgsB09LL0691306913epsmtip1B;
	Fri, 18 Aug 2023 10:02:31 +0000 (GMT)
Date: Fri, 18 Aug 2023 15:29:09 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 13/18] nvmet-tcp: make nvmet_tcp_alloc_queue() a void
 function
Message-ID: <20230818095909.tgar6n5yokwy7sah@green245>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230816120608.37135-14-hare@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmhq6I9/0Ug4v7eSyeHnvEbrFn0SQm
	i5WrjzJZTDp0jdHiwrY+Vov5y56yWxxbIGbx7fQbRot1r9+zOHB6LNhU6nH+3kYWj02rOtk8
	Ni+p99h9s4HN4/2+q0De6WqPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgG5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	FOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnHO8wKTgsUtE35xtLA+NWwS5GTg4JAROJ+/e2MXcx
	cnEICexmlNi/dgU7hPOJUWL+52MscM63lZ/YYVrOHL8HVbWTUWLm7wNQ/c8YJZZ/OAJWxSKg
	KjF16logm4ODTUBb4vR/DpCwiICSxMf2Q2DNzAJdTBLrVm1jBEkIC4RITHv9GczmFTCT2D7p
	NiuELShxcuYTFhCbU8BYYvesbWBxUQEZiRlLv4ItlhCYyiGx4uwXqPNcJJ5desQCYQtLvDq+
	BSouJfH53V42CLtcYuWUFWwQzS2MErOuz2KESNhLtJ7qZwaxmQUyJCZf3QIVl5WYemodE0Sc
	T6L39xMmiDivxI55MLayxJr1C6AWSEpc+94IZXtIHDo2kQ0SROsYJdpWf2abwCg/C8l3s5Ds
	g7CtJDo/NLHOAoYes4C0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY5qWWw6M8OT93EyM4
	8Wp57mC8++CD3iFGJg7GQ4wSHMxKIrwWTPdShHhTEiurUovy44tKc1KLDzGaAmNrIrOUaHI+
	MPXnlcQbmlgamJiZmZlYGpsZKonzvm6dmyIkkJ5YkpqdmlqQWgTTx8TBKdXAVNGwSaKh4EBf
	n8Rizvtvdp1eq/1330OFvl1rNa0SArf6LekX0LcMqOi82i6s8mv2w4SAvS8dq6d3av1Jmxdj
	1+SXrKwRqcCzZNL1S5Fca35zPJv+58l2/esPpM7KCqXNVnn/wnRX8v/C5HfbEjY/kvsRKC9w
	oHqdZtVxr1k66WFbvNtSHiwKeBHRzJFS/tT5eOwB542OXmfXzW97eyZJ0XGe0itD1/R9jNMP
	mp7nVX2rpyRnwpl6h8niwFYJvk0Xmovn6UquvRYbVff0zP0iS+/k7sbjdYUfFZctWGVxId8o
	a2lRzea2NfLeUxdeOnn20I6lJXaS5/96b14iPP2xj9zeeULG51fKxLpy26j9U2Ipzkg01GIu
	Kk4EAPr1j25FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnO5Ox/spBlfvsFk8PfaI3WLPoklM
	FitXH2WymHToGqPFhW19rBbzlz1ltzi2QMzi2+k3jBbrXr9nceD0WLCp1OP8vY0sHptWdbJ5
	bF5S77H7ZgObx/t9V4G809UenzfJBXBEcdmkpOZklqUW6dslcGVs+XOPveCrYMWR9gVMDYyN
	/F2MnBwSAiYSZ47fY+9i5OIQEtjOKNE+7RU7REJSYtnfI8wQtrDEyn/PoYqeABV1NbGBJFgE
	VCWmTl0LlODgYBPQljj9nwMkLCKgJPGx/RBYPbNAD5PE6X2LWUESwgIhEtNef2YEsXkFzCS2
	T7oNFhcSiJLoXXmJHSIuKHFy5hMWEJsZqGbe5ofMIPOZBaQllv8Dm88pYCyxe9Y2sFZRARmJ
	GUu/Mk9gFJyFpHsWku5ZCN0LGJlXMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgRHiVbQDsZl
	6//qHWJk4mA8xCjBwawkwmvBdC9FiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6Yklq
	dmpqQWoRTJaJg1OqgWltbuuJvF17b/jEpn6cnGujlV6/84rDhy8nDyneU/8pNlclpXDuWcPN
	1c17hYOzXKcVrcz4aTi1+vfchqfPpzN4XXov/u19xtct3+f2r/fte91VE+i35qexeGKuueuZ
	HfJisxvdljCnOv/7rrvaZK5aAAevF8ebaIVlV8/liE7jvq1yQP/0wTshWvd/HJ8qJq2Z48Fw
	rix30oGeLh+FK+cm39TV7965aV+Lt8Ddt2ZBFzdWchYtfhpkZlLse0dm8oUaYUeRwOqJm+dn
	JhScedamUqtke+L3LScmCaH86SLlLM3rMy9EVEnpp5TldS6yv/eT75XD14997Zcfb01JFq3r
	eX1xbcLN+4Vyp08eklFiKc5INNRiLipOBAADEaTYAQMAAA==
X-CMS-MailID: 20230818100233epcas5p2b5f459a525d26b110ba92410f366c563
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_6a499_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230818100233epcas5p2b5f459a525d26b110ba92410f366c563
References: <20230816120608.37135-1-hare@suse.de>
	<20230816120608.37135-14-hare@suse.de>
	<CGME20230818100233epcas5p2b5f459a525d26b110ba92410f366c563@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_6a499_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/16 02:06PM, Hannes Reinecke wrote:
>The return value from nvmet_tcp_alloc_queue() are just used to
>figure out if sock_release() need to be called. So this patch
>moves sock_release() into nvmet_tcp_alloc_queue() and make it
>a void function.
>
>Signed-off-by: Hannes Reinecke <hare@suse.de>
>Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>---
> drivers/nvme/target/tcp.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>index 97d07488072d..d44e9051ddd9 100644
>--- a/drivers/nvme/target/tcp.c
>+++ b/drivers/nvme/target/tcp.c
>@@ -1621,15 +1621,17 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
> 	return ret;
> }
>
>-static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>+static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> 		struct socket *newsock)
> {
> 	struct nvmet_tcp_queue *queue;
> 	int ret;
>
> 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>-	if (!queue)
>-		return -ENOMEM;
>+	if (!queue) {
>+		ret = -ENOMEM;
>+		goto out_release;
>+	}
>
> 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
> 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>@@ -1666,7 +1668,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> 	if (ret)
> 		goto out_destroy_sq;
>
>-	return 0;
>+	return;
> out_destroy_sq:
> 	mutex_lock(&nvmet_tcp_queue_mutex);
> 	list_del_init(&queue->queue_list);
>@@ -1678,7 +1680,9 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> out_free_queue:
> 	kfree(queue);
>-	return ret;
>+out_release:
>+	pr_err("failed to allocate queue, error %d\n", ret);
>+	sock_release(newsock);
> }
>
> static void nvmet_tcp_accept_work(struct work_struct *w)
>@@ -1695,11 +1699,7 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
> 				pr_warn("failed to accept err=%d\n", ret);
> 			return;
> 		}
>-		ret = nvmet_tcp_alloc_queue(port, newsock);
>-		if (ret) {
>-			pr_err("failed to allocate queue\n");
>-			sock_release(newsock);
>-		}
>+		nvmet_tcp_alloc_queue(port, newsock);
> 	}
> }
>
>-- 
>2.35.3
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_6a499_
Content-Type: text/plain; charset="utf-8"


------2jlpTr02XJ1Dz0Ro0nWDo60KkQ.efMTj2bJXEJ.ys0a_1.o3=_6a499_--

