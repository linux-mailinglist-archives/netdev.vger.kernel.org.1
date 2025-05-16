Return-Path: <netdev+bounces-190964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9AAB9828
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D9C17A5F2
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1822D4EB;
	Fri, 16 May 2025 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ8NKLYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4322D7B4
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385696; cv=none; b=pkcvVrUZ5wReM5Q5PvAxlDJJpLyzLk4BQ4ir/fmT/soXtYpI7hYHzQnuSA9RMqYjBiL6nf1h8bsycCT3HTjfrTZfjhu0+yJJ8ns9dW+dKZCfuq1m2zYrl1VHCN1y3e8RoO7YuK1Ufy0F8Ko5q5tPg86qqZa/uR+ZJhs0BjcxamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385696; c=relaxed/simple;
	bh=/CZkgagOiJNK6rIIItrL5/4Uhr1yOuyP0gpTftnaIi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM4qeJ81dEC8cwPrAweXlbXW3eryPqusab9MUT2CX5TfjynlYBOgydz6u6dTeNA2hHBc0ATPrlAG6HfqNLFF2BTIx6sKivlgfrvveSfaM/wMXGAVUQgFhQsUX+L2E0hM2k56eX9w37DuG7SufnqbYf8F7iG3R0mlHtan2hCV/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ8NKLYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC8FC4CEF2;
	Fri, 16 May 2025 08:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747385693;
	bh=/CZkgagOiJNK6rIIItrL5/4Uhr1yOuyP0gpTftnaIi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZ8NKLYmucYRHkBBzLiYQE1k8nNrkRzmcHsVKmSnwh6CASFjEBe06AaQLR5nJf0JU
	 6/IrqbMpIEdP3fUZtYROyloRtPq6nygMMhZNJAn8hbwh1SZU2fXtYMxTntBljEhpB2
	 zGoKz0rfEwaYBWXnLFyO6l8hh8bHkZsPyznWBGNPpqHP4OrBisixVTRcoOlKSkaV/W
	 Gq5JyOvi+yInPWcSZ1/IPtWfMHs8mYIvL7MHaF5USlGeKE3R0q4QL3sU1sZ1RtqRUJ
	 70k7/6Xg1Pl4Kb/rxhyDN7lNqYCtQ/ZZgh3UGQ2aa7ulM7tBkcn3qpu/23Gb41RjR+
	 oLljVSErTJW7A==
Date: Fri, 16 May 2025 09:54:48 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com, dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	willemb@google.com, pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v5 3/3] idpf: add flow steering support
Message-ID: <20250516085448.GE1898636@horms.kernel.org>
References: <20250423192705.1648119-1-ahmed.zaki@intel.com>
 <20250423192705.1648119-4-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423192705.1648119-4-ahmed.zaki@intel.com>

On Wed, Apr 23, 2025 at 01:27:05PM -0600, Ahmed Zaki wrote:
> Use the new virtchnl2 OP codes to communicate with the Control Plane to
> add flow steering filters. We add the basic functionality for add/delete
> with TCP/UDP IPv4 only. Support for other OP codes and protocols will be
> added later.
> 
> Standard 'ethtool -N|--config-ntuple' should be used, for example:
> 
>     # ethtool -N ens801f0d1 flow-type tcp4 src-ip 10.0.0.1 action 6
> 
> to route all IPv4/TCP traffic from IP 10.0.0.1 to queue 6.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


