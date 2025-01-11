Return-Path: <netdev+bounces-157349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEF4A0A050
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FB216B0A6
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF976026;
	Sat, 11 Jan 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE379KHW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370389454;
	Sat, 11 Jan 2025 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736562277; cv=none; b=aTEanwd/V13m+A5OOovG+vssB2rJvaJY9dkGYPGbr1Oivup+C8xm8Jgz9XHvfJdbBcnccqEoHmb2OeAV1qa/CGgDb07DLEx6SfWVuMvNRjVcC9VnIKUPQoI6hm3WDla6JCP9ROcRxT/MZOzznENvhv7AyeUEhtHdMRLfrDq8TNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736562277; c=relaxed/simple;
	bh=367UxQeiSTJo4CAQ3EewhAT790PSuJPRk3z6Tj3F3r0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AktwCS5TroIhYAMW2noHlO+Ozl/R5w/lhQc42c9VPoK6KOeDBgItXBegShQCqD0eXpWbS+22oVAdDtZ0zh4gKhnqgx9IbXT6ELBoaKF7elOO+zSemw4LUrZo68ctqoKj2lha4qPIYVnFQAoTDDvKaPhWnFJ2+CAwZiLQXggHd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE379KHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FEC4CED6;
	Sat, 11 Jan 2025 02:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736562276;
	bh=367UxQeiSTJo4CAQ3EewhAT790PSuJPRk3z6Tj3F3r0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lE379KHWgJZ7bssCyXScvImzQ8Ywvn4lVgnLPb08BoGCMnugzOKZMaXO9cOSjhxx4
	 QcMGMPwDQ8U02fByULKKaow2GmuId8KSQAYfIZyCD1SN3ldC75ZF+oe9la+HW+SNcR
	 qP9mmVH2JEaefl0bI68SaI5Xcyuc/p996Msivd6Jsb1fiWpk/wIXAhXOMom086DZRA
	 8ttYfDc0Qtb1sxSi0SfZQaINrPLi+SSbxcNHhxB1msES9xGfElZt+v/sh6bB1TNh/f
	 H/JInO6wMqCVGf1SheyFN4LCVP2pdSTgprGQjbjeLW40ay9p25x5yo5WGVWIPW/mvz
	 jTxP94d40jjuQ==
Date: Fri, 10 Jan 2025 18:24:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yeking@Red54.com
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: appletalk: Drop aarp_send_probe_phase1()
Message-ID: <20250110182435.6b811abe@kernel.org>
In-Reply-To: <tencent_50197BA0ACE5FECA9F15DB877ED002416809@qq.com>
References: <tencent_50197BA0ACE5FECA9F15DB877ED002416809@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 12:27:51 +0000 Yeking@Red54.com wrote:
> Due to the ltpc, cops, and ipddp drivers have been deleted,
> aarp_send_probe_phase1() no longer works. (found by code inspection)

Could you explain more? What is your thought process?

> Fixes: 1dab47139e61 ("appletalk: remove ipddp driver")
> Fixes: 00f3696f7555 ("net: appletalk: remove cops support")
> Fixes: 03dcb90dbf62 ("net: appletalk: remove Apple/Farallon LocalTalk PC support")
> Fixes: dbecb011eb78 ("appletalk: use ndo_siocdevprivate")

Dead code is not a bug, you can mention the relevant commits
in the commit message, but no Fixes tag are appropriate here.
-- 
pw-bot: cr

