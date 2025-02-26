Return-Path: <netdev+bounces-169649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EC4A45161
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA283AA2AC
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BF2940D;
	Wed, 26 Feb 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR/y5lxe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F6219FF;
	Wed, 26 Feb 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740529397; cv=none; b=O3lhjbCpzQwlW8qnZhkdS+AghZrq/HyMABiHXOgNEijs+RNCSF+Wt160QXcwjKZkoNBVtZkQUBXY7Q/7K57Af4KxTBhjsmGasmLwDemU8Tq0TWxHZtW+0w6NeDTqX55Lq3LtzppUhSUAxCPjYECXFZDB0tl4TSukoaI2TIjOmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740529397; c=relaxed/simple;
	bh=NquPViIB4WSmGW9cMez+qk1y/1afdXWIZ9aaaRhlJf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0CD1llJj1Ssu4InjbIU2bbvRcImKM/o8tU02AA6PDzOQ2HwnlmS9EvqbIlgiJqBqtWfsByd1xfS9J79CNlqrVNPoBYf+V8TtvvAydQF8qBmEJjJbO+nwKyJW8Eypz/Wi0cXwy9k6tuzl248QiuPCT5BCSHIqkD0iJSld3J2aDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR/y5lxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4E7C4CEDD;
	Wed, 26 Feb 2025 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740529397;
	bh=NquPViIB4WSmGW9cMez+qk1y/1afdXWIZ9aaaRhlJf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tR/y5lxeVKIm5QCuNyTcbqqu8LaZ1f7DV1OUIXgoCbHM2iAe3uJVr1+3QufZFerZf
	 GTlbw41yEaNzd0jp/nDLRFAz/0lttcwxvVrj1vvEp5o60blc5nVHaz1fibb4iLJlrO
	 912CGa7lfNWRgknwZZKNPM1Ae/URXhlAegsL6JdLtFuEMPlP/LiyuD6YwfhbtCUHeR
	 jMX6cBL5b6gvaOD9CYRxtgPmG8U3r86Yw19qlkCfBDv8t9J8lSz5JROUJFa2zjnv3R
	 9aZBmRuSyVSRxPvqHfvjbC4NSiTnEocsQTz8QopCTNZ1rjIaOkNSeN6tyhGM5Pu0Im
	 i6o6xdo0UvMxw==
Date: Tue, 25 Feb 2025 16:23:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v06 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250225162315.5a9626cb@kernel.org>
In-Reply-To: <0e13370a2a444eb4e906e49276b2d5c4b8862616.1740487707.git.gur.stavi@huawei.com>
References: <cover.1740487707.git.gur.stavi@huawei.com>
	<0e13370a2a444eb4e906e49276b2d5c4b8862616.1740487707.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 16:53:30 +0200 Gur Stavi wrote:
>  .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  25 +

drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c:14:36-41: WARNING: conversion to bool not needed here
-- 
pw-bot: cr

