Return-Path: <netdev+bounces-29544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9E783B2B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE6C1C20A6D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DF846C;
	Tue, 22 Aug 2023 07:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D676D19
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B89C433C8;
	Tue, 22 Aug 2023 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692690720;
	bh=tUNXAy/Qa2HXOQo95yhA/qC5ttOJw/0KFtRrpO25v7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSEPg6DhPjBE/naw5vAIT3/57NgQ5fistVThuMjBIaBzUje4h5gbGSctv5BKPi+iO
	 6tjelTlkSzOdSIZx3gnnD6Vpn6aInbMIlWASsch3KyeN5djiKJmAijDjdRQ7JRuxDP
	 7RYR7QfJYEH7N33r1QVF9c3qfVkN11wSMt0HK4qx+/4nywjVN5a+K2QP2fazmDixm3
	 2vOi6b9/Zc9bqsUlesGDoaLIOD2xyj7K6zLq/8O7shhEEqx3UztpKyBCMgAw2LSxmL
	 O89Myk8jh+E7qi2HnC9EA4oQhnPSecgYgUiFxvRNqgeFt1JKfJPXpXmhCR4+p5nXoK
	 izMa0xzfdLWsA==
Date: Tue, 22 Aug 2023 09:51:56 +0200
From: Simon Horman <horms@kernel.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, alex.williamson@redhat.com,
	jgg@nvidia.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	shannon.nelson@amd.com
Subject: Re: [PATCH vfio] vfio/pds: Send type for SUSPEND_STATUS command
Message-ID: <20230822075156.GT2711035@kernel.org>
References: <20230821184215.34564-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821184215.34564-1-brett.creeley@amd.com>

On Mon, Aug 21, 2023 at 11:42:15AM -0700, Brett Creeley wrote:
> Commit bb500dbe2ac6 ("vfio/pds: Add VFIO live migration support")
> added live migration support for the pds-vfio-pci driver. When
> sending the SUSPEND command to the device, the driver sets the
> type of suspend (i.e. P2P or FULL). However, the driver isn't
> sending the type of suspend for the SUSPEND_STATUS command, which
> will result in failures. Fix this by also sending the suspend type
> in the SUSPEND_STATUS command.
> 
> Fixes: bb500dbe2ac6 ("vfio/pds: Add VFIO live migration support")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


