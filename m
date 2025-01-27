Return-Path: <netdev+bounces-161142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C657A1DA00
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CD716199D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BE14B075;
	Mon, 27 Jan 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5CAUrVz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B960B8A;
	Mon, 27 Jan 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737993456; cv=none; b=cPb8M9GoZqDhsIFHM8Iz1haS1Q2m1pisrXlm/0MJKUVHBIYK1FQWFag89cHbvQO8KkycHHkJ0IMtoF54cyym9JaDSvYvIL1t8JbR7RNG7xPtIWTLfKnHVAi+Zj9VDkfWmQXTulB00RrRLWSpYom9de4EEqaIXcLQmdjjV56E47M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737993456; c=relaxed/simple;
	bh=7eKqMBwKMckNpbRjlFtCQPdCFP5YT8W+V5R6UBjEm5A=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPkPzeabTllD476vC7vHk0MLWvneXj/Br2+UtuNJdJ4Oq1HTWq+zNiHI7n0Wx+SbEQVw2wRearMvYt0EBl++bgx8VZXNLwzNRXq54Eph1o2TdCIM8l4j+O4uS6PXVHg9mggy1hXzHwBp62ZHTEPqQbEXzGRBbM9UAZavnMyBgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5CAUrVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B80DC4CED2;
	Mon, 27 Jan 2025 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737993455;
	bh=7eKqMBwKMckNpbRjlFtCQPdCFP5YT8W+V5R6UBjEm5A=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=j5CAUrVzBt5xoB5Bg2W1dwKL28j+5sFdKfBWa73Rc0oy5EmQGGlIY1mjf34DUUiZL
	 +fgisNbgNjCziHxmG7KEbF7RT2QKMLZiLPeMEiPaNZAYOg7ucShZ1JJ0h6+0LFOhOY
	 CZoUkZMhOmcLmjruecY2gDJedPde7RuEWBTse+YRdhWu0GMVUBIod/E8Aq2ZZEvHFf
	 o4kW1xJI8ABcUAFTseHzKYzz6LZozXZ4dp9ujRuyMdO3gb2Hpz3CKzvQz9DhWdrLb8
	 secqN0q6YBWSGKs3d/RIPQI0UslgxJKGHgVOhzd5Xdiog8P/Pu5HNctLv0bJWsJuvY
	 EiOgl9a9BstXQ==
Date: Mon, 27 Jan 2025 07:57:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] netdev call - Jan 27th
Message-ID: <20250127075734.273530f7@kernel.org>
In-Reply-To: <20250127075639.19a5ad61@kernel.org>
References: <20250127075639.19a5ad61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 07:56:39 -0800 Jakub Kicinski wrote:
> Subject: [ANN] netdev call - Jan 27th

Jan 28th!. Monday mornings are hard.. :)

