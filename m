Return-Path: <netdev+bounces-217390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D35B3881D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C05E1C20F7E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A32D192B;
	Wed, 27 Aug 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/7Z1jOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C17225761
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313874; cv=none; b=gHiNf+2ki0v5FFdhpVk/UKdMOLujXKGCugGkWpPQIOwHQEGPGMUR7EXEOzPIs7u/ynUUnbuUlCa6xr4TVBgZpEdWqDgiS3cPzUNtOUTZC5Zb1QyPnPOMJr37eSGsR7UmooSX1FpWSp9MxQhEbHy8twExYuGr4jHj1gdHGU2luYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313874; c=relaxed/simple;
	bh=+za2Q0MykLYhbifQSSgTfrT2koh6bTcwxrHoSlruYXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKXxTTXg162Jw2hzE8flERLfu7B/cAf23nOw9Y0U8cwRX+V8z3SAnKznWzjXeZzoTLlddC7K6mZJrQsoeOqF04XzTtc4oxhAckPK+JubPWFCYABQdmWAn+VgNl2RC9UAjN3cDlqfeGftqEZMU//HIMKKYeTNlaa57VmyRLLMdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/7Z1jOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508BC4CEEB;
	Wed, 27 Aug 2025 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313874;
	bh=+za2Q0MykLYhbifQSSgTfrT2koh6bTcwxrHoSlruYXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/7Z1jOAljqJdCF5xtMbrTBo93UPthP2sjUXlUl0rP7VlPaAwK3bNTq7rjGqlZHga
	 MjnoyedmG2GDCidjV2dLnQ/NPD/vumbhZypch9kUr1Ix5Tru2AxYRuYVBpE4/4Owq+
	 io71PLVbU4vL7iSTpUXm8sRi3E+HOOqdvVI5ljYI5hC+H091WLFEiXeaNNTejeAqCZ
	 KtrRwRYi328FnjtYfEmtU0X/jNzTjYc8DaSvGNFquZYD0+ICiYCAHwVd37pO9FLDQ1
	 OF70v5URNEcrT5TUhB5nGPoFyJ9ocm93LXB0m21ujgzdhlF6WsrCNReBaFvDPPRzE7
	 YFmgIYU6eVBOQ==
Date: Wed, 27 Aug 2025 17:57:51 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 13/13] macsec: replace custom check on
 IFLA_MACSEC_ENCODING_SA with NLA_POLICY_MAX
Message-ID: <20250827165751.GO10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <085bc642136cf3d267ddbb114e6f0c4a9247c797.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085bc642136cf3d267ddbb114e6f0c4a9247c797.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:31PM +0200, Sabrina Dubroca wrote:
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


