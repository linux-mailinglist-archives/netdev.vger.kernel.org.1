Return-Path: <netdev+bounces-159742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E269FA16B36
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F963A5B48
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380341BC062;
	Mon, 20 Jan 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNgdQ64x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3F33981
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371202; cv=none; b=kDcz9QWUF/FT+TnPsPUcvQWxkhXHCNtwyA56D+3Glje6k9w7mVgMYHvHhPWuWLNdRUiNjjeqT2VVrqgtcTeBWFlg/jLk8ta4XJFxawivD1W/8joD5L3/yFb0eRUm0L2bzNv4QJ9ny9JXu67KpinLA+OlRpnjBpRz5O5jC5Htjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371202; c=relaxed/simple;
	bh=37gfub3Ya1whwevuLBoRfK388bZussEj/iFKl91dWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8+m3fE47874KNp0n4MxS8NQzNn0tsKUXpgd/4uP9cHTWtez1ygBUXNONJ+k/c9kHshwNOH2c2bMTGnmPeaw7BKCOEcnGnbcWiMbzf4efkfadUZj+sxB0Xv2Pa+gGakrUuEpB7fe55jpKFOsFTNE+/qfO2Y649s8umPvrU1fi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNgdQ64x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B1C4CEDD;
	Mon, 20 Jan 2025 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737371201;
	bh=37gfub3Ya1whwevuLBoRfK388bZussEj/iFKl91dWHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNgdQ64xd8aWNLylvyLca1kCwQb9VwlL2i/GAx8DAX7BKuh8IaAdqynQi0wvsA7Bd
	 g7FQgwe9yxftCT5bu+Y7gYpUY2fhhpKzR4sqcwWq26sg1TJ4tAicJ/Bbz1IdupwqlA
	 cH6dXCmkVwn5EFviGKWL2Eh6GHdKg12YduDCJH+1WBuyKAqjYCYsDe0sTurtuY9YP7
	 PsSJq73/szLqvh9gjEFhdRg2t8THe3mvVOrUy3YbLkB/ya/8U2iIZ84r4VIaNCxFyf
	 L5UpR6tzJOWnq72tcHH5DCYSDQhEo4YeO7OJQNmoWnHQHRlWagH1oLprxhueL4fRd+
	 o4UJc+O03x5GQ==
Date: Mon, 20 Jan 2025 11:06:38 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor
 ice_fdir_create_dflt_rules() function
Message-ID: <20250120110638.GW6206@kernel.org>
References: <20250117080632.10053-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117080632.10053-1-mateusz.polchlopek@intel.com>

On Fri, Jan 17, 2025 at 09:06:32AM +0100, Mateusz Polchlopek wrote:
> The Flow Director function ice_fdir_create_dflt_rules() calls few
> times function ice_create_init_fdir_rule() each time with different
> enum ice_fltr_ptype parameter. Next step is to return error code if
> error occurred.
> 
> Change the code to store all necessary default rules in constant array
> and call ice_create_init_fdir_rule() in the loop. It makes it easy to
> extend the list of default rules in the future, without the need of
> duplicate code more and more.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

