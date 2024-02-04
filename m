Return-Path: <netdev+bounces-68956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE0D848F27
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A655328332D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CE22EF4;
	Sun,  4 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK9syyOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1022EEF
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063027; cv=none; b=UOR2y8j9iTvPA4GxvfSZyKZuzdY4znDj3Q5soue8/5/uDJy4CgV5sWC7q8qgO/CGTfYi8ty5l4MeyTf30GeRaZ4o7SISsKYqTfGjJFCoKhPGABzT8UyF7Op/5rKclxqX6C+Tg2SmEd/Lgbcm07jAqPgs85JU9BqZQJ1aAZVoEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063027; c=relaxed/simple;
	bh=DS59K+T6liHqOQP1lYfs/ls0BVf8k5wuY0HC0k+N0g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZWihOlL91BH01t6MUn7OsKnSlRP6AvQvLSIgmD4pAZ/iLfDyDoO7t+1wRXLvHl6Fhu+UU0aM+Ew4Lvd/7BEoA04uEBixQWlzNQWXx9EO/7AXXuWXRnsPrrNHMrA/Mq3NzhvFUDETwhLz/NZUzw6oIbqvGpyX1nw5+tzzNeOFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK9syyOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150BC433C7;
	Sun,  4 Feb 2024 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707063026;
	bh=DS59K+T6liHqOQP1lYfs/ls0BVf8k5wuY0HC0k+N0g4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XK9syyOQPijrhDDtXpEwIVrQCubIMZL4j0If//03HcEJQ/oKxADIrc8a7jin/khTj
	 UnZUu4jy38qIsoazkfXB5Z8Uhhmg1oZxLvsGfBzJtwQNDXPZqRmKHfD7TRKPewcZKl
	 sKYidfu5rHBs6NhNzfqWuyNUvL/O26QXHcjF3fE2b2pIAlc7Fomdzx9nliu8HR0bzH
	 7fQWk/ILexO+PjuevA/n5oxhA4buWzwIoI3xI4W87K1ZInouyrIgguEp3Q9EsjZcdj
	 9BnhoAKjl5omhJbcBaT1V/6cWMPz7Fkac5RavhojqxN8tYnbAtFBQNW6sVve3JjfJT
	 XNaj7gcPFmgYQ==
Message-ID: <0af236c5-d713-4f5c-b91d-9baef46364cd@kernel.org>
Date: Sun, 4 Feb 2024 09:10:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sinquersw@gmail.com, kuifeng@meta.com
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-4-thinker.li@gmail.com> <Zb9nEkehw-j8s7o6@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Zb9nEkehw-j8s7o6@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/24 3:29 AM, Hangbin Liu wrote:
> FYI, I will wait for David Ahern to help review this patch.


I will get to it later today

