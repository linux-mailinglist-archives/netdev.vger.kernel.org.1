Return-Path: <netdev+bounces-233684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90060C17605
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE6294E2EA2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462872C15A8;
	Tue, 28 Oct 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN5Net4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141B280033
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761694496; cv=none; b=C1/cFCrCmeoQAlmULOPlTzUrHgfAKM8qxXq36LLon6IVTViBBNNR9uQw5rVsENMX5CT2NYpiEqrqGQQWeW/3amRU7wmPrEglcOsdjkRUqgi6j3XEPBlpALl/8wh+8FD/+T6V7nFbb6V2JevGWH5DUBEI+w36rRjxzttRchHcqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761694496; c=relaxed/simple;
	bh=kLa4gjDOSeDQPpaDuFFI4V1VSh9j5HKheX4snjuiH4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NL066dHI82+if54cEx2fiXSAAvz4oNxPKyHgxMmVQKD+Q9YqUj28sdaOr3oYkqkQ/+HnDGU0nB4nyUE+E257N+l9PCrC6Zyfm3HRRis8+6zQETTNhNW9dV8SfVvjjDiudB/+il3wF6+zseQFg7lnNmiIJZSOXyVKxBJgsKO4zqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN5Net4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FABC4CEE7;
	Tue, 28 Oct 2025 23:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761694495;
	bh=kLa4gjDOSeDQPpaDuFFI4V1VSh9j5HKheX4snjuiH4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SN5Net4eb8eLW3EcMlwf/KO+/bnCvyJPhSWBuCHYSRXxVmKF8AGyuT6Bzc+a52708
	 9FhGV2KXgfWXTxBYJvq7JpoAPvSaVZ7f/Tg6mR/9sNt938FqBTglaJ3lsZkBuzUN2P
	 9VmJKdEcUlRCcqZfcuENPPgszbycQmGqKAIctZyHaSmrvA5HgUmLAL6vYtL9az+M4O
	 okTGlPM0ch8ClPq1tSBMeDmbxcN6FGoY6kn7YoE8ZDEMk0f4DsRNKyThdRHH4bTIJy
	 Mh0IeMEygnBiWuSiOw6xsje3GofJuVdX0/JyGp7V4qrchRhAPBQkiqQe1YWQeh9MWD
	 2iy6Bcg7p7XLg==
Date: Tue, 28 Oct 2025 16:34:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@fiberby.net
Subject: Re: [PATCH net-next v2 2/2] tools: ynl: rework the string
 representation of NlError
Message-ID: <20251028163454.66ca7dc3@kernel.org>
In-Reply-To: <53ad4e54-47c7-4afa-a296-635e10192f8c@lunn.ch>
References: <20251027192958.2058340-1-kuba@kernel.org>
	<20251027192958.2058340-2-kuba@kernel.org>
	<53ad4e54-47c7-4afa-a296-635e10192f8c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 14:58:59 +0100 Andrew Lunn wrote:
> I think as a kernel programmer, i would prefer EINVAL over Invalid
> argument. If i'm going to be digging into the kernel sources to find
> where the error is happening, it is one less translation i need to
> make.
> 
> >>> print(errno.errorcode[1])  
> EPERM
> >>> print(errno.errorcode[2])  
> ENOENT
> >>> print(errno.errorcode[110])  
> ETIMEDOUT
> 
> I suppose the question is, who is the intended user of ynl? Do we want
> user friendly messages, or kernel developer friendly messages?

A mix of both, it is packaged in distros.

