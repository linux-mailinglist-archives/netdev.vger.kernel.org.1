Return-Path: <netdev+bounces-37686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D67B6A06
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 55BA1281593
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF08250E7;
	Tue,  3 Oct 2023 13:15:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EAF505
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:15:56 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E205114
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 06:15:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-haqGrWbKN46Bzjf3YqUNmg-1; Tue, 03 Oct 2023 09:15:36 -0400
X-MC-Unique: haqGrWbKN46Bzjf3YqUNmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 436C4185A79C;
	Tue,  3 Oct 2023 13:15:34 +0000 (UTC)
Received: from hog (unknown [10.45.226.144])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1201054F80;
	Tue,  3 Oct 2023 13:15:29 +0000 (UTC)
Date: Tue, 3 Oct 2023 15:15:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only when
 update_pn is true
Message-ID: <ZRwT76YcQAFXKD4k@hog>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
 <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-28, 11:44:25 +0300, Radu Pirea (NXP OSS) wrote:
> When updating SA, update the PN only when the update_pn flag is true.
> Otherwise, the PN will be reset to its previous value.

This is a bugfix and should go through the net tree with a Fixes
tag. I'd suggest taking patches 3,5,6 out of this series and
submitting them all to net, with a Fixes tag for patches 5 and
6. Patch 7 doesn't fix a bug and could go through the net-next tree.

-- 
Sabrina


