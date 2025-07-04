Return-Path: <netdev+bounces-204172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DEDAF9570
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133A31CC190C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0251ADFFB;
	Fri,  4 Jul 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0vIdv1k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445081A83F9
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639039; cv=none; b=WkecR/evuKLLW165eO1uk2kOX8p31phzPdXStWnL8saG/BgSRm66pF2G0NBhoEZhcEPlraqaGGzu0gIficzSlyqWhAhINWXFGIP3DYe4fEfR9aOk7BOmsvhOrvJ4nhNjoi23JVZ7QhSMoi5E1Tw0o8JrYJv4Isshj7Gsft1KWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639039; c=relaxed/simple;
	bh=7WxuQlZc8vD5Z2eIBi4LfKOgvwn7Ii6URZnvn7v0EZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNEgLSToXqVtNitGtssE3WJLMZ477QGMLs9XQ/zOFpjPafCEDvdb3GNAquQ1nbknJ8mtN0kMPOccAuHLrt0DY+n/8grroORY0xZ8Ru+POmRzT+h4WVPMpTF+kTTEzln9pVdlnEyR8NTe4msxnTS/KkhZpMNpw0WfIiHjLr5XU6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0vIdv1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ECDC4CEE3;
	Fri,  4 Jul 2025 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751639038;
	bh=7WxuQlZc8vD5Z2eIBi4LfKOgvwn7Ii6URZnvn7v0EZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0vIdv1kiJeyeJei5YeWNnELHvPB/rue8OHxIBjr1qkWnhfD7FnQpE8hqsr7KqPJW
	 F+wc5CfEFGAjSvlacF873FFvBAu/PlBO0dQ/0JziQ5+4DmQd/G22cGHUIWPqSbETp8
	 j7p5zXlQ2itNtAXyVtFAGgegRrD8reVVMk+GWIHvhQxi1gjhWr5L01ldn90IRJzbNl
	 7JsEvpa7dH462+RJrUD712AJOVm+lLUrmoySFDEonaBk4JzwRzaKe6aYFZZ7U39H4N
	 WndXVbF/xus83eGkkSCJSymZVJwrPBVeAwDYLGXi8tFA4zayyRbAuW0RyEoX8j/Bse
	 xUTMOVDeu5r8A==
Date: Fri, 4 Jul 2025 15:23:55 +0100
From: Simon Horman <horms@kernel.org>
To: Liangming Liu <liangming.liu@foxmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: fix mixed tab and space indentation in
 af_inet.c
Message-ID: <20250704142355.GX41770@horms.kernel.org>
References: <tencent_87F4A935227D7FACE9A05E681FC13882F40A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_87F4A935227D7FACE9A05E681FC13882F40A@qq.com>

On Fri, Jul 04, 2025 at 05:10:11PM +0800, Liangming Liu wrote:
> Fixes mixed use of tabs and spaces in af_inet.c to comply with
> Linux kernel coding style. This change does not affect logic
> or functionality.
> 
> Signed-off-by: Liangming Liu <liangming.liu@foxmail.com>

Hi,

Unfortunately we don't accept patches like this that
aren't part of a larger body of work.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~

  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:

  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)

  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.

  Conversely, spelling and grammar fixes are not discouraged.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
--
pw-bot: cr

