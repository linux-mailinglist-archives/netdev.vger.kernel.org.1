Return-Path: <netdev+bounces-126558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA0971D31
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D1528401C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A21BB6B7;
	Mon,  9 Sep 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=projectisizwe.org header.i=@projectisizwe.org header.b="DHh2JQFY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CA3iIzo2"
X-Original-To: netdev@vger.kernel.org
Received: from a4-23.smtp-out.eu-west-1.amazonses.com (a4-23.smtp-out.eu-west-1.amazonses.com [54.240.4.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E628EC
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893533; cv=none; b=ekE65C9vNUfMESzO8mnvzApzLXP0CfKOA10itBUJ3cayWM5xvcSh38PTst/JFwcKeOi2s8xtXrrgK2v4jDPFQ92+Iz20MQ5U5Hg+mO8tFeJehsNSrdo0X7WbWgurLIN2dPqt31tGkO+C8maaRiq6XK2ckBrL6pQvten5KvDMX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893533; c=relaxed/simple;
	bh=7PkBlZ+rx12zwj567Rpr3h0Xmg7J/qWp+9HC8QLZxD4=;
	h=From:Subject:To:Content-Type:Date:Message-ID; b=VzbUV3wH3uKqbn0lmqnMhHZHn0IktihEGlgmhyfNM1ZQLapqaFs+4J7FlCkV7dgiUCTjkPU/71RaPN9zDVoSzxEqXnLHnPelUqdOdxkQmTZ/mSwoLtLldgvIKkWfI6nUbTKFMjX2D1FqWamR8BvGB0F2d/brCw53FZsLJ6sRjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=projectisizwe.org; spf=pass smtp.mailfrom=eu-west-1.amazonses.com; dkim=pass (2048-bit key) header.d=projectisizwe.org header.i=@projectisizwe.org header.b=DHh2JQFY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=CA3iIzo2; arc=none smtp.client-ip=54.240.4.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=projectisizwe.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-west-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=fzlixoqoly5bijrqur56zzodikzshzw6; d=projectisizwe.org;
	t=1725893529;
	h=From:Subject:To:Content-Type:Content-Transfer-Encoding:Reply-To:Date:Message-Id;
	bh=7PkBlZ+rx12zwj567Rpr3h0Xmg7J/qWp+9HC8QLZxD4=;
	b=DHh2JQFYhzk88/YdpBvX0Iksa9EBb1YbXHNkMtjU1nbQos6fUgk5Sb9Y9cF/GKRY
	4Y9HjBEsDUL7pYzuCmRRpmM7HAb7zQQxrnbzpugdLEpxHsRwIGDkxOgMxzRYULFxk0s
	cEJPjbuqZIgdd/aORJ83a7FK9ecbogIWdKM6Upzk9F7uV3YYyVsDUnMM6wh4yBle8a0
	F0c8OizJy4Y7dsDZd4K9iKU2W8w1/9TCUpWm5Pc6Rl21XjeCYCtS5h2SGep48YDuNxH
	uNCW7QBr0foT09YIJ64GnclvJO5ef2p+sWTNKiU9BPIAYcMkay3F4qBvNS8mvzullYD
	o/u0JMnzWA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725893529;
	h=From:Subject:To:Content-Type:Content-Transfer-Encoding:Reply-To:Date:Message-Id:Feedback-ID;
	bh=7PkBlZ+rx12zwj567Rpr3h0Xmg7J/qWp+9HC8QLZxD4=;
	b=CA3iIzo2P/kJNrMA8721zFKtmhv56YSA2Q2VkB6VbUIsPzWnTnY4T09L7eIvrN70
	7ty1S77rAx0RNkbUDL17Dl8EwrRv/EPyHmJ6tQoqTSfGExbqvKswa0bRQRaA6TItGki
	K6IkpVit1AIpbjSp1v3jZ8+s8gr9DDJk9yeT+AUk=
From: Trisha Hofmann <sizwe@projectisizwe.org>
Subject: 2023 Extension Filing Ready
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: trisha@oilandgashubsmainoffice.onmicrosoft.com
Date: Mon, 9 Sep 2024 14:52:09 +0000
Message-ID: <01020191d745510a-5728774e-0cda-4a8b-a172-474dfb9e75b4-000000@eu-west-1.amazonses.com>
Feedback-ID: ::1.eu-west-1.2AOxLgPAuuqpXrxWA5yvVxvT/eTBhUkjLwEgzF07NN4=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.4.23
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Good morning,

I have just gotten back into the country, been on the oil rig for the past 
year on the coast. I have compiled all my tax docs for the year 2023. I 
already filed for extension. My tax was delayed due to an accident on the 
rig and i am just recuperating.

Kindly let me know how to send my documents across or schedule a meeting so 
we can complete my filing for the year. Also please let us know the tax 
preparation Fee for late filing

Kindly revert,
Trisha Hofmann


