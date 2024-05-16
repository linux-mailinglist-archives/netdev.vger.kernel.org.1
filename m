Return-Path: <netdev+bounces-96702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C38C733D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D01C226D6
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F6142E8C;
	Thu, 16 May 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4tRZmgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22D130AFA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849458; cv=none; b=U6cyC6IkRRcr6p+D2+VZDP98qGK+JIJcOZQ9L++YyW9o1YfOp97l9C9MNNMc0ju+rTl5X6FG2gIa2CiybZD7icbijAtBxv06Yq/pdVzAnGVjh6cLo72etvEurNq37c4syLw2PMTvrJeDQ14BctqJZ+N9va+zWhcZyxSO0rPcRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849458; c=relaxed/simple;
	bh=0o141OsbQBSWlhcqmL6WnzLb6HnjbT/RtgVx14YaTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTvjq2l0nxQn8c4Qnk+gXV7Gh3T9kpRVoUSGy3lRa5DV/rTIJKB0Tg+xRvkOUZyXqVgGEweM1bDELyIVLadHyYdI7b7WxrZujZ2k+c3O9z25zkoEoV3OMn1UtfD/Ba1+PB29f9bEiaxJ+dIlwV0gwj5v/32xQFQLGHNuuVxwKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4tRZmgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD46C113CC;
	Thu, 16 May 2024 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715849457;
	bh=0o141OsbQBSWlhcqmL6WnzLb6HnjbT/RtgVx14YaTw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P4tRZmgo0ifCRZ0sgKBMyhEudpMasEKTxrUlzebbBviVwrEeIXXl5TNvdH2m7CLdL
	 31ISu/5cFsTCMfEiXX68qqOzsZhhg7RskOu1r+izVqknr+PDOXOsTKurrzL61n9l/Y
	 wP2HGYLOAZISLLKoZMs5HfVnscmghhI9Z8FQ3nmQYzaCSCtMFVbaJg37qE72MbZDDg
	 jEpDKKns+Rty9Qs7Ws1Y3TbF4Whhmqy5iSnz1xRcPAk3FR3fryc/xzpKqTKwS+dENq
	 Y/eJo7V9EPH0btu2YRaT5JGH2AF8+WPpbOvIqGl7Rwn+K5DyrZ1IU58re0z2vdHzn7
	 vrlWT0Z1M1SSw==
Date: Thu, 16 May 2024 09:50:52 +0100
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de, jesse.brandeburg@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, rob.thomas@ibm.com
Subject: Re: [PATCH iwl-net V4,1/2] i40e: factoring out
 i40e_suspend/i40e_resume
Message-ID: <20240516085052.GG179178@kernel.org>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-2-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515210705.620-2-thinhtr@linux.ibm.com>

On Wed, May 15, 2024 at 04:07:04PM -0500, Thinh Tran wrote:
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were factored out from the existing
> i40e_suspend() and i40e_resume() respectively.  This factoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device to be unable to recover.  The functions are now used
> in the EEH handling for device suspend/resume callbacks.
> 
> The function i40e_enable_mc_magic_wake() has been moved ahead of
> i40e_io_suspend() to ensure it is declared before being used.
> 
> Tested-by: Robert Thomas <rob.thomas@ibm.com>
> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>

Hi Thrinh,

Sorry to nit-pick, but the request from Paul in his review of v3
was to use imperative mood in the title.

	Factor out i40e_suspend/i40e_resume

In any case, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

