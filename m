Return-Path: <netdev+bounces-111341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3D930A58
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541B1F2158A
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374E81E52A;
	Sun, 14 Jul 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ass0/dJt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AE63C8;
	Sun, 14 Jul 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967015; cv=none; b=tYfMkPt/RBiEavFGl7j6XWmec43mLePxT9J7j8krdyLWQyCVyurnvUnTIPWstlSbrh11eRDyQrVfxv4k8jV5VAa/GfvxHX81VycQU/qiyU+fac1/xcoRFS7+I8Qs2e0p8IhrEtERq6BGGos7iPo1Ql1x8ShadsKe1OuKnByeYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967015; c=relaxed/simple;
	bh=UHj/nSLZ+PQOVweVrGhu6rnTn6njZLQzzk92qwM/x2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftL3XG1F6AcJsRKzmG1CtMFEgYB5jZrbSzSwqBf4Te/OXyQ0wzJ1vuFKGw8PUJkJ+HV0So/4Hrd4P4GitAvMThqZPdkQ835tIaWgDqfNUHRpkL9mB6IfGRJ058zXdVAwse/Zqw+PLpZILPuC4E6nGft9WZXiRtWQ0H6JkJf0aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ass0/dJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA85C116B1;
	Sun, 14 Jul 2024 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720967014;
	bh=UHj/nSLZ+PQOVweVrGhu6rnTn6njZLQzzk92qwM/x2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ass0/dJtFHwm57kcENeTqdaVj368yIZDCvYYWzlYEh5svG1OAEGOyO32cqBuOY8G3
	 fHgVwtYghIFMvkM+cssnN+KaWX1GS5Vu2piX6u6dt1OK9aaN213vUvp9NhGZx3pmAe
	 NlC4Gh5OcBZ+ZRhqzOxmjBn4rNBKc23KlUiyVC50qEpCP3MiVmWsCF8/w/LAOoCMkN
	 WLtGW0udmCnPElz12GeHAgu+lFWxo9WG6Rk7RxSggHBtOprF5lNvvi/jp3cjiBpJ8x
	 8RtkuXGakTIa9juStZFmlCgQu7zFnl0t6w+Yw7bBWJtDvFLHnreTTXD+TYag4iIhH6
	 Ai4q4t6sRuQ7g==
Date: Sun, 14 Jul 2024 07:23:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 akpm@linux-foundation.org, willemb@google.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Igor Bagnucki <igor.bagnucki@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/6] ice: add Tx hang
 devlink health reporter
Message-ID: <20240714072333.2fff045c@kernel.org>
In-Reply-To: <20240712093251.18683-4-mateusz.polchlopek@intel.com>
References: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
	<20240712093251.18683-4-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 05:32:48 -0400 Mateusz Polchlopek wrote:
> +	err = devlink_health_report(reporter, msg, priv_ctx);
> +	if (err) {
> +		struct ice_pf *pf = devlink_health_reporter_priv(reporter);
> +
> +		dev_err(ice_pf_to_dev(pf),
> +			"failed to report %s via devlink health, err %d\n",
> +			msg, err);

My knee-jerk reaction is - why not put it in devlink_health_report()?
Also, I'd rate limit the message.

