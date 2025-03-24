Return-Path: <netdev+bounces-177190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B512A6E391
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605483AEE2C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDA19AD70;
	Mon, 24 Mar 2025 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiTTd8g1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7E119ABA3
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844634; cv=none; b=fRXQvxz974O6HV75tYkKPxbx2+vdvEb0HBkbFtKP+fWETo2Subw14YVTzX1yWizTZw3A1caHVoZEnHOCfIvDjCq5gWp3243YjYhSkH/eMWP4/rzTPv0VxEuIQpEDMKdXG77bif2H+HdQ+1dCKHB8wd2CQW91erejrVxU2OtyNsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844634; c=relaxed/simple;
	bh=fYGJA2NI2dMfezcSEa7PuDvYwzYsReeEvxbxkIDC+B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWZiuvtOqEo06zFv2rIRBT4MXws9w/iQI71fOa5Ht2DWquEQUAwXMdVecfbFWJvu+pxzDNfzN3jGNxOaBRbvCWnfhNrLNJMq5lG7ZMYlfQJJd2njcdb+aGrjIXmF6tvuZYDmH/wE8esHwyEPvwhG9dKfPMvoPTxRk26raSvS2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiTTd8g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D32BC4CEDD;
	Mon, 24 Mar 2025 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844634;
	bh=fYGJA2NI2dMfezcSEa7PuDvYwzYsReeEvxbxkIDC+B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AiTTd8g1bfDAhJLLT9tEP0Ut8RmUmF3XqQRDsSnhSUOAD1nGqK5Z9339wdSv3u+zx
	 W0cxi7rIEiQHeHDyhSLWi+vPjrwaWgUlHiLpy5WCKqYciUB7F6vdVDdbF1BML+U6Hh
	 aMxJ3g/m0V6ShZ68VOiGuJ/SEbFVDNRnWqBmKcP1tmDqSbYI5scS7kZCHMcrD5RIwf
	 V4RxF5pQwrhKkkuT2AxaQCd4PqT9Pu0suEJalNH7CVBHbctdJsBQDYwYeFSKFEv6mx
	 mhjKrJkVv5T4Idl4gmzyIymxpbD6JWb8zUl2O+l7fgIi1tdpF3Ob7Sbnx0Uv++p3aC
	 xKPHRYrvPeqrA==
Date: Mon, 24 Mar 2025 19:30:30 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [RESEND,PATCH net-next v9 1/6] net: libwx: Add mailbox api for
 wangxun pf drivers
Message-ID: <20250324193030.GL892515@horms.kernel.org>
References: <20250324020033.36225-1-mengyuanlou@net-swift.com>
 <A6047EA595026AA9+20250324020033.36225-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A6047EA595026AA9+20250324020033.36225-2-mengyuanlou@net-swift.com>

On Mon, Mar 24, 2025 at 10:00:28AM +0800, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Reviewed-by: Simon Horman <horms@kernel.org>


