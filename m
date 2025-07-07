Return-Path: <netdev+bounces-204538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD9AFB140
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138CB4A0EA8
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547D28641B;
	Mon,  7 Jul 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf/9DyWw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89A19F10A;
	Mon,  7 Jul 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884305; cv=none; b=MC4AYn90haZkswQQiKCaHqdTGZulWoiDagjMmbRP2Y+eqSJ/WSJ+syumD3bB1ueyA9GghlIH3E+/QTM5wcmo209B1wQULcAzeUksrHn1j5wgw5kHlivqytAuXbLqH36Y0kw0rzeYE4N+ifsIcMrbqfPqujcXqIfHSoQk49rI78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884305; c=relaxed/simple;
	bh=zNVRCJVhxcyQEuZZNNKwSVumR6ZaqRVDBCyfbvp2W6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcIyA/huZU2URr000XnzGBGR5lAybMJOoPCfRhXd9JB0ukHp6tkXPhdL9cZM0v/Io0UpYsZh6gl5Rxvyr6u0GknTWMVSIyrr+Fol0i/PLBiNcbHpiLTvV/O9rfkkg/WlMP0s/eZWKu55Khvykqdl7siMyIQqOVNsMCYDjdVxOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf/9DyWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B692AC4CEE3;
	Mon,  7 Jul 2025 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751884303;
	bh=zNVRCJVhxcyQEuZZNNKwSVumR6ZaqRVDBCyfbvp2W6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jf/9DyWw2d48bKozsDaLn0IYfnQhzqps2iChqOnzZLDmFvmCJHYKUAOhftt9BzoqN
	 EWIB47MQ0Y7OEnXUE9dZ7XnK2wgC5IsNeLmoi8jcfmUjJWApD4c+V7GKKK9eYBcNA4
	 cRJYyceIlQ8SfajM1joSBd/Dyoq5JvVrPASRSO5eCsi+Gp61r2ZXK/myWOVKCTUsbx
	 kM+W0TqUevi/7ywtKliOKcXLVFCII3Nfe2yNU53P7f6Xf1FpY3wGOqTqEChB70DNRM
	 g7JS86ZA76mbh1pf7q1ZcJ4Xc6EqUoQl82/kzfJrN98iP79Azxh6hCuhi88gpVxBD0
	 SeRdKqVO81jZw==
Date: Mon, 7 Jul 2025 11:31:40 +0100
From: Simon Horman <horms@kernel.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] atm: lanai: fix "take a while" typo
Message-ID: <20250707103140.GD89747@horms.kernel.org>
References: <mn5rh6i773csmcrpfcr6bogvv2auypz2jwjn6dap2rxousxnw5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mn5rh6i773csmcrpfcr6bogvv2auypz2jwjn6dap2rxousxnw5@tarta.nabijaczleweli.xyz>

On Thu, Jul 03, 2025 at 08:21:16PM +0200, Ahelenia Ziemiańska wrote:
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnrufop6tch@tarta.nabijaczleweli.xyz/t/#u

Reviewed-by: Simon Horman <horms@kernel.org>



