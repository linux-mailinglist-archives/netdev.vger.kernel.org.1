Return-Path: <netdev+bounces-169505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FEA44401
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198DA3BB7B1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFD268689;
	Tue, 25 Feb 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tedXaNG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2C21ABA3
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496007; cv=none; b=TTfrK4RqMX57dFL1PQHdyv65LVXlT+B+DFFNIs5Yfst7AmDtqcv86/8im4dW+af0ZfpFIVHzY11yJyFKpgMurnUf9v/M5FeOTmVJ5mnofYocbtL5RQVOynxvHYqFa4SVxjgSzccXBrBnO6zIvcnMrs8VdO2KhIbn35gbqHggR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496007; c=relaxed/simple;
	bh=E/a2lpB6c6eZoK/al/wVgvnVZyOyl53dAkRlV27hjA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMdNPR5oR6S8xuBGNT2PvpDVdvl6f9DZgzWIVY20q203zZIv92aP6hktglhvCd8KykHhfHJxuHpAaqme/vDjCs0WMid7X1DqfBqtQDeq/90M7EHKYk/+swWJRejPcVPW+kvjgLniPis2o7KJKJVZRd8Wxl/QGyhsv2llohEGD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tedXaNG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5D9C4CEDD;
	Tue, 25 Feb 2025 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496006;
	bh=E/a2lpB6c6eZoK/al/wVgvnVZyOyl53dAkRlV27hjA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tedXaNG0RlHShqBEeavX14Aq279CKcwWjqLX+cI9/cgjfR/o2jfhNj61KxO4PG+qd
	 srz/ptO9/w4YLXAYEWHadUjEPyr6OJU5AZbOhMeukMoUu6J0wVgJiiVVr3HvdThsEc
	 QXwXdMSeqHuPjDGW9iOpZIvU+jwMgctCvn4AxlUKIxpTufnzFGcNOtktugUaKPEpRf
	 ra7TrPsPGmTtIsn3omhUGHsa6XwbsnNL/CDVhdJk3ZVibWC/ZQH+20BObSyd4bJi7l
	 WRnt/sBqYv/0A14EHAICWWtkyUrPsoUgBrFTCVwsYR5sC6U2PKE/T94XwibxHKdHqN
	 3/ZPZs4ix8zxA==
Date: Tue, 25 Feb 2025 15:06:43 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1 3/3] ice: enable timesync operation on 2xNAC
 E825 devices
Message-ID: <20250225150643.GA1615191@kernel.org>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
 <20250221123123.2833395-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221123123.2833395-4-grzegorz.nitka@intel.com>

On Fri, Feb 21, 2025 at 01:31:23PM +0100, Grzegorz Nitka wrote:

...

> +/**
> + * ice_pf_src_tmr_owned - Check if a primary timer is owned by PF
> + * @hw: pointer to HW structure

Sorry, I hit send for my previous email a little to early.

This should document @pf rather than @hw.

> + *
> + * Return: true if PF owns primary timer, false otherwise.
> + */
> +static inline bool ice_pf_src_tmr_owned(struct ice_pf *pf)
> +{
> +	return pf->hw.func_caps.ts_func_info.src_tmr_owned &&
> +	       ice_is_primary(&pf->hw);
> +}

...

