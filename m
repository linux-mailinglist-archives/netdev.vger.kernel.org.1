Return-Path: <netdev+bounces-135911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC899FC83
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9C31C24559
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B51A76DD;
	Tue, 15 Oct 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pacobu+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975021E3D8
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035323; cv=none; b=aoOVYuzcOxjsL8kkC4YjcUVp6JMJ1+IuRMLl0AiNwJVa8Pkh0Y4GmKWfR6aAv9PLcgzTYukvggEhkMcAHOlvxcZH5YgG1NXPdT0PRVFNK0vSyNyshJzxt5VGox3onprMZZksk/GJW39WnHqy+4TN09vFTMiDJxqsE8XppqfkJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035323; c=relaxed/simple;
	bh=qReQMe5MZdLGxAFuPEj0cFwS60ezZmrmsKSK7Jqqeyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggFbcrlsKlVACzxPxgpHCXmnrea5DhHqmCtGSAnr6RB/jXpe4LTVxrQGoGcGosey0fQRUIckfW4XwtWYq/3k4P9lBAl2s5K1JtnENCafpoLNcozOnUDppuYj2LvU/gqtRyvUxg9XoEnZ3F9lqjJI7i7qv1wP/Tr9sYAddw5DP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pacobu+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67618C4CEC6;
	Tue, 15 Oct 2024 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729035322;
	bh=qReQMe5MZdLGxAFuPEj0cFwS60ezZmrmsKSK7Jqqeyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pacobu+5r1T0St1oxZi4PgcDs+yDVW1GSUnq9a+AWl8jeBgYJcANJd+r5Fou5Uj2A
	 q1qku4VCjPFXykMFhMIhTz39V2Jh4m0FdDDu0FSz0M6Wyh6wj/kxlMe3a6n198Xwoy
	 fG0mrT+sl6eL31UDIJQ5fiKcPeEIfiEL9u8T303iPNN1+rQ14i/1K07BU8EQXUqGK/
	 u7XTWsJLbh9UmKcqVJ/IGE40tlvdAI3vbi16uXYmL2iu6LYX5v+s0wiMpPB6jEGozQ
	 dlb78ZeWCpmVTmREjxlHZbQl+Kg5wDLkQxob4PdrhzH+R7svN4ehKERn4Shp1eZSnT
	 2LiysM+j7pI1A==
Date: Tue, 15 Oct 2024 16:35:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, sd@queasysnail.net
Subject: Re: [PATCH net] netdevsim: macsec: pad u64 to correct length in
 logs
Message-ID: <20241015163521.3765bd68@kernel.org>
In-Reply-To: <20241015110943.94217-1-anezbeda@redhat.com>
References: <20241015110943.94217-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 13:09:43 +0200 Ales Nezbeda wrote:
> Currently, we pad u64 number to 8 characters using "%08llx" format
> specifier.
> 
> Changing format specifier to "%016llx" ensures that no matter the value
> the representation of number in log is always the same length.
> 
> Before this patch, entry in log for value '1' would say:
>     removing SecY with SCI 00000001 at index 2
> After this patch is applied, entry in log will say:
>     removing SecY with SCI 0000000000000001 at index 2
> 
> Fixes: 02b34d03a24b ("netdevsim: add dummy macsec offload")

padding prints in a test harness is not a fix so let's drop the Fixes
tag and repost against net-next
-- 
pw-bot: cr

