Return-Path: <netdev+bounces-169507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030EA443F2
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E9F166C2C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD6268689;
	Tue, 25 Feb 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVc/oR7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CB21ABC2
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496091; cv=none; b=fGkT23OXkhr14LpgU4yLh5QYEdPWdWR2vVWwgj7BWAqLCR0j0L71FMz1YS97RBASLBwM31XPyIyqLdctxW2nzfbTyZm28eaLAsdKllY5MHAnYQkuDw5tKnSEkE8or14+VIg4Xrth2WoVz7oTsMhMHqIC5BVLhNxV2oi4NKekz74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496091; c=relaxed/simple;
	bh=IbCTGBLnXSlV+G4vQ7LBQedicGv33RSpdl3CE0jDfRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZq9OR6s/gU+3HXocoCb4VKWJiZ0E4+JnU1PRqM9NTLkC1fJrNCFuEaNcIUHAO1FE3277Zxd4xceSViuMgpUwmDMMGTnDLIN+wcAnDb1Yp1sLCmHkcrBVVmPpGPXNgSxkKBqU4nVU6NNveUeZBodCp48ZDaJLjMEq8A0u3IW1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVc/oR7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596DC4CEDD;
	Tue, 25 Feb 2025 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496090;
	bh=IbCTGBLnXSlV+G4vQ7LBQedicGv33RSpdl3CE0jDfRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVc/oR7ddhu8AxKtcy0EyzkuV/eMKmDxhGN3OUJ3alx/+F6Sv/RX5mnC5ibVRkpPy
	 3DX9R+Mg5Q0t/j0DFyU0fe8zGgQIX7aGZnOamndDznH1iuRQ37KTpVmBixnLs8Wy8z
	 VCWKv62AhAbWly3rZYkNNIy7egrzsuUAJJgFVo840gGHmWCCdZJDgtc9PwtOXq9q8b
	 WwJvZo4q6UKgyNxTGn9ODn1Gn/GCLn9Dc4mxfUKdJavkR/8gjqlvUDf8MVK0GxFWxI
	 NJ7iK/GVyu4wQZJMzIcqt6jDvll7Ff3uULPsrdzdr5TlVo4MDVimIuAZL7/DSCNIlw
	 kddkPowX3zpuQ==
Date: Tue, 25 Feb 2025 15:08:07 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1 2/3] ice: refactor ice_sbq_msg_dev enum
Message-ID: <20250225150807.GB1615191@kernel.org>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221123123.2833395-3-grzegorz.nitka@intel.com>

On Fri, Feb 21, 2025 at 01:31:22PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Rename ice_sbq_msg_dev to ice_sbq_dev_id to reflect the meaning of this
> type more precisely. This enum type describes RDA (Remote Device Access)
> client ids, accessible over SB (Side Band) interface.
> Rename enum elements to make a driver namespace more cleaner and
> consistent with other definitions within SB
> Remove unused 'rmn_x' entries, specific to unsupported E824 device.
> Adjust clients '2' and '13' names (phy_0 and phy_0_peer respectively) to
> be compliant with EAS doc. According to the specification, regardless of
> the complex entity (single or dual), when accessing its own ports,
> they're accessed always as 'phy_0' client. And referred as 'phy_0_peer'
> when handling ports conneced to the other complex.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


