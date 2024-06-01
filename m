Return-Path: <netdev+bounces-99905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098858D6F5C
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 12:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B33E1C20ACC
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF514D711;
	Sat,  1 Jun 2024 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHDOH8Bc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA056F2EB
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717238124; cv=none; b=h6GJsFN6UoEmSg7VowhvgMSSA+nZpli8nX+losIBIzOLiimg36pyBx0Z2zCl7+V1XtGgtQmwuKesaUbH/VpgEWPKnzLcU99fv3H4/flJy7BcNCd1srPuPIYl9CiQiJSsMC/glVnxzruVl/UbodPpnBgtiBQanLPz97XcuzI9nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717238124; c=relaxed/simple;
	bh=Ch3QSUUmcX6m3bJYmOTzhMp9BMVk2qenG/+4AJ4O5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDBNNYS7sCNUtS/PfUBAxqKe5npCU2B+moFptTTMJK2yGc9QQjoQm/yQHRlya4eQITyTkVMtUzjIokdjp0ML22B958GciY8wvZQbZva+r/bIkjITiG6hIFivLeHaXXx2WK2wN8JYOYHOZYZGOHhm7wVQIdFjSZjE7MG00NVacN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHDOH8Bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEA4C116B1;
	Sat,  1 Jun 2024 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717238123;
	bh=Ch3QSUUmcX6m3bJYmOTzhMp9BMVk2qenG/+4AJ4O5OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHDOH8BcN4ZdFcGdbEGflvtKUyvoy2fePhNl+ixigguXhbPZc99MZUAt3dbFjX8fF
	 nBwkDvTtCXqcVTcJ4WmmoH5/Z3Qp2bjeF5HkBeA21r4c9P2NOfS8KgPM6yployo6Oi
	 cf6Xe5PJuAc4FXEUdkqxhoSQ/J+OgVTNFYaA2MLtRh0liMT6KEtotULMINskCd2N2k
	 n9pEarno5veApvI3OxHM6l3wJXLiEmtDMo1/mpr5BWB4qnKCQ9aJpC+fn3461bwhxl
	 9UcVuo7gSt0IbQLeKPT68B5XUiVbbfDR/WRjhX7X/vjjW8DbMdLc5vds3ZtyaQKnJD
	 uG6kPXUwXtaYw==
Date: Sat, 1 Jun 2024 11:35:19 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH next 07/11] ice: Introduce ETH56G PHY model for E825C
 products
Message-ID: <20240601103519.GC491852@kernel.org>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
 <20240528-next-2024-05-28-ptp-refactors-v1-7-c082739bb6f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-7-c082739bb6f6@intel.com>

On Tue, May 28, 2024 at 04:03:57PM -0700, Jacob Keller wrote:
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> 
> E825C products feature a new PHY model - ETH56G.
> 
> Introduces all necessary PHY definitions, functions etc. for ETH56G PHY,
> analogous to E82X and E810 ones with addition of a few HW-specific
> functionalities for ETH56G like one-step timestamping.
> 
> It ensures correct PTP initialization and operation for E825C products.
> 
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Hi Jacob,

This isn't a proper review, but I noticed that your signed-off
appears twice above.


