Return-Path: <netdev+bounces-229116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6393BD854B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFB33E60B8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3E2E54B0;
	Tue, 14 Oct 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQWL7HV5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E552DE6E1;
	Tue, 14 Oct 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432341; cv=none; b=nKrOHTW9Mj4CelBhJDeqj1zWH+4X9GwFhZFlDLQK4TzqaTNhPWiH3ew13+8bd/B2qUDP9ntcRzwXXSKkFveNEFXXYBSY9xeLwLN9Mw1MMRgztyuTtj5UQw0Pa7BGujAiEhlrrHEsZIF0lUFDTHP9vdQsdrYRKNLylJ3uSiX2mmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432341; c=relaxed/simple;
	bh=gSmv+sj9NLcmMjhB9pOTGPUI+c554NtegDKIVrvQseE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnFEhdiuXmnDLcyNbN2eFwIyDuFB7KIDlXUSe6oj62dHPACR24TDmA+XJALCUyg7PcE3S7DynFbSNIB00d4ncvUVBjiAwx85zn1p92QPWG+xco2VK+2n2/kfVqks1brR1SQaIPhfwJKMGQcSQFDJzePhDISlxqhP7vJcpqOf/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQWL7HV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AEBC4CEF9;
	Tue, 14 Oct 2025 08:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432341;
	bh=gSmv+sj9NLcmMjhB9pOTGPUI+c554NtegDKIVrvQseE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQWL7HV56BC5zWW6WUHiKG3ofUaCJRFuv3vIO4g0wh7DgFwRCImEPRRUwQClPRoUU
	 S6a8zE0W8LBTJ8sYxeb3OOlTk/GvahqCpD5v0C5QlTPcgATcJXMt/95oDrcnL6DCeN
	 JOdUHJ7Cen1puMfCxoDzVnYyJZw7ClponPpkY2M6va8IRkljLCr2stqOL4PxlVCMdA
	 6nuQ12iYPQxG4cjJ9o6KkrG3q/EovJPuy4Jd1idmq5ynuTjRhrwEv6as17+5wd6gNs
	 ocHPF/L7Gj92mk/Y+sSeRUWwo9sU8xgu+tiqakiX8lzDrVeDhFlzbOJzCN65VlaKr9
	 eiueD1IdanEcQ==
Date: Tue, 14 Oct 2025 09:58:56 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: pse-pd: pd692x0: Preserve PSE
 configuration across reboots
Message-ID: <aO4Q0HIZ_72fwRI2@horms.kernel.org>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
 <20251013-feature_pd692x0_reboot_keep_conf-v2-3-68ab082a93dd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-feature_pd692x0_reboot_keep_conf-v2-3-68ab082a93dd@bootlin.com>

On Mon, Oct 13, 2025 at 04:05:33PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Detect when PSE hardware is already configured (user byte == 42) and
> skip hardware initialization to prevent power interruption to connected
> devices during system reboots.
> 
> Previously, the driver would always reconfigure the PSE hardware on
> probe, causing a port matrix reflash that resulted in temporary power
> loss to all connected devices. This change maintains power continuity
> by preserving existing configuration when the PSE has been previously
> initialized.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

Perhaps I'm over thinking things here. But I'm wondering
what provision there is for a situation whereby:

1. The driver configures the device
2. A reboot occurs
2. The (updated) driver wants to (re)configure the device
   with a different configuration, say because it turns
   out there was a bug in or enhancement to the procedure at 1.

...

