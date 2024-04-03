Return-Path: <netdev+bounces-84428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E196896EEC
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8EA1F22477
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D861EEF9;
	Wed,  3 Apr 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo+n8b7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7F1CD00
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147820; cv=none; b=VDie3gzi6+RxEYdxIdtxP2HXqmxjG5sDn9MUsBqyzdKH2W5ZQYLQZ20NrCoS0LMh3EzKsxznRISiwsK1NlPg5RrlDZbWjOhUezE2MmccBbHJarnQovkDnnSTkMGnOm4KF2MFnZ4sbIVPwwOOaMbF2QHJaUD5vX+cpWoEaKQFktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147820; c=relaxed/simple;
	bh=QrGG23GIUNYCv6P2C1COEcnfKDfaDnkuqPaI3H4iDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4ceKbr97FsbecirooU9++WSSw9S4LkMmY89yClnpZzA1EZsWlFNUanLiBnYWZ8PJBl+YUlSoEZxCNFIKmShrxS+Ws8CIOT0Z3iaVDzLEkF54TM5D6cM4Z5AQVky5UyvyIqW/YDHz5ZPGSAnUR9mgo0uqvW9sQ9AhFzs2AqRg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo+n8b7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34322C433F1;
	Wed,  3 Apr 2024 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147820;
	bh=QrGG23GIUNYCv6P2C1COEcnfKDfaDnkuqPaI3H4iDvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fo+n8b7eyBwsaT8fRarsifuwWQouxmlVufmcXKymPoVY9v9uF5dvTWGKSWO7jEt+l
	 4xOkdk/KF6qjfWbQCcMJE4cqGBSYVWJX0PDvKNHh/7v9ted4+/WF7YBg6gjo7PwMJY
	 qPWWlIhhqtBqvgh9YVrlX0cp2sDev6VGSJHB0c5w7APlhV8yiooN5Q+zQScjXCJgZu
	 V/bZQGuvMTan1okuvK2byQ3JOrLPPEBdasjczlQhg60l8Kb/DCVxAxQPuDgxoUhvKu
	 tzeX4tsm1Sg5lbfd/1ZajAjRp9ze7FLBcuNxPG6TM2ZTlXxryFbQP7kWBLEUveR4/M
	 8A60hs2McIzjg==
Date: Wed, 3 Apr 2024 13:36:55 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 01/15] mlxsw: pci: Move mlxsw_pci_eq_{init,
 fini}()
Message-ID: <20240403123655.GW26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <7ae120a02e1c490084daae7e684a0d40b7cce4e7.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae120a02e1c490084daae7e684a0d40b7cce4e7.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:14PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Move mlxsw_pci_eq_{init, fini}() after mlxsw_pci_eq_tasklet() as a next
> patch will setup the tasklet as part of initialization.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


