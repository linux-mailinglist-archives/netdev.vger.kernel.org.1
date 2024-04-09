Return-Path: <netdev+bounces-86131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03C89DA51
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED8C1F21EA6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FF6136E2A;
	Tue,  9 Apr 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsAQjYq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B1136E29;
	Tue,  9 Apr 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669257; cv=none; b=QCON95Bmlcj6nRIb6PuLOLvRazQh2Bn8K8hilN8pMgAlakZNfqilyn7E9W3i++xCuUjRSdn0maWtUCnTGpzyKYrrQI1UeqeefRx08+ZKxV3AvjkX1imFkNHagZ+h05xX62w20sntOPa2HPld7XKEPvcVZsARVQ5mVbxwGkcHc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669257; c=relaxed/simple;
	bh=Rcx44Jywg4fp0GB6abwphb0WTJLB/yX5eE14LI5C9vY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RLwdNiayOy9zDQ5H7UOiqrGI1x/kuM8of/aByB1uk1kiTALh9yIy0iCAqblsGhZusVFOIdqnDYH2ZSnEtAJ4hnW+HRigdF5H1Y+WCoNhD3kDfZniRVYedv1AARPetRgXQMxuRUIu+K/Kz/edx+Ju6UcAmsjPfFaoK/6ljabONiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsAQjYq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1292C433C7;
	Tue,  9 Apr 2024 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669256;
	bh=Rcx44Jywg4fp0GB6abwphb0WTJLB/yX5eE14LI5C9vY=;
	h=Date:From:To:Subject:From;
	b=OsAQjYq3ef6pzQOeNd3lG9oJjrvbDZKG3uUJJayeJADrrtwuKcEZ78Vyvwpz4K7/J
	 QPAI5BEpQ2j8BOmlao7xU1hnXFV/ZvYlnwU3zy0Usx7A5SFue4DH+WQcVYDP6CFkyf
	 reQzjD5luas53joEHZaukQhjOox2BaF58yYv/89D+dz1YWY71PaEAT+3EmlVVY+3uV
	 wMsn+pv2ecYwe8ZtPjtB/Q2SxsX05AkMVmgM77QTLF6bv1hInLT0pyoqFM8TZrInqq
	 4Bt9MOpT9NOOstxworPzZSyD0D9u3sWxJvjxevzdbYwJ2Gt1N6q9si936vhBbz+NoL
	 T59Hx/DeYnpDg==
Date: Tue, 9 Apr 2024 06:27:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - April 9th
Message-ID: <20240409062735.2811d3f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Yes, the bi-weekly call is happening today, I forgot to send out 
the reminder. Time zones are aligned again, so 8:30 am (PT) / 
5:30 pm (~EU). See you at https://bbb.lwn.net/b/jak-wkr-seg-hjn

