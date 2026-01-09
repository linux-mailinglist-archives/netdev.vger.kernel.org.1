Return-Path: <netdev+bounces-248527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0704D0A9F9
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B1E3085869
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6DE35BDC5;
	Fri,  9 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvTtwn8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F81A58D;
	Fri,  9 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968624; cv=none; b=VbPFw8ULIVHC2mKazODf2BiK5N2uhH59HFzF43O8jxUrwASTu6yE3GxGNRDdfqhLCkea957xpfqusWGijorIc3yA3M5SJu9wjU+mRaEtdBwfSmru6kH3u+lf3pnfSe3J9wEqRegOlcROcIH39GExykxtduu4v2U1Tn5mJp3usuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968624; c=relaxed/simple;
	bh=I38D9XYTfnNU7l+dVHx5TGMwNWjmaU+4YHbJgRJuk/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3914f2rHp7BCceyq2wi+3vhjpeL6t/AITPa85G0UflF+t4cLjQTr1/icrG+16o08B5uYkugSoJEXwSsrBXVE58nRDvCSr9pMDarkt8q6OGI5LKHbdvaTKMF6QcEQxPa6ZAT2Wnblx1vND5AqWT0xLhqgeOuzX8NP0EKlV8gafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvTtwn8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EC6C4CEF1;
	Fri,  9 Jan 2026 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767968624;
	bh=I38D9XYTfnNU7l+dVHx5TGMwNWjmaU+4YHbJgRJuk/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZvTtwn8mgcT4Bql+/TV8P6J3B+SYtD8lfuvGbbewiKjxtIHYB/XjKqYOd4gm+uX4y
	 vPJOdTuUa14vnKLg/LvDFineYJFfy5O03f4n7OHKdOArmDaGKxavNelTLY9HX2m5w4
	 rP7RTwnSpaRRV2Ji3NHzD0oMQd2OeGXyMI+BisTZ3fcwbUyNkSLpkQlLojEnFtHxnE
	 pVEdnhDuerU9IkwRmFhgi/qbvZGkjDvPbaCSxb22cQqONKpGJ3ufFAkm9KDTT9RyFy
	 RzlyWEhZmfA0/W2hWQniiNt4kEuB2dhGOrfluVpyuzchCf+oX7E02mtwuj5YRqtbNl
	 E5xKZMakqOzmg==
Date: Fri, 9 Jan 2026 06:23:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v10 2/9] hinic3: Add PF management interfaces
Message-ID: <20260109062342.2a6b1c89@kernel.org>
In-Reply-To: <add09d6f61ba86bd9c3c37fe3845b25291a26bdf.1767861236.git.zhuyikai1@h-partners.com>
References: <cover.1767861236.git.zhuyikai1@h-partners.com>
	<add09d6f61ba86bd9c3c37fe3845b25291a26bdf.1767861236.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 10:35:52 +0800 Fan Gong wrote:
> +static void hinic3_init_mgmt_msg_work(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
> +				      struct hinic3_recv_msg *recv_msg)
> +{
> +	struct mgmt_msg_handle_work *mgmt_work;
> +
> +	mgmt_work = kmalloc(sizeof(*mgmt_work), GFP_KERNEL);
> +	if (!mgmt_work)
> +		return;
> +
> +	if (recv_msg->msg_len) {
> +		mgmt_work->msg = kmalloc(recv_msg->msg_len, GFP_KERNEL);
> +		if (!mgmt_work->msg) {
> +			kfree(mgmt_work);
> +			return;
> +		}
> +		memcpy(mgmt_work->msg, recv_msg->msg, recv_msg->msg_len);

coccicheck says:

drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c:128:19-26: WARNING opportunity for kmemdup
-- 
pw-bot: cr

