Return-Path: <netdev+bounces-171911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD43A4F4DE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325887A75D0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E845C18;
	Wed,  5 Mar 2025 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKC26AC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E4FBA27;
	Wed,  5 Mar 2025 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143017; cv=none; b=LQhCuDC9SyZDjJkMV55PhNy0npNGusbN/vE/duD8Qo7DZKJvKuiSAXvxPM3Gm/6g//Pbq96BsA8Srg8q4r+Pdm9Z6BJfjN8o49YzShDA3qtqNp2BFZE9BP2spWFtEraRU+ktytzLwVzLEplHJk/9Hmg5tWjyaK3XURamhJWYeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143017; c=relaxed/simple;
	bh=p2fHHRwbfxTC+zvZ5vM12u69WQOX7F8wxQnK45TsCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrd7NyaN9YqwQb7Zd4jvomeZmn4eTL6jPKJyuBTeu4Qb2LwyR0u4/fcLN5pNmcuL6/miLujteqBYhVI4lmMexCQ4wQF87DnU1kL20Nb7JwP4QVqkAedWaK722g8/RyX2pI1kefFWCzWKJjZ1Fa4VpALK3YRpm+9u1wwva54IS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKC26AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5112EC4CEE5;
	Wed,  5 Mar 2025 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741143016;
	bh=p2fHHRwbfxTC+zvZ5vM12u69WQOX7F8wxQnK45TsCJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcKC26ACrFbg1Xbr69Va46gRCxOB4BfgtbugOUyqDAEvp81RqUbeNvXXkj5nCvlM7
	 g+PZKZe3jpQU9GPRhwVF3uaTxoUOqZy6NNOrn+9THhh9mZuOZFM3W5q6OEo3HWDnby
	 GgAMkDSNuRFh40Z02fSmw+5cA8rYrm+Gb1ojz/QjdUsrLcaXD1obxb/mY2lgJfxXAQ
	 6E+M0eRFY8lkQLgNwONl1fT/mrziX0nWvDSXOkxLdWldmULb2eRQ3NEeTYiVB7DatT
	 4FlmW+IY7H+ISR6Wiox0kYReBdFEKpeNQZlkyndpq0HZgqkzZ7y6JQG1qMmQ5khIs1
	 9VTN9xPRGpEpQ==
Date: Tue, 4 Mar 2025 18:50:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sanman
 Pradhan <sanman.p211993@gmail.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Su Hui <suhui@nfschina.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] eth: fbnic: Cleanup macros and string
 function
Message-ID: <20250304185015.4d0663f5@kernel.org>
In-Reply-To: <20250228191935.3953712-1-lee@trager.us>
References: <20250228191935.3953712-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 11:15:25 -0800 Lee Trager wrote:
> We have received some feedback that the macros we use for reading FW mailbox
> attributes are too large in scope and confusing to understanding. Additionally
> the string function did not provide errors allowing it to silently succeed.
> This patch set fixes theses issues.

Applied, thanks!

