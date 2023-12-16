Return-Path: <netdev+bounces-58167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB851815643
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8321C219C4
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539515BB;
	Sat, 16 Dec 2023 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVqLeEZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD915B9
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6089C433C8;
	Sat, 16 Dec 2023 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692552;
	bh=oAPMjFTkQqozEwEc1NSnwTx0+B+lW4D65miNVnJTiX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KVqLeEZ7PZ1dxUjXxmiWtbrINw6TIDsAe/S3vRk6p+Gjk0LO97p0kWm+R8sxe6kKO
	 lCH9v58wRDpIhorz0bOjKo7/sY1p5o4NOx/TwRzfVVNYTo8ZTp1vweUYzYXLlYcmFu
	 EKFmXabcdihnGath53Wj3G1vvY/3hrmH8dnZ+JBaPMO3hzkedpgmBXHriLBznNVvgn
	 UGCkcSnNlmPKaknqkYI3m3WXEZhAJi8gvpHket7AqHQ4z5XXXsboyfhZKYhKCxx5aS
	 KP6C7fRtIUaZXa4SzVvJpmupP58RZfA5jtaxwJz/sNcNoExgGTEwvCRhJffeO3+GcG
	 JIa1qw9YntMhA==
Date: Fri, 15 Dec 2023 18:09:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] netlink: specs: use exact-len for IPv6
 addr
Message-ID: <20231215180911.414b76d3@kernel.org>
In-Reply-To: <20231215035009.498049-4-liuhangbin@gmail.com>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:50:09 +0800 Hangbin Liu wrote:
> We should use the exact-len instead of min-len for IPv6 address.

It does make sense, but these families historically used min-len..
Not sure if it's worth changing this now or we risk regressions.

