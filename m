Return-Path: <netdev+bounces-51287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A87F9F5E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCC7281451
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFDE1CFBC;
	Mon, 27 Nov 2023 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU/txeKT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453E1A709
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 12:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A6C433C9;
	Mon, 27 Nov 2023 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701087362;
	bh=s9rET20v/rSXQlRujYuxlhNNOKLKtQvmV96idnskVkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rU/txeKTYQCMDfJtJqGVSHHioO6RTS2LrchPi7WT3rvPBWAHUuDJf3DKcW4VIHhYN
	 dmddKcScUVE1ysBY6T4/EegoY6QVaUd4getqOkOFqptv7xQB3Y9FWGq7bmAYHZK2P0
	 QwcnsQJyJTNBYiDuT9UMXJvgz7au7lknobJ+36PsOSEdFQkSeIWvD1OfM7PLUwsJAZ
	 jVhHvo3HpCvUA394KLioh4+I7eFaw5b1QfpEcz7jm9xEDrZXQ5f27wAhpfpJTNhSND
	 BUPBNGaeS9pJej9O0uXq7tgKGRksK4vDZWP1Q/2ftgo3aSfbyU8igVRDXN7vyvpNAu
	 RpQzyUXmmgiMQ==
Date: Mon, 27 Nov 2023 12:15:57 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	wojciech.drewek@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next] iavf: use
 iavf_schedule_aq_request() helper
Message-ID: <20231127121557.GE84723@kernel.org>
References: <20231114223522.2110214-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114223522.2110214-1-poros@redhat.com>

On Tue, Nov 14, 2023 at 11:35:22PM +0100, Petr Oros wrote:
> Use the iavf_schedule_aq_request() helper when we need to
> schedule a watchdog task immediately. No functional change.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> v2: rebased on net-next

Reviewed-by: Simon Horman <horms@kernel.org>

