Return-Path: <netdev+bounces-192682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B5AC0D2D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBA97B5BE6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36828C2CB;
	Thu, 22 May 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8V2N1yx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DC28C2BE
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921677; cv=none; b=Wt00LHr+F3sulVXoFu46LE8NMuh/c31p56KHOe+h/KFRnqptmmnDNXsXN/batXuPLY5fxKarqjoeLtONplnRbkTZ+n02SpMFibmwSOCCs+9vAiByK0/H9kttJn5mYVJ05SRmNVuOahTq6WP5Cvt32MzbNLYdRCCEySMbin7qg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921677; c=relaxed/simple;
	bh=Z+6STB0mJB9ZfxXG40/d45IvVbxmdQAgRwvRZ4HssVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo/ku9R6Ad7//t03Arj0SGbb3vqDofJfN5rjaGa+HuaLjppfm51IecLKnGZrM5keueGZJrQbL6q7hkqMJuSvClXUCS0BgLw7MsaG+yQoE62iniSElWBFTEjal38gQ/XrYF4yEe+R1sKAKbHaVdqakofj4EKQV0SUsA0F+8Lmj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8V2N1yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AD9C4CEE4;
	Thu, 22 May 2025 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921677;
	bh=Z+6STB0mJB9ZfxXG40/d45IvVbxmdQAgRwvRZ4HssVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8V2N1yxhqtKwY9LWQkGqWIAMFxG17rIK8gKEqIXw8oLQJcTVZYl95N31DWBXSvIv
	 l1FZ0kQ5rswjd1AjCy99mQiR47y6EFx0e7vYGGt9IXJYSoO5ovfIMsPd3fLr7q8O77
	 hpvx1v2vXQjy5k2ilFeknvmRVnbLaDSXsQyhke875+2yHPCuhYiI7e8jbh8jX59lsf
	 G7zT9u9OrAOJJGdInwNx88hZKyg3QCXUJq1j7oGxZGtofW7QxiGqQMALunSEZzRbYQ
	 820QO48eDIMZpZhO3KsUkgXBoKVua5SSx9HmnBLdLfHwveZLcNMJ3uNe0oIpuVh2Yt
	 5lD25Nb8izyFA==
Date: Thu, 22 May 2025 14:47:53 +0100
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kuba@kernel.org, dawid.osuchowski@linux.intel.com,
	pmenzel@molgen.mpg.de, Kory Maincent <kory.maincent@bootlin.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH iwl-next v4 1/2] ice: add link_down_events statistic
Message-ID: <20250522134753.GE365796@horms.kernel.org>
References: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
 <20250515105011.1310692-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515105011.1310692-2-martyna.szapar-mudlaw@linux.intel.com>

On Thu, May 15, 2025 at 12:50:09PM +0200, Martyna Szapar-Mudlaw wrote:
> Introduce a link_down_events counter to the ice driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
> 
> The value is exposed via ethtool's get_link_ext_stats() interface.
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


