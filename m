Return-Path: <netdev+bounces-164261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3787A2D280
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87F43ABA40
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C871EA73;
	Sat,  8 Feb 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAA1dQN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64229A2
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977180; cv=none; b=poVSvDj+vvI3fCjmWDmLb/5dBbGqg81c4u6TLtY3W4Xi7KncMDrOsbsgCstrTv8anr1PmtpYs4xYaSH69K3cmtVe0T5LtdPx2eSpD/2doB1AlBj7j04iQw0c9zAdSHC/cgQPSc4QST2VUaY06tlQeE28oryaLwTIMuOhIrYwOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977180; c=relaxed/simple;
	bh=PsXGyS+V+KA9T/xpM3hs9qCtcfLeiEiVYJaTcj2rwgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0o6487m8v7uHKyJwbZHG2q2zlEiqr8If4rb4GYO66/KiTU36gMrheqtyNeppEwzui/7sAtKZzOG7TOBEnFkSmRiMKYW+XzS7bP2HrZXhUP9feo4G4WjKD7jiAdQz9Mo1No2BAlTN65hL1jAbzejFC88B4OoNHmvV2FoU3N11cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAA1dQN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22ACC4CED1;
	Sat,  8 Feb 2025 01:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738977179;
	bh=PsXGyS+V+KA9T/xpM3hs9qCtcfLeiEiVYJaTcj2rwgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nAA1dQN0gJQ2G9z5vWvEkZTsZxHuWwVgeVmSihV3O+uUdu8NNZk+M9cCbyn8PBzgj
	 LItq4n2j7EZE//Rd/Y2jvbQ2vYmv3lBMlJ2BkGTdtnYTJByIQFrO52wsTVIHfl3xzD
	 cP15qBQRxG69++guXL/5gnkAALsMGo8WuA87kahfk4E96VgCpYsE2dN4vC7dYCAHrx
	 DNZbvdD9VNviUEJPC8pl8t+GxrUc1CpUI+R0kslbPBCyoSH5WvlUonxldk1V6heNjN
	 rz/8lG1Nrwgs1BylnHQ1xjdJJCa2irsglHJkennM8I0vID7yrdo+OMMqKZKd/m8Dmk
	 ebXfj2J2g+EYg==
Date: Fri, 7 Feb 2025 17:12:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 2/6] net: libwx: Add sriov api for wangxun
 nics
Message-ID: <20250207171258.5e3c3374@kernel.org>
In-Reply-To: <20250206103750.36064-3-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 18:37:46 +0800 mengyuanlou wrote:
> +	num_vf_macvlans = wx->mac.num_rar_entries -
> +			  (WX_MAX_PF_MACVLANS + 1 + num_vfs);
> +	if (!num_vf_macvlans)
> +		return;
> +
> +	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
> +			  GFP_KERNEL);
> +	if (mv_list) {

if you need to respin:

	if (!mv_list)
		return;

> +		for (i = 0; i < num_vf_macvlans; i++) {
> +			mv_list[i].vf = -1;
> +			mv_list[i].free = true;
> +			list_add(&mv_list[i].mvlist, &wx->vf_mvs.mvlist);
> +		}
> +		wx->mv_list = mv_list;
> +	}

