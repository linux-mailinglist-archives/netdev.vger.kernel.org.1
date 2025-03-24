Return-Path: <netdev+bounces-177075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12920A6DBA7
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24EC3A89C8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD125E456;
	Mon, 24 Mar 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqzHW33H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7725DAF7;
	Mon, 24 Mar 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823186; cv=none; b=nNakSfN7+2rWzdobZENrb1vGWWVkKWv8vjs9HObN/8pX0lcBd8uiaurlhaQu2RBTZRLMjFTF/k/rpHbmy6efMMYX8GeN1J0rC2wNjnwdReYa+Dt25zSFtR1F7XeHsVJX/rZYAzO+ER9yyyOX4JmNhFDp426+z2ZPyGBlbj3hSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823186; c=relaxed/simple;
	bh=POpM7iprYiMrRI4p3DTfMmzzBojyuvddVIFF9is9Pfo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=kd7SjixI7X4NwcoihkZynIzIUauBCRB4K8scj4ueEXTlVimPROiNPwehM3t4VeY1LEocj5WHyeae/mvXkK+15IqpOKia6OJRzl1TgE1XRaWc1j8oRpyqshoYrIC6e5qWSlNT60S04wG/h2uTofrYR09RlQn07aSdFGoafe9n7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqzHW33H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0CBC4CEE9;
	Mon, 24 Mar 2025 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742823186;
	bh=POpM7iprYiMrRI4p3DTfMmzzBojyuvddVIFF9is9Pfo=;
	h=Date:From:To:Subject:From;
	b=ZqzHW33HtGcRWMe5gkABEb0tQ96LfOyMqQXyhDanKMCV51C1QldR04jrdWOKSlHA+
	 Qn9wsDMMF6UaMnEyP2M91gR1UWBBoWP1gA9rHI0+51XBRaEw9sVwBPmJYmi2thlNMO
	 1LKbTdfxka6XzgPFHYnO9kCC9wW43PmfskO3Yc9RnkG6kQFw690UU5ogB1svKPry/X
	 8sm0ZM7MORVP39U3x2y3xzv7NGAuqFiHo6pW3esbNc0ZGEqXY53ysyt+78Bw/iGvqI
	 VKLTxaTuvjEjirooyf0/G7OnH6gQ8zCxncJz0PJMBID0HovNkE6lmHCp+P8ibyoAP5
	 mLdy2cavWrJCA==
Date: Mon, 24 Mar 2025 06:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Mar 25th
Message-ID: <20250324063300.6d0ceb84@kernel.org>
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
4:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

Note the timezone misalignment!

I'm not aware of any topics so please share some, if nobody
does we'll cancel.

