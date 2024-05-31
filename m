Return-Path: <netdev+bounces-99768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E58D64F0
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2201F21FD5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9F56773;
	Fri, 31 May 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8I9dJwi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DA1CF9B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167277; cv=none; b=QnQUODTw6uh5bP1hd46sXh0B0bH3glePwrWhEA76jWZV4w8cFMqZkXMURmkrf8OOJraiHcFU/alKusXhDEboPqVt8bjqWtNW5KWeq3yvwpKPgsopcns0EulxaJvxXAhPG86pk033wOLRXw6wMEpaWnN+XOpjknws2fTpc8cwvTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167277; c=relaxed/simple;
	bh=Av7R+ie+lKmeY0v/wpCObfbqVXSTaAaZUt6YnpKNQrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqrAA0BrmtuC2ZV9IPhnTnONpatCaI+rvLPjoB6T8uiLDGHbLgYZSVaxxbCQ1d7uvTvw8r3Ok+qNZkiSK8zVcyLiCchlA9LWfjSzNmwFTnpJ0SDY97gW6shJctE3USz7mzLeu9cedxJNibuHRfG4BCcf87mmH6sEeoWQu1ycNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8I9dJwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5487FC116B1;
	Fri, 31 May 2024 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167276;
	bh=Av7R+ie+lKmeY0v/wpCObfbqVXSTaAaZUt6YnpKNQrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8I9dJwicdMSl+JcqW9rbcpOqwrAYuY8YAJ/y7hO9Ong+7Xf24/IpVZO7heXZepVD
	 l35KNOFd026BpswlpR+zxR/LrIA406TRRCVIKLnJm/MrldL5b9DwExoMwqrMOxllXO
	 ihs3BS6kI3OhhG1xDW5C94nigcDpDvjpGRQlMUwP0rzokcy6w8dBgIozgJpdBBe5Y+
	 5TzzBnH6XbhOUTjAqvNKK6tJNTQpnXYynyXf1ixMhKH4p403dOT3z59hhDnVwtMA8P
	 sMTMzvPERZ0/PnDIfkCfaF0Va0KctsWcL0ZMGXUur+aS+m+zGxhzXodLNHybpqVock
	 JhSe8UeC/tuCg==
Date: Fri, 31 May 2024 15:54:33 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v7 1/7] ixgbe: Add support for E610 FW Admin
 Command Interface
Message-ID: <20240531145433.GK123401@kernel.org>
References: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
 <20240527151023.3634-2-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527151023.3634-2-piotr.kwapulinski@intel.com>

On Mon, May 27, 2024 at 05:10:17PM +0200, Piotr Kwapulinski wrote:
> Add low level support for Admin Command Interface (ACI). ACI is the
> Firmware interface used by a driver to communicate with E610 adapter. Add
> the following ACI features:
> - data structures, macros, register definitions
> - commands handling
> - events handling
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


