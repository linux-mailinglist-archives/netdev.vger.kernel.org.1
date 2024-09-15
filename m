Return-Path: <netdev+bounces-128406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734D979762
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572661C20C4F
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE51C7B6F;
	Sun, 15 Sep 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpM55Niz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A371C7B60;
	Sun, 15 Sep 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412724; cv=none; b=PecY27a1ehJ4V0OaM0zbupibbjfwbss5bAAbZSgFL3CNC/M2Fr7n2EqsEf4mzU2mBZQsBx8L/FUDUjolvEsLM2tG51v3rczz6ptBQdyzetl/mueTPYQg3DZh/DPOUBF108r5sisWPg21FIj4XMfDZHPBPLYPF3AkoLE8wgMGYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412724; c=relaxed/simple;
	bh=wXHt5/IVVu2xZ2zd2ilHT1jwyhWGRUYK0spBI1zCrY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRgQA230QE2x/xIuYgTXX6XwtmNtWn58NgvB9uJrsIZ24AAgD30ESqR5ruAfhOyvtsSn8SBDJxHb7NFZvt/WidRx9pqnaRzWhKzsCJtXi8axNtq65geRwAP/2SaHw+rlf8GHqGGkVje2OF/ZBMmX//llFZFxGggEcoNxchsDhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpM55Niz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0263EC4CEC3;
	Sun, 15 Sep 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726412724;
	bh=wXHt5/IVVu2xZ2zd2ilHT1jwyhWGRUYK0spBI1zCrY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IpM55Niz+7GsVIvUy8ay1cOGmJ7sfFgcxPc0J5l/XrbKSQijBeQTQYvk465yPZC2y
	 0PsUYNpuLXBnzWPgtApveQN2OAuAPhfBOvsA+/240F75Tcs9mTXXDi3vWCVA1unOq+
	 WvPguYPwltCsycBf5M8lZaq7NHPCz9Z/z+lW95lMXFXtF7NtoGieMtvdt9RCI9d7u5
	 BhgnMVhTZcjE1vVETkVMuiAAQRIjEdfX3U3LqBfPezNOzfdePFm3QlYr681GLZe+Ih
	 9aldL3CYSO17bmz5geZ0+qPRDXnEkq3Y8zhjwmdRT074wk5RRtzosVgwnn4EbHVgut
	 y71+86uRWkwOA==
Date: Sun, 15 Sep 2024 17:05:17 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 net-next 09/10] net: hibmcge: Add a Makefile and
 update Kconfig for hibmcge
Message-ID: <20240915170517.5cf1027c@kernel.org>
In-Reply-To: <20240912025127.3912972-10-shaojijie@huawei.com>
References: <20240912025127.3912972-1-shaojijie@huawei.com>
	<20240912025127.3912972-10-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 10:51:26 +0800 Jijie Shao wrote:
> +ccflags-y += -I$(src)

please drop this, use relative includes for local driver headers

