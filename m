Return-Path: <netdev+bounces-46450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD097E4342
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6161F21D2B
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266503158E;
	Tue,  7 Nov 2023 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKF+RYhH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612130D0B;
	Tue,  7 Nov 2023 15:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD475C433C9;
	Tue,  7 Nov 2023 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699370328;
	bh=uVJ645+VuEHxOP8w8Z+6y5IMCcpafxtnwjwVfF8N4mU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKF+RYhHYzGOqcc1tWqUcEHmYDXpwsOrbAPC0yyuBAC+FmY+KiW8k1twqUiw9zVM/
	 4NszSo7oeGlhDJ0QDUWeEroGyvH39RSeYtNxEKjLYspDnM+9TFfn2P+8eawyLYwDLV
	 rkJ0wmZY7CTaXE8Af37cxvAJpKgbq2OS2aYNuW1wIfpM+k4RldibtyBVTIiaLMDua3
	 idleeFra2A2zzNvhvhOus0gA+WQq52RQ0NzrWnhoRNyxQ43/bPTbehHVmGOhK3mXoZ
	 ZoqUp6BHE0tGlbhtCwApBg0oH0UHqHK+OwY7GoCwzTbr8n78uD8uXyGTN6P05KicNz
	 UwDkCXNYumttw==
Message-ID: <bbdedbf7-efad-48a2-8e27-53d03156fe17@kernel.org>
Date: Tue, 7 Nov 2023 08:18:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/12] Device Memory TCP
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20231106024413.2801438-1-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Is there a policy about cc'ing moderated lists on patch sets? I thought
there was, but not finding anything under Documentation/. Getting a
'needs moderator approval response' on every message is rather annoying.

