Return-Path: <netdev+bounces-146262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951579D28A0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FBAB2300E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDEC1CDFD8;
	Tue, 19 Nov 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF+qFPGH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE5199240;
	Tue, 19 Nov 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027978; cv=none; b=CXiJWzPIrpOy0LIPSNI4tHexwRYb82cGFy3W4I2Di4hE+C09fkQ1pNybYv2vyhj5xkquCbG61ihw3hACidr7WNz6iG2uYUErhvnP5dRBc1nAOkXTJ+xPeE5XgKlPyLcq1ZE50ZxleYSwQtXZ0nxoVWIqHCkLvv4hyc5k9okFFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027978; c=relaxed/simple;
	bh=Nn72iFLnuMxWOtW0+9g1a3uqEBYC3hWlsamrh8wIVjY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YjbG/Bm07VdmcG6xam6KMVy2vaebGKckG7SF4oGMtDCU627nulSNErPWhApG7zMuRtas+QwLUw5VcAAde6wXRC29+VGmNcDAuPiVuWqdUO6r114gkdAq3phPAC3bXtjL6w0Mlohhe96wNtOWmQC00jbmOdi+l6S39YxAjn9Yuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF+qFPGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103A5C4CECF;
	Tue, 19 Nov 2024 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027978;
	bh=Nn72iFLnuMxWOtW0+9g1a3uqEBYC3hWlsamrh8wIVjY=;
	h=Date:From:To:Subject:From;
	b=IF+qFPGHP7o8U+5AUWEpZwHQrMmMiXC5hTiFrifHarKWq6fgsmJNGoWMkQkrxu3H4
	 h4ImrJgnwXF/BPzoacZnLuxwjr2fFpdE2KizBB81q8udweh4fUHEOsd1naU2f8xFLZ
	 H92NV3//H+SjIKRBUsTFdSrw/PVOaFko01f8lM0PqMxfo3Af06teulHvxPB9WEhWIy
	 wVZvc9WGnGwo2pE9prWg0L6lUYJJrviHOMqwyarq9qodl+RqfMHa/gxO2/pMNlXyAv
	 qALorKR2pgcUviKcq+jXUaSEWBaxcnd6pYTspoKxqtB1U+rC9Yfs1+xd2++Nj9bnF4
	 CyvPsoDpmArow==
Date: Tue, 19 Nov 2024 06:52:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] netdev call - Nov 19th
Message-ID: <20241119065257.5cb3bd87@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Now I remember what I forgot to do yesterday.. announce this call.

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

No agenda, yet, so it will likely be a very short one.
Please come with topics to discuss?

