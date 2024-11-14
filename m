Return-Path: <netdev+bounces-144650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6189C80D4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC2D284BCC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A101E8835;
	Thu, 14 Nov 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohtOKEZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F91E7C35;
	Thu, 14 Nov 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551116; cv=none; b=tQqKOvf21cZHTglZ3rxEqPfMDgEniMGisLMh6BteykGj8LpiqoNASIYXQqpZQAa+3gTw1CjkScizwqOnyoDIeKPMYRyznKQpno3oQ5a1urPkj49chfw8nYrk+kBZLx0jNzsrMT6JA5bQWZmewwBuSNB7KAw5NNYhJMZAMR4wblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551116; c=relaxed/simple;
	bh=qB25+Dbf9WY7WBvFohrWN4vsJ1OR1bLr9G+yZVNMHXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2QQqxyQrKatFoKOclK/Vby10QO5vMgJbqTNmXehw5biI+jV2VRzuiYSDsn++gGx+Nb7IHqVwG8QlUElhQ5rkbbK4j0U2ttcwX3MMkuPjrKMJ3dg0nJdSGGY48dzuBAbO5+AJoDplIoHHJsY7pSoBLGkXt2TYVS9kTUYVEAdrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohtOKEZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D36C4CEC3;
	Thu, 14 Nov 2024 02:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731551113;
	bh=qB25+Dbf9WY7WBvFohrWN4vsJ1OR1bLr9G+yZVNMHXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohtOKEZ0wXGQgeiOKJUhw0BrCzqqexbut/k3RQIElP0qBVgZr8/FDyCqzkHRzLPbe
	 eEmjaSy4pXBipFL8hPSVulgM9nHzmJTpgFEh18NkZxy6AJIdIvn2O6jD6l6E8uTynm
	 WLyB9UtC1riuQWL07zyRN3XFPqQaQwSTTwidLL7KlfVRQ1DhGIJu7sUMgPMJldgKZZ
	 APEs7EQPdW9bFK/wXH28shzzG/286/lajC96O0PmDvtwcFFtOypXR3rW57cdM4cU3p
	 8lhF0sBsGY9iMvExOllpp85H36MJEKra0RmH1aOYFCAcSb7/2NUuoynGqjEAgi4PCe
	 KBHFbupanJMsA==
Date: Wed, 13 Nov 2024 18:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Cc: manas18244@iiitd.ac.in, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Shuah
 Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] netlink: Add string check in
 netlink_ack_tlv_fill
Message-ID: <20241113182511.41960cc0@kernel.org>
In-Reply-To: <20241114-fix-netlink_ack_tlv_fill-v2-1-affdfb5f4c6f@iiitd.ac.in>
References: <20241114-fix-netlink_ack_tlv_fill-v2-1-affdfb5f4c6f@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 06:15:15 +0530 Manas via B4 Relay wrote:
> -	if (extack->bad_attr &&
> +	if (extack->bad_attr && strlen(in_skb->data) &&
>  	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
>  		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))

that's most definitely not the right fix.
in_skb->data points to binary data.

my best idea so far is to rework this check to use nlh, because in_skb
will be pulled at this stage for dumps
if that makes sense to you please give it a go, otherwise I'll work on
the fix tomorrow

