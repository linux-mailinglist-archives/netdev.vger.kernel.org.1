Return-Path: <netdev+bounces-99804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB278D68D3
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBC12884E8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954AD176AC1;
	Fri, 31 May 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivmJASeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7C2E3F2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179435; cv=none; b=PZVLeq3QR9Y6ENsCzemBPOGsUhcmYgWQ5j/WHmEmvYHxhrn4RUfFDJCOKK33VExWDVUM0qVmqqDUPpXz0D5xro6gMwOFEbVTlJ2djlxFw7/BYBwTr1oKl4z/WV59WzvkzRUiiUGzdEDzZeaYk7AyFccGT6CpmIGSYaOYonOiBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179435; c=relaxed/simple;
	bh=zPBrhbLB0Q56LyxnRq5onVyfj0pzfuh5LNc4BRXZmWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abHgrxAKgQsw4YxYiB1SXqSPX8beshjzFiYMwN35HEKAj73LIhatmH3PEh6GjW9YKg59w0HopX0sulP6X3vyZ8M+6mx/bVZJ+0LO/p57uuXLsH51KwmpXktheFgT0UcsX/w3+QicHEskGPG4/mDbk0OEAIux3pStJVnJHOJ5/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivmJASeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA948C116B1;
	Fri, 31 May 2024 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179435;
	bh=zPBrhbLB0Q56LyxnRq5onVyfj0pzfuh5LNc4BRXZmWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivmJASeYYm1gNnFdhHxkL9bJ540N5+chCYHV0RWtkcSXRVYT6KCUGqHPTO4+6HSCG
	 wzErI4nUH2feDqBu/wYBAdQM8bFHyhe26CzVlKkwogXnsEA/LK9D0R2rlUTT7WxWIV
	 bzz6tS44pQwgJR+MzBPJeamCIMFzuGWG1+CLdW3gsEKsbXEPF0jj/27ElpTU5eS4pl
	 I5n9GSHpF/pP1ELnJNPDdKnz7oSlsT9ZMFexqcLhbm/RX04zjciL6h3eMV+hsns12y
	 ndrTDO3QbFfhsQRqFjbeL4ThItefj35Spv2nfot5w/nOWJyWMivpYvG3u/r9jX0j08
	 Ipr2zFHjQxfOg==
Date: Fri, 31 May 2024 19:17:09 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 09/15] ice: create port representor for SF
Message-ID: <20240531181709.GL491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-10-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-10-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:07AM +0200, Michal Swiatkowski wrote:
> Implement attaching and detaching SF port representor. It is done in the
> same way as the VF port representor.
> 
> SF port representor is always added or removed with devlink
> lock taken.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


