Return-Path: <netdev+bounces-28655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E366780294
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E6D282267
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 00:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28F8363;
	Fri, 18 Aug 2023 00:13:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143C360
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10CAC433C8;
	Fri, 18 Aug 2023 00:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692317585;
	bh=C+/ynu2hvYBZtMBA0r4hOOlLWuECvWqT7CdHlGYSyOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W8vzdhF1m8OKXIxoynFZYEQ7ilo4PsVUGeH/Ttgdoz9gEspboET+K+uLqbEtqepN9
	 UPmbglsiNgieILiXJz7A4CMIvEXeTjtoOBlafwGgp+H6Esoa1tF5dsKVFg4trwaKJR
	 uxFH6OL7HPfAYxW4YUf8dcF5oaxtFD+zeK8gfagJ5yDVEogJbiLF9Nkjc4R6Y2VsvA
	 gQltnN5Pv061UpTTKiE7fvsjKTZusHScorNhA6DCyvnSu1QolXtyAIWX2v9r9XxilN
	 YX1/+3MqGMxZI9x6WyibwCZYlRwWrvD1ex2FGeV98vncthTiaAtSsvXRFGiNTbvakJ
	 w6OFs2oOnqsWA==
Date: Thu, 17 Aug 2023 17:13:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com, Willem de Bruijn
 <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC net-next 00/13] net: page_pool: add netlink-based
 introspection
Message-ID: <20230817171303.32c56797@kernel.org>
In-Reply-To: <CAHS8izPB=x1ZYhan-sjuA8ofbHmxbHJrSbtvN3z3zfziBMmMdA@mail.gmail.com>
References: <20230816234303.3786178-1-kuba@kernel.org>
	<CAHS8izPB=x1ZYhan-sjuA8ofbHmxbHJrSbtvN3z3zfziBMmMdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 14:21:26 -0700 Mina Almasry wrote:
> - rx-queue GET API fits in nicely with what you described yesterday
> [1]. At the moment I'm a bit unsure because the SET api you described
> yesterday sounded per-rx-queue to me. But the GET api here is
> per-page-pool based. Maybe the distinction doesn't matter? Maybe
> you're thinking they're unrelated APIs?

Right, they aren't unrelated but I do somehow prefer the more flexible
model where each object type has its own API and the objects can refer
to each other.

I think there's too much of a risk that the mapping between page pools
to queues will become n:m and then having them tied together will be 
a problem.

