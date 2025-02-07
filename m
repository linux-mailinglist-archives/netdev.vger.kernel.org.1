Return-Path: <netdev+bounces-163930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3DA2C0E1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41573188C5E7
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D611DE2A7;
	Fri,  7 Feb 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRHbNZrq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798D1A23A9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925226; cv=none; b=Bf3cdgbN21u78y7hJSsawIzcARFSvZrQk+BdaA8Kf5emGJZgza2UwJItI8rcmc1a7AGa7MCNUOWjtMvoPm69U6Oy0/Xlk1saxjcPAND33IgKKG8oJdDO0iuEuHHEoQac7MQFz6jMeAAuQ/j//g3DadXwIf5VEhrHRNhiGVIiub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925226; c=relaxed/simple;
	bh=d5IJFjytcsT+LXZ87CAh0a76bYphLqRKFqt3F+ZSJPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgtjd3rz/IoimckCOg+VsI06du9aLB3N2x/SZcEtWai5HE/2paqgy8N94YiOA8+aYEwh2b9RHVnIEaLkLSgZQbLRbbrhLE5dn/qJ6v0VbyTr2tPx0dqE/ot9e6Dk6muoi6kNf5blnTEFBj4NtudNrnX6TdAkOjtkXVp5w448GFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRHbNZrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B709EC4CED1;
	Fri,  7 Feb 2025 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925225;
	bh=d5IJFjytcsT+LXZ87CAh0a76bYphLqRKFqt3F+ZSJPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRHbNZrqVBXfpxiC2LzVJGxCO+28vt1yE9pYtnRAIWeIrorb8HiegUO4YIzNsKNgj
	 7iwv/vmCIi8xXLXe8od/XZxoF3scXxpo5qL231t0sh0OnuM1MlXc71Mt0M/MrL/MxI
	 GcFeI/G65l6xOnRHn17ZLx8GkONNMH7YgLSnGiIMM4npikPULXX1GDl5LkwQ61xktN
	 8sjQCMLDFFJ4jiJlgYRU6mHVID1Uqu6AEfwNh1ku2NMIJ+t++kh4tr1a1gloDTcKWF
	 oJPEmNK8DiBeG8onMGBX5dhuwJCtKXHynfiktgSkdJiuL2wsdV1dOJY4SZHJ3oPdEl
	 0G72H9b13/mrw==
Date: Fri, 7 Feb 2025 10:47:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v1 01/13] ixgbe: add initial devlink support
Message-ID: <20250207104702.GO554665@kernel.org>
References: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
 <20250203150328.4095-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203150328.4095-2-jedrzej.jagielski@intel.com>

On Mon, Feb 03, 2025 at 04:03:16PM +0100, Jedrzej Jagielski wrote:
> Add an initial support for devlink interface to ixgbe driver.
> 
> Similarly to i40e driver the implementation doesn't enable
> devlink to manage device-wide configuration. Devlink instance
> is created for each physical function of PCIe device.
> 
> Create separate directory for devlink related ixgbe files
> and use naming scheme similar to the one used in the ice driver.
> 
> Add a stub for Documentation, to be extended by further patches.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
> new file mode 100644
> index 000000000000..ca920d421d42
> --- /dev/null
> +++ b/Documentation/networking/devlink/ixgbe.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +ixgbe devlink support
> +====================

nit: the '=' lines are one character too short wrt the text they decorate.

Flagged by make htmldocs.

> +
> +This document describes the devlink features implemented by the ``ixgbe``
> +device driver.

...

