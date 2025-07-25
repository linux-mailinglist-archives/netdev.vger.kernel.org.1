Return-Path: <netdev+bounces-210231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12033B12717
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5A8583ED4
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5754258CE8;
	Fri, 25 Jul 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICJliPK3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155422F767
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753484972; cv=none; b=Tyyz+xTHn2Lv6jm+nd3iegSkO4SFocaik7zsJmi/pX3woxwkc48SSdmzTM5sAWCydMr1hq1f1AKv0jvhqTjqfKmnwNZMHADqZU3HisiMlsyhfrURWgsN80AlTuV0lrFvTPr2UeLPV0ln4UBUtr4zFUlsge7UFvWWUT28NJbWJ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753484972; c=relaxed/simple;
	bh=zRJjPHB9H/qhUCzIPa3tiO1M5+D1iRVDeu5PtSf3w28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqK052e6hITWQFt82gzESS16iq61EYUPiiCZRHuy6SD8o/e34stfPdPgwTvxNNbNx1s1KpAU0aD3eD5ldyVxUudOxn6aGY5kQHyJEsAdcE2L39wSBs83XVF7AwEefDoUP89YL7IhbKIOM2TCsCjx9+vxRxyzzIGHKTp60jjkhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICJliPK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CCAC4CEF4;
	Fri, 25 Jul 2025 23:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753484972;
	bh=zRJjPHB9H/qhUCzIPa3tiO1M5+D1iRVDeu5PtSf3w28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICJliPK3TNLCnjo4wDYl7OxheLlm21NHx326L0xIoO7ExxMvvs9c3t4cofqSWU1aa
	 1TSQRfUVQVAeY522dSG39LzKglCZ5KzMqWkDxDh347TsFy6Ffr6Exyg+0pkATnZe5N
	 LhaQ6g/FDa+DvgfkhzK02TGMOvCokfAjhX0J3GbiRL+1pPzJ2ANJOC4ypBalmIYE7F
	 WLpBIgpN0Lu3pt+Q5Qd3cCj8qrDbG/MHM+4s9t1sD7M1Ja0qW/XeGNriy8ZiWur79G
	 2ehvB1CUIm+TiherKmMGAaxY1xHFaJBZZ+8pg5wx+tbvE/tXY5yASV+imFvVfK2UFS
	 85uUQfQ+XuCTA==
Date: Fri, 25 Jul 2025 16:09:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, aleksander.lobakin@intel.com,
 przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
 aleksandr.loktionov@intel.com, jedrzej.jagielski@intel.com,
 larysa.zaremba@intel.com
Subject: Re: [PATCH net-next 5/8] libie: add adminq helper for converting
 err to str
Message-ID: <20250725160930.23f9c420@kernel.org>
In-Reply-To: <20250724182826.3758850-6-anthony.l.nguyen@intel.com>
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
	<20250724182826.3758850-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 11:28:21 -0700 Tony Nguyen wrote:
> +const char *libie_aq_str(enum libie_aq_err err)
> +{
> +	if (err >= ARRAY_SIZE(libie_aq_str_arr) ||
> +	    !libie_aq_str_arr[err])
> +		err = __LIBIE_AQ_STR_NUM;
> +
> +	return libie_aq_str_arr[err];

All the LIBIE error values map to the POSIX ones, right? And this is
mostly used in error messages. So why not use %pe I wonder..

