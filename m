Return-Path: <netdev+bounces-178961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCDA79AE1
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 06:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3091887C34
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BF199935;
	Thu,  3 Apr 2025 04:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A515853B
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743655408; cv=none; b=EKqh/qANq2TK2rcjO5YYunaZeAo1kKHNPRilI5piyy0Vv6ioCtMLRb5s8w+FDLat0p9v7iZVPLkNR719Gj5PWvSvEEWyn0uc5T6Vz0nG0wVjh9oyh8Rnf/C94LLgUgLYyd/gltV4eXr1OYJbgQUcBp6Zg9lMcCcn0zA4J7gayYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743655408; c=relaxed/simple;
	bh=ApcdTXU8noqvEHL8TmokNvDKKue7lSHehf4idoqbia4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7fygnNNZJiMH/2hrkT/l7gh+I/Epq5HECTLAwe5Xm/Va4d51aOU5I5/gp2P3kL29iCyPEuq25fCLQeLsajGXowdkpQi9I6PRNjweqKAqqYiCST1fro783S4bx+iZnFhjV3gSEs61oQ5iQ9hE/lZDQybIu3CSRMTk6IQqCBBbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FB3C68D09; Thu,  3 Apr 2025 06:43:21 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:43:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, kuba@kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com
Subject: Re: [PATCH v27 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer
 registration
Message-ID: <20250403044320.GA22803@lst.de>
References: <20250303095304.1534-1-aaptel@nvidia.com> <20250303095304.1534-16-aaptel@nvidia.com> <20250304174510.GI3666230@kernel.org> <253jz8cyqst.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253jz8cyqst.fsf@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Btw, just as a reminder nvme code has to go through the nvme tree, and
there is absolutely no consesnsus on this feature yet.


