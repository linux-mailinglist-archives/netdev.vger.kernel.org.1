Return-Path: <netdev+bounces-58212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F13815898
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 11:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FFC284D76
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A361428A;
	Sat, 16 Dec 2023 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv8quTZ9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16015494
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 10:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B907C433C8;
	Sat, 16 Dec 2023 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702721052;
	bh=60CNHiI28W+RPdvZLBBxAVevQrzUhn11pjItGrKDp6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hv8quTZ9Nnxady0pn3xYyJUwJY8+DY0ZXofAiSRdf6TTM5Rk5m7NRjprDuzINonWW
	 F+1knSCQKlofNMTiAmimpUbdEQK2TqITVsvCiBUAH7vzHp3q/dDfoiWgy6OiSQ4t5T
	 bmg59zMUj+KbPQP46aOu17ctpUzYhyOWSeCiO/eLmkKqnxUcY0DMnwhpt0sx1XG1uC
	 38DxuW2XA3RhIF4aNNedqqQ3ffNb+ez+r5f06iI02tsAgaWES5ETOTdytHrReqz2dZ
	 yZ2dtezdAuyJYWrq4wdhiP7yOqTHg3v0c/oAGbYlGMzc+3l35DosdIsB1QZhprT8cp
	 WUMx8JNfmPF+g==
Date: Sat, 16 Dec 2023 10:04:09 +0000
From: Simon Horman <horms@kernel.org>
To: Lukasz Plachno <lukasz.plachno@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3 1/2] ice: Remove unnecessary argument from
 ice_fdir_comp_rules()
Message-ID: <20231216100409.GM6288@kernel.org>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-2-lukasz.plachno@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214043449.15835-2-lukasz.plachno@intel.com>

On Thu, Dec 14, 2023 at 05:34:48AM +0100, Lukasz Plachno wrote:
> Passing v6 argument is unnecessary as flow_type is still
> analyzed inside the function.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>

Thanks, this is a nice clean up.

Reviewed-by: Simon Horman <horms@kernel.org>

