Return-Path: <netdev+bounces-30941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E878A052
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68041280F35
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608211198;
	Sun, 27 Aug 2023 16:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE7EE
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 16:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B79C433C7;
	Sun, 27 Aug 2023 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693155571;
	bh=RfF4ljjHOVMaY0QZ0564BYSxWXYZ+w9xsoCJaHZciXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7VnrVJi0+BZZrZXtEG9y1tAkd74UBHUsr33bVVixCy0r01j7Veor5k5v89ecmrX1
	 C4pWV3+5RpkHbRtAKU4/K8W9Ifetul1Ef2Zc6f2aJrG9b0QpWX+UbBFaZn/sOXgN5G
	 pvx8npofo3dgJZ4eySKYi0k6ghQRCrPuFdoNooD1RpU/CspnuJEXamXDxJqcgntOQc
	 hMI13CnOhLuab/yB8vapLuRcRd4ScBQV6T2mZYVJFceoMWkxuHUwNiVoB3+p2PF0eg
	 ITezmXGbPfPSHv4gxWwPFGkpM58xafzbZx1SdrEPEnYtGo3sTI4lWOWa5nXEQs6wmV
	 02RM+QF7rDYOw==
Date: Sun, 27 Aug 2023 18:59:17 +0200
From: Simon Horman <horms@kernel.org>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org, andrew@lunn.ch,
	aelior@marvell.com, manishc@marvell.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: Re: [PATCH iwl-next v3 2/8] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <20230827165917.GW3523530@kernel.org>
References: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
 <20230823180633.2450617-3-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823180633.2450617-3-pawel.chmielewski@intel.com>

On Wed, Aug 23, 2023 at 08:06:26PM +0200, Pawel Chmielewski wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> The need to map Ethtool forced speeds to Ethtool supported link modes is
> common among drivers. To support this, add a common structure for forced
> speed maps and a function to init them.  This is solution was originally
> introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
> maps on module init") for qede driver.
> 
> ethtool_forced_speed_maps_init() should be called during driver init
> with an array of struct ethtool_forced_speed_map to populate the mapping.
> 
> Definitions for maps themselves are left in the driver code, as the sets
> of supported link modes may vary betwen the devices.

Hi Pawel,

a minor nit from my side is that checkpatch.pl --codespell
suggests betwen -> between

> 
> The qede driver was compile tested only.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

...

