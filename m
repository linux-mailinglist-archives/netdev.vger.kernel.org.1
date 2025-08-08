Return-Path: <netdev+bounces-212179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E68B1E964
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B94A7A4401
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059A27BF99;
	Fri,  8 Aug 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/QN9mi9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE3273D76
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660648; cv=none; b=b/Oa2YOMXFh58Portkj0y72PrBCdoUMGVRNjyFFsU+AunAt/WsfArGeRpOciRIKf755UwNY392SbX5Hl/ja/xnqyQC5TfyJtpcgPc0n1Xfnlj0Ghi3luuM+6D5TN5idKwyZnH4tXxsme+VzRtAEdceGv0cvsnrZheeNR32ZN7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660648; c=relaxed/simple;
	bh=aDf7NMnkN5iw5doUTcNxOHGeiGXtGbenvGGZZatXars=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2CGXiNhF5fxJDPlddH3GPEVbInrr+jd3tRLhTlMEglRIqPkw7ifxSGWx1ytUJ+x3RzUm8FDwhKauiVK1JFnaxTJniX41yq7qmTnKBr646Hg5v71SFcfxe557zr0RdFUt64wYTAeKwHIPtK4uKrntj9B+XKXxzBbygEoWnMVc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/QN9mi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D156EC4CEED;
	Fri,  8 Aug 2025 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660647;
	bh=aDf7NMnkN5iw5doUTcNxOHGeiGXtGbenvGGZZatXars=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/QN9mi9RHJ3bVb07VsDSMcbfzhsbwdsNTUpwDrlzuz10p5yM0UmlM48NZqXI0pZE
	 c+G98gmElQavOm2uFsidhh7kJHcTREiVMa27cO2tilmvpXbk8V+m7gRtg3gDzcCi7k
	 9CtgzgQMIbQsBgzYZMHVytkhCnYLe5hW3+KydLJAofAvGCfHvK4dqQycQMWlCpLhxm
	 GLDIYkt2EzrnFXVyvFklptsNGDA0kaui+fw++uzfKchz8+ikiDPB+Ixrd+jR2Ic16D
	 nXJ+k6ikQIew5Q4fZy7sP0SzdybYYc9i8VZIEwRCM4gpOYN/6Fwnffwd/fqGJ3jJ6O
	 VHl3axENqe9cg==
Date: Fri, 8 Aug 2025 14:44:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 1/5] e1000: drop unnecessary constant casts
 to u16
Message-ID: <20250808134403.GA4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <6abd035f-c568-424c-bdbc-6b9cbcb45e1e@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abd035f-c568-424c-bdbc-6b9cbcb45e1e@jacekk.info>

On Wed, Jul 23, 2025 at 10:54:11AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Additionally replace E1000_MNG_VLAN_NONE with resulting value
> rather than casting -1 to u16.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


