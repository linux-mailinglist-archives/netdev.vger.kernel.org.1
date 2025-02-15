Return-Path: <netdev+bounces-166693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A72A36F80
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C6B188F42E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FE1A5B95;
	Sat, 15 Feb 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxVe/hJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56948D529;
	Sat, 15 Feb 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637656; cv=none; b=nCQYuaCNinGo+onqysu+NbC5nZujminKyvQRGy6RjA1PpY7AdD0Bb8OevtHyyocYFWntwwuaYNqLdjuPRtqL9KM4BrOKKjoNGiHSmQ+gp+rICeCWHHAZRNmW1vVjg2tH+a4yjnkkkti9NapjVj+fA5nUF2oBzL9+myJ1gbMBkeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637656; c=relaxed/simple;
	bh=BVypI3IHDMnMPfXwsi4Pcfk/2mG1xpprtvPcUh7Oq/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2dF83/yyMoTg7ciFoPk0dZzZxRkhdRkX+6MD78EAxfjeQEIda950vyNfC0BeN7vQmSs3FcSjEt3IOXpYCCDgSuS3lQdbeUA4dUYTQEFlirbcj1fFLPeJ3DqvrMPkhUZyXVVnhPqyuWL4jcV13o9CnX//O5p0dQDXaP6c8KaPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxVe/hJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E07C4CEDF;
	Sat, 15 Feb 2025 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739637655;
	bh=BVypI3IHDMnMPfXwsi4Pcfk/2mG1xpprtvPcUh7Oq/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LxVe/hJI43RZTfJeGj+7sR1ZghHCg1isg3hh7FiXjK5tKo+1CU8NrvbPZr5Ctl3u3
	 lfb3vOgGFcre5sQwCpDTXlJxMvL1zxaTHQoNGq1QUfaFmV1iYAWuFh0DVdyeDRR+PA
	 OYVCxwtYlpp4l7Kih7FF58FGXAvRQrYvO3/zNKDeiWohpf6FlUpFAiQNE5j2eVqMmo
	 P6Ga1r0TqERaS4PQcqC/pL4rKNQ2tneou/k+NaXwoK8BJKNnh41wZCLd27SVIttcHt
	 fYaxadY5GRFsArt4SgvB8M19ezhoZTFqTnwSLW+H3jmxWAVlc2RWBRq+RI8ZbM216F
	 0eQSw+bgbeQ2w==
Date: Sat, 15 Feb 2025 08:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sean Anderson <sean.anderson@linux.dev>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: cadence: macb: Report standard stats
Message-ID: <20250215084054.09f12b7a@kernel.org>
In-Reply-To: <19e578ec-b71d-4b22-b1db-016f19c5801d@lunn.ch>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
	<20250214212703.2618652-3-sean.anderson@linux.dev>
	<19e578ec-b71d-4b22-b1db-016f19c5801d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 00:14:35 +0100 Andrew Lunn wrote:
> Could we maybe have one central table which drivers share? I assume
> IETF defined these bands as part or RMON?

IIRC RMON standardizes these three:

        {    0,    64 },
        {   65,   127 },
        {  128,   255 },
        {  256,   511 },
        {  512,  1023 },
        { 1024,  1518 },

Once we get into jumbo (as you probably noticed) the tables start 
to diverge, mostly because max MTU is different.

On one hand common code is nice, on the other I don't think defining
this table has ever been a source of confusion, and common table won't
buy users anything. But, would be yet another thing we have to check
in review, no?

