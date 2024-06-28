Return-Path: <netdev+bounces-107791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653E91C5E3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F6D281C61
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538421CCCD7;
	Fri, 28 Jun 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjged7CM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016125634
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599805; cv=none; b=JLHNsT/aEHxDUSC/JOp8pVEvxpuCn8pOVfHtVobVLcVE0T6/Nd90FGpjsTzpsdcgPia5dChXDAeUnByYPzIG6ZU7GICb1328cfENdiSeLGUygeAPphEi2oMZ4MqyIR5nzMyHv30EgjmyNeXy2saDkBzCyplQIc/kryZ6T7bW7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599805; c=relaxed/simple;
	bh=Vu4DMeYFylySur1lZ4EtGg+jOO6nbzB22102RW+KNOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/xLhS6vtU1y9WeMV5OqOjfaW2qIpb9L6grsHfOsYcEcs6pl6EU86U/3pnXhPh1pplAuO+byQPvVKu83fD4NVTtm/8SrQfIuhvWHvukBY93MNyrjeuJjwbHci9UA5hC3uHF4ak4SVbIE3ezMKcmKYyTzBcB7HaOx5+mcX18/wMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjged7CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D205C116B1;
	Fri, 28 Jun 2024 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719599804;
	bh=Vu4DMeYFylySur1lZ4EtGg+jOO6nbzB22102RW+KNOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wjged7CM6F7FluzMhLSH8QUM3VRBeUwE1K9i7VgI4f2vSWHu2iihV2p3tq2qSFWD1
	 gyr7UlilP+EFBS2Ie3Ly1U8NbpLseZDomKPz+GHUb1pnZ3usAlMVKMdhMJC7zrjXxL
	 g5DyFaSSI1tiDfAp/qhk/RcNpLBNGrhOECaNaD0mM/lNlf6RyyqXo4EUdM3mA6iIcD
	 5sxSDPQIsncDftfewK76bd4El3uX7XnPnLRuCUJ6H2s55nbvKlsioL+pcn6DZ/s6l+
	 g39Q+4cF1a+paUCqInhwth1UWiEmx1K2mtNifPyPY3vNuLg+PO4jslg7svoat3Ab2V
	 +iBkfgEDwxPYQ==
Date: Fri, 28 Jun 2024 19:36:41 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com, pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v3 7/7] ice: Add tracepoint for adding and
 removing switch rules
Message-ID: <20240628183641.GG837606@kernel.org>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
 <20240627145547.32621-8-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627145547.32621-8-marcin.szycik@linux.intel.com>

On Thu, Jun 27, 2024 at 04:55:47PM +0200, Marcin Szycik wrote:
> Track the number of rules and recipes added to switch. Add a tracepoint to
> ice_aq_sw_rules(), which shows both rule and recipe count. This information
> can be helpful when designing a set of rules to program to the hardware, as
> it shows where the practical limit is. Actual limits are known (64 recipes,
> 32k rules), but it's hard to translate these values to how many rules the
> *user* can actually create, because of extra metadata being implicitly
> added, and recipe/rule chaining. Chaining combines several recipes/rules to
> create a larger recipe/rule, so one large rule added by the user might
> actually consume multiple rules from hardware perspective.
> 
> Rule counter is simply incremented/decremented in ice_aq_sw_rules(), since
> all rules are added or removed via it.
> 
> Counting recipes is harder, as recipes can't be removed (only overwritten).
> Recipes added via ice_aq_add_recipe() could end up being unused, when
> there is an error in later stages of rule creation. Instead, track the
> allocation and freeing of recipes, which should reflect the actual usage of
> recipes (if something fails after recipe(s) were created, caller should
> free them). Also, a number of recipes are loaded from NVM by default -
> initialize the recipe counter with the number of these recipes on switch
> initialization.
> 
> Example configuration:
>   cd /sys/kernel/tracing
>   echo function > current_tracer
>   echo ice_aq_sw_rules > set_ftrace_filter
>   echo ice_aq_sw_rules > set_event
>   echo 1 > tracing_on
>   cat trace
> 
> Example output:
>   tc-4097    [069] ...1.   787.595536: ice_aq_sw_rules <-ice_rem_adv_rule
>   tc-4097    [069] .....   787.595705: ice_aq_sw_rules: rules=9 recipes=15
>   tc-4098    [057] ...1.   787.652033: ice_aq_sw_rules <-ice_add_adv_rule
>   tc-4098    [057] .....   787.652201: ice_aq_sw_rules: rules=10 recipes=16
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


