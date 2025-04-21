Return-Path: <netdev+bounces-184357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D64CA94F9D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 12:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71DF16F733
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00367261568;
	Mon, 21 Apr 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMfCEgcZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC425FA05;
	Mon, 21 Apr 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232872; cv=none; b=OF32HW9o1mDPV5IngpIz1Z4tD7/mZQO+rbck1dNjSinJavJ5nGeR6sRvCGUJwpTd3HnwwbSzY5c/6jzQ1MIqQisz5tSbR/ktnTJno1z4uRW2dho86rVCJfDKPV+t6pzPzsf5n4FR7g5u9SRijMoZzyeheo6pNzF5dJC9PyLXvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232872; c=relaxed/simple;
	bh=gMJvnEfotBvSliWuuC3VZ3tsHnAYdml0PIXBlVeN6Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUpUlaakGTUMTVRBcU3j6NDBYJX76oJmlshXJDEIsW5Y4KiCQDcK2eZaQXDp+RnMp0XVPV08VNO4IVyRdIBIjr1VGCPrgylLTklBMqRjfR8eZyq3QwkBSq9PdC1kHMM9WdEasS5lVbgtPQAGH3Jm91s2B+Q/qeLYFMnOxNZIor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMfCEgcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BEDC4CEE4;
	Mon, 21 Apr 2025 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745232872;
	bh=gMJvnEfotBvSliWuuC3VZ3tsHnAYdml0PIXBlVeN6Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMfCEgcZrtJO8QWVE0fbHENM58NkS3XmgW2rahmz7OqEEfwh+vuRFXa8nKOH3baiK
	 fxkbG8nGEXXUKqkQ8zCD8rst8hdzdyXuNWeWyQ0CktYzU2fdPndSTGXnKjimagHOmN
	 0xzSJDPGq9VaXOrg8RqoOgMkRgLDY7XNnBiiJJKHAYI9VqgS4aNhHMyyh9qI+IvM8j
	 YoekjaMnUoI/kzhPac5kxO8vMKYfwARPG0tuNcC1lYaCEA388bZTaq6u7ac1XPxK53
	 O3p1aJ9H4f6JyUbYzXlEyIRitDGoXaWMGOelQYYSg9QE4yW6Qbru99SiRzS3hF5vwF
	 1sbVZNb6uRcvw==
Date: Mon, 21 Apr 2025 11:54:28 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH v2 net-next 2/3] ionic: support ethtool
 get_module_eeprom_by_page
Message-ID: <20250421105428.GB2789685@horms.kernel.org>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
 <20250415231317.40616-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231317.40616-3-shannon.nelson@amd.com>

On Tue, Apr 15, 2025 at 04:13:15PM -0700, Shannon Nelson wrote:
> Add support for the newer get_module_eeprom_by_page interface.
> Only the upper half of the 256 byte page is available for
> reading, and the firmware puts the two sections into the
> extended sprom buffer, so a union is used over the extended
> sprom buffer to make clear which page is to be accessed.
> 
> With get_module_eeprom_by_page implemented there is no need
> for the older get_module_info or git_module_eeprom interfaces,
> so remove them.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


