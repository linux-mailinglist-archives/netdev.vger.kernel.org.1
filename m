Return-Path: <netdev+bounces-41810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2837CBF0C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E1BB20DE8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B03FB0A;
	Tue, 17 Oct 2023 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkers0aL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B4381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3BCC433C8;
	Tue, 17 Oct 2023 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697534805;
	bh=oy4Sf1JoFG4LPg+9MPIgE17JVRLoPiuPyt6+sBDTQxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mkers0aLVyzt++Uz9ggAKYq1NY/8Kr10Upv/m2KMQTd39CBJ3y6KeaY19Ss2b63so
	 qyuTlnGZKU8ZCxG2F/VReYKqWLD3RPVuk+1u0klEZmAVM7Mkf9UEJvEHtiHY0cemki
	 lXPBlR/Oy1klCK/4xScL4qz723hqPdHP5mQxH6j+0mteEF4wYihlpXGZf9tMbcXsrI
	 KYB2d5Krb1nSUVOxQwewRIWxpZp3NAi6LG6+w7BPFRSTAMB7VF+aZ39YBp8T3TRl+B
	 robH6YqZZ0f+jg4M84y1xBJIA92jGUIFB1c0IBN4qbNGxrrS3adGy7ziVEs8FepZu0
	 I1eh11hZjtVOA==
Date: Tue, 17 Oct 2023 11:26:40 +0200
From: Simon Horman <horms@kernel.org>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, aelior@marvell.com,
	manishc@marvell.com, vladimir.oltean@nxp.com, jdamato@fastly.com,
	pawel.chmielewski@intel.com, edumazet@google.com,
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
	d-tatianin@yandex-team.ru, pabeni@redhat.com, davem@davemloft.net,
	jiri@resnulli.us, Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v5 2/3] qede: Refactor
 qede_forced_speed_maps_init()
Message-ID: <20231017092640.GU1751252@kernel.org>
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
 <20231015234304.2633-3-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015234304.2633-3-paul.greenwalt@intel.com>

On Sun, Oct 15, 2023 at 07:43:03PM -0400, Paul Greenwalt wrote:
> Refactor qede_forced_speed_maps_init() to use commen implementation
> ethtool_forced_speed_maps_init().
> 
> The qede driver was compile tested only.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


