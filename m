Return-Path: <netdev+bounces-242824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0CC95200
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0F563429C2
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D52264D9;
	Sun, 30 Nov 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn6wpiYX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39650186A;
	Sun, 30 Nov 2025 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764518207; cv=none; b=ryT5SV3SNIkvrY6a5UyWFlSedDo4wr8XwvH6vwTimOvsyvAZ0AeA2MsWSYMhdlZAo76wFPiVW5gkO80L8EBXr/YPYrM0W30okcoY+0OYsQMnu1jEPbrvZCUOxGgJBsmL+ih67Q+3wh4Iu1+yzaBl+DHk0QvLLQezkZ2mIktVDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764518207; c=relaxed/simple;
	bh=WCbStfFokOsFT9GFFsPdSCfGiJ7hVN+3jjgGKQlZUdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i863CMDMojSnv1LMlmax8QFEnet6GXZNQ3v13+LB4W2PqX+gNSK5ZKlmq2KY0clYa8CuOi6kqSBxHxH5gIaOjCSCitJWIA1eGZes+6AUoKmUDUkX4pXaSyTSl4h/AMOPL2D85uvIvh8uD+EyKVQ7crNWfhNmGbPs7wk3yJB0sTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn6wpiYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A02C4CEF8;
	Sun, 30 Nov 2025 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764518206;
	bh=WCbStfFokOsFT9GFFsPdSCfGiJ7hVN+3jjgGKQlZUdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn6wpiYXDd++l+SkLQSq5dujchROHV9uUQE2mLJw3S0M5ce++0P6nyKEQQPxtMZct
	 ff67+kksIhiuvOKP6Pb4zD29NlI9oF6SP0gh4jAo/OHSTHF4Yamm6XAtmqvY+t0o7M
	 LwuQk97jrCbQVxT0J27twMsRwr85k4g+rSdrDfXIFUVJEgkQ8rqIGudx9uRttXin+K
	 R8DLkjgTs2hTkLHYzyao4ue7co4f4vaffIy4zCaHzFUchqBwoLngACiFsGjW9KNrdk
	 w3Nio5VjtNnU9YtK0ZndPzdD2fX0PRaTEggGi2CAcJysttl67n6i1Md/1Npg9fUd4n
	 wMl1l7ndJDYNQ==
Date: Sun, 30 Nov 2025 15:56:42 +0000
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] net: atm: targetless need more input msg
Message-ID: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
References: <69298e9d.a70a0220.d98e3.013a.GAE@google.com>
 <tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com>

Hi Edward,

Thanks for taking time to look into this issue.

On Fri, Nov 28, 2025 at 11:56:25PM +0800, Edward Adam Davis wrote:
> syzbot found an uninitialized targetless variable. The user-provided
> data was only 28 bytes long, but initializing targetless requires at
> least 44 bytes. This discrepancy ultimately led to the uninitialized
> variable access issue reported by syzbot [1].
> 
> Adding a message length check to the arp update process eliminates
> the uninitialized issue in [1].
> 
> [1]
> BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_arp_update net/atm/lec.c:1845 [inline]
>  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
>  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> 
> Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com

I think it would be useful to also include:

Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057

And as a fix for Networking code it should include a fixes tag.
Briefly examining the history of this code, using git annotate,
it seems that this problem has existed since the beginning of git history.
If so, this tag seems appropriate:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Also, as a fix for Networking code present in the net tree,
it should be targeted at that tree, like this:

Subject: [PATCH net] ...

More information on the Networking development workflow can be found here:
https://docs.kernel.org/process/maintainer-netdev.html


> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/atm/lec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index afb8d3eb2185..178132b2771a 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -382,6 +382,15 @@ static int lec_atm_send(struct atm_vcc *vcc, struct sk_buff *skb)
>  			break;
>  		fallthrough;
>  	case l_arp_update:
> +	{
> +		int need_size = offsetofend(struct atmlec_msg,
> +				content.normal.targetless_le_arp);
> +		if (skb->len < need_size) {

As per Eric's comment on a similar fix [1],
you should probably be using pskb_may_pull().

Also, I see that this patch addresses the l_arp_update case.
But it looks like a similar problem exist in least in the l_config case
too.

So I think it would be useful take a more holistic approach.
Perhaps in the form of a patchset if you want to restrict this
patch to addressing the specific problem flagged by syzbot.

[1] https://lore.kernel.org/netdev/20251126034601.236922-1-ssranevjti@gmail.com/

> +			pr_info("Input msg size too small, need %d got %u\n",
> +				 need_size, skb->len);
> +			dev_kfree_skb(skb);
> +			return -EINVAL;
> +		}
>  		lec_arp_update(priv, mesg->content.normal.mac_addr,
>  			       mesg->content.normal.atm_addr,
>  			       mesg->content.normal.flag,

-- 
pw-bot: changes-requested

