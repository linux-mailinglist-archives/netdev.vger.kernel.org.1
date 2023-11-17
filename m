Return-Path: <netdev+bounces-48732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751A7EF5BB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026C51F24193
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD8132C76;
	Fri, 17 Nov 2023 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzPrXz1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C390E49F9A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56A2C433C8;
	Fri, 17 Nov 2023 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236445;
	bh=8hGNcP/+cdosJtyYwO2mgxQOhcJhtfUZ7yKjh31tMPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzPrXz1kInRuXEeqJu7aUbdIJ285yt6E2W2e6DPSyP6vksMzuVCmO/aqRGVdSlZ8R
	 OVirfXIVpe91zZ2wCV4aZnqDpZpFrghwZLtCSdap38B0vnHwk10W/sOnyhXIsUjH12
	 z5at2FbVGB4mGoDaEwfeQY5lZBp+6Sneo/oIyttHu8zFZFbTYVJUIo3NXhubNQ6DcP
	 i2cs+60hkVWb303X1a6PNayYWY1ZO9EqaD7WOPoZgmbQjzS7FvhuCVh+Et+aM/CDAN
	 5+OAviuPdLFcTytf9rWU9cGcKlHa+fyA9/WFtg9CDG/7mDu0XPnxdIIfOzpSF41mhc
	 VKLkky3n7i8lA==
Date: Fri, 17 Nov 2023 15:54:01 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 13/14] mlxsw: pci: Implement PCI reset handlers
Message-ID: <20231117155401.GN164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <3bb150e9efd7fbf2ced0a2fb6f3ea321fbcf6046.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb150e9efd7fbf2ced0a2fb6f3ea321fbcf6046.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:22PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Implement reset_prepare() and reset_done() handlers that are invoked by
> the PCI core before and after issuing a PCI reset, respectively.
> 
> Specifically, implement reset_prepare() by calling
> mlxsw_core_bus_device_unregister() and reset_done() by calling
> mlxsw_core_bus_device_register(). This is the same implementation as the
> reload_{down,up}() devlink operations with the following differences:
> 
> 1. The devlink instance is unregistered and then registered again after
>    the reset.
> 
> 2. A reset via the device's command interface (using MRSR register) is
>    not issued during reset_done() as PCI core already issued a PCI
>    reset.
> 
> Tested:
> 
>  # for i in $(seq 1 10); do echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset; done
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


