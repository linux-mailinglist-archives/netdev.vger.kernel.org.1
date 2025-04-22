Return-Path: <netdev+bounces-184701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F3A96F42
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9647ADE01
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C6283682;
	Tue, 22 Apr 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDZHAg/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00478DF58
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333238; cv=none; b=GQyz59Wl8el6mF1z8nFtcxMiwgATY5h5hLD+VSowu45vXbQlsSN5D3p05BdmfJejZUaFn+CRWmc29R5Iu/ris27ZDIQE+IrewtOvrme6A4/wxKYZUiR3CxULwxrr1cWBOTXfmrz2jqipPT6pOcyKTn3Vrf47tBZCgyrXckib858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333238; c=relaxed/simple;
	bh=FoMJHBpWMu0PfFPXdOpXqsF4rsLE9nT+684D4CStTqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZwDDE2F7hlTlYWJJeCwtslN4uydmZk58Sbkq/M/svRTB8gHRN6lOnkHL9hybWn0wUdCnb6zVjaluXo5YhlsqrBYNtse2rPjGYxJZqx7MBQNANRXSG/Y3AoWKFZfFH9WoZL44hG3SMKeyvXyn25AW6FvjiXX0tltXT96XJImuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDZHAg/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF7C4CEE9;
	Tue, 22 Apr 2025 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745333237;
	bh=FoMJHBpWMu0PfFPXdOpXqsF4rsLE9nT+684D4CStTqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDZHAg/vxSCs1SDn+fai6JVXrLIRdQ0usnl9Vqa5ZmduLJ7JUNOzfi9eVthE8v41f
	 XvsTO574pkxOVt7857ozBxJ2V4eCmwN/seI/sDnXYyor9O4J5xtT/BapgvLbjqAmeS
	 78ZvgvrKdoc0lbm1lJEmJvXeNMSkel6HXiCIferTFkTz7BqIRjfBPYz3TZi4ecKWfH
	 hOld6pXH5OsT7QF/jJQQN7SYdHHhU4CXIjyEbaUXFnlDb07Bq70JexyUhlCZ/5aK2q
	 WfrM+Dhthfsj1X3vyDzVEQiSNCNid4TrxMBrxZ71Wq8YxqrUX05IDydRM//5HJ6JPG
	 1WqaUn/HAYuHQ==
Date: Tue, 22 Apr 2025 07:47:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net: airoha: Add missing filed to
 ppe_mbox_data struct
Message-ID: <20250422074716.2ddd4320@kernel.org>
In-Reply-To: <aAeiYFIIOyTVvMhw@lore-desk>
References: <20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org>
	<20250421183610.7bad877c@kernel.org>
	<aAeiYFIIOyTVvMhw@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 16:06:24 +0200 Lorenzo Bianconi wrote:
> actually the commit below is even present in the net tree. Since this is
> required to work with the official airoha firmware, I guess I should repost
> targeting net with the same Fixes tag. Agree?

Agree! I must have mis-grep'ed it

