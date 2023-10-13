Return-Path: <netdev+bounces-40739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671017C88E8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E8D282BFC
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA01BDD1;
	Fri, 13 Oct 2023 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLrrFrOx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2D1BDDB
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F9C433C7;
	Fri, 13 Oct 2023 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697211704;
	bh=WtbPqvXD8Sp/dZdaV6c5+xedVuADZeNktkl6UocO2vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLrrFrOx70w9wRHUO2/WbfZRJDcD6ULGeBlcbzzq2Qvy/LgaudtfdpL/5WAfzLrmK
	 as0k8cc00B4vYeXBDj01em/D5j/kSmb9datCsxZqSI/wTI+bp1h6Yat69GLzEzZoRB
	 +EASbtsyAeW6QwKqlWDEgVWWVotHzJGIkrBeUqZpeEtQCTMwwHDGbYcTMTudvyEU67
	 ezLyTM3H1kGB5OHPoQlZH+U4/CUNmGIM+ONK1M351GpICPWDlks27Z+RMmNa8T9vRo
	 yDXZacPNJTm6yfQ4ygkzhz1PWQj08a7zqEKirFx9QhdZ3TOFi0uDgzXucFlCULImMT
	 xMeY2nNuQ/4AA==
Date: Fri, 13 Oct 2023 17:41:41 +0200
From: Simon Horman <horms@kernel.org>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, louhongxiang@huawei.com
Subject: Re: [PATCH] scsi: libfc: Fix potential NULL pointer dereference in
 fc_lport_ptp_setup
Message-ID: <20231013154141.GO29570@kernel.org>
References: <20231011130350.819571-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011130350.819571-1-haowenchao2@huawei.com>

On Wed, Oct 11, 2023 at 09:03:50PM +0800, Wenchao Hao wrote:
> fc_lport_ptp_setup() did not check the return value of fc_rport_create()
> which is possible to return NULL which would cause a NULL pointer
> dereference. Address this issue by checking return value of
> fc_rport_create() and log error message on fc_rport_create() failed.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>

Thanks,

I verified that fc_lport_ptp_setup can return NULL (if kzalloc fails).

Reviewed-by: Simon Horman <horms@kernel.org>

