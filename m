Return-Path: <netdev+bounces-103243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18891907443
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC5B1F23059
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88E1E519;
	Thu, 13 Jun 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvZRukKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AC161;
	Thu, 13 Jun 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286636; cv=none; b=qbc7iZ2sAIRYoCnnDnAHQxyCS9aMDqSDgsV84M3qBNhQ3cTtEdPw8YW8WuGjLGyzY7OKqGd+opkKCwdlfPPX6bBI7LjjTejtxFHnVxfArPIGLW3B1IcWnJLnhEr8wpZ7MWzcezJaUGvVagAxMTEj9CNjJrBY9BV55B+PCoUr2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286636; c=relaxed/simple;
	bh=OKi9qQ3DVMAgbpAcDkR4JhzZz9wn+qyJdBUqHK+ndSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9otiUxSURr2QetI7JQymtQuJd1ZhrZDL5aouhal3b65zUkuLxBDBd7oUmDW5G5Y6O0UnM5kpVFGzBMIlxHj8NZG9ewx6o8Dx8qfADQAPvxanBqTOhANXBXNnU2i/Tfqmkt2MR5VkguzhCLRlaImxwjO3pp/wHk1xXL2Dtm31jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvZRukKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A798C2BBFC;
	Thu, 13 Jun 2024 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718286635;
	bh=OKi9qQ3DVMAgbpAcDkR4JhzZz9wn+qyJdBUqHK+ndSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mvZRukKXMXn9u6f30hwmtgwbhB3aplJr5gqcF6e8vIxGL3OllfvuIDLuUO4VCUHZ2
	 qopKUqyoRjpIarWsiXhF7SJ4C2kvlcu6jOMLIvVYTbdHZp6Icu0/F+KNqJu08LWxUN
	 p3u2EeDDKsJITj3FTQBJqy6nSLGJEY0AgEEiid5E/vuZ5RJjdyA27RoFpilFUENF8R
	 tNfw1U1JlH8hrMiM+NRZV3cx1Z5Du1hQQp/0p8JXpOfmCxdgQE4KIP7CdwfeTN+H/5
	 tTnH0Y7pvcovCYmOp63sEfPtSJiD4wv+9FhWgTlv+6zxn7RBU8W7uPx/Pc5Gt0l7/S
	 otMQtWItYY4tA==
Date: Thu, 13 Jun 2024 06:50:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] netdev call - May 7th
Message-ID: <20240613065034.51c3ef37@kernel.org>
In-Reply-To: <4a2236c6-1a1a-45bb-89d5-bbb66a8e79b3@intel.com>
References: <20240506075257.0ebd3785@kernel.org>
	<2730a628-88c8-4f46-a78d-03f96b3ec3e2@lunn.ch>
	<4a2236c6-1a1a-45bb-89d5-bbb66a8e79b3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:11:11 +0200 Przemek Kitszel wrote:
> Was it discussed? Any conclusions?

Y'all keep reinventing and working around locks with gazillion flags.
I really hope the step 0 for you will be to figure out a sane locking
scheme :( guard() is not gonna change the math.

