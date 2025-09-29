Return-Path: <netdev+bounces-227073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9441FBA7EF1
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EF53B861B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 04:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5841FFC7B;
	Mon, 29 Sep 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmFeS71n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688D15E90;
	Mon, 29 Sep 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759119983; cv=none; b=W43HuDx0E46UwFQLh1VD5KRFQGZZdsFk5B9t4YHINcls5b5vsOv4WKlLnvltfQ88h5sdTYrOW0VxZMxvZBvrsegSt9w/TNkXJpXlXmk6yMg/mbzqJGxnjRcoMPBoZwLiGG68jKV5tEzztKmO8n9NuEuI2cGT9VrAWQCnMZZEVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759119983; c=relaxed/simple;
	bh=5MXCAKrM0qsDni4qbrGZIwt6Md46BWFVB0Lz6K//KHg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=OnqMDFa2fXupc1FsrOQbUK1ybLSCTFG9II9Bt7AZbCdSxtgMoK9r9cbg06gd/t/SpBdBZwpTocSeCUpn63bEyPmrG3HzQmKTj2YOqcysPIHvqx0ZfJSq1LrDKe2RW5Baj4n/8qO95oJV9VC1fQOa4PotpvC7TA+9utqUVKnRy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmFeS71n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F55C4CEF4;
	Mon, 29 Sep 2025 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759119983;
	bh=5MXCAKrM0qsDni4qbrGZIwt6Md46BWFVB0Lz6K//KHg=;
	h=Date:From:To:Subject:From;
	b=WmFeS71nt4SkgJrjk59EHMrNGedr7L+Y72p7q8w5IRY6KxKz7j7AUyYJx01r4bFjK
	 4ACNOnFAB31On+6EVFiC9EcGgejbHWdlU+6TEVZfdrvSyrhTGYHbjHZVisGt4nz8JG
	 ZgJbgahoozP1/mSpFSxArGXUKjOcnmdgJlVWyO1MirwDahCk99p5fS8xaPp+NHRINk
	 ctpOKSlwuOofhU4ZxMPeqjIMjjlP9G5UUFKgxhOJ7u/mvAThhXcjt1eRZzDnoLP467
	 2QY+JGXrt5uenGqE5f2s9eMcaH6CI03CWVVWPPnc/mDwFg26YpCe6OjCYxV4XEGpP4
	 4zvpgX3U+waeA==
Date: Sun, 28 Sep 2025 21:26:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20250928212617.7e0cbfe4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged v6.17 and as usual net-next will be closed for new
submissions for the duration of the merge window, until v6.18-rc1 
is tagged (on Oct 12th).

We will still look thru patches already in patchwork.

If you have a fix for net-next it's okay to still post it (with net-next
in the subject). net Fixes should continue to use "PATCH net".

