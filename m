Return-Path: <netdev+bounces-217384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C2CB38813
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203115E346C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13A2C3242;
	Wed, 27 Aug 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlfOnb6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7947276023
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313708; cv=none; b=N2EMsWxbcn9rNyuWu6SfebkeJM2CT4ITG7YF/iM/vrTFWFBseBGQSiQkUY9p12dDBEUOdfTq1YPH/U8QJ9dz2qh83F5WQO/WVtdYCOZBymg3FmYw7eY7q32YAqH2SAUw9HTRhktSONF4wqR3BcVWIyODTB45EU0mp5SNeYucnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313708; c=relaxed/simple;
	bh=Rgihr596KFZezdolTLQjlnc3O0ar5+QhaIwvbmrhw+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grn8eKS/qgvbUujKxoaFrvjeWGTZkCpLqxLzDWW+MgqoRYnnPFkhIXYFQpQZOaJNq12jPricfJT+N/bnW1pUDdw4sdAPUaCgDsJazWFKhIuIID5/H+RTaX/l0FuIaNgu/AC7Js68fPu+B6snisIUppcgUTNvZWiqhPfjnmo5DNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlfOnb6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8880C4CEEB;
	Wed, 27 Aug 2025 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313708;
	bh=Rgihr596KFZezdolTLQjlnc3O0ar5+QhaIwvbmrhw+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlfOnb6jOab8kfXMkxOyCiAoWniw6YjubJrVdw2tzuimnRwaALv6EYzv4qUIKg4h9
	 b+dv0oF64Pw1/qlj5wBPjYzI/b0zC2X7EsAxfx592wr0bn4A4BUuj34I0YJMVzozI4
	 awTCGiqkSwg0Po8Keeaqnay5L7ud4NMT9X2NHKtKIUrTzN0LsGY9BQxp8qCB66flXY
	 qmm9v5VG31HHFtt4x4sJMLX1fGa3fJl7Yp8yktM6cKiJkVOhJNbpjwdNiezGMIx+kq
	 R0NLqZ25xm7JinEvEHLO8isBSVMfdey74YJoxKQ0YQam70n/jRXsP+Z2Qnq6KOoTwB
	 +sz0jPIb5Qfkw==
Date: Wed, 27 Aug 2025 17:55:05 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/13] macsec: remove validate_add_rxsc
Message-ID: <20250827165505.GI10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <218147f2f11cab885abc86b779dcefcd3208a2f8.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218147f2f11cab885abc86b779dcefcd3208a2f8.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:25PM +0200, Sabrina Dubroca wrote:
> It's not doing much anymore.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


