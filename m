Return-Path: <netdev+bounces-153197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FA49F7269
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34605170677
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F61433C0;
	Thu, 19 Dec 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngpPSi/h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351894120B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573559; cv=none; b=CtNtGzOwPx85hjq2neKNMtvInaDlmGePgmHGspWpphLVfHdFpMl8eIuhdleDhg/D5o8kE1U8T/GlmaWhSt/NFxDGsJsUQwUAVbc9gxREs82oV1FF5QBuwD86Z8cuhtZ3Csu8AMUa5b98sY4aw2j7NxUHv1Znpdx3G4LAZLBck/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573559; c=relaxed/simple;
	bh=JR6+SvnJS7toF5tgpQ4AdhWSNK2ATDlyzvS2ohd2Aw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOa/QBNNUnfKW4eAzbsazZkPJ8hCOCnNSTYeZpzkSma15d1RB2Jo5LpX5P+gHUqIGWkzGt+YBI/1IfSFuw6ojistU9Sx71RYv29lq2GFPDAn7e4QXD8otf4ujoDPBmuWxYJg6QAiLFy56F2MpokVq0M27hc3pqz1s7zzf4tpH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngpPSi/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC054C4CECD;
	Thu, 19 Dec 2024 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573559;
	bh=JR6+SvnJS7toF5tgpQ4AdhWSNK2ATDlyzvS2ohd2Aw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngpPSi/hnQXRf0C3l1rqMZ6nIP7P7Lzms0aKn/EquABoVgxPw185DxumN0Q95qETL
	 rFW3fUpb9ZLwxMgnf9YGAc5VWJ4tneTzxYWrYuci+g0dt9begY+6Qw6L1LdcrivTTW
	 VNyO36GYyvwTmuOdxt3O8W1zfc84SGxJwMsHwttv5sDyKnyzUUkz2sGPz/U3dAO3iQ
	 z8b8/1HaQh2WJlcowC+Qrd8OTF8gf+NERO1o8EQt2X9k5XEUjEw2iwKg/3xp7H6lCy
	 FAejgepdnHjP6vNtrh87RStd5RytUnc+lZw5VsH4+2/CFAKLajI7wKQQ0sz1SNPCQf
	 zPrKXuBBLv1Ew==
Date: Wed, 18 Dec 2024 17:59:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>, <arnd@arndb.de>, <jk@ozlabs.org>,
 <segher@kernel.crashing.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 24/25] net: spider_net: Remove powerpc Cell driver
Message-ID: <20241218175917.74a404c1@kernel.org>
In-Reply-To: <20241218105523.416573-24-mpe@ellerman.id.au>
References: <20241218105523.416573-1-mpe@ellerman.id.au>
	<20241218105523.416573-24-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 21:55:12 +1100 Michael Ellerman wrote:
> This driver can no longer be built since support for IBM Cell Blades was
> removed, in particular PPC_IBM_CELL_BLADE.
> 
> Remove the driver and the documentation.
> Remove the MAINTAINERS entry, and add Ishizaki and Geoff to CREDITS.

Yay! Please let us know if you'd like us to take these, otherwise I'll
assume you'll take them via powerpc.

