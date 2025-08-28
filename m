Return-Path: <netdev+bounces-217569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BB0B39143
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB708980E22
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D91244677;
	Thu, 28 Aug 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilb/SmUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650C244661
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345910; cv=none; b=gwqqWko8UBBh/h3SkiPRXQkuqC34xgwUQ3iXgb9U0CZdMP7uXUct2COGljo5NFCwBrviYQTY2enHaWriz8tydovuaMvTcG1Cal78DhxLp62NTXbrGum/QkdEaoKfCPNpgBDebXnVao8kER+bZQzIpkBsJ2vH/qhi5JaX0K/HxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345910; c=relaxed/simple;
	bh=VAN/U3qSeG2Ee92pQoq9v39XTWNEMfcvhCp23euNCU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiSOtl0SMSq9bWOwecrhPAjb4DLy+mCdTZs80EYJzMDikHH/6q/sPwzHNIcAYNW3V4HhJ2MT9w6m1VILURgzy6PEvGuaConJGZgjFcFBYMJSkaarc/YmG1lPW/VAJ6USAUH+sRvrz9VjOkHFCX8B5lmpjKmjdacJOlzFyYKYINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilb/SmUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B29C4CEEB;
	Thu, 28 Aug 2025 01:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756345910;
	bh=VAN/U3qSeG2Ee92pQoq9v39XTWNEMfcvhCp23euNCU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ilb/SmUYes8DyRyYdTCaiZ5u/qZOF511lATd7sX3UoHE9KMElmFnyxAVjkthCUxYV
	 eagLs9MEGWI4o1Gsyp7actNnY6aE+VcAGTF7cGdeZlBdiPS1MR1sj4YLrNQWZweD3s
	 KqkWVwjMOHzLsZsC2OtcXJswlPLpIUGI795IUnsWwe/DuRQIBXlZvY+F8XwymeeMs0
	 Jse95/JniMkxquY/Ag25HVbmVtwveF1DYVXLL6Ea1SPXDa/6NQR0b57gmYlZHBvk4R
	 tTktfIW/kA4bUI6OllRUW1nymycgxsYngDZkMs0AQ+Ph1T8XWcRie4/RmJiERvV9UX
	 rzlpiFXi9mo1w==
Date: Wed, 27 Aug 2025 18:51:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/13] macsec: add NLA_POLICY_MAX for
 MACSEC_OFFLOAD_ATTR_TYPE and IFLA_MACSEC_OFFLOAD
Message-ID: <20250827185149.48b45add@kernel.org>
In-Reply-To: <37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
	<37e1f1716f1d1d46d3d06c52317564b393fe60e6.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 15:16:26 +0200 Sabrina Dubroca wrote:
> This is equivalent to the existing checks allowing either
> MACSEC_OFFLOAD_OFF or calling macsec_check_offload.

AFAICT "equivalent" is a bit misleading as we didn't have validation.
But seems low risk.

