Return-Path: <netdev+bounces-46711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A467E601E
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB79B280F11
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06C374D8;
	Wed,  8 Nov 2023 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEpEAMXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028910A06
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 21:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DEAC433C7;
	Wed,  8 Nov 2023 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699479944;
	bh=cH7mlZbv43X51KtintcGszNBNI0PO8LHj2oMnwGTrYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEpEAMXf8doF+tfDtjvi9AmsQtZH8+bnQtGjswJXtT+Z184I2iuH9lfLfcN32mzoy
	 S6/1KmFbGNc89nXz0Ep6ZJ5SqQBQYeqVO3n3GNWjDYkOZ6TxrOWF8eZ8JzkL9jZAVS
	 0UGCRUaEm+IsxXiMqayd+f+lGEn4W5XwZTdEjrjbyBhZD8pjUVaEUvSa+ne9bn4FdO
	 BLoZo3lHFLgIbQ/9wFrmZpS8xwVWFBH4jc6ZFngfYVGHBORfdXI62nE+J8Vgw7w3WM
	 m8IGANTvbFG12S2KG0i5W3upQUE+7CzFqHQRvnW0IzQDzKpFF/KXLJ+6AIF2mMCo/A
	 Q9kixAS+hVLdQ==
Date: Wed, 8 Nov 2023 16:45:42 -0500
From: Simon Horman <horms@kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR
 kerneldoc
Message-ID: <20231108214542.GA432024@kernel.org>
References: <20231107080117.29511-1-tklauser@distanz.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107080117.29511-1-tklauser@distanz.ch>

On Tue, Nov 07, 2023 at 09:01:17AM +0100, Tobias Klauser wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Hi Tobias,

I am fine with this change but I don't think it fits the guidelines for
a bug fix. So I think it would be better targeted at net-next.

	Subject: [PATCH net-next] ...

If so, the following applies:

## Form letter - net-next-closed

The merge window for v6.7 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after November 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

