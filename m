Return-Path: <netdev+bounces-37665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970917B683B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C27CA1C20803
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F175219F4;
	Tue,  3 Oct 2023 11:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF2208DD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C81BC433CA;
	Tue,  3 Oct 2023 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696333497;
	bh=k8cnobPkdVCXeL3c8IKKmK6W+O4lcf9poakgRi8Q4mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmyTUB1WTn44SqKX34+R/3bQCESFttPRwerLBsQmUeWf0ksD8Hlfxk9Z58SfiN9XG
	 EQQps3KIljJGcM2yV4KKiQWl3z5PEuG4op1EGbZJAOy2KxW/AWWmmvKYRH52MpDeBz
	 0CWNQXeJ3nk0LuUO98cbNIEFJUUwUmrM/4yh06U5xHefT96Wm3C27T/HKBoWPFK1HL
	 in98r3GCpcJQQwxndgcRdwESA4o0WF+xfZB9Q7mQTBsk03GxNkj5V0PEhXB9sZyZ9R
	 hKFmCnH6xWuG22pS+Bmr6AJpJXx1VQYQYDpp+dM64meijrBltgf2BoA2hrFh09WjH+
	 C9Si+DKep1UHg==
Date: Tue, 3 Oct 2023 13:44:52 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: nl80211: fix doc typos
Message-ID: <ZRv+tGSZaH+GmTTt@kernel.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
 <20231001191633.19090-3-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001191633.19090-3-rdunlap@infradead.org>

On Sun, Oct 01, 2023 at 12:16:33PM -0700, Randy Dunlap wrote:
> Correct some typos.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


