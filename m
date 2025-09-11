Return-Path: <netdev+bounces-221914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5837B5254B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F3A1C205E9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E6136351;
	Thu, 11 Sep 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAcvMqRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA2134AC;
	Thu, 11 Sep 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552616; cv=none; b=X0tQ4CHrjkS0pioZWB5DP/cG2q0X2+4DBVZOzggK6qHZCukDIUYdkY16gpyFhaYq9crRwdVRS39WmK+sn16ee7A5V/CrT2SpmPv3qieZFaYsKRkGxkov/iEDPmjxoVP1ulV9pZJt52D5Mh4QPWqa4HEH+STgt79TCSCwfGi9ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552616; c=relaxed/simple;
	bh=LiMD7Yq8EeLwK5zzNdXzm03hL0chXJW8TQsnqED26ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzbAOsiL5rJ/0oJL2XX+TwYjzbpONBKNs2YEWVWJZj6aLktHepDAPUCwDBC45dY+FyAlm65YKSAQSy1CmBzfr1655+WVf4HZw1+spsETda/flD71Qs88T8AtdbwDnhAOFpJYeGRxhRRVEOKz7wGGsHDb6x9opqdOBzEVlGGeQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAcvMqRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCFFC4CEEB;
	Thu, 11 Sep 2025 01:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757552615;
	bh=LiMD7Yq8EeLwK5zzNdXzm03hL0chXJW8TQsnqED26ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MAcvMqRPeEyt1jEI51QFCvbEs0DTyNajUlwxAi9iEJOPoSo4Znoo5ZcYHo2BIwCQ0
	 yuKsHV3W3oYqgxm/kpDolSDeCNUuTteesua6ewy0ir7EeuH/OkUj5lDpVoYJPQyJ2A
	 cu45ksWlIfMGodrB3RilXsCr9nRXXmZYuSmpPDPRoTiB+MwiqbTu0Q+h1uozvgo1hE
	 koZiiwFxl14zkDWZxnEbv2kpOAR7UViSJfbgA9yRlJlGNMfzrrx8GwoiuW919/I267
	 G3MQyMU8UHLO0bfyqXfadM53mpTawNkOx0fHElOELpBAeHnL2UDSOPJQlZi0UKHKPR
	 0ZbYEIhMzqlhg==
Date: Wed, 10 Sep 2025 18:03:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <20250910180334.54e55869@kernel.org>
In-Reply-To: <00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
	<20250909120906.1781444-5-dong100@mucse.com>
	<68fc2f5c-2cbd-41f6-a814-5134ba06b4b5@ti.com>
	<20250909135822.2ac833fc@kernel.org>
	<00A30C785FE598BA+20250910060821.GB1832711@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 14:08:21 +0800 Yibo Dong wrote:
> 	do {
> 		err = mucse_mbx_get_info(hw);
> 		if (err != -ETIMEDOUT)
> 			break;
> 		/* only retry with ETIMEDOUT, others just return */
> 	} while (try_cnt--);

	do {
		err = bla();
	} while (err == -ETIMEDOUT && try_cnt--);

