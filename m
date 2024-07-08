Return-Path: <netdev+bounces-109891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DF92A30D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4383B2839DE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71554824A3;
	Mon,  8 Jul 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKEz5M3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2E8249B;
	Mon,  8 Jul 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442518; cv=none; b=kb2sVbN+Lh6PWbVTho1N7PO6GC1kfDptsqGc2aExciaPzbekQsw2XnHYvjVE9QHrdI7t25ISIWell/ukGgMVgQ3sltcZGvn06S24XS62Rp7o77EuHqeCQUlpfq640HR0mN0HyiXpAPoSLMf5JOS4hi9uKbAGTnPthhTrogMu1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442518; c=relaxed/simple;
	bh=5nQj+rts9YS9Ia5kQOE7Jvlvi0YFlA7izBiZdjKmwlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLfSR36Mjc/yrLIT/xCT13znyXTakZMg123YE5QJaEMir/UikfDtHsZm0NeCdyVdMtLM3jbYkYYC44Vc9nxYPgx+cPUt12yvLArbuamRVgVAgTyVUNjkMirDWnrvJWridRE/ohxHoLdgLtQyGbiN/lKip/VHUZwrlxcaRJSPDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKEz5M3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C5BC116B1;
	Mon,  8 Jul 2024 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442518;
	bh=5nQj+rts9YS9Ia5kQOE7Jvlvi0YFlA7izBiZdjKmwlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKEz5M3X7+Cx6EplGd79DL1xlzDx5b8XkquKiT9sTPAmH8w2ngNC3PkWfz7HinF5i
	 4UPP7gj7omvpNraMTa1HVhDQJjfYLDnVx0bhRHYC58vKl3QwsJoB8eoZw+ULSpusgB
	 3CRDnqJ8E74R+nSUXO1dy46GD0LJ+qupfI/k1ZizZ3oGCWNYmh0wLG9RKSmiMbWBf/
	 VycI3bHcM76tXOMfvW6leVaZFRax4BqAyaGRB9EgsDe/dHDyOrHC0G2hAOQE2CAPyk
	 wpGlBkC8/F/wmDaCKXDBxLPYazc0nuWKrVWCLhnjmCrdAY57gB/J2/kbWt7LNsmVD0
	 f22qY8l9Rhu8A==
Date: Mon, 8 Jul 2024 13:41:53 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 4/6] ice: print ethtool
 stats as part of Tx hang devlink health reporter
Message-ID: <20240708124153.GQ1481495@kernel.org>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
 <20240703125922.5625-5-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703125922.5625-5-mateusz.polchlopek@intel.com>

On Wed, Jul 03, 2024 at 08:59:20AM -0400, Mateusz Polchlopek wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Print the ethtool stats as part of Tx hang devlink health dump.
> 
> Move the declarations of ethtool functions that devlink health uses out
> to a new file: ice_ethtool_common.h
> 
> To utilize our existing ethtool code in this context, convert it to
> non-static.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


