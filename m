Return-Path: <netdev+bounces-111580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF809319AE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB91C21DF7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0D4C62A;
	Mon, 15 Jul 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNhd6FuW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB8487B0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064847; cv=none; b=BiXIIDRAPCsl8ZQ1SHrO3w9BvG9atVNJ0IzCQ29yWfz47fmBL4TUAdrzjXP4JdqRsoWrT2BAWQQHVX4Gbohbsmn5WgMD5X5jLP2MbyRELMsnKEnyvNmdV25SEb23ivkKpzzCrKvYsJflqwoPCmxjW0I2Z+Onbk/9opkVulQ1S58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064847; c=relaxed/simple;
	bh=P6we4k1bJDl24GW4P/OoCvemnpOxTjpwzgRwiGjCDTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J2OkZnJQdUAG9RfiLwGciPS5GNgKo3BbcdzRxyx6fiyp0TiG98D8HCQuY4bolp/wp/iPlaioxszJRZY0jVkmZhYdAA16rnKdVI6a4iaC7j5COFvZv8tLtjXce20UNkBYrWcbM8WchOg8qTFYFz/bus0B/FseHR4zBGUweRyfrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNhd6FuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB10C32782;
	Mon, 15 Jul 2024 17:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064847;
	bh=P6we4k1bJDl24GW4P/OoCvemnpOxTjpwzgRwiGjCDTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mNhd6FuW2Eyi3pvldVepO+LF6OE7oCX1TBvhKzW6X57QoPg9wO8po27ccEbz/uu3d
	 P53AoTZw1wBC5UnYvRQ0FbLkdvmqWMB0WORCZj1ClksoWWA73MsBQlKHnNEC0e2YtZ
	 ukK5+hVGx3hmhAyCHI+N+jAqLbYHxW2MnAJWRiDuY7M2COs2eaFycRv+n2DB+25642
	 X+SwmwdZxh4EHPVbPB+66nTFkaTRB2RxVS570cTRAZyN+ZU1yWeJ4dYuHixhqmaODd
	 DvJTSCwu9maEllt6zsfR/MOOVVn8e0k1F7MglKP5HQqudJ9R+xMCKyyt/N4GnPSy/a
	 YtG6krzp18y+w==
Date: Mon, 15 Jul 2024 12:34:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 9/9] bnxt_en: Support dynamic MSIX
Message-ID: <20240715173405.GA435973@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-10-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:39PM -0700, Michael Chan wrote:
> A range of MSIX vectors are allocated at initializtion for the number

s/initializtion/initialization/

> needed for RocE and L2.  During run-time, if the user increases or
> decreases the number of L2 rings, all the MSIX vectors have to be
> freed and a new range has to be allocated.  This is not optimal and
> causes disruptions to RoCE traffic every time there is a change in L2
> MSIX.
> 
> If the system supports dynamic MSIX allocations, use dynamic
> allocation to add new L2 MSIX vectors or free unneeded L2 MSIX
> vectors.  RoCE traffic is not affected using this scheme.

