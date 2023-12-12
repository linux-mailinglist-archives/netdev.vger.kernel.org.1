Return-Path: <netdev+bounces-56325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D680E885
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59123B20A2B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9E5916F;
	Tue, 12 Dec 2023 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN5VnVoh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AE5916B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F1C433C8;
	Tue, 12 Dec 2023 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375329;
	bh=XAmy2BovHe8P4ggR+oAdUOnvdaVfRCZbV3Eb2Hl3vYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jN5VnVoh82Y9VxLFu6nQ5jKfTM/Ak9HYCZgi8Zce1OPqBxuhv8aVzwbGYhC1/zRIA
	 IqC8rXwcf8ckyR9d19PV8sKPkvigPOzqHxsfKMDr0UKVW7gWYKoLyNs+zS1bhbBfhX
	 aV6a0BZZz0kAXBur2DLy8zCeKCa8v9j12J42T/QwsJyhyI8bcdg4SzQh+zUYRfMm2E
	 IMhWPOY01TqJvwy1wWwivGuWflqn1v4c6Gl0dnXv/z4TTw3Zpjqq6dYVLEs5BtpmYV
	 K0/fkTnHQ3i2PhjX+CEOmINW4cqzFUofeHoCA1Ov9Wqm9w/bo94P4Ov//QTSmQg+mM
	 VLSKExuHp49qg==
Date: Tue, 12 Dec 2023 10:02:06 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1 3/3] ice: add support for 3k signing DDP
 sections for E825C
Message-ID: <20231212100206.GW5817@kernel.org>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
 <20231206192919.3826128-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206192919.3826128-4-grzegorz.nitka@intel.com>

On Wed, Dec 06, 2023 at 08:29:19PM +0100, Grzegorz Nitka wrote:
> E825C devices shall support the new signing type of RSA 3K for new DDP
> section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
> The driver is responsible to verify the presence of correct signing type.
> Add 3k signinig support for E825C devices based on mac_type:
> ICE_MAC_GENERIC_3K_E825;
> 
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


