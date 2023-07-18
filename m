Return-Path: <netdev+bounces-18727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD9758665
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3D1C20E09
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D14171DB;
	Tue, 18 Jul 2023 21:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090715AF4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 21:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEF7C433C8;
	Tue, 18 Jul 2023 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689714188;
	bh=o3Jvx9qhitAUK/np9vwAANypajdBbxRTCgoTGxQwNgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRNvrnrxd/2x8Pee7Au36NFGDDUv0HtepDXr7KaWHvlSo2xkJE1LCW1pR44rMGg05
	 +fZp3FppHrQYR+ksRuROqCrxhCnAbDDq/WS1nP6qtKrpKY8ltMcszRLMR2tPw5fs65
	 OsdGNQixLOeSzJaAETAnbB2FsMzvp+gvwnIIrBDhY8VLm5DBEbbbc85OHXQBmpuW23
	 HsIG0ZhxBvRBSBcQjEp29ZzAMsoDwxbrR+C+8gajX6eRwQMadOc7pbHKj3zGS0NBvn
	 rIIdFvbFtPsLbqN0Z8a3qZ+SkiT5zJ0TdvQ9HOkkLgY6nTW0CQlxumOPKJl2z8qUxP
	 VsviwmR8Eayrg==
Date: Tue, 18 Jul 2023 14:03:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [Bug 217678] New: Unexplainable packet drop starting at v6.4
Message-ID: <20230718140307.728272fd@kernel.org>
In-Reply-To: <20230717115352.79aecc71@hermes.local>
References: <20230717115352.79aecc71@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 11:53:52 -0700 Stephen Hemminger wrote:
> 1. This situation began after booting in different delays. Sometimes
> can trigger after 30 seconds after booting, and sometimes will be
> after 18 hours or more.

Probably just the echoes of the weirdness around recent Red Hat changes
in my heard, but I wonder where the line between bug report and support
ticket is.

