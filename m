Return-Path: <netdev+bounces-129559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EBC98477D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D3D1C20A0E
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470E1A727B;
	Tue, 24 Sep 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="od3LY1p0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBA1A725D
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187523; cv=none; b=GGlAXIij1OGR6CRcxY/9/fUuHuNVlqmMwE4Nui6MhY5jBMW7KS66GXhDpNOkMAMtIivMTIuA3X4pK5dTBkaSIku1NnglS6kKRXnFkyOrJ906ekCJFw9wW5nTSozf0k49orpjm6PO4MVuqDyEgMgT2ZTZmkHbYH1T6E/Tp2ugIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187523; c=relaxed/simple;
	bh=1pstKRkGR9i0azSxCO28Eb427MDH6Spt9bdlYiRVmcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G8pviT9j0HDJYaMHag5NpLIOCkhjVSCAHawAvuw6NjRIS7xYjPJLnVnnQWVsPtq96Y69VEF6Ek6q0hMhLDWJeU2OPpr1vBNA6/DSUB//L/+EnmvHF7FlUilmUp7eI05pee8B2jvSLGbKQxM3W6poOINx2l5lpAqWO/a5KLabS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od3LY1p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E368DC4CEC4;
	Tue, 24 Sep 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727187523;
	bh=1pstKRkGR9i0azSxCO28Eb427MDH6Spt9bdlYiRVmcM=;
	h=Date:From:To:Cc:Subject:From;
	b=od3LY1p0/4B8Uy/GKhZy6ULBe180RURhp3rYjQUHYG+5s7WD22U7BjogEwvJILSeq
	 uTn5kjOdHdrS35xiEuPEjES85A63wfsd55dNcgmN+Krn/4SuE7VB0XxzpKzWHYFWqh
	 G5QE20QORYbKX1S5klh+rFqQ+VM6msEj1SNlLwaU=
Date: Tue, 24 Sep 2024 10:18:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Salil Mehta <salil.mehta@huawei.com>, 
	Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, helpdesk@kernel.org
Subject: Bouncing maintainer: Yisen Zhuang
Message-ID: <20240924-muscular-wise-stingray-dce77b@lemur>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

I'm reaching out to co-maintainers of the following subsystems:

  - HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
  - HISILICON NETWORK SUBSYSTEM DRIVER

The email address for one of your maintainers is bouncing:

  M: Yisen Zhuang <yisen.zhuang@huawei.com>

There are several possible courses of action:

1. If you know the new email address for the maintainer, please ask them to
   submit a patch for MAINTAINERS and .mailmap files.

2. If this maintainer stepped away from their duties, or if co-maintainers are
   equally unable to reach them via any other means, please submit a patch to
   MAINTAINERS to remove their M: entry.

The goal is to have no bouncing M: entries in the maintainers file, so please
follow up as soon as you have decided on the correct course of action.

Best regards,
-- 
Konstantin Ryabitsev
Linux Foundation

bugspray track

