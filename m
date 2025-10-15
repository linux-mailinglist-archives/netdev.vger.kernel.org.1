Return-Path: <netdev+bounces-229466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3707BDCA77
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C5422F10
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA502FFFAD;
	Wed, 15 Oct 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cCDHjYCf"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568A2F5A33
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508292; cv=none; b=AoAYoLZAyNGAaLoOgJK06AOV/RCj1kT4hPPtotBOUYA5InM+9ANt9qOn+JIDUQd/MRUG3nyuKUH9AN0c7q1fhX0NjIJyMHOgNFQ73ZIelE7L61YniPjlbRsTFGFtGiAwt0hNKKt8lvxeWKkm0RfbeqBNddZi+8ndRaw6IStFbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508292; c=relaxed/simple;
	bh=WsN6bR5AdRAePUDRv2yBU4zPXb7rHSXYpThAiWBLiXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfYt6l1DCrxFBbTvhNDu1mKwWzuBnUkof/62e0gqU3UF9D3eo6eDi44FIBuRAUcUyhaJVOFv69SGLRUoJMCwoHN7Q+liunvmAu7V5f7sR5sdyShYp5nSs8J0I9ATHUVRcDEUJywcmWPY3EBb/U1lH93Zq0Gq92hRrWIp1iy4Ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cCDHjYCf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e7530fc-c546-4420-9ca7-0e3d0a7b63e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760508286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsN6bR5AdRAePUDRv2yBU4zPXb7rHSXYpThAiWBLiXo=;
	b=cCDHjYCfZZ3uM/TvAqVk2kPPBS4cU1A6hFR7RIPRhBh8OuIEe8emzckv6Yy1nA5BB6CN/q
	NbKeBObhMG466NnTmdmI+8WF/reYhp3TLQkz2apUmGL/PCnUP2a5bZkdiENEtTOc8eDft5
	BaSBiRhGQ1g2KjtlcKPk+fxtFRQ0pSE=
Date: Wed, 15 Oct 2025 14:03:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: remove obsolete
 WARN_ON(refcount_read(&sk->sk_refcnt) == 1)
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Kuniyuki Iwashima <kuniyu@google.com>
References: <20251014140605.2982703-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20251014140605.2982703-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/14 22:06, Eric Dumazet 写道:
> sk->sk_refcnt has been converted to refcount_t in 2017.
>
> __sock_put(sk) being refcount_dec(&sk->sk_refcnt), it will complain
> loudly if the current refcnt is 1 (or less) in a non racy way.
>
> We can remove four WARN_ON() in favor of the generic refcount_dec()
> check.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>

Dear Eric,

Following your line of thought, I found there's also a point in btrfs that
needs modification.

Would you like to modify it together? Though it has nothing to do with
socket, or shall I modify it separately later?

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..485bef0ba419 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -138,7 +138,6 @@ static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
  void btrfs_put_transaction(struct btrfs_transaction *transaction)
  {
-       WARN_ON(refcount_read(&transaction->use_count) == 0);
         if (refcount_dec_and_test(&transaction->use_count)) {
                 BUG_ON(!list_empty(&transaction->list));
                 WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));

Thanks!


