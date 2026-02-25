Return-Path: <netdev+bounces-260852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKE6LBXInmkuXQQAu9opvQ
	(envelope-from <netdev+bounces-260852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:59:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66F19567C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1236300DF66
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CC2DCF55;
	Wed, 25 Feb 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neBGT/qt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B221FF47
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013585; cv=none; b=hRrtBOH1rzN2P6zGBrWhygCpJW6Sl//qNdzV+6TdsFVD2LYWpsQLdpdsdbDgfm2GE/SyuimTE8wbs131Pj7+mrhuAPzLgYbSw4ub92oesXMWShqaer7KOHW0Vh1xNkL6BV6pIrmRgTiSyZ99mneqPfUGiigYo1MlK0LAhPfGiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013585; c=relaxed/simple;
	bh=unrCpWR0ZUEpdxq3xVrxxq2dTQ1Gxls1sXOcFsbziJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXxGx6o35w/QoWJlS/9tfY469a2fbAlMrYAYDATsAs8rvPcBzH4ZdTonuf8g9ZRzhDTT2ac89eQkI7TUXAE6GDfq975QRYCMsEzJnTrbix2viz6ag7i/Py86D+2NMv9zzNRMwVe0MyE9xLssRzqhqOXhd7SnHcFScXrk8mG2y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neBGT/qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC0EC116D0;
	Wed, 25 Feb 2026 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772013585;
	bh=unrCpWR0ZUEpdxq3xVrxxq2dTQ1Gxls1sXOcFsbziJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neBGT/qtGwdrHvi/EBGGCJvW4Q2pyDnXSE0bhqWmDauu/4pln2gpvcU7LizVCTXcG
	 CEro1Mfixxi83KUDz1kyprGdPaNMYsJKBmYm8oUc2t8WsvCO7s3OYRZXm7s2W08Ehz
	 otJpgz4dZzQuHLJ1hmdnb0vryhJQDapsYc59UVTTFekhRFQqNYnqlqFGgYuN5oKrdp
	 WZsiqBURIvny5zJ/wZ2t77+7sxDZa6XLYhAOkz4/pS86I5/GRhPIuagFgBGmc2sIQw
	 ZsJAiQEeNTAHNzT3A/gXY30OZfYlPJtSylQB+FnKxvTMCUqxXsejq/rLCEK/dZ+nu3
	 ZPthXlsflwe5Q==
Date: Wed, 25 Feb 2026 09:59:41 +0000
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-net v2] ice: dpll: Fix compilation warning
Message-ID: <aZ7IDXaOOnwcnuuq@horms.kernel.org>
References: <20260223143214.241797-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260223143214.241797-1-przemyslaw.korba@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260852-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5A66F19567C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:31:55PM +0100, Przemyslaw Korba wrote:
> ice_dpll.c: In function ‘ice_dpll_init’:
> ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
> writing between 1 and 10 bytes into a region of size 4
> [-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
> "rclk%u", i);
> 
> Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Hi Przemyslaw,

I agree that it is good to address this problem.
But is it a bug?

It seems to me that of the 8 bytes of pin_name, three are available for %u.
So values up to 999 can be safely formatted.  And I suspect that
pf->dplls.rclk.num_parents is always significantly smaller than that.

If so, I'd suggest this is iwl-next material. And should not have
a Fixes tag. But you could cite the commit that introduced the problem
something like this (the part starting with 'commit' is the syntax for
citing commits):

Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
dynamic pin discovery")

...

