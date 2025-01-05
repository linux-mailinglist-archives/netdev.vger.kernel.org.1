Return-Path: <netdev+bounces-155231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76CA017AC
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EBA1883F67
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C635976;
	Sun,  5 Jan 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QhwkUx6H"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D2835963;
	Sun,  5 Jan 2025 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736039807; cv=none; b=m7JuqASmbFb/gXU92dIpcVOKilOn7EL4QEU6ymBgZIS4KinhSUkYd4Bww//k0ogkA1JvWY+PsUVomSfPP9lzLYPzYil9/cy9O6JpYQHa2AcHvN5OPoE6/GWIUxPfGPfa8MmfA5KGuHqcd6bQzcH6IhjZqaJ8sVSVZU8DMVDIzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736039807; c=relaxed/simple;
	bh=9u29+Tp1uKONLXkhssW7L/0nSghsMGKnRSx1xHrCcQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRIoVANjJ0lR4ZbQQaBo4GuANeu/UKekf6S7srhaGhmMyIDvJUhUi/C+b8NQ3S0YnGhwpbF6NaRAitFTxyZAbYKMj8hTmS7Zi7lmfVHgWVglSlMDqocH5nd2EUFtzru9nhjgVxEKpWRnPHPAu64c2IdVPARvPFEzPvQJshF5Hng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QhwkUx6H; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=/PXMx0aYm3p77AOabnQSJYxJRLSAjD5vIBHkByO2LPE=; b=QhwkUx6HBWLdPZiN
	NJQpIbL3Y5K800+KUDVsQ6/0vN9x2SpA67PhsVrGt01RwFpEc48Jobbc5q7X4WmlRT6rTA5u3pc/h
	Zv+uUO3SmNCrfEIFiwA34S/QvIHG9+MaDjzxPBKIoTdrtEsO6JYDrYfGTtfAKqIy/e4fJui1sfVm9
	6IeUtyYVelUU3Mwv9aLSa2c6hEW33PR0btxQv+6I6exqbKQRA2pPlG9WThFsZISxfZKizCy+MTZ1Q
	z9CIqnup2mUBY6wxOqcQwS7XFsygvZwUKFBNAFp7HqMSwHGI7bmi/R1xK09KgmdImTuQ3b7Dsos5d
	H0iWMZXPvWNi0udu5w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tUFFn-008Bvs-2t;
	Sun, 05 Jan 2025 01:16:31 +0000
Date: Sun, 5 Jan 2025 01:16:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <Z3ndbw-GcldRgilg@gallifrey>
References: <20250102174002.200538-1-linux@treblig.org>
 <20250104081532.3af26fa1@kernel.org>
 <Z3muiBPv30Dsp8m5@gallifrey>
 <20250104165440.080a9c7b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250104165440.080a9c7b@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:15:08 up 241 days, 12:29,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jakub Kicinski (kuba@kernel.org) wrote:
> On Sat, 4 Jan 2025 21:56:24 +0000 Dr. David Alan Gilbert wrote:
> > > This one doesn't apply, reportedly.  
> > 
> > Hmm, do you have a link to that report, or to which tree I should try
> > applying it to.
> 
> net-next, the tree in the subject prefix:
> 
> $ git checkout net-next/main

Thanks

> $ wget 'https://lore.kernel.org/all/20250102174002.200538-1-linux@treblig.org/raw'
> Saving 'raw'
> $ git am raw
> Applying: ixgbevf: Remove unused ixgbevf_hv_mbx_ops
> error: patch failed: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h:439
> error: drivers/net/ethernet/intel/ixgbevf/ixgbevf.h: patch does not apply
> Patch failed at 0001 ixgbevf: Remove unused ixgbevf_hv_mbx_ops

Oh I see, it's the e610 patch that crept in and just changed the context
and moved the lines down a bit; not built it yet, but I'll cut a new version.

See below.

Dave

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 9b37f354d78c..4384e892f967 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -443,7 +443,6 @@ extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
-extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
 extern const char ixgbevf_driver_name[];

vs

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 130cb868774c..a43cb500274e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -439,7 +439,6 @@ extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
-extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
 extern const char ixgbevf_driver_name[];

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

