Return-Path: <netdev+bounces-162835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2EA281D5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC2B1886049
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80D18EA2;
	Wed,  5 Feb 2025 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn+3Wigz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64677EAD0
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722869; cv=none; b=QLUfqhBUM9ccCkdLlVADU9uR7fVjT4Gzk8NohVfbmoDQC0UQdQjUb6tEUlqqSS8AyRsOoosX5TMCgMES5+80ApP7PmqnPpRnjP9Efb36B8TTkrJD4jf6iTtPzVSzGa8dBou3VklIEqF+3UxIBlDiR08EJxMkON6jjdx2IE4w4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722869; c=relaxed/simple;
	bh=QPsXsnRdovvjDuEswWvxOO8uT+6DjrZxd12qbDn9u+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+XISsP/XT1YXAYhnbURTNg91LEzERxLNqTeJOjQjcTm7hhR9M1upSwhdaZl1mdBzlB78XmnB4y+zB2Y5LknzYYupoeJGwfNGqKY9cP+BzClYs8MYTXH7x95AzgwyRL4wEObX1cWeOEIbeklHZJVTXCQwIDl+mCtq2GP6IjXyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn+3Wigz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E434C4CEDF;
	Wed,  5 Feb 2025 02:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722868;
	bh=QPsXsnRdovvjDuEswWvxOO8uT+6DjrZxd12qbDn9u+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zn+3WigzLlZL9RbZ+x5iAb10bTJClhbOnLPx5wdlc0IguOd+1hS/ayGCxhS+ZlEZi
	 dTaGNfGTWnPAOaoKtlhLKK5R/Usdkmb8wnZoikAyDf3EZeRo07WuU2v2VHA/DOFf6g
	 BbNqyvHCSUTLYpsqme5iyiXJpUBFgFbVHIeHS0L6Hd1f1nNhfnoD93qI6asCv9zMVb
	 VgJ7wO5bujYOVKEkT+p02YZ+XkgF/gGKGfGy/BrTsCopjV6zZjBbmTvLRajiRn/fCj
	 UDquQf6oosftSlFbRXaoN1sh04xmYx+INRwjXOQhLYVaPiBz4CeTR44WR68P9hegOD
	 1zRJUTybdzr3A==
Date: Tue, 4 Feb 2025 18:34:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Message-ID: <20250204183427.1b261882@kernel.org>
In-Reply-To: <20250204133957.1140677-11-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
	<20250204133957.1140677-11-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 15:39:51 +0200 Danielle Ratson wrote:
> +#define YESNO(x) (((x) != 0) ? "Yes" : "No")
> +#define ONOFF(x) (((x) != 0) ? "On" : "Off")

Are these needed ? It appears we have them defined twice after this
series:

$ git grep 'define YES'
cmis.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")
module-common.h:#define YESNO(x) (((x) != 0) ? "Yes" : "No")

