Return-Path: <netdev+bounces-49052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA17F0859
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69527B2093F
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8163C5;
	Sun, 19 Nov 2023 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjmcmahon.com header.i=@rjmcmahon.com header.b="ir8VVTs7"
X-Original-To: netdev@vger.kernel.org
Received: from bobcat.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60363C2
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 10:36:04 -0800 (PST)
Received: from mail.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
	by bobcat.rjmcmahon.com (Postfix) with ESMTPA id CDD4E1B313
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 10:36:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com CDD4E1B313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
	s=bobcat; t=1700418963;
	bh=5v3o8p9wjMCpgpIYVJJq1dNE98wvNZkZjdUlQdDfLjY=;
	h=Date:From:To:Subject:From;
	b=ir8VVTs7b3sCPHbOrhiPYUgr6CzbZ5skU2jXH0GIOrQmQy1P9UBw+2aJzbpOij5Tc
	 f3fnHPVTurk08OAkbjmWyegVe3pCkisHXxuArgXDbQ1xtWy7RW9CcOxL+Fya4DVh8u
	 hbEnLWAQd6dQi4Q1flwPVA8xMvaAlJ3Xkr1k/kXw=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Nov 2023 10:36:03 -0800
From: rjmcmahon <rjmcmahon@rjmcmahon.com>
To: Netdev <netdev@vger.kernel.org>
Subject: On TCP_CONGESTION & letter case
Message-ID: <5dca57c7a699ac4a613806e8c8772dd7@rjmcmahon.com>
X-Sender: rjmcmahon@rjmcmahon.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: **

Hi all,

Will the CCA string in setsockopt and getsockopt for TCP_CONGESTION 
always be lowercase?

Sorry if this question has been asked and answered somewhere else.

Thanks,
Bob

