Return-Path: <netdev+bounces-92994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5865B8B98B8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FAE1C2244D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FEE5820A;
	Thu,  2 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnuNz5js"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF256B73;
	Thu,  2 May 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645413; cv=none; b=Oy0xhTQQGlSwcES+3DD+eaAXS1F6BuaJFQhMgxjSzLALkVBWZVM/rOCl0Vd4uELnu3iSXhgPynVxCZ1DHp/HpdU4Cldfh82ILHhgwcZqxHOO5ywTjWPeNhaDevIWQZZrS1gXnD/FxqMDU/AcYCYAgYLHsDOJZ5TZjERic/c+cYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645413; c=relaxed/simple;
	bh=ja1UKESxKdgu0FF/YiYOmlaHU6Vp8rntl7jZYGmKZGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mivVtEhZTNpiadP28WXb5vA2jr10EKbepqmCwObYjCrbDP6NH24GxY1rcAlO4CQnZp25I0PHfw0i2lJJLwb+aLVUmqjqtjs71uNxZzVmb4+1HR+6OBHROe2p1oAI2ErlY0Dre++Lc+ntPInH6z3BL/m1DuqLBTa94uef/7lVpOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnuNz5js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09163C113CC;
	Thu,  2 May 2024 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714645413;
	bh=ja1UKESxKdgu0FF/YiYOmlaHU6Vp8rntl7jZYGmKZGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnuNz5jsnatTwFNi4IVOtuH0wWzX1fVo7aDRidBjhyBXlKyGE1JsqZut4icuvbMMh
	 +24lRzkfr3DjxhFaYONrKiW1bi5zndwkRI3c7ri88qGa/ovuZEwkmaiEc2NUV0Zorq
	 FTC73oiRU7BWAXY14EYnuLm1CX7N429bPF/z1PguYRXp45sDtaaoFVBrXDtfSwRuf3
	 a0He7vSLURF8tzxH/0WtQ0kjQOqpuE1It+8KdSh3P3SWhl1fkxfA3CmBh1BGqRbpPJ
	 Fy6uDKB+6soKmkmgEnTJoETAF+9u/llEQMkmEAIu9rP9hlW7AoAeTVYmtV4vhdmZU0
	 DHHk5tGHKHDSw==
Date: Thu, 2 May 2024 11:23:28 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v17 00/13] Add Realtek automotive PCIe driver
Message-ID: <20240502102328.GK2821784@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091847.65181-1-justinlai0215@realtek.com>

On Thu, May 02, 2024 at 05:18:34PM +0800, Justin Lai wrote:
> This series includes adding realtek automotive ethernet driver
> and adding rtase ethernet driver entry in MAINTAINERS file.
> 
> This ethernet device driver for the PCIe interface of 
> Realtek Automotive Ethernet Switch,applicable to 
> RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

Hi Justin,

Unfortunately this patch-set does not seem to apply cleanly to net-next.
Please rebase and repost.

Please wait the standard 24h before reposting.
Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

