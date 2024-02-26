Return-Path: <netdev+bounces-74933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C08676A5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A071C24D88
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B2128386;
	Mon, 26 Feb 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMnbHoma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CF128378
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954421; cv=none; b=KYPEuuAB7oG3SivAD3l/yGYTudm0o5KfGaGqn2ODhbSOelbVpMmQUEXjSMzGIi2Wg9/UcGGfRw9iw0RNSSiM5GWF91Fd1AvGBibpwVeFGBYxmpRmdKv0KGZocK1YQIxAVpf+fCDleex1610pCgus+n2ymcxcQLcOFXCM0D2eTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954421; c=relaxed/simple;
	bh=3F3a2hjfNgnWwI7UM4NM18GlspXcpUia5Ij1lXCE6KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9MH52O7j38WLODZVItB5CoTiMoOwzmIFwm6GLH6qdjNoxsqa8POFn+VYtt5Cz53uhvYhS9rH0YQPIhhYzn8NKhuYNC/ChvWJXgLHDuEvshiErbMn9xUHZX0zt5qsA8NrLc1xTDfkWmYlLC/KnHJb7SYvYg3UJ+wgWGWq2jcQhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMnbHoma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A3C433F1;
	Mon, 26 Feb 2024 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708954421;
	bh=3F3a2hjfNgnWwI7UM4NM18GlspXcpUia5Ij1lXCE6KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMnbHomak7nJGPkaweH+wRQekJ0YztQyRn3bODQ+JK6lV7pFOMI2AY2mlu2OmRe1d
	 UZSmwsY8TwecieNXXTIad6NxJIduyB9Dj0cgDUgHnq3DeFJhP1skHatb6v3hFWRW/z
	 Aq3Oz5iTuPZ4PlPbljMkhSFL97+GAqOyou+ynsID1jlrNq/thSo7FQawnwVr1+4GlY
	 e16AKuUZn1uDooAYmMi3m/73yDuQZU8oIOx4wowxOSdm4h7sWcKG3BDTb+98FFss2+
	 4qOab1OcmgIYrH/wbPur4TnpZd8C15WXYksBsDmGPI6O5rPneJYX0B4/+XMp4KM9rP
	 iRlOp/ERslp1g==
Date: Mon, 26 Feb 2024 13:33:34 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com, pmenzel@molgen.mpg.de,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [iwl-next v2 2/2] ice: tc: allow ip_proto matching
Message-ID: <20240226133334.GC13129@kernel.org>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>

On Thu, Feb 22, 2024 at 01:39:56PM +0100, Michal Swiatkowski wrote:
> Add new matching type for ip_proto.
> 
> Use it in the same lookup type as for TTL. In hardware it has the same
> protocol ID, but different offset.
> 
> Example command to add filter with ip_proto:
> $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
>  skip_sw action mirred egress redirect dev eth0
> 
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


