Return-Path: <netdev+bounces-161141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2018A1D9FF
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD66188646B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D3149DE8;
	Mon, 27 Jan 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2nNnPmu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8286333;
	Mon, 27 Jan 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993400; cv=none; b=PTfB/lpAlysi9FtP69VVi5VriADfotpvYX6e4VweHiHSJ4pmvwuEOBXdCho6shMpyhmO61PiqkfEpl92k3IhooKaLU2+y4xWa9Rup2QGOq2jtSGm61tja5bVwlfaphrHx1A1s+213ixqaRWM1jLZdG5gfwmPWWNmHR2ZbYcILlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993400; c=relaxed/simple;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=a8+TMj5VxkRwaj1XQcMYfJ8tTob9hAzjp5MSn64DMQN4wUKJ1MUBFxgW9k8ORpIG/vk+zOmESx9QjB/qRl2Sl6qESVRwAC/gU4GiFWnUFz316XTco85wmkOq18S+RGUqd1uN6doMqPzS4nLRwWbeUiRWKf4/NkWT9PvGvT4XDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2nNnPmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CDEC4CED2;
	Mon, 27 Jan 2025 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737993400;
	bh=QpeiK2sRkZo2IkL69SEukYBewbXtcL/h1uTz1zaXmac=;
	h=Date:From:To:Subject:From;
	b=H2nNnPmuAfGoGl4zUo39PZ1XJvQT2UrLQQUI+EgqHDxR9QOfOKEOdVSjWYP+Spj8I
	 EaS/naq3YZUElJQbkA7q3UXzznO2IdUlMLJkr5fgh09Z49z9QUEelU7hCPrG+tmNwm
	 jMMOqVHTaQlz9Zm0bx8iJCoYFx8vpg02YI9bkdxg8V0p02MMzpXq4JwVyq6YdmFzyB
	 GPdQQVkOgC5jC8N562cv2PNQtJTCZcxCdESLB7jZrMqPO304cGrAV/mFdc0jrZxiXs
	 +dYc7gyJWKUseqcpRZurrR8yegJUYbA1A4Y9glbJD5oEZu/cejO1s7qRNSBFCpD3zZ
	 zBghefKViP3JA==
Date: Mon, 27 Jan 2025 07:56:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] netdev call - Jan 27th
Message-ID: <20250127075639.19a5ad61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'm not aware of any topics so please share some, if nobody
does we'll cancel.

