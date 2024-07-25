Return-Path: <netdev+bounces-113130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A793CB75
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 01:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A461C20C92
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE3149E01;
	Thu, 25 Jul 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDFUos9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BEF145A0B;
	Thu, 25 Jul 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951466; cv=none; b=qKmYGUyLdv4kP7W1MwBUsZgE0QeZSzgQMt6iVD4nLRWEiMIk6/K7xLdF02qbY0vg98k0CB9/tFZuUInFU7XA5MvOeFoflX+qmg+z6sP3pGbjEB6B8bGX94fFY+Eexhn9rXqkaoPxIhCicEndUCfO/Y07qlkNaUFC9hbR4Y21UC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951466; c=relaxed/simple;
	bh=NPVJBIXzkikVAlCWmCqeACxfwRnUScUTqbB9GjyqpVU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Vk/Z90qE+bN6orFD14LKAr5x43ISl2GYmXAsIJDrMEZqKzk9RxtxuqzinjEsD8aIsGzkys6WDuIFpGm3M/LbtlsXCnGB9AYCkkYooqaPjAQ2PaGn9JAdVFXsoYA2tmMf5ZJAySRKf6XosDwsxitdZKrhQiEO1kPPWJUu4o9crWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDFUos9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F905C116B1;
	Thu, 25 Jul 2024 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721951465;
	bh=NPVJBIXzkikVAlCWmCqeACxfwRnUScUTqbB9GjyqpVU=;
	h=Date:From:To:Subject:From;
	b=oDFUos9a4ttQaDAxZDnW9Sw8Qp9KWWizeUMNBseRtInwkbDFWPGUSoctaQgbUgvqu
	 rfMyTrSVLdc6OU5nRJfK6xt+eJnoQKi70HhpHSedRH+lEckcZ/TBpC9TPzx/5aMxZn
	 AqwGLKJiioJo9WyjP2pHfoJwuu1wgI5VAw4w+DCkauvpTLFoCC+VI6MOcfdQmau8zh
	 IZZKt5VxPr393JYQ33FBZT+LZens0XTu1gDIQkeMuiEQPbk+l3nrTpvSUuYiPcNeG+
	 seAQ/Cep4enTTGdwmCsarq4rZL7lfHNtUh+qhvzWnDhYp2eFKxC2EcWRVVAiXFOyyU
	 u0fQLonpIbbmw==
Date: Thu, 25 Jul 2024 16:51:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] Reminder: deadline for LPC and netconf 2024 submission
 approaching
Message-ID: <20240725165102.4e1b55cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The deadline for submissions to LPC and netconf is fast approaching
(August 4th, we extended the previous netconf deadline to align).

Quoting from the LPC CFP:

  Relevant topics span from proposals for kernel changes, through user
  space tooling, to presenting interesting use cases, new protocols 
  or new, interesting problems waiting for a solution.

  The goal is to allow gathering early feedback on proposals, reach
  consensus on long running mailing list discussions and raise awareness
  of interesting work or use cases. We are seeking proposals of 30-45 min
  in length (including Q&A discussion). Presenting in person is preferred,
  however, exceptions could be given for remotely presenting if attending
  in person is challenging.

LPC CFP: https://lore.kernel.org/all/20240605143056.4a850c40@kernel.org
netconf: https://lore.kernel.org/all/20240410091255.2fd6a373@kernel.org

Please feel free to submit the same topic to netconf and LPC.

netconf is a great opportunity to discuss proposals and challenges with
the maintainers and key contributors, refer to materials from previous
editions to get a sense of the topics:
https://netdev.bots.linux.dev/netconf/
Submissions of LPC are via the website, for netconf please send me
a few sentences over email. Don't be shy!

Note that we have some speaker tickets to provide to those who haven't
registered for LPC, yet.

If there are any questions or concerns don't hesitate to reach out
to me on- or off-list.

Last but not least, remember that netconf is not the same thing as
netdev.conf, which took place a week ago :)

