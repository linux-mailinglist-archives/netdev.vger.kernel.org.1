Return-Path: <netdev+bounces-286742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME92HiULAmrpnQEAu9opvQ
	(envelope-from <netdev+bounces-286742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8E2512E11
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133E1305B9AE
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60E421F12;
	Mon, 11 May 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdErAr2g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD43D667D;
	Mon, 11 May 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516895; cv=none; b=JmODmnIiiHiDUOQUwa3ZuJUonB8wEuDjLcHFHx9w/uXjX/mjmHCXJtnhICC0OE1fQ1IaW4GizuZRYrsWprnXSWCfQyhvFUED6OCL7Yc1+uFNUGDZDhEpLf1tWhuv12zEa2afKkAQD/NoVQ+0zTTiElJzGVKj9sYrIfaxeVIsHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516895; c=relaxed/simple;
	bh=NniAWlMwg0MnR6VwlJuOsYihhqkKD5tw4Vf1zwmvhOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czs1WgdaeAvY5JUh5G3KTi1SZyytHOEL1hCzx7kAD2zVsYjLjoj+J7ZXX+cqQ+BMKE8Z+UxO3iOBPjY1oR6Q4gERLiMhBOuTRm1BMTkwP5KVMEvsQRzNN7M6S74ICh8l7HhzrglGEpZxwXt67czSYypWEMie9LqStiTQXuRkhpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdErAr2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA99C2BCB0;
	Mon, 11 May 2026 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516894;
	bh=NniAWlMwg0MnR6VwlJuOsYihhqkKD5tw4Vf1zwmvhOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdErAr2g44EhXnJtKEi7rHDBqfcWm0A5OWtbXe1WEibnye4I94d9KVuTYU34JKGWy
	 IGXB3TEIxXv8Sv1tx7NbvltWUQHb43Orf8jMN7lU2Tw8JGmXDOn8AKPo8289yRITae
	 tChraIzauoxsLjkZofATYli3oPIj6hfDzAI1q4Ld6Mq9PHFQar8Vh8dmBTEtsZ4QOm
	 OQdV+DuR1bnzRA/v/6W1PUu9joKz3BbYGWlniw4DeKbNNFg01sWcukZ3q6BRBUZkBb
	 pwq+mQ+q/O9aEZOgBWXX2r1hEoP5UOPQNA0N8Hg059Gb4xPMiAm/9XxHS2etI8f43O
	 GB6wxhZXaRkfg==
Date: Mon, 11 May 2026 17:28:09 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com, hector.blanco.alcaine@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-next v5 0/4] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260511162809.GF27589@horms.kernel.org>
References: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
X-Rspamd-Queue-Id: 9A8E2512E11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286742-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:47:02AM +0800, KhaiWenTan wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> This series adds support for forcing 10/100 Mb/s link speed via ethtool
> when autonegotiation is disabled on the igc driver.
> 
> Changes in v5:
> - add removal justification to include copper context in commit
>   description for igc: remove unused autoneg_failed field (Paul)
> - check that cmd->base.duplex is either DUPLEX_HALF or DUPLEX_FULL
>   in igc_ethtool_set_link_ksettings() (Simon)
> - dynamically override hw->fc.current_mode to igc_fc_none during
>   link configuration instead of mutating requested_mode (Simon)
> 
> Changes in v4:
> - Validate that autoneg is AUTONEG_ENABLE or AUTONEG_DISABLE early
>   in igc_ethtool_set_link_ksettings() to avoid passing unexpected
>   values to igc_handle_autoneg_disabled(). (Simon Horman)
> 
> Changes in v3:
> - Modify condition from "if (duplex == DUPLEX_HALF)" to
>   "if (duplex != DUPLEX_FULL)". (Simon Horman)
> 
> Changes in v2:
> - When forcing half-duplex, set hw->fc.requested_mode = igc_fc_none,
>   since half-duplex cannot support flow control per IEEE 802.3.
>   (Simon Horman)
> - Split the original single patch into three patches for clarity:
>   patches 1 and 2 are preparatory cleanups; patch 3 carries the
>   functional change.

Thanks for your persistence.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


