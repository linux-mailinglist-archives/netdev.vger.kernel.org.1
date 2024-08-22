Return-Path: <netdev+bounces-121069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1095995B8C5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC410283410
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3251CC14E;
	Thu, 22 Aug 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl5N2eiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6B1CB31D
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337877; cv=none; b=Xc7KhLSJwmoCgjcbDplNd68Go4kF8t/9aEqPtRyo1byFuZXUjMvRYKj5vbcgScynTZi9+1ZsCsw8nHlsiCefHnBqpxBpeZGKxi6wtnBYRXPj68aw21AfsQFwq8Vu15QycWfPChtI4JlNbgyguO/9xShN51UUjiqGSCk2ePz2d3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337877; c=relaxed/simple;
	bh=87SA/stBKNXT/v3vmIGU+pgezziLWfrzNNqpiZxVCVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDxz3dKCAPF8k6EgizSYj5mJRs+487kt+lzGk2IPtPMbRtyVfHAFYi/VazvM9n0Pb538vmQJvbMu8ZdqQcdlDjt8g2vfj4KatikdGX76i95ohEWAsIHFGHVYPGfVClTTLBJLh7EIeBOEPTfiTVPS2yiU3CFUbB39M0Mvf5NoRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl5N2eiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE273C4AF0E;
	Thu, 22 Aug 2024 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337877;
	bh=87SA/stBKNXT/v3vmIGU+pgezziLWfrzNNqpiZxVCVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pl5N2eiYVAsceohDb/XOH565wJcgcYhB9+4FKkdOJKvwP5byCRFWMvqwwsTuANR5j
	 /dKIbJQGZ5YlwaSQuf7RtUvxCSj/qTJwr1wJs7vOnUWZDC3pwtBuiMWKYYl3UQiheb
	 uPtc1MooQ1o7HMGU5yT9FvHq4odBtwduBswtBt3sTrjaYuG4R0SaTW67z9r6HdoUvW
	 mliJGDy/zRGoMfHk3VsP2j7URqhX1uB6JlwPSdn31MxCNeFbNJ5iQc4tUpdxTXfDlI
	 YHGwhlM8XSuu8VG02SqruNR8hCl69HqYwU/pt/IoV7bk3C5FpsYUCE64HkxNtBI9dV
	 QBuj7T/hxkoKA==
Date: Thu, 22 Aug 2024 07:44:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] net: drop special comment style
Message-ID: <20240822074436.6ae0d3d1@kernel.org>
In-Reply-To: <20240819110950.9602c7ae8daa.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
References: <20240819110950.9602c7ae8daa.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 11:09:43 +0200 Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As we discussed in the room at netdevconf earlier this week,
> drop the requirement for special comment style for netdev.
> 
> For checkpatch, the general check accepts both right now, so
> simply drop the special request there as well.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I, myself, don't care, which aligns with the new logic of accepting
both:

Acked-by: Jakub Kicinski <kuba@kernel.org>

