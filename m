Return-Path: <netdev+bounces-69792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFF884C9C5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46000B24972
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06851B5BF;
	Wed,  7 Feb 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+XSZPDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6B20B34;
	Wed,  7 Feb 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306093; cv=none; b=LteQt5aRer3a1SdrGXlf3B9nzXDYUV4oVGVll5ytfK0nhnUboVqpCQ/exfHskr47Dw4qH+cXXW2LOpyPNi4qSOSoFh/DwioltVB09f9Lowrv/OsnOfdRzpF5bFyNBJbXmscIvXG1WePeJoDrKO+4ZJVe0u3wgs+E2NEoAFp+J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306093; c=relaxed/simple;
	bh=gxNWpfgLSmIaSsyTC8WyBW+PvzWAZH3sKGiDvpPP8fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEw6zs8qxEKXz/SDXPNS0EZXk+MG3UPWQXzQ/ONO0b58DC0PqyLTaX6C8Fcbw2vtpNXfb9Z90TBBUKFY4QhJEAXvUIArao8nKDRuNJ6NakJMyDquIuQWsFO6i9rmRTeEm4asNgZJPqmi6xaKiJeV5tFMAazfmKcQCm08FqWPC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+XSZPDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38920C433F1;
	Wed,  7 Feb 2024 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707306093;
	bh=gxNWpfgLSmIaSsyTC8WyBW+PvzWAZH3sKGiDvpPP8fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+XSZPDLj5uIiPA9odm7ONpGoRXSmVzflZgkQe4cb5GG+neW2rF3vVOxjH0qPO23z
	 CrapPP5+z2XepqMS8+xHq8FrQU123D7l/vFLD8SFkUlsg3xtmwMmCiy8ULcF9xy+t7
	 M0uIwYSRNxFUkKjDIXGf/IdJm1806HJLntBZlVF69zNwaX+tJjs6Jz1Tv679QGA5Iy
	 PrqcozcoTFrMZan8Xqv278iKGay5v8q52wbQhBbl2D7zcVRSdgAIEdfsr0MYZTtQ7N
	 lVcltjAlEXDGXzPd6f9nagy6lucjgXlipxlXB3ewtL67FAz8KonzLZg3AGC9IdaxjO
	 3g+LnvaT0WsPQ==
Date: Wed, 7 Feb 2024 11:41:29 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net v2 2/9] net: fill in MODULE_DESCRIPTION()s for mpoa
Message-ID: <20240207114129.GG1297511@kernel.org>
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101929.484681-3-leitao@debian.org>

On Wed, Feb 07, 2024 at 02:19:21AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Multi-Protocol Over ATM (MPOA) driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


