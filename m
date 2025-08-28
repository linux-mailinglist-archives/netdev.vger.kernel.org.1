Return-Path: <netdev+bounces-217571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173FDB3914B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41F8464D8B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93F23C4FA;
	Thu, 28 Aug 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmOk0LZW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD351E7C27
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346142; cv=none; b=gaEXZjL98g2zt6ifH785fP6UR8vE0ZdIlqKe7ldBRwYZIvCE0BSGZ2qPo4E/HT0ghCkJiOSLLq7D1x/AD2CXSFz/nxtt8HHvW3w9c0eFvJR0BUVJRCXc6HNWBjA7RV0W+18+L71aJyXjkc1sXXxlBvHNkWKTSBnQormqWyVPitg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346142; c=relaxed/simple;
	bh=7CHjwfyoou0rP6v5Bciqdrx9CxTgjwubyscPR1Yf38o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQaAiviji5nBEI8sUa2NBIpVS/8yeOctjV8OQoNaIa00L7k1svwba9pANvUrEjNPmpiV+5JipYtO2RJmHh6oGA20Wd79zSh5WO9u4864bEdwamUCkSigfSrJMv5an+DvYUdaPv5dTJ1yj2E8f0OJkSQM/TtfP8mnKb+++Ew1v3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmOk0LZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4FEC4CEEB;
	Thu, 28 Aug 2025 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756346141;
	bh=7CHjwfyoou0rP6v5Bciqdrx9CxTgjwubyscPR1Yf38o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmOk0LZWsNGecQYvXSwvyDmkM5LORk2Dia6eUsVfYCwlwgi5N7HfIL9I4EAA8+JAj
	 MF5ml2WaDsdeUtE+OumzqjKZQWNNhrRm6Ke7ac8mjPEipmJNwvMSmz77AZ4ZLtyAf7
	 upDucduWapSlfL7bn80TtQEOu8r+tXI7WiqkTwAuGEnXvpHkqYZSPkfCiaGaSJizZm
	 GQnOmWN7NzYYr0l8gk+AYggf42h7fO/jocCzSLMmEvxcMJqnVhA6Le/+45Tit+IiOs
	 EuQC9BuMlFAwmBT+83yfCdGQopUy6su2tmiZP/qUXB+sI07LmjqwchXxG6LDUW/J8t
	 +NI5MUtv056kA==
Date: Wed, 27 Aug 2025 18:55:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/13] macsec: use NLA_UINT for
 MACSEC_SA_ATTR_PN
Message-ID: <20250827185540.3e42dbcc@kernel.org>
In-Reply-To: <20250827185415.68d178c3@kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
	<c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
	<20250827185415.68d178c3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Aug 2025 18:54:15 -0700 Jakub Kicinski wrote:
> On Tue, 26 Aug 2025 15:16:24 +0200 Sabrina Dubroca wrote:
> > MACSEC_SA_ATTR_PN is either a u32 or a u64, we can now use NLA_UINT
> > for this instead of a custom binary type. We can then use a min check
> > within the policy.
> > 
> > We need to keep the length checks done in macsec_{add,upd}_{rx,tx}sa
> > based on whether the device is set up for XPN (with 64b PNs instead of
> > 32b).
> > 
> > On the dump side, keep the existing custom code as userspace may
> > expect a u64 when using XPN, and nla_put_uint may only output a u32
> > attribute if the value fits.  
> 
> I think this is a slight functional change on big endian.
> I suppose we don't care..

we don't care == the change is not intentional, so in the unlikely case
BE users exist aligning with LE is better in the first place.

