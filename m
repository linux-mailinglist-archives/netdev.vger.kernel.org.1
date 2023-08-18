Return-Path: <netdev+bounces-29028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04E7816CD
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B631C20D45
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870EA32;
	Sat, 19 Aug 2023 02:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602865B
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:47:18 +0000 (UTC)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371513ABC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 19:47:16 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230819024712epoutp02c22e51f6810e810d1b3ce3fa10d06df3~8qN40F2xp1380613806epoutp02Q
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:47:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230819024712epoutp02c22e51f6810e810d1b3ce3fa10d06df3~8qN40F2xp1380613806epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1692413232;
	bh=wmiyAdMU345OEXZcKFLZJNaM8KMUaiRWEFf8CnqqwjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhpwZ+E/nDNiZSpdYZGbGT1kI2jVT26IQiWvBMed3vCVplJvmIzTSFwK9oSS6oXMn
	 OT4z4JFqLojSih37XcGchsPlPlLa8yg2yuDVgnLMaRm1FAVMDPvweG4L4G28R4fuV2
	 d5Nyi7KbURefY4sNNTOLmKsdx9P5P5XT5irRon1A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230819024711epcas5p1f964674d2cb80ca585edab404aead866~8qN4G_TZT0635806358epcas5p1C;
	Sat, 19 Aug 2023 02:47:11 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4RSNSG2Jhhz4x9Pr; Sat, 19 Aug
	2023 02:47:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.1E.29345.E2D20E46; Sat, 19 Aug 2023 11:47:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230818115353epcas5p1339bf7f9993a4f8a8d49a263e5bb8bbe~8eB6z3ak-0225502255epcas5p1E;
	Fri, 18 Aug 2023 11:53:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230818115353epsmtrp22ce5b8f663579141f0b90c70323c0b75~8eB6zOig_1448314483epsmtrp2F;
	Fri, 18 Aug 2023 11:53:53 +0000 (GMT)
X-AuditID: b6c32a49-d91ff700000172a1-9c-64e02d2e9dee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.68.30535.1DB5FD46; Fri, 18 Aug 2023 20:53:53 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20230818115351epsmtip297a7a7664236a4704e03f1721cdf0d9d~8eB5bcVgY0827208272epsmtip22;
	Fri, 18 Aug 2023 11:53:51 +0000 (GMT)
Date: Fri, 18 Aug 2023 17:20:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
	Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 10/18] nvme-tcp: improve icreq/icresp logging
Message-ID: <20230818115034.x33sgaahkpp523rg@green245>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230816120608.37135-11-hare@suse.de>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmhq6e7oMUg01zBSyeHnvEbrFn0SQm
	i5WrjzJZTDp0jdHiwrY+Vov5y56yWxxbIGbx7fQbRot1r9+zOHB6LNhU6nH+3kYWj02rOtk8
	Ni+p99h9s4HN4/2+q0De6WqPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgG5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
	FOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnrNh4mbmgl7/i77L1bA2MV3m6GDk5JARMJE4s2MzS
	xcjFISSwm1Giq+86K4TziVFi+bEn7BDON0aJf/c/sMC03Hx2jg3EFhLYyyixo98NougZo8S6
	72fBilgEVCXmnbwP1M3BwSagLXH6PwdIWERASeJj+yGwocwCXUwS61ZtYwRJCAs4Spw4/Bis
	l1fATGLXqVVMELagxMmZT1hA5nAKGEtsvhANEhYVkJGYsfQrM8gcCYG5HBJLTraC1UgIuEgs
	OskNcaewxKvjW9ghbCmJz+/2skHY5RIrp6xgg+htYZSYdX0WI0TCXqL1VD8ziM0skCFx599S
	qLisxNRT65gg4nwSvb+fMEHEeSV2zIOxlSXWrF8AtUBS4tr3RijbQ2JFx3dGSACtY5R4OPEO
	+wRG+VlIfpuFZB+EbSXR+aGJdRbQP8wC0hLL/3FAmJoS63fpL2BkXcUomVpQnJueWmxaYJiX
	Wg6P8OT83E2M4KSr5bmD8e6DD3qHGJk4GA8xSnAwK4nwWjDdSxHiTUmsrEotyo8vKs1JLT7E
	aAqMq4nMUqLJ+cC0n1cSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoRTB8TB6dU
	A1NZJ8NN0bU30uxuT5Lk2him3Rzc32nCb3JiAgPrRMdngRLyEq4nFJjqzzqJdrpzlofyLwoT
	Xqq3ZI7+vQM/mzPmhF9c1Fu6OdTGgddmkcrBYvV5GbMTF7+q4/x/r+jy96LFc7bVGRRY8PK+
	W8K3dVvyk+l7fM0LpxzJkJeYrptr5jLz4LVZDZxHmI8oylhuuht3urL1/2/vuRsPdgvumbD7
	9r4gc3XJOs74487fl3quVCtLX/rG67g0//679dkT3gpuVjXj8Mpk9L4a3HeCwTY7S98h+avA
	ozN6fOu3eXAcZ5yu3KfE2VG5M+E7i/+Cxgm2YQmOj2ZZLp9fyPZZcO/X01V2/joWdWVaqyX8
	lViKMxINtZiLihMBMh4ob0MEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO7F6PspBhvns1o8PfaI3WLPoklM
	FitXH2WymHToGqPFhW19rBbzlz1ltzi2QMzi2+k3jBbrXr9nceD0WLCp1OP8vY0sHptWdbJ5
	bF5S77H7ZgObx/t9V4G809UenzfJBXBEcdmkpOZklqUW6dslcGVM36NbsJ+n4mbLe5YGxoVc
	XYycHBICJhI3n51j62Lk4hAS2M0oce9kMztEQlJi2d8jzBC2sMTKf8/ZIYqeMEp8mDiHDSTB
	IqAqMe/kfaAEBwebgLbE6f8cIGERASWJj+2HwOqZBXqYJE7vW8wKkhAWcJQ4cfgxC4jNK2Am
	sevUKiYQW0ggSuJa4wcmiLigxMmZT8BqmIFq5m1+yAwyn1lAWmL5Pw4Qk1PAWGLzhWiQClEB
	GYkZS78yT2AUnIWkeRaS5lkIzQsYmVcxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRH
	ipbWDsY9qz7oHWJk4mA8xCjBwawkwmvBdC9FiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170p
	QgLpiSWp2ampBalFMFkmDk6pBqZ9Yr+vbn+76eWLeY/epXHoxz6/t12lt+9djI1dfJacVUxv
	7RW/F88a5J8bzp+a/3mp172pxbzdNyvWZPrNFNskUlDM93tPifxCiaV+d+TU+mwYVuXPyJy9
	a6f38s8NHXf+fxf582HjqZPi8y+9PBd7JpEz7IaTmNm+jntVno3f5d9tPpgsKMrsvvNgZ4b+
	Q4/ncr2fRLl3uFf+fxslPZUxiJfDWep/THPEfc8Zx0/tfZVy77eS1fedvwrb35z1PsS2i0fd
	t4HRwdCuaNbyj9X59e4X18nV5a+KkzONjRCeW8y7Ntt1sssiAf4zcULPIg9IfuXetDjxJ2vp
	+pWHPjif59s2Y97uELm4ss5iHlclluKMREMt5qLiRACo7rGEAwMAAA==
