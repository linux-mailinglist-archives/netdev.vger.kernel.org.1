Return-Path: <netdev+bounces-133170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D230E995310
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC51B230EE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D31D1DFE1D;
	Tue,  8 Oct 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue6QjAXQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9B1DFE00;
	Tue,  8 Oct 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400314; cv=none; b=lYTTYajwLDdo+nJiPbfPQ0ahZLfob+e6udP/6NPWkyL9MMg/DjUFEwmtJtozx4FVilZhYl9hMykqEbcw3UEA9z9DEOWiAFuPmP55OAkXJ7j1qumWoKGnECAHiWRA79WNivh3bO9t09QaclbJ7CCotigviXuAEUBWloouJVd6DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400314; c=relaxed/simple;
	bh=EG/hsmu1NdfLzRH0AKiGNL3bmjSZ16slJjmMBXd3twA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4asM9NPM2EB7Mrvc33JaVtqoFExnSoQ8yA03pOrd4FNrq33OiuK/xXBbms5ny2uOg46UdasE7z9cyonLLqfzQqBoI3J6txPKBdyjyHjjmxuDWfByuRPUDRDVx5l7zH+Oc1FTtVObOQ/Qaf7ARDM+F1fxDMbxsvSxwFxWDSYDCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue6QjAXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C52C4AF1A;
	Tue,  8 Oct 2024 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400313;
	bh=EG/hsmu1NdfLzRH0AKiGNL3bmjSZ16slJjmMBXd3twA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ue6QjAXQLUyLTavUMBoSaScVcwxxwp0dMpl3QVAbA+PXvABSN/CE7Z3Lo4LS0oV1T
	 TFrmCKd/6L4Ww2h4V+Rlp9riOrUCxX01BjNQ27LlUWgT2YklNeaXiZCzwn3jcrtcdj
	 jMXgfu7L2OwPNzhUrJ5HEy78KlmI2voKUClXkYPoqlno8bd+lZ1dDjbTWNSJAs6K7+
	 zMwRafE9R2wNMott0RLqTxKPyOUUJqneGKP45IuVwcNE+foSivhWjH12kUN6w89yXF
	 3lRHVwQHF6PXsfB0FGaes/a8vq+raciAYRAFH5j7mllcGTFcKzMdfPA5An2PfsgxZk
	 AdxesZmH0C0UA==
Date: Tue, 8 Oct 2024 08:11:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <yuehaibing@huawei.com>, <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v4 0/2] ethtool: Add support for writing
 firmware
Message-ID: <20241008081152.772df3e8@kernel.org>
In-Reply-To: <20241001124150.1637835-1-danieller@nvidia.com>
References: <20241001124150.1637835-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 15:41:48 +0300 Danielle Ratson wrote:
> Patchset overview:
> Patch #1: preparations
> Patch #2: Add EPL support

Would you mind reposting?
I'm worried people who may need to review this didn't pay attention,
plus NIPA build testing got wedged on Rust code during the merge window
so we got no testing coverage of this set :(
-- 
pw-bot: cr

