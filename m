Return-Path: <netdev+bounces-198847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD91ADE0A4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BA417CDFA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF98188713;
	Wed, 18 Jun 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRlk/SaJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D035963;
	Wed, 18 Jun 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750209908; cv=none; b=AxH7PwlfZh/VQYY8YqX2fH5OTmlDad04ECRpRPpkiOBEPRnUSEd8Y6XN9jwxYklSTMahe+OUZoWiW46vnU9UX/ru/2VHiXUL6MYQcT+tzCZk+t617uJgihl4fnR8GJlRyRX/Xn89VdMz5w3YIT5lMCQ4Ae/anVSpyVob8lQD+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750209908; c=relaxed/simple;
	bh=vlNf4DPU02s/S3Bp9z5v57PZRC5NERyxi9d51QzIa7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usKyo+5+8gnlT5ZYmZflhF3iyXGhPxXx8lrdCff+ukFgweaNeuqzQiWzMeRaxy8xtMuKqwP4brKf/7J9DvSfr0a8TEnGEeveIJFr7Tgy6l50+sf9pczwVuKyzRp77lY6yI5iozQoCmHVwF8vcfs2BscwZ+hoKNmhJ7UYTGJ1qnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRlk/SaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB49EC4CEE3;
	Wed, 18 Jun 2025 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750209907;
	bh=vlNf4DPU02s/S3Bp9z5v57PZRC5NERyxi9d51QzIa7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tRlk/SaJrtO1Yp2Saapb549sOJdf32hClt9BTxlQmtrLMj7oE3CDmDbIxX8hiov7R
	 9LRI5DE4YgUr2v8fr0KsOPDm3QoZMZsS4akj++0nzVns8g4+CPRMUNBqKyTTTTuvBb
	 97y4xgm0mUF92OJ+H9nFBaM3RqMB2XbxO1IebuxYWZxl5/zwdO2/5KmB5fFoCloOKH
	 ENnOGQUW/qFC8W17547KzYbdipfixrFQpzox+ATc2ee9igN2yntByRXqcs2bytSPaQ
	 /8JdJ+2NdEJC78eE7x/ZUJd9VTAoYYHKwUGDVua0FwI3kI1fu3eMH9Qsnoqh7s/46/
	 P+RHo7DR1HoCg==
Date: Tue, 17 Jun 2025 18:25:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v03 1/1] hinic3: management interfaces
Message-ID: <20250617182505.6cfbd99f@kernel.org>
In-Reply-To: <c17133d2629728942ade513d3e761277cca4b44d.1750054732.git.zhuyikai1@h-partners.com>
References: <cover.1750054732.git.zhuyikai1@h-partners.com>
	<c17133d2629728942ade513d3e761277cca4b44d.1750054732.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 15:27:50 +0800 Fan Gong wrote:
>  25 files changed, 3735 insertions(+), 15 deletions(-)

Break it up into smaller patches, please.
-- 
pw-bot: cr

