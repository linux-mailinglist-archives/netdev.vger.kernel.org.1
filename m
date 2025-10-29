Return-Path: <netdev+bounces-234094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD57C1C73E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC756188C565
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB338350A0B;
	Wed, 29 Oct 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+Q3TZ0r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870833502AD
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759140; cv=none; b=BdapGaT/BbulvYPiMBeBpYtBBMZP6b4if1+PBU1MyIzP3W+YvtVViwsvCW2T4YFfKyeRllCigmnmYBpe/Zg41hIf1QRd1DNqv2IYEPozcTubrJqwpoi1X+XghbHRx73KsOurLX79mMJIKAfq6s/mVFKki9hBnvwbb5e9ZrZ8rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759140; c=relaxed/simple;
	bh=jkoXhZV0tCLNnY11dmb4cLLuhD/f3n5d0agSGcuuGiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUaFuuk3XQQntrC89O91GT/kGmGHCi69f+3bDZNFL6FCZSKgu9/eKAkTYH83gllrBNeQiDCFRH3oHmp8PAcCE0reuba/4l5GY7xiumMnK4v/oOna5eqlxUZok2VMP17uaHPmWKUB/QCZRe1NUbnXqh+pRfeByERzEHabg9TRsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+Q3TZ0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B4BC4CEF7;
	Wed, 29 Oct 2025 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759140;
	bh=jkoXhZV0tCLNnY11dmb4cLLuhD/f3n5d0agSGcuuGiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+Q3TZ0r3o03JrI9nDq+UUsTKbgt7EC6hRWkgZffAnXDxWAqqIdGxpcuNs5vmdC9D
	 EN5+Q6SrM48t3vnLWqB0V/QErHff2YfTLbd6PrRqNkPCFta4a1EYSzF9N+F/Fefvao
	 YiK1Ewo9qk/Rtb4Ma58mvYBAjwHsVjYCVFDfrySLrisd4GRkJ4Nyb6fpoi4ENFsS/N
	 4Y2t+ms/J0FGeSsi/XHZM2J2lzQjZZocVASr2XGVQ0kLc5GMP3kinaUAidMI6OrlWm
	 hiJsV/Jm03ssP9nASWuT+9wZAVs+MU/DGP7oe5ntjg6DqosPZ8N+2b0NPZ/6kOjvCp
	 E0xdbKG+wVerg==
Date: Wed, 29 Oct 2025 17:32:16 +0000
From: Simon Horman <horms@kernel.org>
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Cc: przemyslaw.kitszel@intel.com, devlink@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] devlink: add NULL check in devlink_dpipe_entry_clear
Message-ID: <aQJPoOocbpj_-iq5@horms.kernel.org>
References: <20251029070256.2091-1-zhangchujun@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029070256.2091-1-zhangchujun@cmss.chinamobile.com>

On Wed, Oct 29, 2025 at 03:02:56PM +0800, Zhang Chujun wrote:
> This patch adds a NULL check for the pointer 'entry' at the entry
> point of the function devlink_pipe_entry_clear. If the passed
> 'entry' is NULL, the function returns immediately, avoiding subsequent
> dereferencing of a NULL pointer and thus preventing potential kernel
> crahses or segmentation faults.
> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

Hi,

Do you have a case where entry can be NULL?
If not, this feels like defensive programming,
which, AFAIK, is not the preferred approach for Kernel code.

...