X-CMS-MailID: 20230818115353epcas5p1339bf7f9993a4f8a8d49a263e5bb8bbe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----cwDnXQeNqm9n2JmbxxzyH.SqTJacSNX2iApenF_P1a93Txhp=_6ab8c_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230818115353epcas5p1339bf7f9993a4f8a8d49a263e5bb8bbe
References: <20230816120608.37135-1-hare@suse.de>
	<20230816120608.37135-11-hare@suse.de>
	<CGME20230818115353epcas5p1339bf7f9993a4f8a8d49a263e5bb8bbe@epcas5p1.samsung.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------cwDnXQeNqm9n2JmbxxzyH.SqTJacSNX2iApenF_P1a93Txhp=_6ab8c_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/08/16 02:06PM, Hannes Reinecke wrote:
>When icreq/icresp fails we should be printing out a warning to
>inform the user that the connection could not be established;
>without it there won't be anything in the kernel message log,
>just an error code returned to nvme-cli.
>
>Signed-off-by: Hannes Reinecke <hare@suse.de>
>---
> drivers/nvme/host/tcp.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>index e8e408dbb6ad..ef9cf8c7a113 100644
>--- a/drivers/nvme/host/tcp.c
>+++ b/drivers/nvme/host/tcp.c
>@@ -1403,8 +1403,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> 	iov.iov_base = icreq;
> 	iov.iov_len = sizeof(*icreq);
> 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		pr_warn("queue %d: failed to send icreq, error %d\n",
>+			nvme_tcp_queue_id(queue), ret);
> 		goto free_icresp;
>+	}
>
> 	memset(&msg, 0, sizeof(msg));
> 	iov.iov_base = icresp;
>@@ -1415,8 +1418,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> 	}
> 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> 			iov.iov_len, msg.msg_flags);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		pr_warn("queue %d: failed to receive icresp, error %d\n",
>+			nvme_tcp_queue_id(queue), ret);
> 		goto free_icresp;
>+	}
> 	if (queue->ctrl->ctrl.opts->tls) {
> 		ctype = tls_get_record_type(queue->sock->sk,
> 					    (struct cmsghdr *)cbuf);
>-- 
>2.35.3
>

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------cwDnXQeNqm9n2JmbxxzyH.SqTJacSNX2iApenF_P1a93Txhp=_6ab8c_
Content-Type: text/plain; charset="utf-8"


------cwDnXQeNqm9n2JmbxxzyH.SqTJacSNX2iApenF_P1a93Txhp=_6ab8c_--

