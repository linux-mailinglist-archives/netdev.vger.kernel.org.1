Return-Path: <netdev+bounces-177191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26796A6E393
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FF13A763B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E927E110;
	Mon, 24 Mar 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgWAAjYl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A310E9
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844672; cv=none; b=ttJiDyE1C/Y3iI9dFlGKSFHQzl0lLeSKRARWxp1pSKnUj//HuTYwRZJiJl6WiI4lfpsk+hc+XjJHQn8CTikTv/WhFm8Di4x+Sb9znXA9aHtfolK9Y3+8IK5VA49XHkFcL0rg11s88ch2wb/QNy51jVA01BV+q8PwYT6SNznf1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844672; c=relaxed/simple;
	bh=m10oppKyEgXQ5SfK3CD6amo/nIpUczGIsM39RH4O3U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0XY1sQICBYzH8CRKnIchCLaej4FE1gspmU7D4LKlNKobzB7X9EEObGyDTv3A7qPZ2OFqcxd88TMgk64WyhiAOo1KtCfOGvty/JhWYgj+zzm9GIlRTrC+iy6X2dNQ1znShVSnpOCl5gpAGg3x4SvmE4TH+WfQXu92P6RqCTjAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgWAAjYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E7AC4CEDD;
	Mon, 24 Mar 2025 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844670;
	bh=m10oppKyEgXQ5SfK3CD6amo/nIpUczGIsM39RH4O3U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgWAAjYllKa9JR65G3LiJl8rRaB7q70h/80pCB1/R7GFnmW97r9+fJ/iJk7Tzedq0
	 qqpaXBbze9vMEYfBMP/xNWrWpJRtzHYQTXPyNnaL8X6X/lOaG8yxRyVtIAXdIAGA7B
	 bSaHOAg+D4f76dNTPO3JiyF1xJKsi2giUANsebCEh7diUhNDiKxEUvx7OG1SuPGIyf
	 5rDGdiuFjKeTzklJEafwEsIOwFMEfR8QVOfj94LmK/lIcGkUzAFdbt7qSS1AjANqtX
	 xmF5ctCWrsW/pY6VLe+0aIY31Y3piWhxn280UCLDqhPp9eGNsiaj7trlkImeMjwnFy
	 fyZC0EI5H+6Eg==
Date: Mon, 24 Mar 2025 19:31:07 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 2/6] net: libwx: Add sriov api for
 wangxun nics
Message-ID: <20250324193107.GM892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <BB5F8D8A58D935D7+20250324020033.36225-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB5F8D8A58D935D7+20250324020033.36225-3-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:29AM +0800, Mengyuan Lou wrote:
> Implement sriov_configure interface for wangxun nics in libwx.
> Enable VT mode and initialize vf control structure, when sriov
> is enabled. Do not be allowed to disable sriov when vfs are
> assigned.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Reviewed-by: Simon Horman <horms@kernel.org>


