Return-Path: <netdev+bounces-168140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C40A3DAFB
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699571719FA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360201F76B9;
	Thu, 20 Feb 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8bh0hag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA53C3C
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057201; cv=none; b=CSh9l+RXaZ2VtHfS9SPsEm3jQAoCy+RFBoNeZvjthLUPK4s0GveK8MScJTimNLZDQAsXZIp/KMlu6Gu2Fdn3NAsekVjJRfc3omKvx4EBrHdwuRvpofbnYNa1UYVntu9j10I2/xz63XNUXEjcW1lI2iNPreRhtEbG8hyWV5pao8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057201; c=relaxed/simple;
	bh=kfrR8B+O35qz/zXE38aAnrq3gSnLI1V0kGwQVK9LXOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8LM5v3g6f916KaLsQOL8YdXZhLhxvyDRzrWegEx+y9HB9NofQxkAWMgKgXAZy4uObv0Cwn/19N6iJJSKkQm5S2a14YT45TAPUpbWli2xKioxWX94c+7cTqW7NFkJHcdzP3NheU1RBP4UJs5Wgvdk7av3AboXAG02EZB5MVeCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8bh0hag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECEBC4CED1;
	Thu, 20 Feb 2025 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057200;
	bh=kfrR8B+O35qz/zXE38aAnrq3gSnLI1V0kGwQVK9LXOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8bh0hag/oeJyibPwalbyILGMWc5capJvTuVsZagKuxBiFUdaXwMfK4fIgxw6ZVME
	 /9FZhC+NxCeCaM4Fdq4p8ySw7V9sIuUL8i3SNrhp+4wrgqL3zPPk8Mb3iZVb7P3Fle
	 6YoBkb+waeif/e3UyVTaeRjAMnn/1kyrxvMNu5011f5B/Ua2o1antuoOo6kSWHre+C
	 5Py5DPktXrxE7ge4158MV1y0WAQl2b0LF/fopldp0rrNJj/6L5TSLO7VjA9iEZR7e1
	 12CoSz2bWUh2SGEvTEp+iznw0Wu9hLHcxB77qsmKr/TYsu3AL53savO4Bp9Nj9Dk51
	 79brcgJBiQuEw==
Date: Thu, 20 Feb 2025 13:13:17 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next 1/3] ice: redesign dpll sma/u.fl pins control
Message-ID: <20250220131317.GV1615191@kernel.org>
References: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
 <20250207180254.549314-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207180254.549314-2-arkadiusz.kubalewski@intel.com>

On Fri, Feb 07, 2025 at 07:02:52PM +0100, Arkadiusz Kubalewski wrote:
> DPLL-enabled E810 NIC driver provides user with list of input and output
> pins. Hardware internal design impacts user control over SMA and U.FL
> pins. Currently end-user view on those dpll pins doesn't provide any layer
> of abstraction. On the hardware level SMA and U.FL pins are tied together
> due to existence of direction control logic for each pair:
> - SMA1 (bi-directional) and U.FL1 (only output)
> - SMA2 (bi-directional) and U.FL2 (only input)
> The user activity on each pin of the pair may impact the state of the
> other.
> 
> Previously all the pins were provided to the user as is, without the
> control over SMA pins direction.
> 
> Introduce a software controlled layer of abstraction over external board
> pins, instead of providing the user with access to raw pins connected to
> the dpll:
> - new software controlled SMA and U.FL pins,
> - callback operations directing user requests to corresponding hardware
>   pins according to the runtime configuration,
> - ability to control SMA pins direction.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


