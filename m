Return-Path: <netdev+bounces-221418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E743B5079B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD126443CD3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0D1C3C11;
	Tue,  9 Sep 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE3O6GK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31212CDA5
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451675; cv=none; b=mhL9Y7DwMQysXY8jO+9q7Saekbxfx4V4blJrppeEaoG5lL/UYFwptSr0D8jnKIjOhx2szd0Ru4r2Q+NY/9XT/lWlLCuDF8Wu41nM7ZAelmt8sXPbVDyEovx83G79P5FHPovZ5q71P5Y7TlFXaKPVJdFvl9ZcqpZyAfJNDaXk1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451675; c=relaxed/simple;
	bh=D2ZdgPsjqexsJh1SrE79RnfKNE7yxCfkIb/D0ea9eWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kW3hymtqVrxaJesieBizvxljHAoThFp/hQz/5bW1XH8b/5BS3pfTL4VhA4q6PY7ppwk8P1aGc8oarUXe2Zuaw5oZe/dbP5bDEoiuhq33MiN+GTxaPePH6W4OMNAoZ0l+Cdz5DV+4yFs73Zae/EBtxplsUb3w9GTOn91dUVRrtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE3O6GK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03305C4CEF4;
	Tue,  9 Sep 2025 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757451674;
	bh=D2ZdgPsjqexsJh1SrE79RnfKNE7yxCfkIb/D0ea9eWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qE3O6GK8Guko/hIu/kRCiByeRoXiQebzHVo3ecwXLm/Lk188ePCG3Z6VcwLcs/2q7
	 RI5DNhukyl5gaYHQw3p6wSHpXmAAv7Qjy+mmFc5gapUByweVHHY/F84G8sPB0474k/
	 RvPx1UgzNXoX/BbH9jwMnG7Bl5P+49eaRiOBN+Gn0ksF5SAtL6Fet0CT04sSRLUjO4
	 gWLDb8ix6KBzudjrtDI1SaEEVSlrGv0CqHEHaDXZJz0duUTG0Feovbs4Jqb++9EQNW
	 6o5yCmZ9b9ELL8kdsE9GWaNq22Kl7Un81xk2UWltgMHFMfQeO4HPE0luW+rZJ0unk6
	 rYEKQc5itkb6g==
Date: Tue, 9 Sep 2025 14:01:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: mvneta: add support for hardware
 timestamps
Message-ID: <20250909140113.3977f8ba@kernel.org>
In-Reply-To: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
References: <E1uw0ID-00000004I6z-2ivB@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Sep 2025 16:30:01 +0100 Russell King wrote:
> +		/* FIXME: This is not really the true transmit point, since
> +		 * we batch up several before hitting the hardware, but is
> +		 * the best we can do without more complexity to walk the
> +		 * packets in the pending section of the transmit queue.
> +		 */

That's true for all SW/driver timestamps I know of. 
No objection to keeping the comment, just a FWIW.

