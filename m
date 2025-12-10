Return-Path: <netdev+bounces-244235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7ACB2B51
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FB1A3109E89
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359330DEA3;
	Wed, 10 Dec 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmXvr6dZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E930DD17;
	Wed, 10 Dec 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362536; cv=none; b=tV7Eiz1apAEhUZdZp1NacssJCZwr1w7W6QRvZvHdEKN2ZwQMSemqcfO7CwwA3ACw8LhMEiBfqOli7ZzZql0FwAO7hzoVMUEz4SmEGAScmHbMmKocwDS8PgYjnGjtHdVrCWb7zMYKDKK9hhF+MD4YGZyT9tH88mYcjlEFSGbDRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362536; c=relaxed/simple;
	bh=KNlp4Q7w9bDK5wq68w+K+ndS1ohZaT8XBbYvXvshsMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjKXHOJfFMTEdbNpo3aTtF6SuXG0JL9obXhtFfhI1Ajjl/6XsK1NJMac5fxMq9zPuIRdNAaTSaIJaGSvJcscEY2TcpzPK+2PvRWeuC4WVt+yDAPu5yn59FOYSE4/1UQUXxJG7YG1UZ5LQIjleG4FvXHpvAVUxxPCcJHfvsA97ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmXvr6dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C0C4CEF1;
	Wed, 10 Dec 2025 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765362536;
	bh=KNlp4Q7w9bDK5wq68w+K+ndS1ohZaT8XBbYvXvshsMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmXvr6dZLGRPHG5XDKhjVj83w5/xGC//hN+7yNSvhLUEgAbR2uULmxC2F9KUUtCfA
	 ahNXKkF01oi59I2Dw7Q30Q3MI5cBzY17+GSVZpNJF15vnwyimEZpY3jJWMSlm2UCIu
	 2qBKr8lc0IvH3fju5ubNjPW4rck6IF+wvcCqPsirlLKMSkcV6+goFJI72Yi26v+gcz
	 nyN28fPEBHghSyRG97j1oFy5XFMM4HS9UvVQr21sMvBqdSQrkeQhcJT11GODGmJULr
	 y6Ifr5ulqLT+5UzQ8ooWMgstM6NWrYYKCjk6Enx+3Uksg/H7mkSNlHoNXglZ4+hFaY
	 gJJVE0J1W6b2A==
Date: Wed, 10 Dec 2025 10:28:53 +0000
From: Simon Horman <horms@kernel.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH v3] net: atm: lec: add pre_send validation to avoid
 uninitialized
Message-ID: <aTlLZUDphWwZGaGS@horms.kernel.org>
References: <20251210035354.17492-2-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210035354.17492-2-dharanitharan725@gmail.com>

+ Edward

On Wed, Dec 10, 2025 at 03:53:55AM +0000, Dharanitharan R wrote:
> syzbot reported a KMSAN uninitialized-value crash caused by reading
> fields from struct atmlec_msg before validating that the skb contains
> enough linear data. A malformed short skb can cause lec_arp_update()
> and other handlers to access uninitialized memory.
> 
> Add a pre_send() validator that ensures the message header and optional
> TLVs are fully present. This prevents all lec message types from reading
> beyond initialized skb data.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> Tested-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>

As pointed out elsewhere, this patch largely duplicates the following by
Edward (CCed).

- [PATCH] net: atm: targetless need more input msg
  https://lore.kernel.org/netdev/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08%40qq.com/

Ideally there would be some collaboration between you and him on this.

Also, as a fix for Networking code, please explicitly target the patch
at net-next.

Subject: [PATCH net] ...

> ---
>  net/atm/lec.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index afb8d3eb2185..c893781a490a 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -489,8 +489,33 @@ static void lec_atm_close(struct atm_vcc *vcc)
>  	module_put(THIS_MODULE);
>  }
>  
> +static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
> +{
> +	struct atmlec_msg *mesg;
> +	u32 sizeoftlvs;
> +	unsigned int msg_size = sizeof(struct atmlec_msg);

Please use reverse xmas tree order - longest line to shortest -
for Networking code.

> +
> +	/* Must contain the base message */
> +	if (skb->len < msg_size)
> +		return -EINVAL;
> +
> +   	/* Must have at least msg_size bytes in linear data */
> +   	if (!pskb_may_pull(skb, msg_size))
> +   		return -EINVAL;

As you pointed out off-list, this check seems to be the main difference
between your patch and Edward's. I agree it seems relevant. But if so I
believe it duplicates the skb->len check above which can be dropped.

Also The indentation of the three above is not correct.
It should only use tabs.  checkpatch.pl points this out.

> +
> +	mesg = (struct atmlec_msg *)skb->data;
> +	sizeoftlvs = mesg->sizeoftlvs;
> +
> +	/* Validate TLVs if present */
> +	if (sizeoftlvs && !pskb_may_pull(skb, msg_size + sizeoftlvs))
> +       	return -EINVAL;

Tabs only for indentation on the like above too.

> +
> +	return 0;
> +}
> +
>  static const struct atmdev_ops lecdev_ops = {
>  	.close = lec_atm_close,
> +	.pre_send = lec_atm_pre_send,
>  	.send = lec_atm_send
>  };

-- 
pw-bot: changes requested

