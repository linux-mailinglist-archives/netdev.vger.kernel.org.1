Return-Path: <netdev+bounces-176966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A80A6D032
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 18:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D3B3AFC3C
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364D1DFF7;
	Sun, 23 Mar 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ragj1DmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1962E3367
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742750300; cv=none; b=eUPXhKrCtowDba9c4TqaXSR699n6DpT+5KQHG8zeJx0ODbIGRYBod3jszsdjl6x04niU56IqunGw1r4www+mr0w3z+VyFmNr5p+7FiM+HNBHSZ2d37UYjxJ/BgnV65FzDIUEL5MTq00V/alSUr9Sqqtc/R2At8W3ZYlvF42tHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742750300; c=relaxed/simple;
	bh=AfEP5myafd2YVQO5WMSJSZArn2vQQ+Sn1nkU4OJeiMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJd4MI8pUzQaLmsaWRQbRO/bXTSS4zJusQ0lUOjVl5aYHxFSO0JHX1p97Mw5mvR+VBE3Dd01ALnZg3SW2PCKtJwOtZKaz1ISj/0yfP1bqLTzSD9Siq1jIlk7JZ+ha9stTbEiqkaS2cIr7+m8kEQ4cYgDwKEt27AtEPLqt/LQJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ragj1DmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD4EC4CEE2;
	Sun, 23 Mar 2025 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742750299;
	bh=AfEP5myafd2YVQO5WMSJSZArn2vQQ+Sn1nkU4OJeiMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ragj1DmJYPLXGd+mWTL3m+jdzLdsidgcB7yVYw+cCe8wo3fL6lOcuiZYl0dC3g7Dp
	 ewv6FSzN6/7FgcyiWktlnNWFpgSJUyJtsDQaiZAnDY0plUQsp6zDhJPLibO+xS9mVu
	 dCWkd9prVBGXA+S6V/N66Q84FJAZaowJI/Orfx8Awc6Aysw5Vhw8UgKd4Gx5IZCfpS
	 CwvFBYMb5tTHhEbbHizxPNgnJVgTQ0FmxaZS4xBy2nNVE/UWF19dLXrBt0oGGxOI4k
	 EpTPCxzRgyB2nJV34pbWregoCpRZsjkirR0ZEMxb0zAzv2Ueeo4BMg2XrS5OGM8fxT
	 hUZoBfY4bJFvA==
Date: Sun, 23 Mar 2025 17:18:14 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	donald.hunter@gmail.com, parav@nvidia.com
Subject: Re: [PATCH net-next 1/4] ynl: devlink: add missing
 board-serial-number
Message-ID: <20250323171814.GU892515@horms.kernel.org>
References: <20250318153627.95030-1-jiri@resnulli.us>
 <20250318153627.95030-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318153627.95030-2-jiri@resnulli.us>

On Tue, Mar 18, 2025 at 04:36:24PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a missing attribute of board serial number.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


