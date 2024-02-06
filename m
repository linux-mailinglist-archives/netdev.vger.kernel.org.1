Return-Path: <netdev+bounces-69648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D284C0BE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BFB1F23A39
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968E1C69D;
	Tue,  6 Feb 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8p+DySB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E41CD27
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261455; cv=none; b=W3srRd50CnHzf4Pfh7i4csV1/SwCJhJgVHidKX1Cr2DR1EOStZKGmHGEUrwnvq5QpJQ2ZZrDBp2EZbSFkeoi5pIeS3LZxDwNvq7UdIe1afZ30b94jlGJlqw8+5e7QPN6ycm5oYxAXI57yAJX9YmjXhU7cMsnS5cOTglrGN7nnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261455; c=relaxed/simple;
	bh=xDeP1WzOK7z0TrBaP7cyYGKrsqjlegG7W3Yixb26mAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFW3/mDLC/xgVAV4AtzmZlaT4qbDKwH4qfohWZpExs3FZrqaKKQb9RCXBrJFdnmMNX7gwhNwNLkxWfwSw6wkmRtv3rIiJaLns031PEgoQIJmNF8Qf13nFzlgsC2VBbmN6DaHMdHngTdGc+mG97gyI6rQyyNangOJTfsQt9ABL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8p+DySB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F3EC433C7;
	Tue,  6 Feb 2024 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707261455;
	bh=xDeP1WzOK7z0TrBaP7cyYGKrsqjlegG7W3Yixb26mAM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8p+DySBWJ75qkCh7OjMVqv9bMVjApCJNhKXHlo2S+sDkIVQItorHFPY0strszai/
	 3YlgUQbtcJz4asTMTowCqnHCrTkIQ3BpdnpJnZg6EYAFasbGKgkKjtVpHmTIowJ5xs
	 A/bwZI9Tb6+w1e1k2ut0Cr++uml61X1D5/yNOg5GPktwZYumJjlVqptxU3CLLc8v22
	 0mQqg8hfe66G861JpvCwBE2Q1oIEwjmkrDyO/8zmiZdB8UQxODrvPxVenhNfEE/Nil
	 V6p0e/bfQhM6eCUXCeQBayzNuS1aXwFb57FwPunnJuAA4f+wmwzw+YNc2oyK+yg05S
	 +Py/FxQLeMvKA==
Date: Tue, 6 Feb 2024 15:17:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Bagnucki, Igor" <igor.bagnucki@intel.com>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v4 00/10 iwl-next] idpf: refactor virtchnl messages
Message-ID: <20240206151733.076ddfcd@kernel.org>
In-Reply-To: <CO1PR11MB508916E50B5BA5A85BE28852D6462@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
	<20240206105737.50149937@kernel.org>
	<d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
	<20240206120303.0fd22238@kernel.org>
	<CO1PR11MB508916E50B5BA5A85BE28852D6462@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2024 22:50:25 +0000 Keller, Jacob E wrote:
> > Hm, okay, that does sound like making it worse.
> > I'll disable the minmax coccicheck for now, it seems noisy.  
> 
> Maybe you could make the coccicheck only complain if the value is
> non-zero or not const? Maybe that's a bit too complicated... Hm

Non-zero could work. It may be worthwhile to look at the warnings cocci
currently generates and figure out what's common among the cases where
warning doesn't make sense.

