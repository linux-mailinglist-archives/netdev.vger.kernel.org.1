Return-Path: <netdev+bounces-114617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73994327A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D4C285D05
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5D1BBBCA;
	Wed, 31 Jul 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGQd/qIj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140C1B29A7;
	Wed, 31 Jul 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437606; cv=none; b=BHu8ZnztOIQXXcp7NseofSnrqkhxxbBCrMrULY1l+zKIQvr3zsjmKDjRlJu3ttjZo5s6aKobs769Z9oMx7zMZjefgLy2kIHFj2HEwyce5JY2J0jjkoYhjEQGc8y4Kg04WbALKV+aSJtBv+Wnk9nzHSp4wF0nu2XUv3apQnsjNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437606; c=relaxed/simple;
	bh=04DiHFlQJst8PufubC0qrIGXrnoe8fz8x2ZLCN0hLNI=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHqoHtIdYc8Txl8+43gZ7Z461GmvDnVHYOLY6rTZJjoI10JAWIsHRHSm5RugKzfvlbB6qK9Wvz/oGIpPFsJ7YTbPGoIvEsAQ5hGJlaKPP9MgRRA7XUqC7ztCC0ItQaEz+OIvhYg+8RzdsG/x4aMtfQIasDtK+CY4eDAFYY11No4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGQd/qIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AFAC116B1;
	Wed, 31 Jul 2024 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722437606;
	bh=04DiHFlQJst8PufubC0qrIGXrnoe8fz8x2ZLCN0hLNI=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=oGQd/qIjlxP7Jc7A1ajcq8GsT7KK3WXxefOlChCcfht+tMTk6hjvGPG0fOO16e2EY
	 sSkZvurn8LsWe+xYvPLKSitzeif4QIqKgU5UCzrQZodkuBSCbVtsrM3jH3y7Pe5QzE
	 qgpBkwDigjzZUMgqRmXlCs+kEmJdV7IBiB1q+Pp544WqWvSb0EURrWk/dCPJJaGf2w
	 BZZbyJY5KPrZbtmpH6I9MTUMyuuEdEVjFyadmC0buVMDuUjH/Mv6FcOswz7GmnS1Yr
	 bbC/xRbZasY1E/1ryurO5diSV7dHc5T8jANwbvu2JU/QBVVKFqrM2R7ZJ4/EZnHU5Y
	 41EzZ9ilWMALw==
Date: Wed, 31 Jul 2024 07:53:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] Reminder: deadline for LPC and netconf 2024 submission
 approaching
Message-ID: <20240731075325.3024fda9@kernel.org>
In-Reply-To: <20240725165102.4e1b55cb@kernel.org>
References: <20240725165102.4e1b55cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Final reminder, good people of netdev!

Please submit your topics for netconf and LPC by the end of the week!

On Thu, 25 Jul 2024 16:51:02 -0700 Jakub Kicinski wrote:
> Hi!
> 
> The deadline for submissions to LPC and netconf is fast approaching
> (August 4th, we extended the previous netconf deadline to align).
> 
> Quoting from the LPC CFP:
> 
>   Relevant topics span from proposals for kernel changes, through user
>   space tooling, to presenting interesting use cases, new protocols 
>   or new, interesting problems waiting for a solution.
> 
>   The goal is to allow gathering early feedback on proposals, reach
>   consensus on long running mailing list discussions and raise awareness
>   of interesting work or use cases. We are seeking proposals of 30-45 min
>   in length (including Q&A discussion). Presenting in person is preferred,
>   however, exceptions could be given for remotely presenting if attending
>   in person is challenging.
> 
> LPC CFP: https://lore.kernel.org/all/20240605143056.4a850c40@kernel.org
> netconf: https://lore.kernel.org/all/20240410091255.2fd6a373@kernel.org
> 
> Please feel free to submit the same topic to netconf and LPC.
> 
> netconf is a great opportunity to discuss proposals and challenges with
> the maintainers and key contributors, refer to materials from previous
> editions to get a sense of the topics:
> https://netdev.bots.linux.dev/netconf/
> Submissions of LPC are via the website, for netconf please send me
> a few sentences over email. Don't be shy!
> 
> Note that we have some speaker tickets to provide to those who haven't
> registered for LPC, yet.
> 
> If there are any questions or concerns don't hesitate to reach out
> to me on- or off-list.
> 
> Last but not least, remember that netconf is not the same thing as
> netdev.conf, which took place a week ago :)


