Return-Path: <netdev+bounces-179008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1D0A79FA0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C051893F28
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179B24BD1F;
	Thu,  3 Apr 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk1TP5t6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6C24BC08
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671051; cv=none; b=eJdmkUdhxvEnhWuQCz+/HAyubfCeoPGQox8krm3b5ZPA46Oxv9jYKul7vlnega7BJPSs+jlAI0fHF63axhxholTAce8S+mojb1X9dMu7lJIr9qw2WVoCfCJMjXQXZBD35UQmOVZAvir8Cldmqxve0XPyHR+cAu1UQ8Ky8nZ5Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671051; c=relaxed/simple;
	bh=8966iDvrPLd1vyjCPpwFztDAfZU3QS9ZZY0R8QZCu64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAf8/nQnhyqawj4gni0/kdgSzUiCcq7VaazKdaVjDElyO+Kj3JdmkVQgnaF5Xb8abkYsNXBHy2+5RduqHXMj4XFCZ6SaUZg7VyRe2GvajTg/Woj5tPzrbK0Glesv2HyCyjzzHRC40oWJBS0H+zHB2cVwdAdQkUsUNPFG7zAli+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk1TP5t6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EAAC4CEE3;
	Thu,  3 Apr 2025 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743671051;
	bh=8966iDvrPLd1vyjCPpwFztDAfZU3QS9ZZY0R8QZCu64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yk1TP5t6mb4UPdNXtXXiAl9JuDEA74oIpvC0vHImF6hFEHrfFSW1GETHqQietcyya
	 RDt80lXPh66ZqIaGOOc/asn3R5UxwjdYSz7PGe1PJbtlxsBPggBP9v7+eS1w5kITlX
	 DvEQbt02AAYAbJC/zf/afvBHTc+xybU97DkmpENuZ2QRAOr/8XMe6dZqRFf+zWDr3U
	 R0nQJpsqBBzP+sSHpo2Un2BBSQZbosSf1kPdr846aKovCgCKEcyGBG6GXJTfboOyMB
	 LWMCfktnx0Pg6R5L+mYL7PrASOtws9k8Qrc+rDcju15Yn0NQBl0Xxq2YDJRJlJdBH8
	 zz2+Knq1tHAeg==
Date: Thu, 3 Apr 2025 10:04:06 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	danieller@nvidia.com, damodharam.ammepalli@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated
 read_write_len_ext
Message-ID: <20250403090406.GB214849@horms.kernel.org>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402183123.321036-3-michael.chan@broadcom.com>

On Wed, Apr 02, 2025 at 11:31:23AM -0700, Michael Chan wrote:
> From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> For EPL (Extended Payload), the maximum calculated size returned by
> ethtool_cmis_get_max_epl_size() is 2048, so the read_write_len_ext
> field in struct ethtool_cmis_cdb_cmd_args needs to be changed to u16
> to hold the value.
> 
> To avoid confusion with other u8 read_write_len_ext fields defined
> by the CMIS spec, change the field name to calc_read_write_len_ext.
> 
> Without this change, module flashing can fail:
> 
> Transceiver module firmware flashing started for device enp177s0np0
> Transceiver module firmware flashing in progress for device enp177s0np0
> Progress: 0%
> Transceiver module firmware flashing encountered an error for device enp177s0np0
> Status message: Write FW block EPL command failed, LPL length is longer
> 	than CDB read write length extension allows.
> 
> Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)

Hi Damodharam, all,

As per my comment on patch 1/2: I don't think there is any need to resend
for this, but I think there is a '"' missing towards the end of the Fixes
tag above. That is, I think it should look like this.

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")

> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Other than the nit above this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

