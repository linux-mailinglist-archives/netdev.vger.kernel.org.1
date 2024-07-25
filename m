Return-Path: <netdev+bounces-113121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375793CAD9
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A32F1C20CC3
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB6142911;
	Thu, 25 Jul 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ist/rV0d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716F17E9
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946381; cv=none; b=btZNz/lvdvLyL9JS1/pPHH5VaJz7wSS+3l8gcLV1jtSYAJo1Ovor580Ceod71+7z9DbnsPxQd0PXp7g8uB00a3fiNAGTiBjjCifP0h6jh3MQgHCiPPKrAy8evbyrzUub3y15t82XP3MfOUAIRlSglniGGyouCtRPDNpmEXWGO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946381; c=relaxed/simple;
	bh=fJHHbC3sfxfjAFbMnFHrHavQdpnYTeHQ371xF7CckrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uwwo0VnDX5ipCOC0cl4p7vz3GK1IBuitKtY+cCPt9GLomTkJ5Dg4MZL3DfIavWQQoW5QGPAMY8+xYnjMIz04uflQPlgsgotOMRSQ/NgNcWIuX53vj9aJCGo3nM8SPYQFenzHu0aw0ou+SMhtPLx0MZTuhV7Il15BLtWXZMay4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ist/rV0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA0DC116B1;
	Thu, 25 Jul 2024 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946380;
	bh=fJHHbC3sfxfjAFbMnFHrHavQdpnYTeHQ371xF7CckrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ist/rV0d6lnFSQ6ObRpMW6CEYTKsb1J+HS4PkYksNpsC1u3rqnuYJlnsgVXZhh3IJ
	 Wo4ti1mX2/OP5UO/ugBaIn+AlqFkpQ9uPHjXfup/HRSmBgXHz4IBK6XpciaEeMV55L
	 CVy/HA0dhtKPJ+kJmIWr5ZHiHjt3U9AQgbEQkx83lxU/xAl/eFNMAG1hjXuPIsSpro
	 qu2hFs5jvkt7n/9f67i63JM59nguiEDHkjvA3BciI0JZu7TodL9BCBc7tPm0sdUfxx
	 pkGAfJcO2y1UQIWlSIkqliAvWIJo/nmmlpJOBXSjA9PSbIgn3vGLjb4okmrag3Pb5X
	 uAhjRHzXWFHIg==
Date: Thu, 25 Jul 2024 15:26:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, horms@kernel.org, przemyslaw.kitszel@intel.com,
 hkelam@marvell.com
Subject: Re: [PATCH iwl-next v5 00/13] ice: iavf: add support for TC U32
 filters on VFs
Message-ID: <20240725152619.75787373@kernel.org>
In-Reply-To: <20240725220810.12748-1-ahmed.zaki@intel.com>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:07:56 -0600 Ahmed Zaki wrote:
> v5:
>   - Add queue ID validation to iavf_add_cls_u32() (patch 13)

Is it really worth reposting after 24h without getting any feedback?
I'd say it's not..

