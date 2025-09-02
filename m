Return-Path: <netdev+bounces-219099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803CB3FCFC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6A316EA3C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2B283FF1;
	Tue,  2 Sep 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="wXfarb3+"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAF283680
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810047; cv=none; b=qB6dQM8Fr1J4yL7uytHZRgwlDCoPDE3+xZOC0VzquGhoIGAv5NYvtUYFoynvLzKPFoXsTtDSyW+l5RJRgSQ0LIp03rYaCEsFmlFHyC7nBMj3iFqJxsBJPmDSKY/PlAoUzWxa8XNu9slzLgiBcHoiUm0f4OTMtEQ5u+iHhdvi540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810047; c=relaxed/simple;
	bh=LnJizG7XhZQVsn+enC0vl5CQ2axfJ3gHWyHyB/bX++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZhF7A0Mf8MBgGSkNurNlOu7yUAr81z58CYwY5MxI9cu6sA1O5M7fJWtLMk3AM92iiSMF3/VD+iifJjzaV9f0Omjeqn/jLdIjCQO0AxSP4idlNQz5F520Vto+ugOxQzgj3zRTeXoUCS4/IWxaxyOAu0sUBU72K+4Jx4ofVo+I08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=wXfarb3+; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cGMrQ21snz9tQ2;
	Tue,  2 Sep 2025 12:47:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1756810038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lV+l/abgmHpQqmeGSBvsTCuokZnuY1jXVG9xt6N9/rg=;
	b=wXfarb3+X1eSJg3DUEtiHXAviwGIcCABPRUQHzI9dmwGqo2CStl1aGBJSPFrvUw89ARXUI
	g/DGvr34anPxAZjGqw62gT/SgdMqSWzJ0sIQq7meyJp36iaS7ReKAjgh90Vq7+sGJcBhs6
	l4tvIHSCZshf+uCKe6IJAzPyqtGu3wcabMlsAhKum4I+Q/2lBPKBGxNxlQhkC9QgKOk5Yy
	OBJwXFXFsALybvALsPT1CDtM1Hz/1kM/NVje1g0iM972GY9Rcq1d0VCJB45ZXc9DEc4iHv
	6+w7g/PvgWmuKoV8tmw57nuoD5NF8w98LptEb6oAVk2xdvLpLSMH2O60MzFHpw==
Date: Tue, 2 Sep 2025 16:17:11 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2] net: intel: fm10k: Fix parameter idx set but not used
Message-ID: <crnofgnchveaeduom44nzbq26m2zudy4wut3pl7xgf3fwar46n@tzvxk3nwlgmq>
References: <e13abc99-fb35-4bc4-b110-9ddfa8cdb442@linux.dev>
 <20250902072422.603237-1-listout@listout.xyz>
 <c7005c02-63dc-4316-905c-e02283e398c5@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7005c02-63dc-4316-905c-e02283e398c5@linux.dev>

On 02.09.2025 11:34, Vadim Fedorenko wrote:
> On 02/09/2025 08:24, Brahmajit Das wrote:
> > Variable idx is set in the loop, but is never used resulting in dead
> > code. Building with GCC 16, which enables
> > -Werror=unused-but-set-parameter= by default results in build error.
> > This patch removes the idx parameter, since all the callers of the
> > fm10k_unbind_hw_stats_q as 0 as idx anyways.
> > 
> > Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Brahmajit Das <listout@listout.xyz>
> > ---
> > changes in v2:
> > 	- Removed the idx parameter, since all callers of
> > 	fm10k_unbind_hw_stats_q passes idx as 0 anyways.
> Just a reminder that you shouldn't send another version of the patch
> as a reply to the previous version. And you have to wait for at least
> 24h before sending next version to let other reviewers look at the code.
> Current submission looks OK in patchwork, so no action is needed from
> you right now.
> 
> Thanks,
> Vadim

Noted, thank you.
-- 
Regards,
listout

